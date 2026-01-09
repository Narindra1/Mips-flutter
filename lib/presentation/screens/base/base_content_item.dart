import 'package:MIPS/presentation/configurations/extension_for_localization.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../common/constants/constant.dart';
import 'menu_item.dart';
import '../../configurations/color_filter.dart';
import '../../configurations/colors_list.dart';
import '../../widgets/loading_image_cache_widget.dart';

class BaseContentItem extends StatelessWidget {
  final MenuItemHolder menuItem;
  final bool? isModExpanded;
  final bool? isSelected;

  const BaseContentItem({
    super.key,
    this.isModExpanded,
    this.isSelected,
    required this.menuItem,
  });

  @override
  Widget build(BuildContext context) {
    Widget listItem = const SizedBox();

    switch (menuItem.menuItemType) {
      case MenuItemHolderType.mainMenu:
        listItem = InkWell(
          onTap: menuItem.onClick,
          child: Padding(
            padding: const EdgeInsets.all(smallPadding),
            child: Center(
              child: Container(
                // color: Colors.blue,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        // CircleAvatar(
                        //   maxRadius: 16,
                        // backgroundColor: Colors.white.withOpacity(0.2),
                        // backgroundColor: menuItem.color,
                        // backgroundColor: Colors.transparent,
                        // child:
                        CachedNetworkImage(
                          imageUrl: menuItem.iconPath!,
                          height: 24,
                          width: 24,
                          // color: menuItem.color,
                          // color: Colors.white,
                          progressIndicatorBuilder: (context, url, progress) =>
                              const LoadingImageCacheWidget(),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.error,
                            size: 24,
                          ),
                          // ),
                        ),
                        // Text(
                        //   "Maha",
                        //   textAlign: TextAlign.center,
                        //   style: Theme.of(context)
                        //       .textTheme
                        //       .titleMedium
                        //       ?.copyWith(
                        //           color: Colors.white,
                        //           fontWeight: FontWeight.bold,
                        //           fontSize: 10,
                        //           shadows: [
                        //         Shadow(
                        //             // bottomLeft
                        //             offset: const Offset(-0.5, -0.5),
                        //             color: menuItem.color!),
                        //         Shadow(
                        //             // bottomRight
                        //             offset: const Offset(0.5, -0.5),
                        //             color: menuItem.color!),
                        //         Shadow(
                        //             // topRight
                        //             offset: const Offset(0.5, 0.5),
                        //             color: menuItem.color!),
                        //         Shadow(
                        //             // topLeft
                        //             offset: const Offset(-0.5, 0.5),
                        //             color: menuItem.color!),
                        //       ]),
                        // ),
                      ],
                    ),
                    const SizedBox(
                      height: smallPadding,
                    ),
                    Text(
                      menuItem.title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.black,
                          // color:
                          // isSelected == true ? Colors.white : Colors.black,
                          fontSize: isSelected == true ? 14 : 12,
                          fontWeight: FontWeight.bold),
                    ),
                    // Expand event reponsible
                    // InkWell(
                    //   onTap: () {
                    //     context.read<AppBloc>().add(MainMenuExpandeChangeEvent());
                    //   },
                    //   child: Column(
                    //     mainAxisSize: MainAxisSize.min,
                    //     children: [
                    //       const Padding(
                    //         padding:
                    //             EdgeInsets.symmetric(horizontal: smallPadding),
                    //         child: Divider(
                    //           color: Colors.white60,
                    //         ),
                    //       ),
                    //       Row(
                    //         children: [
                    //           Expanded(
                    //             child: Text(
                    //               (menuItem.desc!).split(":").last,
                    //               textAlign: TextAlign.center,
                    //               maxLines: isModExpanded! ? null : 1,
                    //               overflow: isModExpanded!
                    //                   ? null
                    //                   : TextOverflow.ellipsis,
                    //               style: Theme.of(context)
                    //                   .textTheme
                    //                   .bodySmall
                    //                   ?.copyWith(
                    //                       color: isModExpanded!
                    //                           ? Colors.white
                    //                           : Colors.white70),
                    //             ),
                    //           ),
                    //           if (!isModExpanded!)
                    //             const Icon(
                    //               Icons.keyboard_arrow_down,
                    //               color: Colors.white70,
                    //             )
                    //         ],
                    //       ),
                    //       if (isModExpanded!)
                    //         const Padding(
                    //           padding:
                    //               EdgeInsets.symmetric(horizontal: smallPadding),
                    //           child: Divider(
                    //             color: Colors.white60,
                    //           ),
                    //         ),
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
          ),
        );
        double radius = 8;
        return Card(
            color: isSelected == true ? secondaryColor : Colors.white,
            clipBehavior: Clip.antiAlias,
            // elevation: mediumPadding,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
            // surfaceTintColor: Colors.white,
            // margin: const EdgeInsets.all(mediumPadding),
            child: Container(
              decoration: BoxDecoration(
                // border: Border.all(
                //     color: menuItem.color!.withOpacity(1), width: 4),
                border: Border.all(
                  color: isSelected == true
                      ? Colors.transparent
                      : Color(0xFF858585).withAlpha(100),
                ),
                borderRadius: BorderRadius.circular(radius),
              ),
              child: Container(
                  decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(radius - 4),
                      // gradient: LinearGradient(
                      //   begin: Alignment.topLeft,
                      //   end: Alignment.bottomRight,
                      //   colors: [
                      //     menuItem.color!.withOpacity(.7),
                      //     menuItem.color!,
                      //     menuItem.color!.withOpacity(.88),
                      //     menuItem.color!.withOpacity(1),
                      //     menuItem.color!.withOpacity(.88),
                      //     menuItem.color!
                      //   ],
                      // ),
                      ),
                  child: listItem),
            ));

      case MenuItemHolderType.group:
        List<Widget> sublistElement = [];
        List<Widget> sublistElementRow = [];
        if (menuItem.subMenu != null) {
          for (int i = 0; i < menuItem.subMenu!.length; i++) {
            sublistElementRow.add(Expanded(
              child: InkWell(
                onTap: menuItem.subMenu![i].onClick,
                child: Padding(
                  padding: const EdgeInsets.all(smallPadding),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: mediumPadding,
                        height: smallPadding,
                      ),
                      Expanded(
                        child: Text(
                          menuItem.subMenu![i].title,
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      if (menuItem.subMenu![i].annoncesTodayCount > 0)
                        Container(
                          decoration: BoxDecoration(
                              color: secondaryColor,
                              borderRadius:
                                  BorderRadius.circular(largePadding)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: mediumPadding),
                          child: Text(
                            "+ ${menuItem.subMenu![i].annoncesTodayCount}",
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ));
            if (i != 0 && i != menuItem.subMenu!.length) {
              sublistElement.add(Divider(
                height: 1,
                color: Colors.grey.shade400,
              ));
            }
            if (sublistElementRow.length == 1) {
              sublistElement.add(Padding(
                padding: const EdgeInsets.symmetric(vertical: smallPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: sublistElementRow,
                ),
              ));
              // sublistElement.add(Divider());

              sublistElementRow = [];
            }
          }
        }

        sublistElement.add(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: sublistElementRow,
        ));
        sublistElementRow = [];
        listItem = Padding(
          padding: const EdgeInsets.all(smallPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: sublistElement,
          ),
        );
        return Padding(
          padding: const EdgeInsets.all(smallPadding),
          child: Card(
            elevation: smallPadding,
            shadowColor: Colors.black,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  // color: Colors.green,

                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          menuItem.color!,
                          menuItem.color!.withOpacity(.88),
                          menuItem.color!.withOpacity(1),
                          menuItem.color!.withOpacity(.88),
                          menuItem.color!,
                          menuItem.color!.withOpacity(.7),
                        ],
                      ),
                      color: menuItem.color ?? tertiaryColor,
                      // color: Colors.white,
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(8))),
                  child: Padding(
                    padding: const EdgeInsets.all(mediumPadding),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          menuItem.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        )),
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(
                              color: menuItem.color ?? tertiaryColor,
                              width: 0.2),
                          right: BorderSide(
                              color: menuItem.color ?? tertiaryColor,
                              width: 0.2),
                          left: BorderSide(
                              color: menuItem.color ?? tertiaryColor,
                              width: 0.2),
                          bottom: BorderSide(
                              color: menuItem.color ?? tertiaryColor,
                              width: 0.2),
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(8),
                        )),
                    child: listItem),
              ],
            ),
          ),
        );
      case MenuItemHolderType.normal:
        listItem = InkWell(
          onTap: menuItem.onClick,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: largePadding * 1.6,
              horizontal: largePadding,
            ),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            menuItem.title,
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                        if (menuItem.annoncesTodayCount > 0 &&
                            !menuItem.reference.startsWith("I"))
                          Container(
                            decoration: BoxDecoration(
                                color: secondaryColor,
                                borderRadius:
                                    BorderRadius.circular(largePadding)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: mediumPadding),
                            child: Text(
                              "+ ${menuItem.annoncesTodayCount}",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        return Padding(
          padding: const EdgeInsets.all(0),
          child: Card(
            // margin: const EdgeInsets.all(0),
            color: Colors.white,
            surfaceTintColor: Colors.white,
            elevation: smallPadding,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      color: menuItem.color ?? tertiaryColor, width: 0.2),
                  right: BorderSide(
                      color: menuItem.color ?? tertiaryColor, width: 0.2),
                  bottom: BorderSide(
                      color: menuItem.color ?? tertiaryColor, width: 0.2),
                  left: BorderSide(
                      width: mediumPadding,
                      color: menuItem.color ?? tertiaryColor),
                ),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    child: menuItem.isFree
                        ? Container(
                            // width: 100,
                            padding:
                                EdgeInsets.symmetric(horizontal: smallPadding),
                            decoration: BoxDecoration(
                              color: tertiaryColor,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                              ),
                            ),
                            child: Text(
                              textAlign: TextAlign.center,
                              context.appLoc.free,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ),
                  listItem,
                  if (menuItem.reference == "IC" ||
                      menuItem.reference == "ID" ||
                      menuItem.reference == "AA")
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Image(
                        height: 24,
                        width: 24,
                        image: AssetImage("assets/imgs/mips_coin.png"),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
        break;
      default:
        listItem = InkWell(
          onTap: menuItem.onClick,
          child: Padding(
            padding: const EdgeInsets.all(largePadding),
            child: Center(
              child: Text(
                menuItem.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
        );
        return Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: const AssetImage("assets/imgs/menu_transp_v3.png"),
                    alignment: Alignment.bottomRight,
                    opacity: .05,
                    colorFilter:
                        ColorFilters.matrix(brightness: -1.0, contrast: 1),
                    fit: BoxFit.contain),
                color: menuItem.color,
                borderRadius: BorderRadius.circular(8)),
            margin: const EdgeInsets.all(smallPadding / 2),
            child: listItem);
    }
  }
}
