import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartstock_inventory/core/constants/app_colors.dart';
import 'package:smartstock_inventory/core/constants/app_sizes.dart';
import 'package:smartstock_inventory/core/utils/validator.dart';
import 'package:smartstock_inventory/core/widgets/buttons/app_button.dart';
import 'package:smartstock_inventory/core/widgets/textfields/app_custom_text_field.dart';
import 'package:smartstock_inventory/features/brand/function/brand_functions.dart';
import 'package:smartstock_inventory/features/brand/widgets/brand_image_picker_widget.dart';

class MobileAddBrandBottomSheet extends StatefulWidget {
  const MobileAddBrandBottomSheet({super.key});

  @override
  State<MobileAddBrandBottomSheet> createState() =>
      _MobileAddBrandBottomSheetState();
}

class _MobileAddBrandBottomSheetState extends State<MobileAddBrandBottomSheet> {
  final BrandFunctions _brandFunctions = BrandFunctions();
  final _formKey = GlobalKey<FormState>();
  final _brandController = TextEditingController();
  final _descriptionController = TextEditingController();
  XFile? _image;
  String? _imageError;
  String? _brandError;

  @override
  void dispose() {
    _brandController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> pickBrandImage() async {
    final image = await _brandFunctions.pickBrandImage();
    if (image == null) return;
    setState(() {
      _image = image;
      _imageError = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.background,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSizes.size20),
        ),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: AppSizes.size20,
          right: AppSizes.size20,
          top: AppSizes.size10,
          bottom: MediaQuery.of(context).viewInsets.bottom + AppSizes.size20,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: AppSizes.size60,
                height: AppSizes.size5,
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(AppSizes.borderRadius25),
                ),
              ),
              const SizedBox(height: AppSizes.size20),
              const Text(
                "Add Brand",
                style: TextStyle(
                  fontSize: AppSizes.font24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSizes.size20),
              BrandImagePickerWidget(
                image: _image,
                imageError: _imageError,
                onTap: pickBrandImage,
              ),
              const SizedBox(height: AppSizes.size25),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppCustomTextField.textField(
                    controller: _brandController,
                    label: "Brand Name",
                    hint: "Enter Brand Name",
                    icon: Icons.sell_rounded,
                    validator: (v) =>
                        Validator.validateName(v, fieldName: "Brand name"),
                  ),
                  if (_brandError != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        left: AppSizes.padding10,
                        top: AppSizes.size5,
                      ),
                      child: Text(
                        _brandError!,
                        style: const TextStyle(
                          color: AppColors.error,
                          fontSize: AppSizes.font14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: AppSizes.size20),
              AppCustomTextField.textField(
                controller: _descriptionController,
                label: "Description",
                hint: "Enter Description",
                icon: Icons.description,
                maxLines: 4,
                textInputAction: TextInputAction.done,
                validator: (v) => Validator.validateDescription(
                  v,
                  fieldName: "Brand description",
                ),
              ),
              const SizedBox(height: AppSizes.size30),
              AppButton(
                text: "Save Brand",
                icon: Icons.save,
                backgroundColor: AppColors.blue,
                textColor: AppColors.white,
                iconColor: AppColors.white,
                onPressed: () async {
                  if (_image == null) {
                    setState(() => _imageError = "Please select a brand image");
                    return;
                  }
                  setState(() => _brandError = null);
                  if (!_formKey.currentState!.validate()) return;
                  final success = await _brandFunctions.saveBrand(
                    context: context,
                    formKey: _formKey,
                    brandController: _brandController,
                    descriptionController: _descriptionController,
                    imagePath: _image!.path,
                  );
                  if (!success) {
                    setState(() => _brandError = "Brand already exists");
                  }
                },
              ),
              const SizedBox(height: AppSizes.size15),
            ],
          ),
        ),
      ),
    );
  }
}
