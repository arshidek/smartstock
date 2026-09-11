import 'package:flutter/material.dart';
import '../../../app/app_navigation.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/services/hive_service.dart';
import '../../../core/utils/app_snack_bar.dart';
import '../../../core/widgets/dialogs/logout_dialog.dart';
import '../../../core/widgets/bottom_nav/app_bottom_navigation_bar.dart';
import '../../auth/presentation/login_screen.dart';
import '../../profile/presentation/profile_screen.dart';
import '../widgets/security_notice_card.dart';
import '../widgets/setting_item_group.dart';
import '../widgets/setting_section_header.dart';
import 'about_app_screen.dart';
import 'privacy_policy_screen.dart';
import 'terms_conditions_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _handleLogout(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => LogoutDialog(
        onLogout: () async {
          Navigator.pop(context); // Close dialog

          final authService = AuthService();
          final hiveService = HiveService();
          final userId = authService.getCurrentUserId();

          await authService.logout();

          if (userId != null) {
            await hiveService.closeUserBoxes(userId);
          }

          if (!context.mounted) return;

          AppNavigation.goToScreenAndRemoveAll(context, const LoginScreen());

          AppSnackBar.success(context, "Logged out successfully!");
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.appBarColor,
      appBar: AppBar(
        backgroundColor: AppColors.blue,
        elevation: 1,
        centerTitle: false,
        automaticallyImplyLeading: false,
        titleSpacing: AppSizes.padding16,
        title: Text(
          "Settings",
          style: TextStyle(
            color: AppColors.white,
            fontSize: AppSizes.font24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.background),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: AppSizes.size40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [



              // Account Section
              const SettingSectionHeader(title: "ACCOUNT"),
              SettingItemGroup(
                items: [
                  SettingItemModel(
                    icon: Icons.person_outline,
                    title: "Profile",
                    subtitle: "Manage your account information",
                    iconBackgroundColor: AppColors.lightPurple,
                    iconColor: AppColors.blue,
                    onTap: () {
                      AppNavigation.goToScreen(context, const ProfileScreen());
                    },
                  ),
                ],
              ),

              // More Section
              const SettingSectionHeader(title: "MORE"),
              SettingItemGroup(
                items: [
                  SettingItemModel(
                    icon: Icons.info_outline,
                    title: "About App",
                    subtitle: "Version 1.0.0",
                    iconBackgroundColor: const Color(
                      0xFFFFF3E0,
                    ), // Light orange
                    iconColor: const Color(0xFFFF9800), // Orange
                    onTap: () {
                      AppNavigation.goToScreen(context, const AboutAppScreen());
                    },
                  ),
                  SettingItemModel(
                    icon: Icons.description_outlined,
                    title: "Terms & Conditions",
                    subtitle: "Read our terms and conditions",
                    iconBackgroundColor: const Color(
                      0xFFE8EAF6,
                    ), // Light indigo
                    iconColor: const Color(0xFF3F51B5), // Indigo
                    onTap: () {
                      AppNavigation.goToScreen(
                        context,
                        const TermsConditionsScreen(),
                      );
                    },
                  ),
                  SettingItemModel(
                    icon: Icons.privacy_tip_outlined,
                    title: "Privacy Policy",
                    subtitle: "Read our privacy policy",
                    iconBackgroundColor: const Color(0xFFE3F2FD), // Light blue
                    iconColor: AppColors.blue,
                    onTap: () {
                      AppNavigation.goToScreen(context, PrivacyPolicyScreen());
                    },
                  ),
                ],
              ),

              // Session/Logout Section
              const SettingSectionHeader(title: "ACCOUNT"),
              SettingItemGroup(
                items: [
                  SettingItemModel(
                    icon: Icons.logout,
                    title: "Logout",
                    subtitle: "Logout from your account",
                    iconBackgroundColor: const Color(0xFFFFEBEE), // Light red
                    iconColor: AppColors.error,
                    isDestructive: true,
                    onTap: () => _handleLogout(context),
                  ),
                ],
              ),

              const SizedBox(height: AppSizes.size32),
              const SecurityNoticeCard(),
            ],
          ),
        ),
      ),

      // Close Container
      bottomNavigationBar: const AppBottomNavigationBar(currentIndex: 3),
    );
  }
}
