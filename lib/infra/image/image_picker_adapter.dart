import 'dart:io';

import '../../data/image/image.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerAdapter implements LocalPickImage {
  final ImagePicker picker;

  ImagePickerAdapter({required this.picker});

  @override
  Future<File?> pickFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return Future.value();
  }

  @override
  Future<File?> pickFromDevice() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return Future.value();
  }
}
