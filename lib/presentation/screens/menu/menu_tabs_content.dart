import 'package:cached_network_image/cached_network_image.dart';
import 'package:colorful_iconify_flutter/icons/noto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:mips/common/common.dart';
import 'package:mips/domain/domain.dart';
import 'package:mips/presentation/configurations/colors_list.dart';
import 'package:mips/presentation/configurations/extension_for_localization.dart';
import 'package:mips/presentation/presentation.dart';
import 'package:mips/presentation/routes/route.dart';
import 'package:mips/presentation/routes/router.dart';
import 'package:mips/presentation/widgets/empty_list_widget.dart';
import 'package:mips/presentation/widgets/error_page_widget.dart';
import 'package:mips/presentation/widgets/message_displayer_utils.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// Contenu d'un menu principal (ex: Véhicules, Quotidien) affiché « à plat » :
///
/// 1. une barre d'onglets = les sous-menus du menu ([items]) ;
/// 2. sous l'onglet sélectionné :
///    - si le sous-menu a des enfants (niveau 3) : un bloc par enfant avec un
///      carrousel d'annonces et un lien « Voir plus » ;
///    - sinon : directement la liste d'annonces (VIP, puis Premium et Normal,
///      avec chargement progressif).
///
/// Les sous-menus qui ne sont pas des listes d'annonces (sondage, taux de
/// change, MIPS info, ...) ouvrent leur écran dédié via [onOpenItem].
class MenuTabsContent extends StatefulWidget {
  final List<MenuItem> items;

  /// Ouvre l'écran dédié d'un sous-menu (liste complète, sondage, ...).
  final void Function(MenuItem item) onOpenItem;

  const MenuTabsContent({
    super.key,
    required this.items,
    required this.onOpenItem,
  });

  @override
  State<MenuTabsContent> createState() => _MenuTabsContentState();
}

class _MenuTabsContentState extends State<MenuTabsContent> {
  late int _selected;

  @override
  void initState() {
    super.initState();
    _selected = _firstInlineIndex();
  }

  int _firstInlineIndex() {
    final index = widget.items.indexWhere(_isInline);
    return index == -1 ? 0 : index;
  }

  /// Un sous-menu est affiché dans l'onglet s'il contient des enfants ou s'il
  /// s'agit d'une liste d'annonces. Sinon, il ouvre son propre écran.
  static bool _isInline(MenuItem item) {
    if (item.subMenu.isNotEmpty) return true;
    return item.screenTypeRoute == MenuTypeRoute.list ||
        item.screenTypeRoute == MenuTypeRoute.listBasic;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) {
      return const Center(
        child: EmptyListWidget(listType: ListType.availableSoon),
      );
    }
    final int selected = _selected.clamp(0, widget.items.length - 1);
    final MenuItem current = widget.items[selected];

    return Column(
      children: [
        _TabBar(
          items: widget.items,
          selected: selected,
          onSelected: (index) {
            final item = widget.items[index];
            if (_isInline(item)) {
              setState(() => _selected = index);
            } else {
              widget.onOpenItem(item);
            }
          },
        ),
        Expanded(
          child: KeyedSubtree(
            key: ValueKey('tab-${current.id}'),
            child: current.subMenu.isNotEmpty
                ? _BlocksTab(item: current, onOpenItem: widget.onOpenItem)
                : _AnnonceListTab(item: current),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Barre d'onglets
// ---------------------------------------------------------------------------

class _TabBar extends StatelessWidget {
  final List<MenuItem> items;
  final int selected;
  final ValueChanged<int> onSelected;

  const _TabBar({
    required this.items,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: smallPadding),
        child: Row(
          children: List.generate(items.length, (index) {
            final bool isSelected = index == selected;
            return InkWell(
              onTap: () => onSelected(index),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: largePadding,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected ? tertiaryColor : Colors.transparent,
                      width: 2.5,
                    ),
                  ),
                ),
                child: Text(
                  items[index].name.trim(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected ? tertiaryColor : Colors.black87,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Onglet avec niveau 3 : aperçu en blocs, puis détail d'un enfant
// ---------------------------------------------------------------------------

class _BlocksTab extends StatefulWidget {
  final MenuItem item;
  final void Function(MenuItem item) onOpenItem;

  const _BlocksTab({required this.item, required this.onOpenItem});

  @override
  State<_BlocksTab> createState() => _BlocksTabState();
}

class _BlocksTabState extends State<_BlocksTab> {
  /// Enfant ouvert (« Voir plus »). `null` = aperçu de tous les blocs.
  MenuItem? _opened;

  Future<void> _chooseChild() async {
    final MenuItem? picked = await showModalBottomSheet<MenuItem>(
      context: context,
      showDragHandle: true,
      backgroundColor: Colors.white,
      builder: (context) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: widget.item.subMenu.map((child) {
            final bool isCurrent = child.id == _opened?.id;
            return ListTile(
              title: Text(
                child.name.trim(),
                style: TextStyle(
                  fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
                  color: isCurrent ? tertiaryColor : Colors.black87,
                ),
              ),
              trailing: isCurrent
                  ? const Icon(Icons.check, color: tertiaryColor)
                  : null,
              onTap: () => Navigator.of(context).pop(child),
            );
          }).toList(),
        ),
      ),
    );
    if (picked != null && mounted) {
      setState(() => _opened = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final MenuItem? opened = _opened;
    if (opened != null) {
      return _AnnonceListTab(
        key: ValueKey('child-${opened.id}'),
        item: opened,
        header: _ChildHeader(
          title: opened.name,
          onBack: () => setState(() => _opened = null),
          onChoose: _chooseChild,
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: largePadding),
      itemCount: widget.item.subMenu.length,
      itemBuilder: (context, index) {
        final child = widget.item.subMenu[index];
        return _SectionBlock(
          key: ValueKey('block-${child.id}'),
          item: child,
          onSeeMore: () => setState(() => _opened = child),
        );
      },
    );
  }
}

/// En-tête d'un enfant ouvert : flèche retour, titre et chevron pour changer.
class _ChildHeader extends StatelessWidget {
  final String title;
  final VoidCallback onBack;
  final VoidCallback onChoose;

  const _ChildHeader({
    required this.title,
    required this.onBack,
    required this.onChoose,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        smallPadding,
        mediumPadding,
        largePadding,
        0,
      ),
      child: Row(
        children: [
          IconButton(
            visualDensity: VisualDensity.compact,
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          ),
          Expanded(
            child: InkWell(
              onTap: onChoose,
              borderRadius: BorderRadius.circular(mediumPadding),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: mediumPadding),
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        title.trim(),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: smallPadding),
                    const Icon(Icons.keyboard_arrow_down, size: 22),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionBlock extends StatelessWidget {
  final MenuItem item;
  final VoidCallback onSeeMore;

  const _SectionBlock({super.key, required this.item, required this.onSeeMore});

  static const double _carouselHeight = _VipCard.height;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AnnonceBloc>(
      create: (_) =>
          GetIt.instance<AnnonceBloc>()
            ..add(LoadAnnonceList(id: item.id, pageIndex: 1)),
      child: BlocBuilder<AnnonceBloc, AnnonceState>(
        builder: (context, state) {
          final List<Annonce> ads = [
            ...state.annoncesVIP,
            ...state.annoncesPremium,
            ...state.annoncesNormal,
          ].take(10).toList();

          Widget body;
          if (state.listStatus == ListStatus.loading) {
            body = ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: largePadding),
              itemCount: 3,
              separatorBuilder: (_, _) => const SizedBox(width: 12),
              itemBuilder: (_, _) => const _SkeletonCard(),
            );
          } else if (ads.isEmpty) {
            body = Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: largePadding,
                vertical: mediumPadding,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  context.appLoc.empty_list_announce,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                ),
              ),
            );
          } else {
            body = ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: largePadding),
              itemCount: ads.length,
              separatorBuilder: (_, _) => const SizedBox(width: 12),
              itemBuilder: (context, index) => _VipCard(
                annonce: ads[index],
                onTap: () => _openDetail(context, ads[index]),
              ),
            );
          }

          final bool showCarousel =
              state.listStatus == ListStatus.loading || ads.isNotEmpty;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  largePadding,
                  20,
                  largePadding,
                  mediumPadding,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.name.trim(),
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: onSeeMore,
                      borderRadius: BorderRadius.circular(mediumPadding),
                      child: Padding(
                        padding: const EdgeInsets.all(smallPadding),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              context.appLoc.view,
                              style: const TextStyle(
                                color: tertiaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                            const Icon(
                              Icons.chevron_right,
                              size: 18,
                              color: tertiaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (showCarousel)
                SizedBox(height: _carouselHeight, child: body)
              else
                body,
            ],
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Briques visuelles communes
// ---------------------------------------------------------------------------

/// Petit titre de section en capitales (« VIP · 3 », « ANNONCES »).
class _SectionLabel extends StatelessWidget {
  final String text;

  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(largePadding, 18, largePadding, 10),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.9,
          color: Colors.grey.shade600,
        ),
      ),
    );
  }
}

/// Grande carte (carrousel VIP et aperçu des blocs) : visuel ou initiales en
/// haut, titre et lieu en dessous.
class _VipCard extends StatelessWidget {
  final Annonce annonce;
  final VoidCallback onTap;

  const _VipCard({required this.annonce, required this.onTap});

  static const double width = 158;
  static const double height = 196;
  static const double _imageHeight = 104;

  @override
  Widget build(BuildContext context) {
    final String photo = annonce.photos.isNotEmpty
        ? annonce.photos.first.urlMiniature
        : "";
    return SizedBox(
      width: width,
      height: height,
      child: Card(
        margin: EdgeInsets.zero,
        color: Colors.white,
        clipBehavior: Clip.antiAlias,
        elevation: 0.5,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: _imageHeight,
                width: double.infinity,
                child: _AdThumb(photo: photo, title: annonce.title, big: true),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
                child: Text(
                  annonce.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
                child: Text(
                  annonce.emplacement,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Emplacement « Publier ici » à la suite des annonces VIP.
class _PublishVipCard extends StatelessWidget {
  final VoidCallback onTap;

  const _PublishVipCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _VipCard.width,
      height: _VipCard.height,
      child: Card(
        margin: EdgeInsets.zero,
        color: Colors.white,
        elevation: 0.5,
        shadowColor: Colors.black26,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Icon(Icons.add, size: 36, color: Colors.grey.shade500),
          ),
        ),
      ),
    );
  }
}

/// Visuel d'une annonce : photo, ou carré coloré avec initiales sans photo.
class _AdThumb extends StatelessWidget {
  final String photo;
  final String title;
  final bool big;

  const _AdThumb({required this.photo, required this.title, this.big = false});

  static const List<Color> _palette = [
    Color(0xFF37474F),
    Color(0xFF1E6FD9),
    Color(0xFF2E7D32),
    Color(0xFFC0392B),
    Color(0xFF6A4FC1),
    Color(0xFFE67E22),
  ];

  String get _initials {
    final words = title
        .trim()
        .split(RegExp(r'\s+'))
        .where((w) => w.isNotEmpty)
        .toList();
    if (words.isEmpty) return "M";
    if (words.length == 1) return words.first.substring(0, 1).toUpperCase();
    return (words[0].substring(0, 1) + words[1].substring(0, 1)).toUpperCase();
  }

  Widget _fallback() => Container(
    color: _palette[title.hashCode.abs() % _palette.length],
    alignment: Alignment.center,
    child: Text(
      _initials,
      style: TextStyle(
        color: Colors.white,
        fontSize: big ? 30 : 24,
        fontWeight: FontWeight.w800,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    if (photo.isEmpty) return _fallback();
    return CachedNetworkImage(
      imageUrl: photo,
      fit: BoxFit.cover,
      progressIndicatorBuilder: (context, url, progress) =>
          const LoadingImageCacheWidget(),
      errorWidget: (context, url, error) => _fallback(),
    );
  }
}

class _SkeletonCard extends StatelessWidget {
  const _SkeletonCard();

  @override
  Widget build(BuildContext context) {
    final Color base = Colors.grey.shade300;
    Widget bar(double w, double h) => Container(
      height: h,
      width: w,
      decoration: BoxDecoration(
        color: base,
        borderRadius: BorderRadius.circular(6),
      ),
    );
    return SizedBox(
      width: _VipCard.width,
      height: _VipCard.height,
      child: Card(
        margin: EdgeInsets.zero,
        color: Colors.white,
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: _VipCard._imageHeight,
              color: Colors.grey.shade200,
            ),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: bar(_VipCard.width * 0.7, 10),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: bar(_VipCard.width * 0.4, 8),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Liste directe : VIP, puis annonces (Premium avant Normal)
// ---------------------------------------------------------------------------

class _AnnonceListTab extends StatelessWidget {
  final MenuItem item;

  /// Widget affiché tout en haut de la liste (ex: titre d'un enfant ouvert).
  final Widget? header;

  const _AnnonceListTab({super.key, required this.item, this.header});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AnnonceBloc>(
      create: (_) =>
          GetIt.instance<AnnonceBloc>()
            ..add(LoadAnnonceList(id: item.id, pageIndex: 1)),
      child: BlocBuilder<AnnonceBloc, AnnonceState>(
        builder: (context, state) {
          if (state.listStatus == ListStatus.loading) {
            return Column(
              children: [
                if (header != null) header!,
                const Expanded(child: Center(child: AppLoadingWidget())),
              ],
            );
          }
          if (state.listStatus != ListStatus.loaded) {
            return Column(
              children: [
                if (header != null) header!,
                const Expanded(child: Center(child: ErrorPageWidget())),
              ],
            );
          }

          final int premiumCount = state.annoncesPremium.length;
          final int adsCount = premiumCount + state.annoncesNormal.length;
          final bool showVip = !item.isFree;
          final int headerCount = header != null ? 1 : 0;
          final int vipCount = showVip ? 1 : 0;
          final int labelCount = adsCount > 0 ? 1 : 0;
          final int bodyCount = adsCount == 0 ? 1 : adsCount;

          return RefreshIndicator(
            onRefresh: () async {
              context.read<AnnonceBloc>().add(
                LoadAnnonceList(id: item.id, pageIndex: 1),
              );
            },
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.only(bottom: mediumPadding),
              itemCount: headerCount + vipCount + labelCount + bodyCount + 1,
              itemBuilder: (context, index) {
                if (headerCount == 1) {
                  if (index == 0) return header!;
                  index -= 1;
                }
                if (showVip) {
                  if (index == 0) {
                    return _VipSection(item: item, ads: state.annoncesVIP);
                  }
                  index -= 1;
                }
                if (labelCount == 1) {
                  if (index == 0) {
                    return _SectionLabel(context.appLoc.announces);
                  }
                  index -= 1;
                }

                if (adsCount == 0) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.only(top: largePadding),
                      child: EmptyListWidget(
                        listType: state.query == ""
                            ? ListType.annonce
                            : ListType.annonceSearch,
                      ),
                    );
                  }
                  return const SizedBox();
                }

                if (index == adsCount) {
                  return Padding(
                    padding: const EdgeInsets.all(largePadding),
                    child: state.isNextListAvailable
                        ? VisibilityDetector(
                            key: Key('loadMore-${item.id}'),
                            onVisibilityChanged: (info) {
                              if (info.visibleFraction * 100 >= 80) {
                                context.read<AnnonceBloc>().add(
                                  LoadMoreListItem(),
                                );
                              }
                            },
                            child: const AppLoadingWidget(),
                          )
                        : const SizedBox(),
                  );
                }

                final bool isPremium = index < premiumCount;
                final Annonce annonce = isPremium
                    ? state.annoncesPremium[index]
                    : state.annoncesNormal[index - premiumCount];

                return _AdRow(
                  annonce: annonce,
                  isPremium: isPremium,
                  isMerci: item.reference == mahaNouvelleMenuRef,
                  hideAuthor: item.reference == blablaZoneMenuRef,
                  onTap: () => _openDetail(context, annonce),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

/// Section VIP : étiquette « VIP · n », carrousel et emplacement « Publier ici ».
class _VipSection extends StatelessWidget {
  final MenuItem item;
  final List<Annonce> ads;

  const _VipSection({required this.item, required this.ads});

  void _publishVip(BuildContext context) {
    if (context.read<AppBloc>().state.isLogged) {
      AppRouter.go(
        context,
        RoutesNames.demandePub,
        queryParameters: {
          "menuParentRef": item.reference,
          "modeVIPOnly": "true",
          "idMenu": item.id.toString(),
          "title": item.name,
          "idAnnonce": "0",
          "isFreeMode": item.isFree.toString(),
        },
        extra: context.read<AnnonceBloc>(),
      );
    } else {
      MessageDisplayerUtils.showAuthRequiredDialog(
        context,
        GoRouterState.of(context).uri.toString().startsWith(RoutesNames.login),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool hasFreeSlot = ads.length < 3;
    final int itemCount = ads.length + (hasFreeSlot ? 1 : 0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionLabel("VIP · ${ads.length}"),
        SizedBox(
          height: _VipCard.height,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: largePadding),
            itemCount: itemCount,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              if (index < ads.length) {
                return _VipCard(
                  annonce: ads[index],
                  onTap: () => _openDetail(context, ads[index]),
                );
              }
              return _PublishVipCard(onTap: () => _publishVip(context));
            },
          ),
        ),
      ],
    );
  }
}

/// Ligne d'annonce : visuel, titre (+ badge Premium), auteur • date, réactions
/// et lieu.
class _AdRow extends StatelessWidget {
  final Annonce annonce;
  final bool isPremium;
  final bool isMerci;
  final bool hideAuthor;
  final VoidCallback onTap;

  const _AdRow({
    required this.annonce,
    required this.isPremium,
    required this.isMerci,
    required this.hideAuthor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final appState = context.read<AppBloc>().state;
    final bool isMine =
        appState.isLogged &&
        appState.user != null &&
        appState.user!.id == annonce.authorID;
    final String author = hideAuthor
        ? ""
        : (isMine ? appState.user!.pseudo : annonce.author);
    final String date = AppUtils.getDate(annonce.dateDeCreation);
    final String byline = author.isEmpty ? date : "$author · $date";
    final String photo = annonce.photos.isNotEmpty
        ? annonce.photos.first.urlMiniature
        : "";

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      color: Colors.white,
      elevation: 0.5,
      shadowColor: Colors.black26,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 96,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Visuel pleine hauteur, collé au bord gauche, haut et bas.
              SizedBox(
                width: 96,
                child: _AdThumb(photo: photo, title: annonce.title),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              annonce.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          if (isPremium) ...[
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 7,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF2B2B2B),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                "Premium",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        byline,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          color: tertiaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          if (annonce.reactionCount >= 0) ...[
                            isMerci
                                ? const Iconify(Noto.folded_hands, size: 15)
                                : Icon(
                                    Icons.thumb_up_outlined,
                                    size: 15,
                                    color: Colors.grey.shade700,
                                  ),
                            const SizedBox(width: 4),
                            Text(
                              "${annonce.reactionCount}",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            const SizedBox(width: 12),
                          ],
                          if (annonce.emplacement.isNotEmpty)
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.place_outlined,
                                    size: 15,
                                    color: Colors.grey.shade700,
                                  ),
                                  const SizedBox(width: 3),
                                  Expanded(
                                    child: Text(
                                      annonce.emplacement,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Ouvre le détail d'une annonce en réutilisant le bloc de la liste courante.
void _openDetail(BuildContext context, Annonce annonce) {
  AppRouter.go(
    context,
    RoutesNames.detail,
    queryParameters: {"id": annonce.id.toString(), "name": annonce.title},
    extra: context.read<AnnonceBloc>()
      ..add(LoadAnnonce(id: annonce.id.toString())),
  );
}
