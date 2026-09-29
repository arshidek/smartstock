import 'package:flutter/material.dart';
import 'package:smartstock_inventory/core/responsive/responsive.dart';
import 'mobile/mobile_add_brand_bottom_sheet.dart';
import 'web/web_add_brand_bottom_sheet.dart';

class AddBrandBottomSheet extends StatelessWidget {
  const AddBrandBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return const MobileAddBrandBottomSheet();
    } else {
      return const WebAddBrandBottomSheet();
    }
  }
}
