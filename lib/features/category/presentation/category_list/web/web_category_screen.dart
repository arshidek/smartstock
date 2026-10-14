import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smartstock_inventory/app/app_navigation.dart';
import 'package:smartstock_inventory/core/constants/app_colors.dart';
import 'package:smartstock_inventory/core/constants/app_sizes.dart';
import 'package:smartstock_inventory/core/services/category_service.dart';
import 'package:smartstock_inventory/core/services/product_service.dart';
import 'package:smartstock_inventory/core/widgets/search/app_search_bar.dart';
import 'package:smartstock_inventory/core/responsive/responsive.dart';
import 'package:smartstock_inventory/data/models/category_model.dart';
import 'package:smartstock_inventory/features/category/function/category_functions.dart';
import 'package:smartstock_inventory/features/category/presentation/add_category/add_category_bottom_sheet.dart';
import 'package:smartstock_inventory/features/category/widgets/category_list_view.dart';

class WebCategoryScreen extends StatefulWidget {
  const WebCategoryScreen({super.key});

  @override
  State<WebCategoryScreen> createState() => _WebCategoryScreenState();
}

class _WebCategoryScreenState extends State<WebCategoryScreen> {
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
        title: const Text(
          "Categories Management",
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
          padding: const EdgeInsets.all(AppSizes.padding25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: AppSearchBar(
                  controller: _searchController,
                  hintText: "Search Categories...",
                  showFilter: false,
                  onChanged: (value) => setState(() {}),
                ),
              ),
              const SizedBox(height: AppSizes.size24),
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
                      isTabletOrWeb: true,
                      productService: _productService,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await AppNavigation.showBottomSheet<bool>(
            context,
            const AddCategoryBottomSheet(),
          );
        },
        backgroundColor: AppColors.blue,
        icon: Icon(Icons.add, color: AppColors.white),
        label: Text(
          "Add Category",
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
