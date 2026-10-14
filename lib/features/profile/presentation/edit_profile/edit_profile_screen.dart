import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../app/app_navigation.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/services/user_service.dart';
import '../../../../core/utils/image_picker_helper.dart';
import '../../../../data/models/user_model.dart';
import '../../function/profile_functions.dart';
import 'mobile/mobile_edit_profile_screen.dart';
import 'web/web_edit_profile_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final ProfileFunctions _profileFunctions = ProfileFunctions();

  final UserService _userService = UserService();

  UserModel? currentUser;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _shopController = TextEditingController();

  @override
  void initState() {
    super.initState();

    currentUser = _userService.getCurrentUser();

    if (currentUser != null) {
      _nameController.text = currentUser!.username;
      _emailController.text = currentUser!.email;
      _phoneController.text = currentUser!.phone;
      _shopController.text = currentUser!.shopName;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _shopController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.black,
            size: AppSizes.size30,
          ),
          onPressed: () {
            AppNavigation.goBack(context);
          },
        ),
        title: const Text(
          "Edit Profile",
          style: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: kIsWeb
          ? WebEditProfileScreen(
              currentUser: currentUser!,
              formKey: _formKey,
              nameController: _nameController,
              emailController: _emailController,
              phoneController: _phoneController,
              shopController: _shopController,
              onPickImage: _handlePickImage,
              onSave: _handleSave,
            )
          : MobileEditProfileScreen(
              currentUser: currentUser!,
              formKey: _formKey,
              nameController: _nameController,
              emailController: _emailController,
              phoneController: _phoneController,
              shopController: _shopController,
              onPickImage: _handlePickImage,
              onSave: _handleSave,
            ),
    );
  }

  Future<void> _handlePickImage() async {
    final image = await ImagePickerHelper.pickImage();
    if (image == null) return;

    setState(() {
      currentUser!.profileImagePath = image.path;
    });

    await currentUser!.save();
  }

  void _handleSave() {
    if (currentUser == null) return;

    _profileFunctions.updateProfile(
      context: context,
      formKey: _formKey,
      user: currentUser!,
      nameController: _nameController,
      emailController: _emailController,
      phoneController: _phoneController,
      shopController: _shopController,
    );
  }
}
