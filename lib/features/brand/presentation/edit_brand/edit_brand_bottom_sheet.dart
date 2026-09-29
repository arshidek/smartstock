import 'package:flutter/material.dart';
import 'package:smartstock_inventory/core/responsive/responsive.dart';
import 'package:smartstock_inventory/data/models/brand_model.dart';
import 'mobile/mobile_edit_brand_bottom_sheet.dart';
import 'web/web_edit_brand_bottom_sheet.dart';

class EditBrandBottomSheet extends StatelessWidget {
  final BrandModel brand;
  const EditBrandBottomSheet({super.key, required this.brand});

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return MobileEditBrandBottomSheet(brand: brand);
    } else {
      return WebEditBrandBottomSheet(brand: brand);
    }
  }
}
