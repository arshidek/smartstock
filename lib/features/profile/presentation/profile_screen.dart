import 'package:flutter/foundation.dart';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../app/app_navigation.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/services/user_service.dart';
import '../../../data/models/user_model.dart';
import '../widgets/profile_avatar.dart';
import '../widgets/profile_info_card.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserService _userService = UserService();
  UserModel? currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = _userService.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    if (currentUser == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: Container(
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
                        currentUser!.profileImagePath != null &&
                                currentUser!.profileImagePath!.isNotEmpty
                            ? kIsWeb
                                  ? Image.network(
                                      currentUser!.profileImagePath!,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      File(currentUser!.profileImagePath!),
                                      fit: BoxFit.cover,
                                    )
                            : Container(color: AppColors.appBarColor),

                        // Blur Effect
                        BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                          child: Container(
                            color: Colors.black.withOpacity(0.2),
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
                        color: Colors.black,
                        size: AppSizes.size25,
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
                      onPressed: () async {
                        await AppNavigation.goToScreen(
                          context,
                          const EditProfileScreen(),
                        );

                        setState(() {
                          currentUser = _userService.getCurrentUser();
                        });
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.black,
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
                  child: Center(child: ProfileAvatar(user: currentUser!)),
                ),
              ],
            ),

            const SizedBox(height: AppSizes.size60),

            Text(
              currentUser!.username,
              style: const TextStyle(
                fontSize: AppSizes.size25,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              currentUser!.shopName.isEmpty
                  ? "No Shop Name"
                  : currentUser!.shopName,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
                fontSize: AppSizes.font16,
              ),
            ),

            const SizedBox(height: AppSizes.size20),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSizes.size15),
                child: Column(children: [ProfileInfoCard(user: currentUser!)]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
