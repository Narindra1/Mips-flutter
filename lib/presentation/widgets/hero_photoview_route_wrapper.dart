import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_view/photo_view.dart';

import 'loading_image_cache_widget.dart';

class HeroPhotoViewRouteWrapper extends StatefulWidget {
  const HeroPhotoViewRouteWrapper({
    super.key,
    required this.urls,
    required this.selectedImgIndex,
    required this.title,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
  });

  final List<String> urls;
  final int selectedImgIndex;
  final BoxDecoration? backgroundDecoration;
  final Text title;
  final dynamic minScale;
  final dynamic maxScale;

  @override
  State<HeroPhotoViewRouteWrapper> createState() =>
      _HeroPhotoViewRouteWrapperState();
}

class _HeroPhotoViewRouteWrapperState extends State<HeroPhotoViewRouteWrapper> {
  late PageController pageController;
  late int currentIndex;
  bool isZoomed = false;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.selectedImgIndex;
    pageController = PageController(initialPage: widget.selectedImgIndex);
    pageController.addListener(() {
      final newIndex = pageController.page?.round() ?? widget.selectedImgIndex;
      if (newIndex != currentIndex) {
        setState(() {
          currentIndex = newIndex;
        });
      }
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void onScaleStateChanged(PhotoViewScaleState state) {
    setState(() {
      isZoomed =
          state == PhotoViewScaleState.zoomedIn ||
          state == PhotoViewScaleState.zoomedOut;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.title,
        actionsPadding: EdgeInsets.all(0),
        titleSpacing: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.chevron_left_outlined, color: Colors.black),
        ),
      ),
      body: PageView(
        controller: pageController,
        children: List.generate(
          widget.urls.length,
          (index) => PhotoViewGestureDetectorScope(
            axis: Axis.horizontal,
            child: PhotoView.customChild(
              initialScale: PhotoViewComputedScale.contained,
              minScale: widget.minScale ?? PhotoViewComputedScale.contained,
              maxScale:
                  widget.maxScale ?? PhotoViewComputedScale.contained * 2.5,
              heroAttributes: PhotoViewHeroAttributes(tag: widget.urls[index]),
              scaleStateChangedCallback: onScaleStateChanged,
              child: CachedNetworkImage(
                imageUrl: widget.urls[index],
                progressIndicatorBuilder: (context, url, progress) =>
                    const LoadingImageCacheWidget(),
                errorWidget: (context, url, error) => const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline),
                    Text("Error loading image"),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
