part of '../image_picker_bloc.dart';

extension AddImages on ImagePickerBloc {
  Future<void> _pickImage(
    ImagePickerEvent event,
    Emitter<ImagePickerState> emit,
  ) async {
    emit(ImagePickerLoading());
    try {
      final pickedFile =
          await imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        images.add(File(pickedFile.path));
        emit(ImagePickerData(listImages: images));
      }
    } catch (e) {
      emit(ImagePickerError(error: 'Что-то пошло не так'));
    }
  }
}
