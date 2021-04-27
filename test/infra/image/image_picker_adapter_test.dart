import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:desafio_nextar/data/image/image.dart';

class ImagePickerSpy extends Mock implements ImagePicker {
  final PickedFile pickedFile;
  ImagePickerSpy({required this.pickedFile});
  @override
  Future<PickedFile?> getImage({
    required ImageSource source,
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
    CameraDevice preferredCameraDevice = CameraDevice.rear,
  }) =>
      this.noSuchMethod(
          Invocation.method(#getImage, [
            source,
            maxWidth,
            maxHeight,
            imageQuality,
            preferredCameraDevice
          ]),
          returnValue: Future.value(pickedFile),
          returnValueForMissingStub: Future.value(pickedFile));
}

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

void main() {
  late ImagePickerSpy imagePicker;
  late ImagePickerAdapter sut;
  late PickedFile pickedFile;

  setUp(() {
    pickedFile = PickedFile('');
    imagePicker = ImagePickerSpy(pickedFile: pickedFile);
    sut = ImagePickerAdapter(picker: imagePicker);
  });

  test('Should call functions with correct values', () async {
    await sut.pickFromCamera();
    await sut.pickFromDevice();

    verify(imagePicker.getImage(source: ImageSource.gallery));
    verify(imagePicker.getImage(source: ImageSource.camera));
  });

  test('Should throw if ImagePicker throws', () async {
    when(imagePicker.getImage(source: ImageSource.gallery))
        .thenThrow(Exception());

    final future = sut.pickFromDevice();

    expect(future, throwsA(TypeMatcher<Exception>()));
  });

  test('Should throw if ImagePicker throws', () async {
    when(imagePicker.getImage(source: ImageSource.camera))
        .thenThrow(Exception());

    final future = sut.pickFromCamera();

    expect(future, throwsA(TypeMatcher<Exception>()));
  });
}
