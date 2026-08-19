import 'package:flutter/material.dart';
import '../../../app/app_navigation.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/utils/validator.dart';
import '../../../core/widgets/buttons/app_button.dart';
import '../../../core/widgets/buttons/app_outline_button.dart';
import '../../../core/widgets/textfields/app_custom_text_field.dart';
import '../function/auth_function.dart';
import '../widgets/auth_responsive_layout.dart';
import '../widgets/login_header.dart';
import 'create_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthFunction _authFunction = AuthFunction();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AuthResponsiveLayout(
      formWidget: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const LoginHeader(),
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
              label: "Username or Email",
              icon: Icons.person,
              validator: Validator.validateUsernameOrEmail,
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
              text: "Login",
              icon: Icons.login,
              backgroundColor: AppColors.blue,
              textColor: AppColors.white,
              iconColor: AppColors.white,
              onPressed: () async {
                if (!_formKey.currentState!.validate()) return;

                await _authFunction.login(
                  context: context,
                  usernameOrEmail: _usernameController.text.trim(),
                  password: _passwordController.text,
                  mounted: mounted,
                );
              },
            ),
            const SizedBox(height: AppSizes.size25),
            Row(
              children: [
                Expanded(child: Divider(color: AppColors.lightGrey)),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSizes.padding16),
                  child: Text("OR", style: TextStyle(color: AppColors.grey)),
                ),
                Expanded(child: Divider(color: AppColors.lightGrey)),
              ],
            ),
            const SizedBox(height: AppSizes.size25),
            AppOutlineButton(
              text: "Create Account",
              icon: Icons.person_add,
              onPressed: () {
                AppNavigation.goToScreen(context, const CreateScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
