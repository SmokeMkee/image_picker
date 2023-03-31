import 'dart:async';
import 'dart:io';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'image_picker_event.dart';

part 'parts/delete_image.dart';

part 'parts/pick_image.dart';

part 'image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  List<File> images = [];
  final ImagePicker imagePicker = ImagePicker();

  ImagePickerBloc() : super(ImagePickerInitial()) {
    on<PickImage>(_pickImage, transformer: droppable());
    on<DeleteImage>(_deleteImage, transformer: droppable());
  }
}
