import 'dart:ui';

enum MenuItemHolderType { normal, group, mainMenu }

class MenuItemHolder {
  final String reference;
  final String title;
  final String? desc;
  final int id;
  final int annoncesTodayCount;
  final bool isFav;
  final bool isFree;
  final Color? color;
  final int? nbrPartenaire;
  final String? iconPath;
  final Function()? onClick;
  final List<MenuItemHolder>? subMenu;
  final MenuItemHolderType menuItemType;

  const MenuItemHolder(
      {required this.title,
      required this.reference,
      required this.id,
      required this.onClick,
      required this.isFav,
      required this.isFree,
      required this.annoncesTodayCount,
      this.nbrPartenaire,
      this.desc,
      this.iconPath,
      this.color,
      this.subMenu,
      required this.menuItemType});
}
