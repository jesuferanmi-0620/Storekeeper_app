import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageUtils {
  static final ImagePicker _picker = ImagePicker();

  static Future<File?> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }
}