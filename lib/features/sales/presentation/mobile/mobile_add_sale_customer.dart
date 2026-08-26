import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/textfields/app_custom_text_field.dart';

class MobileAddSaleCustomer extends StatelessWidget {
  final TextEditingController customerNameController;
  final TextEditingController customerPhoneController;
  final TextEditingController customerEmailController;
  final TextEditingController customerAddressController;

  const MobileAddSaleCustomer({
    super.key,
    required this.customerNameController,
    required this.customerPhoneController,
    required this.customerEmailController,
    required this.customerAddressController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: const Row(
            children: [
              Icon(
                Icons.person_outline,
                color: AppColors.blue,
                size: AppSizes.size25,
              ),
              SizedBox(width: AppSizes.size10),
              Text(
                "Customer Details",
                style: TextStyle(
                  fontSize: AppSizes.font20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSizes.size20),
        AppCustomTextField.textField(
          controller: customerNameController,
          label: "Customer Name",
          hint: "Enter customer name",
          icon: Icons.person_outline,
          validator: (value) => Validator.validateName(
            value,
            fieldName: "Customer Name",
          ),
        ),
        const SizedBox(height: AppSizes.size15),
        AppCustomTextField.textField(
          controller: customerPhoneController,
          label: "Phone Number",
          hint: "Enter phone number",
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          validator: Validator.validatePhone,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10),
          ],
        ),
        const SizedBox(height: AppSizes.size15),
        AppCustomTextField.textField(
          controller: customerEmailController,
          label: "Email Address",
          hint: "Enter email (Optional)",
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          validator: Validator.validateOptionalEmail,
        ),
        const SizedBox(height: AppSizes.size15),
        AppCustomTextField.textField(
          controller: customerAddressController,
          label: "Address",
          hint: "Enter customer address",
          icon: Icons.location_on_outlined,
          maxLines: 3,
          validator: (value) => Validator.validateDescription(
            value,
            fieldName: "Address",
          ),
        ),
      ],
    );
  }
}
