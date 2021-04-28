import '../../factories/image/image.dart';

import '../../../data/usecases/image_picker/image_picker.dart';

import '../../../domain/usecases/usecases.dart';

PickImage makeLocalPickImage() {
  return LocalImagePicker(localPickImage: makePickImagerAdapter());
}
