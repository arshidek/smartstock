import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smartstock_inventory/app/app_navigation.dart';
import 'package:smartstock_inventory/core/constants/app_colors.dart';
import 'package:smartstock_inventory/core/constants/app_sizes.dart';
import 'package:smartstock_inventory/core/services/category_service.dart';
import 'package:smartstock_inventory/core/services/product_service.dart';
import 'package:smartstock_inventory/core/widgets/buttons/app_button.dart';
import 'package:smartstock_inventory/core/widgets/search/app_search_bar.dart';
import 'package:smartstock_inventory/data/models/category_model.dart';
import 'package:smartstock_inventory/features/category/function/category_functions.dart';
import 'package:smartstock_inventory/features/category/presentation/add_category/add_category_bottom_sheet.dart';
import 'package:smartstock_inventory/features/category/widgets/category_list_view.dart';

class MobileCategoryScreen extends StatefulWidget {
  const MobileCategoryScreen({super.key});

  @override
  State<MobileCategoryScreen> createState() => _MobileCategoryScreenState();
}

class _MobileCategoryScreenState extends State<MobileCategoryScreen> {
  final _searchController = TextEditingController();
  final _categoryFunctions = CategoryFunctions();
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
          "Categories",
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
                hintText: "Search Categories...",
                showFilter: false,
                onChanged: (value) => setState(() {}),
              ),
              const SizedBox(height: AppSizes.size20),
              Expanded(
                child: ValueListenableBuilder<Box<CategoryModel>>(
                  valueListenable: CategoryService().box.listenable(),
                  builder: (context, box, child) {
                    final categories = box.values.toList()
                      ..sort(
                        (a, b) => a.name.toLowerCase().compareTo(
                          b.name.toLowerCase(),
                        ),
                      );
                    final searchCategories = _categoryFunctions
                        .searchCategories(
                          categories: categories,
                          query: _searchController.text,
                        );
                    return CategoryListView(
                      categories: searchCategories,
                      isTabletOrWeb: false,
                      productService: _productService,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: AppSizes.size15),
                child: AppButton(
                  text: "Add Category",
                  icon: Icons.add,
                  onPressed: () async {
                    await AppNavigation.showBottomSheet<bool>(
                      context,
                      const AddCategoryBottomSheet(),
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
