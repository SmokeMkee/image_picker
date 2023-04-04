import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker_task/home_screen/bloc/image_picker_bloc.dart';
import 'package:image_picker_task/home_screen/ui/widgets/empty.dart';
import 'package:image_picker_task/home_screen/ui/widgets/error.dart';
import 'package:image_picker_task/home_screen/ui/widgets/page_view_images.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
          ),
          backgroundColor: Colors.blue.withOpacity(0.3)
        ),
        onPressed: () {
          context.read<ImagePickerBloc>().add(PickImage());
        },
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Text('Choose image'),
        ),
      ),
      appBar: AppBar(
        title: const Text('My Image Picker'),
        centerTitle: true,
        elevation: 4,
        backgroundColor: Colors.blue.withOpacity(0.3),
      ),
      body: BlocBuilder<ImagePickerBloc, ImagePickerState>(
        builder: (context, state) {
          if (state is ImagePickerData) {
            return state.listImages.isEmpty
                ? const EmptyWidget()
                : PageViewImages(images: state.listImages);
          }
          if (state is ImagePickerError) {
            return ErrorWidgets(error: state.error);
          }
          return const EmptyWidget();
        },
      ),
    );
  }
}
