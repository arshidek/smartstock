import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class SplashBackgroundGadgets extends StatelessWidget {
  final Animation<double> scaleAnimation;

  const SplashBackgroundGadgets({super.key, required this.scaleAnimation});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          top: height * 0.12,
          left: width * 0.1,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: const Opacity(
              opacity: 0.08,
              child: Icon(Icons.phone_android, size: 50, color: AppColors.blue),
            ),
          ),
        ),

        Positioned(
          top: height * 0.08,
          right: width * 0.35,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: const Opacity(
              opacity: 0.08,
              child: Icon(Icons.cable, size: 50, color: AppColors.blue),
            ),
          ),
        ),

        Positioned(
          top: height * 0.18,
          right: width * 0.12,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: const Opacity(
              opacity: 0.08,
              child: Icon(Icons.headphones, size: 45, color: AppColors.blue),
            ),
          ),
        ),

        Positioned(
          top: height * 0.45,
          left: width * 0.05,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: const Opacity(
              opacity: 0.08,
              child: Icon(Icons.laptop_mac, size: 60, color: AppColors.blue),
            ),
          ),
        ),

        Positioned(
          top: height * 0.55,
          right: width * 0.08,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: const Opacity(
              opacity: 0.08,
              child: Icon(Icons.speaker, size: 50, color: AppColors.blue),
            ),
          ),
        ),
        // Bottom Left Area
        Positioned(
          bottom: height * 0.15,
          left: width * 0.2,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: const Opacity(
              opacity: 0.08,
              child: Icon(Icons.watch, size: 45, color: AppColors.blue),
            ),
          ),
        ),

        Positioned(
          bottom: height * 0.08,
          right: width * 0.4,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: const Opacity(
              opacity: 0.08,
              child: Icon(
                Icons.battery_charging_full,
                size: 55,
                color: AppColors.blue,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
