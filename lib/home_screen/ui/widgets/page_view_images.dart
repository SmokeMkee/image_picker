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
      PageController(initialPage: 0, viewportFraction: 0.8);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: PageView.builder(
            onPageChanged: (page) => setState(() => currentIndex = page),
            itemCount: widget.images.length,
            controller: _pageController,
            itemBuilder: (context, int index) {
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: GestureDetector(
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
                  child: Image.file(
                    widget.images[index],
                    fit: BoxFit.contain,
                  ),
                ),
              );
            },
          ),
        ),
        Flexible(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: widget.images.length,
            itemBuilder: (context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor:
                      currentIndex == index ? Colors.black : Colors.grey,
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
