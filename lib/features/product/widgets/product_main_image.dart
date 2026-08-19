import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';

class ProductMainImage extends StatelessWidget {
  final List<String> images;
  final String? displayImage;
  final int currentImageIndex;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const ProductMainImage({
    super.key,
    required this.images,
    required this.displayImage,
    required this.currentImageIndex,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF0F4FA),
        borderRadius: BorderRadius.circular(AppSizes.borderRadius16),
      ),
      child: Stack(
        children: [
          Center(
            child: displayImage != null && displayImage!.isNotEmpty
                ? kIsWeb
                      ? Image.network(displayImage!, fit: BoxFit.contain)
                      : Image.file(File(displayImage!), fit: BoxFit.contain)
                : const Icon(
                    Icons.image_outlined,
                    size: 80,
                    color: AppColors.grey,
                  ),
          ),
          if (currentImageIndex == 0 && images.isNotEmpty)
            Positioned(
              top: 16,
              left: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow, size: 14),
                    SizedBox(width: 4),
                    Text(
                      "Primary",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (images.length > 1) ...[
            Positioned(
              left: 10,
              top: 0,
              bottom: 0,
              child: Center(
                child: InkWell(
                  onTap: onPrevious,
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0.8),
                    radius: 18,
                    child: const Icon(
                      Icons.chevron_left,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 10,
              top: 0,
              bottom: 0,
              child: Center(
                child: InkWell(
                  onTap: onNext,
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0.8),
                    radius: 18,
                    child: const Icon(
                      Icons.chevron_right,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
