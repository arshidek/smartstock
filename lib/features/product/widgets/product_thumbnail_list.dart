import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProductThumbnailList extends StatelessWidget {
  final List<String> images;
  final int currentImageIndex;
  final Function(int) onThumbnailSelected;

  const ProductThumbnailList({
    super.key,
    required this.images,
    required this.currentImageIndex,
    required this.onThumbnailSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 60,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: images.length > 5 ? 5 : images.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          if (index == 4 && images.length > 5) {
            return Container(
              width: 60,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F4FA),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  "+${images.length - 4}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
            );
          }
          final isSelected = currentImageIndex == index;
          return GestureDetector(
            onTap: () => onThumbnailSelected(index),
            child: Container(
              width: 60,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F4FA),
                borderRadius: BorderRadius.circular(8),
                border: isSelected
                    ? Border.all(color: Colors.blueAccent, width: 2)
                    : null,
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: kIsWeb
                      ? Image.network(images[index], fit: BoxFit.cover)
                      : Image.file(File(images[index]), fit: BoxFit.cover),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
