part of 'image_picker_bloc.dart';

abstract class ImagePickerEvent {}

class PickImage extends ImagePickerEvent {}

class DeleteImage extends ImagePickerEvent {
  DeleteImage({required this.selectedId});

  final int selectedId;
}
