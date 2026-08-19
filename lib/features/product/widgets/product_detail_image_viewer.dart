import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import 'product_main_image.dart';
import 'product_thumbnail_list.dart';

class ProductDetailImageViewer extends StatefulWidget {
  final List<String> images;

  const ProductDetailImageViewer({super.key, required this.images});

  @override
  State<ProductDetailImageViewer> createState() =>
      _ProductDetailImageViewerState();
}

class _ProductDetailImageViewerState extends State<ProductDetailImageViewer> {
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final images = widget.images;
    final displayImage = images.isNotEmpty ? images[_currentImageIndex] : null;

    return Column(
      children: [
        ProductMainImage(
          images: images,
          displayImage: displayImage,
          currentImageIndex: _currentImageIndex,
          onPrevious: () {
            setState(() {
              _currentImageIndex = (_currentImageIndex - 1) < 0
                  ? images.length - 1
                  : _currentImageIndex - 1;
            });
          },
          onNext: () {
            setState(() {
              _currentImageIndex = (_currentImageIndex + 1) % images.length;
            });
          },
        ),
        const SizedBox(height: 16),
        ProductThumbnailList(
          images: images,
          currentImageIndex: _currentImageIndex,
          onThumbnailSelected: (index) {
            setState(() {
              _currentImageIndex = index;
            });
          },
        ),
      ],
    );
  }
}
