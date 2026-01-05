import 'package:MIPS/common/constants/constant.dart';
import 'package:MIPS/domain/domain.dart';
import 'package:MIPS/presentation/bloc/follow_bloc.dart';
import 'package:MIPS/presentation/configurations/extension_for_localization.dart';
import 'package:MIPS/presentation/routes/route.dart';
import 'package:MIPS/presentation/routes/router.dart';
import 'package:MIPS/presentation/screens/profil/bloc/profil_bloc.dart';
import 'package:MIPS/presentation/widgets/loading_image_cache_widget.dart';
import 'package:MIPS/presentation/widgets/loading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:ionicons/ionicons.dart';

class UserFollow extends StatelessWidget {
  const UserFollow({
    super.key,
    required this.user,
  });
  final User user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetIt.instance<FollowBloc>()..add(CheckFollowingEvent(id: user.id)),
      child: BlocProvider(
        create: (context) => GetIt.instance<ProfilBloc>()
          ..add(UserProfilLoaded(id: user.id))
          ..add(AnnonceListUserProfilCountLoaded(id: user.id)),
        child: BlocBuilder<FollowBloc, FollowState>(
          buildWhen: (previous, current) {
            return (previous.isFollowingStatus != current.isFollowingStatus);
          },
          builder: (context, state) {
            bool isFollowing = state.isFollowing;
            return MaterialButton(
              onPressed: () {
                AppRouter.go(
                  context,
                  RoutesNames.profilDetail,
                  queryParameters: {"authorID": "${user.id}"},
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: smallPadding,
                  horizontal: mediumPadding,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(32),
                          child: SizedBox(
                            width: 48,
                            height: 48,
                            child: CachedNetworkImage(
                              imageUrl: user.avatarUrl,
                              fit: BoxFit.cover,
                              progressIndicatorBuilder:
                                  (context, url, progress) =>
                                      const LoadingImageCacheWidget(),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.error,
                                size: 42,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: mediumPadding),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              user.pseudo,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            BlocBuilder<ProfilBloc, ProfilState>(
                              builder: (context, state) {
                                if (state.profilUserAnnoncesCountStatus ==
                                    ProfilUserAnnoncesCountStatus.loading) {
                                  return Container(
                                    height: 20,
                                    width: 100,
                                    color: Colors.grey.shade300,
                                  );
                                }
                                return Text(
                                  "${state.annoncesCount} ${context.appLoc.announces.toLowerCase()}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                        color: Colors.grey,
                                      ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<FollowBloc>().add(isFollowing
                              ? UnFollowUserEvent(id: user.id)
                              : FollowUserEvent(id: user.id));
                        },
                        style: ButtonStyle(
                            backgroundColor: isFollowing
                                ? WidgetStatePropertyAll(Colors.grey)
                                : null,
                            shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(16.0)))),
                        child: Row(
                          spacing: 5.0,
                          children: [
                            state.isFollowingStatus == IsFollowingStatus.loading
                                ? AppLoadingWidget(
                                    size: 16,
                                    color: Colors.white,
                                  )
                                : isFollowing
                                    ? Icon(Ionicons.checkmark_outline)
                                    : SizedBox(),
                            Text(
                              isFollowing
                                  ? context.appLoc.followed
                                  : context.appLoc.follow,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
