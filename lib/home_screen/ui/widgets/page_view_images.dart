import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker_task/home_screen/ui/widgets/show_bodal.dart';

import '../../bloc/image_picker_bloc.dart';

class PageViewImages extends StatefulWidget {
  const PageViewImages({Key? key, required this.images}) : super(key: key);
  final List<File> images;

  @override
  State<PageViewImages> createState() => _PageViewImagesState();
}

class _PageViewImagesState extends State<PageViewImages> {
  final PageController _pageController =
      PageController(initialPage: 0, viewportFraction: 0.76);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          SizedBox(
            height: 350,
            child: PageView.builder(
              onPageChanged: (page) => setState(() => currentIndex = page),
              itemCount: widget.images.length,
              controller: _pageController,
              itemBuilder: (context, int index) {
                var scale = currentIndex == index ? 1.0 : 0.8;
                return GestureDetector(
                  onTap: () => showTappedImage(
                    context: context,
                    file: widget.images[index],
                    onPressDelete: () {
                      context.read<ImagePickerBloc>().add(
                            DeleteImage(selectedId: index),
                          );
                      Navigator.pop(context);
                    },
                  ),
                  child: TweenAnimationBuilder(
                    duration: const Duration(milliseconds: 350),
                    tween: Tween(begin: scale, end: scale),
                    builder:
                        (BuildContext context, double value, Widget? child) {
                      return Transform.scale(
                        scale: value,
                        child: child,
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(26),
                      child: Image.file(
                        widget.images[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 15),
          if (widget.images.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  color: Colors.blue.withOpacity(0.7),
                  onPressed: () {
                    if(currentIndex > 0) {
                      _pageController.previousPage(
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.easeIn,
                    );
                    }
                  },
                  icon: const Icon(
                    Icons.arrow_circle_left,
                    size: 35,
                  ),
                ),
                const SizedBox(width: 20),
                IconButton(
                  color: Colors.blue.withOpacity(0.7),
                  onPressed: () {
                    if(currentIndex < widget.images.length) {
                      _pageController.nextPage(
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.easeIn,
                    );
                    }
                  },
                  icon: const Icon(
                    Icons.arrow_circle_right,
                    size: 35,
                  ),
                )
              ],
            ),
        ],
      ),
    );
  }
}
