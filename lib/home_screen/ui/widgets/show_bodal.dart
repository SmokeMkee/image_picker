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
              child: InteractiveViewer(
                minScale: 1,
                panEnabled: false,
                maxScale: 4,
                clipBehavior: Clip.none,
                child: Image.file(
                  file,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
