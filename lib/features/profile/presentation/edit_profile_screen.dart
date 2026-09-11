import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../app/app_navigation.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/services/user_service.dart';
import '../../../core/utils/image_picker_helper.dart';
import '../../../core/utils/validator.dart';
import '../../../core/widgets/buttons/app_button.dart';
import '../../../core/widgets/cards/app_card_widget.dart';
import '../../../core/widgets/textfields/app_custom_text_field.dart';
import '../../../data/models/user_model.dart';
import '../controller/profile_functions.dart';
import '../widgets/profile_avatar.dart';

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
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.background),

        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.size10),
          child: Column(
            children: [
              Container(
                width: AppSizes.size250,
                height: AppSizes.size250,
                padding: const EdgeInsets.symmetric(
                  vertical: AppSizes.size25,
                  horizontal: AppSizes.size20,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppSizes.borderRadius30),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.blackShadow,
                      blurRadius: AppSizes.borderRadius25,
                      offset: const Offset(0, AppSizes.size10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ProfileAvatar(
                      user: currentUser!,
                      onCameraTap: () async {
                        final image = await ImagePickerHelper.pickImage();

                        if (image == null) return;

                        setState(() {
                          currentUser!.profileImagePath = image.path;
                        });

                        await currentUser!.save();
                      },
                    ),

                    const SizedBox(height: AppSizes.size32),

                    const Text(
                      "Update Your Profile",
                      style: TextStyle(
                        fontSize: AppSizes.size20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSizes.size40),


              AppCardWidget(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Personal Information",
                        style: TextStyle(
                          fontSize: AppSizes.font20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: AppSizes.size25),

                      AppCustomTextField.textField(
                        controller: _nameController,
                        label: "Username",
                        hint: "Enter Username",
                        icon: Icons.person,
                        validator: Validator.validateUsernameOrEmail,
                      ),

                      const SizedBox(height: AppSizes.size20),

                      AppCustomTextField.textField(
                        controller: _emailController,
                        label: "Email",
                        hint: "Enter Email",
                        icon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                        validator: Validator.validateEmail,
                      ),

                      const SizedBox(height: AppSizes.size20),

                      AppCustomTextField.textField(
                        controller: _phoneController,
                        label: "Phone Number",
                        hint: "Enter Phone Number",
                        icon: Icons.phone,
                        keyboardType: TextInputType.phone,
                        validator: Validator.validatePhone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                      ),

                      const SizedBox(height: AppSizes.size20),

                      AppCustomTextField.textField(
                        controller: _shopController,
                        label: "Shop Name",
                        hint: "Enter Shop Name",
                        icon: Icons.store,
                        validator: (value) => Validator.validateName(
                          value,
                          fieldName: "Shop name",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.size25),


              Container(
                padding: const EdgeInsets.all(AppSizes.padding16),
                decoration: BoxDecoration(
                  color: AppColors.lightWhite,
                  borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.shield, color: AppColors.blue),
                    SizedBox(width: AppSizes.size12),
                    Expanded(
                      child: Text(
                        "Your information is safe with us.\n"
                        "We never share your data with anyone.",
                        style: TextStyle(fontSize: AppSizes.font14),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSizes.size20),

              AppButton(
                text: "Save Profile",
                icon: Icons.update,
                backgroundColor: AppColors.blue,
                textColor: AppColors.white,
                iconColor: AppColors.white,
                onPressed: () {
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
                },
              ),

              const SizedBox(height: AppSizes.size40),
            ],
          ),
        ),
      ),
    );
  }
}
