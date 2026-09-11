import 'package:flutter/material.dart';
import 'package:smartstock_inventory/app/app_navigation.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background.colors[0],
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.black,
            size: AppSizes.size30,
          ),
          onPressed: () => AppNavigation.goBack(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "About App",
              style: TextStyle(
                color: AppColors.black,
                fontSize: AppSizes.font24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Know more about SmartStock",
              style: TextStyle(color: AppColors.grey, fontSize: AppSizes.font12),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.size20),
        child: Column(
          children: [
            // Top App Info Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSizes.size20),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppSizes.borderRadius16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.blackShadow,
                    blurRadius: AppSizes.blurRadius,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(height: AppSizes.size10),
                  // App logo image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppSizes.borderRadius20),
                    child: Image.asset(
                      'assets/images/app_logo.png',
                      width: AppSizes.size80,
                      height: AppSizes.size80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: AppSizes.size15),
                  const Text(
                    "SmartStock",
                    style: TextStyle(
                      fontSize: AppSizes.font22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.padding10,
                      vertical: AppSizes.size5,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.blue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppSizes.size20),
                    ),
                    child: Text(
                      "Version 1.0.0",
                      style: TextStyle(
                        color: AppColors.blue,
                        fontSize: AppSizes.font10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSizes.size20),
                  const Text(
                    "SmartStock is an offline inventory\nmanagement app designed to help you\nmanage your products, stock and reports\neasily and efficiently.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.grey,
                      fontSize: AppSizes.font13,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: AppSizes.size10),
                ],
              ),
            ),

            const SizedBox(height: AppSizes.size20),

            // Details List Card
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppSizes.borderRadius16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.blackShadow,
                    blurRadius: AppSizes.blurRadius,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildDetailRow(
                    Icons.info,
                    "Version",
                    "1.0.0",
                    const Color(0xFFE8EAF6),
                    const Color(0xFF3F51B5),
                  ),
                  _buildDivider(),
                  _buildDetailRow(
                    Icons.person_outline,
                    "Developed By",
                    "Muhammed Arshid",
                    const Color(0xFFE8F5E9),
                    const Color(0xFF4CAF50),
                  ),
                  _buildDivider(),
                  _buildDetailRow(
                    Icons.calendar_today,
                    "Release Date",
                    "10 May 2025",
                    const Color(0xFFFFF3E0),
                    const Color(0xFFFF9800),
                  ),
                  _buildDivider(),
                  _buildDetailRow(
                    Icons.language,
                    "Platform",
                    "Android",
                    const Color(0xFFE3F2FD),
                    AppColors.blue,
                  ),
                  _buildDivider(),
                  _buildDetailRow(
                    Icons.storage,
                    "Data Storage",
                    "Local (Offline)",
                    const Color(0xFFF3E5F5),
                    const Color(0xFF9C27B0),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSizes.size20),

            // Rate App Card
            Container(
              padding: const EdgeInsets.all(AppSizes.size20),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppSizes.borderRadius16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.blackShadow,
                    blurRadius: AppSizes.blurRadius,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppSizes.padding12),
                    decoration: BoxDecoration(
                      color: AppColors.blue.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.favorite_border,
                      color: AppColors.blue,
                      size: AppSizes.size22,
                    ),
                  ),
                  const SizedBox(width: AppSizes.size15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Love SmartStock?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "If you enjoy using SmartStock, please rate us on the Play Store.",
                          style: TextStyle(fontSize: 10, color: AppColors.grey),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blue,
                      foregroundColor: AppColors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSizes.borderRadius8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.padding12,
                        vertical: AppSizes.padding8,
                      ),
                    ),
                    icon: const Icon(Icons.star_border, size: AppSizes.size16),
                    label: const Text(
                      "Rate App",
                      style: TextStyle(fontSize: AppSizes.font12),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSizes.size40),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    IconData icon,
    String title,
    String value,
    Color iconBgColor,
    Color iconColor,
  ) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.size15),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: AppSizes.size18, color: iconColor),
          ),
          const SizedBox(width: AppSizes.size15),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
          const Spacer(),
          Text(
            value,
          style: const TextStyle(color: AppColors.grey, fontSize: AppSizes.font13),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 1,
      color: Color(0xFFF1F5F9),
      indent: 15,
      endIndent: 15,
    );
  }
}
