import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/product_model.dart';

class DashboardData {
  final double currentInvValue;
  final double invGrowth;
  final String formattedInvValue;
  final String growthSign;
  final IconData? growthIcon;
  final Color growthColor;
  final int totalStock;
  final int lowStock;
  final int outOfStock;
  final List<ProductModel> topRecent;

  DashboardData({
    required this.currentInvValue,
    required this.invGrowth,
    required this.formattedInvValue,
    required this.growthSign,
    this.growthIcon,
    required this.growthColor,
    required this.totalStock,
    required this.lowStock,
    required this.outOfStock,
    required this.topRecent,
  });
}

class DashboardFunctions {
  static DashboardData calculateDashboardData(List<ProductModel> products) {
    final now = DateTime.now();
    final thirtyDaysAgo = now.subtract(const Duration(days: 30));

    double currentInvValue = 0;
    double previousInvValue = 0;
    int totalStock = 0;
    int lowStock = 0;
    int outOfStock = 0;

    for (var p in products) {
      double value = p.purchasePrice * p.stock;
      currentInvValue += value;
      totalStock += p.stock;

      if (p.stock == 0) {
        outOfStock++;
      } else if (p.stock <= 5) {
        lowStock++;
      }

      if (p.createdAt.isBefore(thirtyDaysAgo)) {
        previousInvValue += value;
      }
    }

    double invGrowth = previousInvValue == 0
        ? 0.0
        : ((currentInvValue - previousInvValue) / previousInvValue) * 100;

    String growthSign = "";
    IconData? growthIcon;
    Color growthColor = AppColors.white70;

    if (invGrowth > 0) {
      growthSign = "+";
      growthIcon = Icons.arrow_upward;
      growthColor = AppColors.success;
    } else if (invGrowth < 0) {
      growthSign = "-";
      growthIcon = Icons.arrow_downward;
      growthColor = AppColors.error;
    }

    String formattedInvValue =
        "₹${(currentInvValue / 100000).toStringAsFixed(1)}L";
    if (currentInvValue < 100000) {
      formattedInvValue = "₹${currentInvValue.toStringAsFixed(0)}";
    }

    final recentProducts = List<ProductModel>.from(products)
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    final topRecent = recentProducts.take(6).toList();

    return DashboardData(
      currentInvValue: currentInvValue,
      invGrowth: invGrowth,
      formattedInvValue: formattedInvValue,
      growthSign: growthSign,
      growthIcon: growthIcon,
      growthColor: growthColor,
      totalStock: totalStock,
      lowStock: lowStock,
      outOfStock: outOfStock,
      topRecent: topRecent,
    );
  }
}
