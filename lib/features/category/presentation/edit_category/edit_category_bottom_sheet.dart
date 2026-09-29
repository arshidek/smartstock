import 'package:flutter/material.dart';
import 'package:smartstock_inventory/core/responsive/responsive.dart';
import 'package:smartstock_inventory/data/models/category_model.dart';
import 'mobile/mobile_edit_category_bottom_sheet.dart';
import 'web/web_edit_category_bottom_sheet.dart';

class EditCategoryBottomSheet extends StatelessWidget {
  final CategoryModel category;
  const EditCategoryBottomSheet({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return MobileEditCategoryBottomSheet(category: category);
    } else {
      return WebEditCategoryBottomSheet(category: category);
    }
  }
}
