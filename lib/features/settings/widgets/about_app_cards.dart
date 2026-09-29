import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/widgets/cards/app_card_widget.dart';

class AboutAppInfoCard extends StatelessWidget {
  const AboutAppInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCardWidget(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSizes.padding16,
        vertical: AppSizes.size10,
      ),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(height: AppSizes.size10),
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
              child: const Text(
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
              "SmartStock is an offline inventory\n"
              "management app designed to help you\n"
              "manage your products, stock and reports\n"
              "easily and efficiently.",
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
    );
  }
}

class AboutAppDetailsCard extends StatelessWidget {
  const AboutAppDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCardWidget(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSizes.padding16,
        vertical: AppSizes.size10,
      ),
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          _buildDetailRow(
            Icons.info,
            "Version",
            "1.0.0",
            AppColors.lightBlue,
            AppColors.blue,
          ),
          _buildDivider(),
          _buildDetailRow(
            Icons.person_outline,
            "Developed By",
            "Muhammed Arshid",
            AppColors.lightGreen,
            AppColors.success,
          ),
          _buildDivider(),
          _buildDetailRow(
            Icons.calendar_today,
            "Release Date",
            "10 May 2026",
            AppColors.lightWarning,
            AppColors.warning,
          ),
          _buildDivider(),
          _buildDetailRow(
            Icons.language,
            "Platform",
            "Android",
            AppColors.lightBlue,
            AppColors.blue,
          ),
          _buildDivider(),
          _buildDetailRow(
            Icons.storage,
            "Data Storage",
            "Local (Offline)",
            AppColors.lightPurple,
            AppColors.purple,
          ),
        ],
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
            padding: const EdgeInsets.all(AppSizes.padding8),
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
            style: const TextStyle(
              color: AppColors.grey,
              fontSize: AppSizes.font13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 1,
      color: AppColors.lightBlue,
      indent: 15,
      endIndent: 15,
    );
  }
}

class AboutAppRateCard extends StatelessWidget {
  const AboutAppRateCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCardWidget(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSizes.padding16,
        vertical: AppSizes.size10,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSizes.padding12),
            decoration: BoxDecoration(
              color: AppColors.blue.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.favorite_border,
              color: AppColors.blue,
              size: AppSizes.size22,
            ),
          ),
          const SizedBox(width: AppSizes.size15),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Love SmartStock?",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: AppSizes.size5),
                Text(
                  "If you enjoy using SmartStock, please rate us on the Play Store.",
                  style: TextStyle(
                    fontSize: AppSizes.font10,
                    color: AppColors.grey,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSizes.size10),
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
    );
  }
}
