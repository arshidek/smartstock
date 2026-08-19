import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/widgets/cards/app_card_widget.dart';
import '../../../core/widgets/textfields/app_custom_text_field.dart';

class NoteCard extends StatelessWidget {
  final TextEditingController controller;

  const NoteCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AppCardWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Stock Update Note",
            style: TextStyle(
              fontSize: AppSizes.font16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            "Add a reason for this stock update (Optional)",
            style: TextStyle(color: AppColors.grey, fontSize: AppSizes.font14),
          ),

          const SizedBox(height: AppSizes.size15),

          AppCustomTextField.textField(
            controller: controller,
            label: "Reason",
            hint: "Example: Received new stock from supplier",
            icon: Icons.description_outlined,
            maxLines: 4,
            textInputAction: TextInputAction.done,
            validator: (value) => null,
          ),
        ],
      ),
    );
  }
}
