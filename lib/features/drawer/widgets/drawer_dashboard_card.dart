import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class DrawerDashboardCard extends StatelessWidget {
  const DrawerDashboardCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackShadow,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.glassIconBackground,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(Icons.home, color: AppColors.blue, size: 24),
        ),
        title: Text(
          "Dashboard",
          style: TextStyle(
            color: AppColors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        onTap: () => Navigator.pop(context),
      ),
    );
  }
}
