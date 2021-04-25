import 'dart:io';

import 'package:desafio_nextar/domain/usecases/pick_image.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

abstract class LocalPickImage {
  Future<File> pickFromCamera();
  Future<File> pickFromDevice();
}

class LocalImagePicker implements PickImage {
  LocalPickImage localPickImage;

  LocalImagePicker({required this.localPickImage});
  @override
  Future<File> pickFromCamera() async {
    return await localPickImage.pickFromCamera();
  }

  @override
  Future<File> pickFromDevice() async {
    return await localPickImage.pickFromDevice();
  }
}

class LocalPickImageSpy extends Mock implements LocalPickImage {
  final File file = File('any_path');
  @override
  Future<File> pickFromCamera() =>
      this.noSuchMethod(Invocation.method(#pickFromCamera, []),
          returnValue: Future.value(file),
          returnValueForMissingStub: Future.value(file));
  @override
  Future<File> pickFromDevice() =>
      this.noSuchMethod(Invocation.method(#pickFromDevice, []),
          returnValue: Future.value(file),
          returnValueForMissingStub: Future.value(file));
}

void main() {
  test('Should call ImagePickerAdapter', () async {
    final LocalPickImage localPickImage = LocalPickImageSpy();
    final sut = LocalImagePicker(localPickImage: localPickImage);

    await sut.pickFromCamera();
    await sut.pickFromDevice();

    verify(localPickImage.pickFromCamera()).called(1);
    verify(localPickImage.pickFromDevice()).called(1);
  });
}
