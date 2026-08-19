import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/utils/validator.dart';
import '../../../core/widgets/buttons/app_button.dart';
import '../../../core/widgets/textfields/app_custom_text_field.dart';
import '../../../data/models/category_model.dart';
import '../function/category_functions.dart';
import '../widgets/category_image_picker_widget.dart';

class EditCategoryBottomSheet extends StatefulWidget {
  final CategoryModel category;
  const EditCategoryBottomSheet({super.key, required this.category});

  @override
  State<EditCategoryBottomSheet> createState() =>
      _EditCategoryBottomSheetState();
}

class _EditCategoryBottomSheetState extends State<EditCategoryBottomSheet> {
  final CategoryFunctions _categoryFunctions = CategoryFunctions();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  XFile? _image;
  String? _imageError;
  String? _categoryError;

  @override
  void initState() {
    super.initState();

    _categoryController.text = widget.category.name;
    _descriptionController.text = widget.category.description ?? "";

    if (widget.category.imagePath != null &&
        widget.category.imagePath!.isNotEmpty) {
      _image = XFile(widget.category.imagePath!);
    }
  }

  @override
  void dispose() {
    _categoryController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> pickCategoryImage() async {
    final image = await _categoryFunctions.pickCategoryImage();

    if (image != null) {
      setState(() {
        _image = image;
        _imageError = null;
      });
    }
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
                "Edit Category",
                style: TextStyle(
                  fontSize: AppSizes.font24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: AppSizes.size20),

              // Extracted image picker widget to reduce lines
              CategoryImagePickerWidget(
                image: _image,
                imageError: _imageError,
                onTap: pickCategoryImage,
              ),

              const SizedBox(height: AppSizes.size25),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppCustomTextField.textField(
                    controller: _categoryController,
                    label: "Category Name",
                    hint: "Enter Category Name",
                    icon: Icons.local_offer_outlined,
                    validator: (v) =>
                        Validator.validateName(v, fieldName: "Category name"),
                  ),
                  if (_categoryError != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        left: AppSizes.padding10,
                        top: AppSizes.size5,
                      ),
                      child: Text(
                        _categoryError!,
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
                  fieldName: "Category description",
                ),
              ),

              const SizedBox(height: AppSizes.size30),

              AppButton(
                text: "Update Category",
                icon: Icons.save,
                backgroundColor: AppColors.blue,
                textColor: AppColors.white,
                iconColor: AppColors.white,
                onPressed: () async {
                  if (_image == null) {
                    setState(() {
                      _imageError = "Please select a Category image";
                    });
                    return;
                  }

                  setState(() {
                    _categoryError = null;
                  });

                  await _categoryFunctions.updateCategory(
                    context: context,
                    category: widget.category,
                    formKey: _formKey,
                    categoryController: _categoryController,
                    descriptionController: _descriptionController,
                    imagePath: _image!.path,
                  );
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
