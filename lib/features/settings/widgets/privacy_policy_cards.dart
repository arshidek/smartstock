import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/widgets/cards/app_card_widget.dart';

class PrivacyPolicyHighlightCard extends StatelessWidget {
  const PrivacyPolicyHighlightCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.size20),
      decoration: BoxDecoration(
        color: AppColors.blue.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(AppSizes.borderRadius16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(AppSizes.padding12),
            decoration: const BoxDecoration(
              color: AppColors.blue,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.lock_person_outlined,
              color: AppColors.white,
              size: AppSizes.size24,
            ),
          ),
          const SizedBox(width: AppSizes.size15),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "We value your privacy",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppSizes.font14,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: AppSizes.size5),
                Text(
                  "This Privacy Policy explains how SmartStock handles your information. We are committed to protecting your data and your trust.",
                  style: TextStyle(
                    fontSize: AppSizes.font12,
                    color: AppColors.grey,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PrivacyPolicyList extends StatelessWidget {
  PrivacyPolicyList({super.key});

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
      "color": AppColors.success,
      "bgColor": AppColors.success.withValues(alpha: 0.1),
    },
    {
      "title": "3. Data Sharing",
      "description":
          "We do not share your personal information with any third parties. Your data stays with you, always.",
      "icon": Icons.share_outlined,
      "color": AppColors.warning,
      "bgColor": AppColors.warning.withValues(alpha: 0.1),
    },
    {
      "title": "4. Backup & Restore",
      "description":
          "Backup files are saved locally or in the location you choose. We do not access or transfer your backup data.",
      "icon": Icons.cloud_outlined,
      "color": AppColors.purple,
      "bgColor": AppColors.purple.withValues(alpha: 0.1),
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
      "color": AppColors.indigo,
      "bgColor": AppColors.indigo.withValues(alpha: 0.1),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _policies.map((policy) {
        return AppCardWidget(
          margin: const EdgeInsets.only(bottom: AppSizes.size15),
          padding: EdgeInsets.zero,
          child: ListTile(
            contentPadding: const EdgeInsets.all(AppSizes.size15),
            leading: Container(
              padding: const EdgeInsets.all(AppSizes.padding10),
              decoration: BoxDecoration(
                color: policy["bgColor"],
                shape: BoxShape.circle,
              ),
              child: Icon(
                policy["icon"],
                color: policy["color"],
                size: AppSizes.size22,
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                policy["title"],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: AppSizes.font14,
                  color: AppColors.black,
                ),
              ),
            ),
            subtitle: Text(
              policy["description"],
              style: const TextStyle(
                fontSize: AppSizes.font14,
                color: AppColors.grey,
                height: 1.4,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: AppSizes.size15,
              color: AppColors.grey,
            ),
          ),
        );
      }).toList(),
    );
  }
}

class PrivacyPolicyFooterCard extends StatelessWidget {
  const PrivacyPolicyFooterCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: Icon(
              Icons.verified_user_outlined,
              color: AppColors.blue,
              size: AppSizes.size20,
            ),
          ),
          const SizedBox(width: AppSizes.size15),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your trust matters",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                    fontSize: AppSizes.font13,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  "SmartStock is committed to keeping your information safe and private.",
                  style: TextStyle(
                    fontSize: AppSizes.font11,
                    color: AppColors.grey,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.description,
            color: AppColors.blue.withValues(alpha: 0.2),
            size: AppSizes.size40,
          ),
        ],
      ),
    );
  }
}
