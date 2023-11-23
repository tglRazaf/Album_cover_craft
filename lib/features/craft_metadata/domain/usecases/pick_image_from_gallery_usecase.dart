import 'dart:io';

import 'package:album_cover_craft/core/usecase/usecase.dart';
import 'package:image_picker/image_picker.dart';

class PickImageFromGalleryUsecase implements Usecase<Future<File?>, NoParam> {
  @override
  Future<File?> call(NoParam param) async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      return File(pickedImage.path);
    }
    return null;
  }
}
