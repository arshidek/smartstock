import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smartstock_inventory/features/brand/function/brand_functions.dart';
import '../../../app/app_navigation.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/services/brand_service.dart';
import '../../../core/services/product_service.dart';
import '../../../core/widgets/buttons/app_button.dart';
import '../../../core/widgets/search/app_search_bar.dart';
import '../../../core/responsive/responsive.dart';
import '../../../data/models/brand_model.dart';
import '../widgets/brand_list_view.dart';

class BrandListScreen extends StatefulWidget {
  const BrandListScreen({super.key});

  @override
  State<BrandListScreen> createState() => _BrandListScreenState();
}

class _BrandListScreenState extends State<BrandListScreen> {
  final TextEditingController _searchController = TextEditingController();
  final BrandFunctions _brandFunctions = BrandFunctions();
  final ProductService _productService = ProductService();


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isTabletOrWeb = !Responsive.isMobile(context);

    return Scaffold(
      floatingActionButton: isTabletOrWeb
          ? FloatingActionButton.extended(
              onPressed: () async {
                final result = await _brandFunctions.openAddBrand(context);
                if (result) {
                }
              },
              backgroundColor: AppColors.blue,
              icon: Icon(Icons.add, color: AppColors.white),
              label: Text(
                "Add Brand",
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null,
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.black,
            size: AppSizes.size30,
          ),
          onPressed: () {
            AppNavigation.goBack(context);
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Brands",
              style: TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.bold,
                fontSize: AppSizes.font24,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.background),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.padding16),
          child: Column(
            children: [
              const SizedBox(height: AppSizes.size15),

              // Search Bar
              AppSearchBar(
                controller: _searchController,
                hintText: "Search brands...",
                showFilter: false,
                onChanged: (value) {
                  setState(() {});
                },
              ),

              const SizedBox(height: AppSizes.size20),

              Expanded(
                child: ValueListenableBuilder<Box<BrandModel>>(
                  valueListenable: BrandService().box.listenable(),
                  builder: (context, box, child) {
                    final brands = box.values.toList();

                    final searchBrands = _brandFunctions.searchBrands(
                      brands: brands,
                      query: _searchController.text,
                    );

                    return BrandListView(
                      brands: searchBrands,
                      isTabletOrWeb: isTabletOrWeb,
                      productService: _productService,
                    );
                  },
                ),
              ),

              if (!isTabletOrWeb)
                Padding(
                  padding: const EdgeInsets.only(top: AppSizes.size15),
                  child: AppButton(
                    text: "Add Brand",
                    icon: Icons.add,
                    onPressed: () async {
                      final result = await _brandFunctions.openAddBrand(
                        context,
                      );

                      if (result) {
                      }
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
