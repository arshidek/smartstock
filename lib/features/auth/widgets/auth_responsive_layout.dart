import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/widgets/cards/app_card_widget.dart';
import '../../../core/widgets/logo/app_logo_widget.dart';

class AuthResponsiveLayout extends StatelessWidget {
  final Widget formWidget;

  const AuthResponsiveLayout({super.key, required this.formWidget});

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    bool isSmallTablet = MediaQuery.of(context).size.width < 800;

    if (isMobile) {
      // Mobile size: scrollable, image in upper the form fields
      return Scaffold(
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(gradient: AppColors.background),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: AppSizes.size40),
                    const AppLogoWidget(),
                    const SizedBox(height: AppSizes.size30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: AppCardWidget(
                        margin: EdgeInsets.zero,
                        child: formWidget,
                      ),
                    ),
                    const SizedBox(height: AppSizes.size40),
                    _buildFooter(),
                    const SizedBox(height: AppSizes.size30),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      // Tap size / Web size: separate (side-by-side), not scrollable
      return Scaffold(
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(gradient: AppColors.background),
            child: Row(
              children: [
                // LEFT SIDE (Logo and Words)
                Expanded(
                  flex: 1,
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const AppLogoWidget(),
                          const SizedBox(height: 50),
                          _buildFeatures(context, isMobile: false),
                        ],
                      ),
                    ),
                  ),
                ),
                // RIGHT SIDE (Form Fields)
                Expanded(
                  flex: 1,
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: isSmallTablet ? 360 : 450,
                            child: AppCardWidget(
                              margin: EdgeInsets.zero,
                              child: formWidget,
                            ),
                          ),
                          const SizedBox(height: 40),
                          _buildFooter(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget _buildFeatures(BuildContext context, {required bool isMobile}) {
    bool isSmallTablet = MediaQuery.of(context).size.width < 800;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start, // Align features nicely
        children: [
          _feature(
            Icons.widgets_outlined,
            "Manage your inventory seamlessly",
            isSmallTablet,
          ),
          _feature(
            Icons.analytics_outlined,
            "Track and analyze your business",
            isSmallTablet,
          ),
          _feature(
            Icons.shopping_bag_outlined,
            "Manage daily sales and stock updates",
            isSmallTablet,
          ),
        ],
      ),
    );
  }

  Widget _feature(IconData icon, String title, bool isSmallTablet) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisSize:
            MainAxisSize.min, // This makes the block tight and center perfectly
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.blue, size: isSmallTablet ? 20 : 28),
          const SizedBox(width: 15),
          Flexible(
            child: Text(
              title,
              style: TextStyle(
                fontSize: isSmallTablet ? 13 : 16,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return const Text(
      "© 2026 SmartStock. All rights reserved.",
      style: TextStyle(color: AppColors.lightBlack, fontSize: AppSizes.font13),
    );
  }
}
