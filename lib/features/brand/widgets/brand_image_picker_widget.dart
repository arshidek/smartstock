import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';

class BrandImagePickerWidget extends StatelessWidget {
  final XFile? image;
  final String? imageError;
  final VoidCallback onTap;

  const BrandImagePickerWidget({
    super.key,
    required this.image,
    this.imageError,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: CircleAvatar(
            radius: AppSizes.size45,
            backgroundColor: AppColors.lightGrey,
            backgroundImage: image != null
                ? (kIsWeb
                          ? NetworkImage(image!.path)
                          : FileImage(File(image!.path)))
                      as ImageProvider
                : null,
            child: image == null
                ? const Icon(
                    Icons.add_a_photo,
                    size: AppSizes.size25,
                    color: AppColors.grey,
                  )
                : null,
          ),
        ),
        if (imageError != null)
          Padding(
            padding: const EdgeInsets.only(top: AppSizes.padding8),
            child: Text(
              imageError!,
              style: const TextStyle(
                color: AppColors.error,
                fontSize: AppSizes.font14,
              ),
            ),
          ),
      ],
    );
  }
}
