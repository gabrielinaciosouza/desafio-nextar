import 'dart:io';

abstract class LocalPickImage {
  Future<File?> pickFromCamera();
  Future<File?> pickFromDevice();
}
