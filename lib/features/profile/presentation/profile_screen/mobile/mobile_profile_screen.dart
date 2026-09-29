import 'dart:io';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../../app/app_navigation.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../data/models/user_model.dart';
import '../../../widgets/profile_avatar.dart';
import '../../../widgets/profile_info_card.dart';

class MobileProfileScreen extends StatelessWidget {
  final UserModel currentUser;
  final VoidCallback onEdit;

  const MobileProfileScreen({
    super.key,
    required this.currentUser,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(color: AppColors.lightWhite),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              SizedBox(
                height: AppSizes.size250,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(AppSizes.borderRadius30),
                    bottomRight: Radius.circular(AppSizes.borderRadius30),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Background Image
                      currentUser.profileImagePath != null &&
                              currentUser.profileImagePath!.isNotEmpty
                          ? kIsWeb
                                ? Image.network(
                                    currentUser.profileImagePath!,
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(
                                    File(currentUser.profileImagePath!),
                                    fit: BoxFit.cover,
                                  )
                          : Container(color: AppColors.appBarColor),

                      // Blur Effect
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                        child: Container(
                          color: AppColors.black.withOpacity(0.2),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Back Button
              Positioned(
                top: AppSizes.size40,
                left: AppSizes.size10,
                child: CircleAvatar(
                  radius: AppSizes.borderRadius25,
                  backgroundColor: AppColors.lightWhite,
                  child: IconButton(
                    onPressed: () {
                      AppNavigation.goBack(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: AppColors.black,
                      size: AppSizes.size30,
                    ),
                  ),
                ),
              ),

              // Edit Button
              Positioned(
                top: AppSizes.size40,
                right: AppSizes.size10,
                child: CircleAvatar(
                  radius: AppSizes.borderRadius25,
                  backgroundColor: AppColors.lightWhite,
                  child: IconButton(
                    onPressed: onEdit,
                    icon: const Icon(
                      Icons.edit,
                      color: AppColors.black,
                      size: AppSizes.size25,
                    ),
                  ),
                ),
              ),

              // Avatar
              Positioned(
                bottom: -AppSizes.size55,
                left: 0,
                right: 0,
                child: Center(child: ProfileAvatar(user: currentUser)),
              ),
            ],
          ),

          const SizedBox(height: AppSizes.size60),

          Text(
            currentUser.username,
            style: const TextStyle(
              fontSize: AppSizes.size25,
              fontWeight: FontWeight.bold,
            ),
          ),

          Text(
            currentUser.shopName.isEmpty
                ? "No Shop Name"
                : currentUser.shopName,
            style: const TextStyle(
              color: AppColors.grey,
              fontWeight: FontWeight.w500,
              fontSize: AppSizes.font16,
            ),
          ),

          const SizedBox(height: AppSizes.size20),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSizes.size15),
              child: Column(children: [ProfileInfoCard(user: currentUser)]),
            ),
          ),
        ],
      ),
    );
  }
}
