import 'package:flutter/material.dart';
import '../../../../app/app_navigation.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/widgets/bottom_nav/app_bottom_navigation_bar.dart';
import '../../../profile/presentation/profile_screen/profile_screen.dart';
import '../../function/settings_functions.dart';
import '../../widgets/security_notice_card.dart';
import '../../widgets/setting_item_group.dart';
import '../../widgets/setting_section_header.dart';
import '../about_app/about_app_screen.dart';
import '../privacy_policy/privacy_policy_screen.dart';
import '../terms_conditions/terms_conditions_screen.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final SettingsFunctions _functions = SettingsFunctions();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(bottom: AppSizes.size40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                    iconBackgroundColor: AppColors.lightWarning,
                    iconColor: AppColors.warning,
                    onTap: () {
                      AppNavigation.goToScreen(context, const AboutAppScreen());
                    },
                  ),
                  SettingItemModel(
                    icon: Icons.description_outlined,
                    title: "Terms & Conditions",
                    subtitle: "Read our terms and conditions",
                    iconBackgroundColor: AppColors.lightIndigo,
                    iconColor: AppColors.indigo, // Indigo
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
                    iconBackgroundColor: AppColors.lightBlue, // Light blue
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
                    iconBackgroundColor: AppColors.lightError, // Light red
                    iconColor: AppColors.error,
                    isDestructive: true,
                    onTap: () => _functions.handleLogout(context),
                  ),
                ],
              ),

              const SizedBox(height: AppSizes.size32),
              const SecurityNoticeCard(),
            ],
          ),
        ),
      ),

      bottomNavigationBar: const AppBottomNavigationBar(currentIndex: 3),
    );
  }
}
