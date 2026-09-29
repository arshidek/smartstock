import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/utils/validator.dart';
import '../../../../../core/widgets/buttons/app_button.dart';
import '../../../../../core/widgets/cards/app_card_widget.dart';
import '../../../../../core/widgets/textfields/app_custom_text_field.dart';
import '../../../../../data/models/user_model.dart';
import '../../../widgets/profile_avatar.dart';

class MobileEditProfileScreen extends StatelessWidget {
  final UserModel currentUser;
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController shopController;
  final VoidCallback onPickImage;
  final VoidCallback onSave;

  const MobileEditProfileScreen({
    super.key,
    required this.currentUser,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.shopController,
    required this.onPickImage,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AppColors.background),
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
                  ProfileAvatar(user: currentUser, onCameraTap: onPickImage),
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
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Personal Information",
                      style: TextStyle(
                        fontSize: AppSizes.font20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSizes.size25),
                    AppCustomTextField.textField(
                      controller: nameController,
                      label: "Username",
                      hint: "Enter Username",
                      icon: Icons.person,
                      validator: Validator.validateUsernameOrEmail,
                    ),
                    const SizedBox(height: AppSizes.size20),
                    AppCustomTextField.textField(
                      controller: emailController,
                      label: "Email",
                      hint: "Enter Email",
                      icon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                      validator: Validator.validateEmail,
                    ),
                    const SizedBox(height: AppSizes.size20),
                    AppCustomTextField.textField(
                      controller: phoneController,
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
                      controller: shopController,
                      label: "Shop Name",
                      hint: "Enter Shop Name",
                      icon: Icons.store,
                      validator: (value) =>
                          Validator.validateName(value, fieldName: "Shop name"),
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
              onPressed: onSave,
            ),

            const SizedBox(height: AppSizes.size40),
          ],
        ),
      ),
    );
  }
}
