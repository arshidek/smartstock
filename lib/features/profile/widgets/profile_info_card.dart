import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../data/models/user_model.dart';

class ProfileInfoCard extends StatelessWidget {
  final UserModel user;

  const ProfileInfoCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: AppSizes.size5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadius20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSizes.size10),
        child: Column(
          children: [
            _buildTile(Icons.person_outline, "Username", user.username),
            const SizedBox(height: AppSizes.size12),
            _buildTile(Icons.email_outlined, "Email", user.email),
            const SizedBox(height: AppSizes.size12),

            _buildTile(
              Icons.phone_outlined,
              "Phone",
              user.phone.isEmpty ? "Not Added" : user.phone,
            ),
            const SizedBox(height: AppSizes.size12),

            _buildTile(
              Icons.store_outlined,
              "Shop Name",
              user.shopName.isEmpty ? "Not Added" : user.shopName,
            ),
            const SizedBox(height: AppSizes.size12),
          ],
        ),
      ),
    );
  }

  Widget _buildTile(IconData icon, String title, String value) {
    return ListTile(
      leading: CircleAvatar(
        radius: AppSizes.size25,
        backgroundColor: AppColors.lightBlue,
        child: Icon(icon, color: AppColors.blue, size: AppSizes.size20),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: AppSizes.font16,
          color: AppColors.grey,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: AppSizes.size5),
        child: Text(
          value,
          style: const TextStyle(
            fontSize: AppSizes.font18,
            fontWeight: FontWeight.bold,
            color: AppColors.lightBlack,
          ),
        ),
      ),
    );
  }
}
