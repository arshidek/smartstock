import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/responsive/responsive.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  PrivacyPolicyScreen({super.key});

  final List<Map<String, dynamic>> _policies = [
    {
      "title": "1. Information We Store",
      "description":
          "SmartStock stores all your data locally on your device. This includes your products, stock, reports and preferences.",
      "icon": Icons.person_outline,
      "color": AppColors.blue,
      "bgColor": AppColors.blue.withValues(alpha: 0.1),
    },
    {
      "title": "2. Data Security",
      "description":
          "Your data is stored securely on your device. We do not collect, upload or share your information with any server.",
      "icon": Icons.lock_outline,
      "color": Colors.green,
      "bgColor": Colors.green.withValues(alpha: 0.1),
    },
    {
      "title": "3. Data Sharing",
      "description":
          "We do not share your personal information with any third parties. Your data stays with you, always.",
      "icon": Icons.share_outlined,
      "color": Colors.orange,
      "bgColor": Colors.orange.withValues(alpha: 0.1),
    },
    {
      "title": "4. Backup & Restore",
      "description":
          "Backup files are saved locally or in the location you choose. We do not access or transfer your backup data.",
      "icon": Icons.cloud_outlined,
      "color": Colors.purple,
      "bgColor": Colors.purple.withValues(alpha: 0.1),
    },
    {
      "title": "5. Data Deletion",
      "description":
          "You can delete your data at any time from the app. Once deleted, the data cannot be recovered.",
      "icon": Icons.delete_outline,
      "color": AppColors.error,
      "bgColor": AppColors.error.withValues(alpha: 0.1),
    },
    {
      "title": "6. Changes to This Policy",
      "description":
          "We may update this Privacy Policy from time to time. Any changes will be reflected in this page.",
      "icon": Icons.verified_user_outlined,
      "color": Colors.indigo,
      "bgColor": Colors.indigo.withValues(alpha: 0.1),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlue,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Privacy Policy",
              style: TextStyle(
                color: AppColors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Your privacy is important to us",
              style: TextStyle(color: AppColors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSizes.size20),
        children: [
          // Highlight Card
          Container(
            padding: const EdgeInsets.all(AppSizes.size20),
            decoration: BoxDecoration(
              color: AppColors.blue.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(AppSizes.borderRadius16),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: AppColors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.lock_person_outlined,
                    color: AppColors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: AppSizes.size15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "We value your privacy",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: AppColors.black,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "This Privacy Policy explains how SmartStock handles your information. We are committed to protecting your data and your trust.",
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.grey,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSizes.size20),

          // Policy Items list
          ..._policies.map((policy) {
            return Container(
              margin: const EdgeInsets.only(bottom: AppSizes.size15),
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
              child: ListTile(
                contentPadding: const EdgeInsets.all(AppSizes.size15),
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: policy["bgColor"],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(policy["icon"], color: policy["color"], size: 22),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    policy["title"],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: AppColors.black,
                    ),
                  ),
                ),
                subtitle: Text(
                  policy["description"],
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.grey,
                    height: 1.4,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: AppColors.grey,
                ),
              ),
            );
          }),

          // Trust Footer
          Container(
            padding: const EdgeInsets.all(AppSizes.size20),
            decoration: BoxDecoration(
              color: AppColors.blue.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(AppSizes.borderRadius16),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.verified_user_outlined,
                    color: AppColors.blue,
                    size: 20,
                  ),
                ),
                const SizedBox(width: AppSizes.size15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Your trust matters",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "SmartStock is committed to keeping your information safe and private.",
                        style: TextStyle(fontSize: 11, color: AppColors.grey),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.description,
                  color: AppColors.blue.withValues(alpha: 0.2),
                  size: 40,
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSizes.size40),
        ],
      ),
    );
  }
}
