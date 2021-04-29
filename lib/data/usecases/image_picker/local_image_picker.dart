import 'dart:io';

import '../../image/image.dart';

import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/pick_image.dart';

class LocalImagePicker implements PickImage {
  LocalPickImage localPickImage;

  LocalImagePicker({required this.localPickImage});
  @override
  Future<File?> pickFromCamera() async {
    try {
      return await localPickImage.pickFromCamera();
    } catch (error) {
      throw DomainError.unexpected;
    }
  }

  @override
  Future<File?> pickFromDevice() async {
    try {
      return await localPickImage.pickFromDevice();
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
