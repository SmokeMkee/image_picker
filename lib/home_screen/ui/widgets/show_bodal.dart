import 'dart:io';

import 'package:flutter/material.dart';

void showTappedImage({
  required BuildContext context,
  required File file,
  required VoidCallback onPressDelete,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: const Color(0xff212429).withOpacity(0.0),
        insetPadding: EdgeInsets.zero,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: onPressDelete,
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Flexible(
              child: ImageZoom(
                file: file,
              ),
            ),
          ],
        ),
      );
    },
  );
}

class ImageZoom extends StatefulWidget {
  const ImageZoom({Key? key, required this.file}) : super(key: key);
  final File file;

  @override
  State<ImageZoom> createState() => _ImageZoomState();
}

class _ImageZoomState extends State<ImageZoom> with SingleTickerProviderStateMixin {
  late TransformationController controller;
  late AnimationController animationController;
  Animation<Matrix4>? animation;

  @override
  void initState() {
    controller = TransformationController();
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(() {
        controller.value == animation!.value;
      });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      minScale: 1,
      transformationController: controller,
      panEnabled: false,
      maxScale: 4,
      onInteractionEnd: (details) {
        controller.value = Matrix4.identity();
      },
      clipBehavior: Clip.none,
      child: AspectRatio(
        aspectRatio: 1,
        child: Image.file(
          widget.file,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
