import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  ImagePickerHelper._();

  static Future<File?> pickImage() async {
    final picker = ImagePicker();

    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );

    if (pickedFile == null) {
      return null;
    }

    return File(pickedFile.path);
  }

  static Future<XFile?> pickImageXFile() async {
    final picker = ImagePicker();

    return await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );
  }

  // Added to support multi-images for products
  static Future<List<File>> pickMultiImages() async {
    final picker = ImagePicker();

    final List<XFile> pickedFiles = await picker.pickMultiImage(
      imageQuality: 100,
    );

    return pickedFiles.map((file) => File(file.path)).toList();
  }
}
