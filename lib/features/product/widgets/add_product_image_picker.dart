import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';

class MainImagePicker extends StatelessWidget {
  final List<File> images;
  final VoidCallback onPickImages;
  final Function(int) onRemoveImage;
  final String? imageError;

  const MainImagePicker({
    super.key,
    required this.images,
    required this.onPickImages,
    required this.onRemoveImage,
    this.imageError,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (images.isEmpty)
          GestureDetector(
            onTap: onPickImages,
            child: Container(
              width: AppSizes.size110,
              height: AppSizes.size110,
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
              ),
              child: const Icon(
                Icons.add_a_photo,
                size: AppSizes.size40,
                color: AppColors.grey,
              ),
            ),
          )
        else
          Stack(
            children: [
              Container(
                width: AppSizes.size110,
                height: AppSizes.size110,
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
                  image: DecorationImage(
                    image: kIsWeb
                        ? NetworkImage(images.first.path) as ImageProvider
                        : FileImage(images.first),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () => onRemoveImage(0),
                  child: CircleAvatar(
                    radius: AppSizes.size12,
                    backgroundColor: AppColors.error,
                    child: Icon(
                      Icons.close,
                      color: AppColors.white,
                      size: AppSizes.size15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        if (imageError != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              imageError!,
              style: const TextStyle(
                color: AppColors.error,
                fontSize: AppSizes.font13,
              ),
            ),
          ),
      ],
    );
  }
}

class ThumbnailImagePicker extends StatelessWidget {
  final List<File> images;
  final VoidCallback onPickImages;
  final Function(int) onRemoveImage;

  const ThumbnailImagePicker({
    super.key,
    required this.images,
    required this.onPickImages,
    required this.onRemoveImage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSizes.padding10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ...images.asMap().entries.skip(1).map((entry) {
              int index = entry.key;
              File image = entry.value;
              return Padding(
                padding: const EdgeInsets.only(right: AppSizes.size10),
                child: Stack(
                  children: [
                    Container(
                      width: AppSizes.size50,
                      height: AppSizes.size50,
                      decoration: BoxDecoration(
                        color: AppColors.lightGrey,
                        borderRadius: BorderRadius.circular(
                          AppSizes.borderRadius8,
                        ),
                        image: DecorationImage(
                          image: kIsWeb
                              ? NetworkImage(image.path) as ImageProvider
                              : FileImage(image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () => onRemoveImage(index),
                        child: CircleAvatar(
                          radius: AppSizes.size10,
                          backgroundColor: AppColors.error,
                          child: Icon(
                            Icons.close,
                            color: AppColors.white,
                            size: AppSizes.size12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            GestureDetector(
              onTap: onPickImages,
              child: Container(
                width: AppSizes.size50,
                height: AppSizes.size50,
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(AppSizes.borderRadius8),
                ),
                child: const Icon(
                  Icons.add_a_photo,
                  size: AppSizes.size20,
                  color: AppColors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
