part of '../image_picker_bloc.dart';

extension DeleteImages on ImagePickerBloc {
  Future<void> _deleteImage(
    DeleteImage event,
    Emitter<ImagePickerState> emit,
  ) async {
    emit(ImagePickerLoading());
    try {
      images.removeAt(event.selectedId);
      emit(ImagePickerData(listImages: images));
    } catch (e) {
      emit(ImagePickerError(error: 'Что-то пошло не так'));
    }
  }
}
