import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';

class TermsWelcomeCard extends StatelessWidget {
  const TermsWelcomeCard({super.key});

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
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSizes.padding12),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
                  border: Border.all(
                    color: AppColors.blue.withValues(alpha: 0.1),
                  ),
                ),
                child: const Icon(
                  Icons.description_outlined,
                  color: AppColors.blue,
                  size: AppSizes.size28,
                ),
              ),
              Positioned(
                right: -4,
                bottom: -4,
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.blue,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(2),
                  child: Icon(Icons.check, color: AppColors.white, size: 10),
                ),
              ),
            ],
          ),
          const SizedBox(width: AppSizes.size15),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome to SmartStock",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppSizes.font14,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  "By using SmartStock, you agree to the following terms and conditions. Please read them carefully before using our app.",
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

class TermsListCard extends StatelessWidget {
  TermsListCard({super.key});

  final List<Map<String, dynamic>> _terms = [
    {
      "title": "Acceptance of Terms",
      "description":
          "By accessing and using SmartStock, you accept and agree to be bound by these Terms & Conditions.",
      "icon": Icons.person_outline,
    },
    {
      "title": "Use of the App",
      "description":
          "SmartStock is an offline inventory management app designed to help you manage your products and stock.",
      "icon": Icons.widgets_outlined,
    },
    {
      "title": "User Responsibilities",
      "description":
          "You are responsible for the accuracy of the data you enter into the app and for maintaining the security of your device.",
      "icon": Icons.verified_user_outlined,
    },
    {
      "title": "Data Storage",
      "description":
          "All your data is stored locally on your device. You are responsible for creating backups to prevent data loss.",
      "icon": Icons.storage_outlined,
    },
    {
      "title": "Limitation of Liability",
      "description":
          "SmartStock is provided \"as is\" without any warranties. We are not liable for any data loss or damages resulting from the use of this app.",
      "icon": Icons.warning_amber_rounded,
    },
    {
      "title": "Changes to Terms",
      "description":
          "We may update these terms from time to time. Any changes will be reflected in this page.",
      "icon": Icons.edit_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _terms.length,
        separatorBuilder: (context, index) =>
            const Divider(height: 1, thickness: 1, color: AppColors.lightBlue),
        itemBuilder: (context, index) {
          final term = _terms[index];
          return Padding(
            padding: const EdgeInsets.all(AppSizes.size15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.blue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "${index + 1}",
                    style: const TextStyle(
                      color: AppColors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: AppSizes.size15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        term["title"],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                          fontSize: AppSizes.font14,
                        ),
                      ),
                      const SizedBox(height: AppSizes.size5),
                      Text(
                        term["description"],
                        style: const TextStyle(
                          color: AppColors.grey,
                          fontSize: AppSizes.font12,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSizes.size10),
                Icon(
                  term["icon"],
                  color: AppColors.blue.withValues(alpha: 0.5),
                  size: AppSizes.size10,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
