part of 'image_picker_bloc.dart';

abstract class ImagePickerState {}

class ImagePickerInitial extends ImagePickerState {}

class ImagePickerLoading extends ImagePickerState {}

class ImagePickerData extends ImagePickerState {
  final List<File> listImages;

  ImagePickerData({required this.listImages});
}

class ImagePickerError extends ImagePickerState {
  ImagePickerError({required this.error});

  final String error;
}
