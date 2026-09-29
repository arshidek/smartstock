import 'dart:async';
import 'package:flutter/material.dart';
import '../../../app/app_navigation.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/services/hive_service.dart';
import '../../auth/presentation/login/login_screen.dart';
import '../../dashboard/presentation/dashboard_screen/dashboard_screen.dart';
import '../widgets/splash_background_gadgets.dart';
import '../widgets/splash_content.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final AuthService _authService = AuthService();
  final HiveService _hiveService = HiveService();

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    Timer(const Duration(seconds: 5), () async {
      if (!mounted) return;

      if (_authService.isLoggedIn()) {
        final userId = _authService.getCurrentUserId();
        if (userId != null) {
          await _hiveService.openUserBoxes(userId);
          if (!mounted) return;
        }
        AppNavigation.goToReplacementScreen(context, const DashboardScreen());
      } else {
        AppNavigation.goToReplacementScreen(context, const LoginScreen());
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.background),
        child: Stack(
          children: [
            SplashBackgroundGadgets(scaleAnimation: _scaleAnimation),
            SplashContent(scaleAnimation: _scaleAnimation),
          ],
        ),
      ),
    );
  }
}
