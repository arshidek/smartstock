import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class SplashBackgroundGadgets extends StatelessWidget {
  final Animation<double> scaleAnimation;

  const SplashBackgroundGadgets({super.key, required this.scaleAnimation});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          top: 120,
          left: 20,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Opacity(
              opacity: 0.08,
              child: Icon(Icons.phone_android, size: 50, color: AppColors.blue),
            ),
          ),
        ),
        Positioned(
          top: 220,
          right: 30,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Opacity(
              opacity: 0.08,
              child: Icon(Icons.headphones, size: 45, color: AppColors.blue),
            ),
          ),
        ),
        Positioned(
          bottom: 220,
          left: 40,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Opacity(
              opacity: 0.08,
              child: Icon(
                Icons.battery_charging_full,
                size: 55,
                color: AppColors.blue,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 150,
          right: 20,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Opacity(
              opacity: 0.08,
              child: Icon(Icons.cable, size: 50, color: AppColors.blue),
            ),
          ),
        ),
        Positioned(
          top: 150,
          right: 120,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Opacity(
              opacity: 0.08,
              child: Icon(Icons.watch, size: 45, color: AppColors.blue),
            ),
          ),
        ),
        Positioned(
          top: 400,
          left: 30,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Opacity(
              opacity: 0.08,
              child: Icon(Icons.laptop_mac, size: 60, color: AppColors.blue),
            ),
          ),
        ),
        Positioned(
          top: 450,
          right: 40,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Opacity(
              opacity: 0.08,
              child: Icon(Icons.speaker, size: 50, color: AppColors.blue),
            ),
          ),
        ),
      ],
    );
  }
}
