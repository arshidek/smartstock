import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../app/app_navigation.dart';
import '../../../../core/services/user_service.dart';
import '../../../../data/models/user_model.dart';
import '../edit_profile/edit_profile_screen.dart';
import 'mobile/mobile_profile_screen.dart';
import 'web/web_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserService _userService = UserService();
  UserModel? currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = _userService.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    if (currentUser == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: kIsWeb
          ? WebProfileScreen(currentUser: currentUser!, onEdit: _handleEdit)
          : MobileProfileScreen(currentUser: currentUser!, onEdit: _handleEdit),
    );
  }

  Future<void> _handleEdit() async {
    await AppNavigation.goToScreen(context, const EditProfileScreen());

    setState(() {
      currentUser = _userService.getCurrentUser();
    });
  }
}
