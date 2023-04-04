import 'dart:async';
import 'dart:io';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'image_picker_event.dart';

part 'image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  List<File> images = [];
  final ImagePicker imagePicker = ImagePicker();

  ImagePickerBloc() : super(ImagePickerInitial()) {
    on<PickImage>(_pickImage, transformer: droppable());
    on<DeleteImage>(_deleteImage, transformer: droppable());
  }

  Future<void> _deleteImage(
    DeleteImage event,
    Emitter<ImagePickerState> emit,
  ) async {
    try {
      images.removeAt(event.selectedId);
      emit(ImagePickerData(listImages: images));
    } catch (e) {
      emit(ImagePickerError(error: 'Что-то пошло не так'));
    }
  }

  Future<void> _pickImage(
    ImagePickerEvent event,
    Emitter<ImagePickerState> emit,
  ) async {
    try {
      final pickedFile =
          await imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        images.add(File(pickedFile.path));
      }
      emit(ImagePickerData(listImages: images));
    } catch (e) {
      emit(ImagePickerError(error: 'Что-то пошло не так'));
    }
  }
}
