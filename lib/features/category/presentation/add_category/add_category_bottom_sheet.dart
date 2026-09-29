import 'package:flutter/material.dart';
import 'package:smartstock_inventory/core/responsive/responsive.dart';
import 'mobile/mobile_add_category_bottom_sheet.dart';
import 'web/web_add_category_bottom_sheet.dart';

class AddCategoryBottomSheet extends StatelessWidget {
  const AddCategoryBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return const MobileAddCategoryBottomSheet();
    } else {
      return const WebAddCategoryBottomSheet();
    }
  }
}
