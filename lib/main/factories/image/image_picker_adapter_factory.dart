import 'package:image_picker/image_picker.dart';

import '../../../data/image/image.dart';
import '../../../infra/image/image.dart';

LocalPickImage makePickImagerAdapter() =>
    ImagePickerAdapter(picker: ImagePicker());
