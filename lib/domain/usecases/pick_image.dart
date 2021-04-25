import 'dart:io';

abstract class PickImage {
  Future<File> pickFromCamera();
  Future<File> pickFromDevice();
}
