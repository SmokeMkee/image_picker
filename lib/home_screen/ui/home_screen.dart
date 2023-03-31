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
        onPressed: () {
          context.read<ImagePickerBloc>().add(PickImage());
        },
        child: const Text('Choose image'),
      ),
      appBar: AppBar(
        title: const Text('Image Picker'),
        centerTitle: true,
      ),
      body: BlocBuilder<ImagePickerBloc, ImagePickerState>(
        builder: (context, state) {
          if (state is ImagePickerLoading) {
            return const CircularProgressIndicator();
          }
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
