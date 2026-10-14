import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smartstock_inventory/app/app_navigation.dart';
import 'package:smartstock_inventory/core/constants/app_colors.dart';
import 'package:smartstock_inventory/core/constants/app_sizes.dart';
import 'package:smartstock_inventory/core/services/brand_service.dart';
import 'package:smartstock_inventory/core/services/product_service.dart';
import 'package:smartstock_inventory/core/widgets/buttons/app_button.dart';
import 'package:smartstock_inventory/core/widgets/search/app_search_bar.dart';
import 'package:smartstock_inventory/data/models/brand_model.dart';
import 'package:smartstock_inventory/features/brand/function/brand_functions.dart';
import 'package:smartstock_inventory/features/brand/widgets/brand_list_view.dart';
import '../../add_brand/add_brand_bottom_sheet.dart';

class MobileBrandScreen extends StatefulWidget {
  const MobileBrandScreen({super.key});

  @override
  State<MobileBrandScreen> createState() => _MobileBrandScreenState();
}

class _MobileBrandScreenState extends State<MobileBrandScreen> {
  final _searchController = TextEditingController();
  final _brandFunctions = BrandFunctions();
  final _productService = ProductService();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.black,
            size: AppSizes.size30,
          ),
          onPressed: () => AppNavigation.goBack(context),
        ),
        title: const Text(
          "Brands",
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
            fontSize: AppSizes.font24,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.background),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.padding16),
          child: Column(
            children: [
              const SizedBox(height: AppSizes.size15),
              AppSearchBar(
                controller: _searchController,
                hintText: "Search Brands...",
                showFilter: false,
                onChanged: (value) => setState(() {}),
              ),
              const SizedBox(height: AppSizes.size20),
              Expanded(
                child: ValueListenableBuilder<Box<BrandModel>>(
                  valueListenable: BrandService().box.listenable(),
                  builder: (context, box, child) {
                    final brands = box.values.toList()
                      ..sort(
                        (a, b) => a.name.toLowerCase().compareTo(
                          b.name.toLowerCase(),
                        ),
                      );
                    final searchBrands = _brandFunctions.searchBrands(
                      brands: brands,
                      query: _searchController.text,
                    );
                    return BrandListView(
                      brands: searchBrands,
                      isTabletOrWeb: false,
                      productService: _productService,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: AppSizes.size15),
                child: AppButton(
                  text: "Add Brand",
                  icon: Icons.add,
                  onPressed: () async {
                    await AppNavigation.showBottomSheet<bool>(
                      context,
                      const AddBrandBottomSheet(),
                    );
                  },
                  backgroundColor: AppColors.blue,
                  textColor: AppColors.white,
                  iconColor: AppColors.white,
                ),
              ),
              const SizedBox(height: AppSizes.size30),
            ],
          ),
        ),
      ),
    );
  }
}
