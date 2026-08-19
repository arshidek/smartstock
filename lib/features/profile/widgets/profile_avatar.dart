import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../data/models/user_model.dart';

class ProfileAvatar extends StatelessWidget {
  final UserModel user;
  final VoidCallback? onCameraTap;

  const ProfileAvatar({super.key, required this.user, this.onCameraTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: AppSizes.size130,
          height: AppSizes.size130,
          padding: const EdgeInsets.all(AppSizes.size5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.blue,
            boxShadow: [
              BoxShadow(
                color: AppColors.blueShadow,
                blurRadius: AppSizes.blurRadius,
                offset: const Offset(0, AppSizes.size10),
              ),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.grey,
              image:
                  user.profileImagePath != null &&
                      user.profileImagePath!.isNotEmpty
                  ? DecorationImage(
                      image: kIsWeb
                          ? NetworkImage(user.profileImagePath!)
                                as ImageProvider
                          : FileImage(File(user.profileImagePath!)),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child:
                user.profileImagePath == null || user.profileImagePath!.isEmpty
                ? Icon(
                    Icons.person,
                    size: AppSizes.size90,
                    color: AppColors.lightWhite,
                  )
                : null,
          ),
        ),

        if (onCameraTap != null)
          Positioned(
            bottom: AppSizes.size7,
            right: 0,
            child: InkWell(
              onTap: onCameraTap,
              child: Container(
                width: AppSizes.size50,
                height: AppSizes.size50,
                decoration: BoxDecoration(
                  color: AppColors.blue,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.white, width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.blueShadow,
                      blurRadius: AppSizes.blurRadius,
                    ),
                  ],
                ),
                child: Icon(Icons.camera_alt, color: AppColors.white),
              ),
            ),
          ),
      ],
    );
  }
}
