import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../app/app_navigation.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/services/product_service.dart';
import '../../../core/widgets/buttons/app_button.dart';
import '../../../core/widgets/search/app_search_bar.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/services/category_service.dart';
import '../../../data/models/category_model.dart';
import '../function/category_functions.dart';
import 'add_category_bottom_sheet.dart';
import '../widgets/category_list_view.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  final CategoryFunctions _categoryFunctions = CategoryFunctions();
  final ProductService _productService = ProductService();

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
                final result = await AppNavigation.showBottomSheet<bool>(
                  context,
                  const AddCategoryBottomSheet(),
                );

                if (result == true) {
                }
              },
              backgroundColor: AppColors.blue,
              icon: Icon(Icons.add, color: AppColors.white),
              label: Text(
                "Add Category",
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
              "Categories",
              style: TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.bold,
                fontSize: AppSizes.font24,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: AppSizes.size12,
              top: AppSizes.size10,
              bottom: AppSizes.size10,
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.background),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.padding16),
          child: Column(
            children: [
              const SizedBox(height: AppSizes.size15),

              // Search Bar fix later....
              AppSearchBar(
                controller: _searchController,
                hintText: "Search Categories...",
                showFilter: false,
                onChanged: (value) {
                  setState(() {});
                },
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
                    text: "Add Category",
                    icon: Icons.add,
                    onPressed: () async {
                      final result = await AppNavigation.showBottomSheet<bool>(
                        context,
                        const AddCategoryBottomSheet(),
                      );

                      if (result == true) {
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
