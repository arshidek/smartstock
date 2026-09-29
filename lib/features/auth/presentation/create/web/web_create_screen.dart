import 'package:flutter/material.dart';
import 'package:smartstock_inventory/app/app_navigation.dart';
import 'package:smartstock_inventory/core/constants/app_colors.dart';
import 'package:smartstock_inventory/core/constants/app_sizes.dart';
import 'package:smartstock_inventory/core/utils/validator.dart';
import 'package:smartstock_inventory/core/widgets/buttons/app_button.dart';
import 'package:smartstock_inventory/core/widgets/textfields/app_custom_text_field.dart';
import 'package:smartstock_inventory/core/widgets/cards/app_card_widget.dart';
import 'package:smartstock_inventory/core/widgets/logo/app_logo_widget.dart';
import 'package:smartstock_inventory/features/auth/function/auth_function.dart';
import 'package:smartstock_inventory/features/auth/widgets/create_header.dart';

class WebCreateScreen extends StatefulWidget {
  const WebCreateScreen({super.key});

  @override
  State<WebCreateScreen> createState() => _WebCreateScreenState();
}

class _WebCreateScreenState extends State<WebCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthFunction _authFunction = AuthFunction();
  bool _obscurePassword = true;

  void _togglePasswordVisibility() =>
      setState(() => _obscurePassword = !_obscurePassword);

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isSmallTablet = MediaQuery.of(context).size.width < 800;
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(gradient: AppColors.background),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const AppLogoWidget(),
                        const SizedBox(height: AppSizes.size50),
                        _buildFeatures(context, isSmallTablet),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: isSmallTablet ? AppSizes.size360 : AppSizes.size450,
                          child: AppCardWidget(
                            margin: EdgeInsets.zero,
                            child: _buildForm(context),
                          ),
                        ),
                        const SizedBox(height: AppSizes.size40),
                        const Text(
                          "© 2026 SmartStock. All rights reserved.",
                          style: TextStyle(
                            color: AppColors.lightBlack,
                            fontSize: AppSizes.font13,
                          ),
                        ),
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

  Widget _buildFeatures(BuildContext context, bool isSmallTablet) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.padding40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
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
      padding: const EdgeInsets.symmetric(vertical: AppSizes.padding10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.blue, size: isSmallTablet ? AppSizes.size20 : AppSizes.size28),
          const SizedBox(width: AppSizes.size15),
          Flexible(
            child: Text(
              title,
              style: TextStyle(
                fontSize: isSmallTablet ? AppSizes.font13 : AppSizes.font16,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const CreateHeader(),
          const SizedBox(height: AppSizes.size30),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Username",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: AppSizes.size5),
          AppCustomTextField.textField(
            controller: _usernameController,
            label: "Username",
            icon: Icons.person,
            validator: Validator.validateUsernameOrEmail,
          ),
          const SizedBox(height: AppSizes.size20),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text("Email", style: TextStyle(fontWeight: FontWeight.w600)),
          ),
          const SizedBox(height: AppSizes.size5),
          AppCustomTextField.textField(
            controller: _emailController,
            label: "Email",
            icon: Icons.email,
            keyboardType: TextInputType.emailAddress,
            validator: Validator.validateEmail,
          ),
          const SizedBox(height: AppSizes.size20),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Password",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: AppSizes.size5),
          AppCustomTextField.textField(
            controller: _passwordController,
            label: "Password",
            icon: Icons.lock,
            obscureText: _obscurePassword,
            validator: Validator.validatePassword,
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: AppColors.grey,
              ),
              onPressed: _togglePasswordVisibility,
            ),
          ),
          const SizedBox(height: AppSizes.size30),
          AppButton(
            text: "Create Account",
            icon: Icons.person_add,
            backgroundColor: AppColors.blue,
            textColor: AppColors.white,
            iconColor: AppColors.white,
            onPressed: () async {
              if (!_formKey.currentState!.validate()) return;
              await _authFunction.createAccount(
                context: context,
                username: _usernameController.text.trim(),
                email: _emailController.text.trim(),
                password: _passwordController.text,
                mounted: mounted,
              );
            },
          ),
          const SizedBox(height: AppSizes.size20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Already have an account? "),
              InkWell(
                onTap: () => AppNavigation.goBack(context),
                child: const Text(
                  "Login",
                  style: TextStyle(
                    color: AppColors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
