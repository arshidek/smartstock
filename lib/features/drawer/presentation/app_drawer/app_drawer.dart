import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/services/user_service.dart';
import 'mobile/mobile_app_drawer.dart';
import 'web/web_app_drawer.dart';

class AppDrawer extends StatefulWidget {
  final bool isCollapsed;
  final VoidCallback? onToggleCollapse;

  const AppDrawer({super.key, this.isCollapsed = false, this.onToggleCollapse});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final UserService _userService = UserService();

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return WebAppDrawer(
        userService: _userService,
        isCollapsed: widget.isCollapsed,
        onToggleCollapse: widget.onToggleCollapse,
      );
    } else {
      return MobileAppDrawer(userService: _userService);
    }
  }
}
