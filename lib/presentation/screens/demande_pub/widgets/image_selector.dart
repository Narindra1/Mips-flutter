import 'package:mips/common/common.dart';
import 'package:flutter/material.dart';

class ImageSelector extends StatefulWidget {
  @override
  _ImageSelectorState createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
  String? selectedImage;

  @override
  Widget build(BuildContext context) {
    return
    // Scaffold(
    //   body:
    GridView.builder(
      padding: const EdgeInsets.all(largePadding),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // number of columns
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: imagePaths.length,
      itemBuilder: (context, index) {
        final imagePath = imagePaths[index];
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedImage = imagePath;
            });
            // Do something with the selected image
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(imagePath, fit: BoxFit.cover),
              if (selectedImage == imagePath)
                Container(
                  color: Colors.black45,
                  child: const Icon(
                    Icons.check_circle,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
            ],
          ),
        );
      },
      // ),
    );
  }
}
