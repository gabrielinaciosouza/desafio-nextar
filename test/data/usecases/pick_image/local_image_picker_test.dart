import 'dart:io';
import 'package:loja_virtual/data/image/image.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:loja_virtual/data/usecases/usecases.dart';

import 'package:loja_virtual/domain/helpers/domain_error.dart';

class LocalPickImageSpy extends Mock implements LocalPickImage {
  final File file;
  LocalPickImageSpy({required this.file});
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
  late File file;
  late LocalPickImage localPickImage;
  late LocalImagePicker sut;

  setUp(() {
    file = File('any_path');
    localPickImage = LocalPickImageSpy(file: file);
    sut = LocalImagePicker(localPickImage: localPickImage);
  });
  test('Should call ImagePickerAdapter', () async {
    await sut.pickFromCamera();
    await sut.pickFromDevice();

    verify(localPickImage.pickFromCamera()).called(1);
    verify(localPickImage.pickFromDevice()).called(1);
  });

  test('Should return a valid value on success', () async {
    final returnedFile = await sut.pickFromCamera();
    final returnedFile2 = await sut.pickFromDevice();

    expect(returnedFile, file);
    expect(returnedFile2, file);
  });

  test('Should throw unexpected if LocalPickImage fails camera', () async {
    when(localPickImage.pickFromCamera()).thenThrow(Exception());
    final future = sut.pickFromCamera();

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw unexpected if LocalPickImage fails device', () async {
    when(localPickImage.pickFromDevice()).thenThrow(Exception());
    final future = sut.pickFromDevice();

    expect(future, throwsA(DomainError.unexpected));
  });
}
