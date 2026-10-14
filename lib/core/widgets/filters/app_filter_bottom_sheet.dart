import 'package:flutter/material.dart';
import 'package:smartstock_inventory/app/app_navigation.dart';
import 'package:smartstock_inventory/core/constants/app_sizes.dart';
import '../../../data/models/brand_model.dart';
import '../../../data/models/category_model.dart';
import '../../constants/app_colors.dart';
import '../../services/brand_service.dart';
import '../../services/category_service.dart';
import 'components/filter_header.dart';
import 'components/filter_sections_1.dart';
import 'components/filter_sections_2.dart';
import 'components/filter_sections_3.dart';
import 'components/filter_bottom_buttons.dart';

class AppFilterBottomSheet extends StatefulWidget {
  final bool isSalesFilter;
  final Map<String, dynamic>? initialFilters;

  const AppFilterBottomSheet({
    super.key,
    this.isSalesFilter = false,
    this.initialFilters,
  });

  @override
  State<AppFilterBottomSheet> createState() => _AppFilterBottomSheetState();
}

class _AppFilterBottomSheetState extends State<AppFilterBottomSheet> {
  List<BrandModel> brands = [];
  List<CategoryModel> categories = [];
  Set<String> selectedBrands = {};
  Set<String> selectedCategories = {};
  List<CategoryModel> filteredCategories = [];
  List<BrandModel> filteredBrands = [];

  TextEditingController categorySearchController = TextEditingController();
  TextEditingController brandSearchController = TextEditingController();

  String selectedDateFilter = "";
  String? selectedSort;
  DateTime? startDate;
  DateTime? endDate;
  String? stockStatus;

  bool isCategoryExpanded = false;
  bool isBrandExpanded = false;

  @override
  void initState() {
    super.initState();
    loadFilters();

    if (widget.initialFilters != null) {
      selectedSort = widget.initialFilters!['sort'];
      stockStatus = widget.initialFilters!['stockStatus'];
      startDate = widget.initialFilters!['uiStartDate'];
      endDate = widget.initialFilters!['uiEndDate'];
      selectedDateFilter = widget.initialFilters!['selectedDateFilter'] ?? "";

      final initBrands = widget.initialFilters!['brands'] as List?;
      if (initBrands != null) {
        selectedBrands.addAll(initBrands.cast<String>());
      }

      final initCategories = widget.initialFilters!['categories'] as List?;
      if (initCategories != null) {
        selectedCategories.addAll(initCategories.cast<String>());
      }
    }
  }

  void loadFilters() {
    brands = BrandService().getAllBrands();
    categories = CategoryService().getAllCategories();
    filteredCategories = categories;
    filteredBrands = brands;
    setState(() {});
  }

  void _resetFilters() {
    Navigator.pop(context, {
      "sort": null,
      "stockStatus": null,
      "brands": <String>[],
      "categories": <String>[],
      "startDate": null,
      "endDate": null,
      "selectedDateFilter": "",
      "uiStartDate": null,
      "uiEndDate": null,
    });
  }

  void _applyFilters() {
    DateTime? st = startDate, en = endDate;
    if (selectedDateFilter.isNotEmpty) {
      final now = DateTime.now();
      en = now;
      st = selectedDateFilter == "Today"
          ? now
          : selectedDateFilter == "Last 7 Days"
          ? now.subtract(const Duration(days: 7))
          : selectedDateFilter == "Last 30 Days"
          ? now.subtract(const Duration(days: 30))
          : DateTime(now.year, now.month, 1);
    }
    Navigator.pop(context, {
      "sort": selectedSort,
      "stockStatus": stockStatus,
      "brands": selectedBrands.toList(),
      "categories": selectedCategories.toList(),
      "startDate": st,
      "endDate": en,
      "selectedDateFilter": selectedDateFilter,
      "uiStartDate": startDate,
      "uiEndDate": endDate,
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.93,
      minChildSize: 0.60,
      maxChildSize: 0.95,
      builder: (context, controller) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.blue, AppColors.lightBlue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppSizes.borderRadius30),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: AppSizes.size12),
            Center(
              child: Container(
                width: AppSizes.size50,
                height: 5,
                decoration: BoxDecoration(
                  color: AppColors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(AppSizes.borderRadius20),
                ),
              ),
            ),
            const SizedBox(height: AppSizes.size20),
            FilterHeader(onClose: () => AppNavigation.goBack(context)),
            const SizedBox(height: AppSizes.size20),
            Expanded(
              child: SingleChildScrollView(
                controller: controller,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.padding16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FilterSortSection(
                      selectedSort: selectedSort,
                      onSortChanged: (v) => setState(() => selectedSort = v),
                    ),
                    const SizedBox(height: AppSizes.size15),
                    FilterDateSection(
                      selectedDateFilter: selectedDateFilter,
                      startDate: startDate,
                      endDate: endDate,
                      parentContext: context,
                      onDateFilterChanged: (v) =>
                          setState(() => selectedDateFilter = v),
                      onDateRangeChanged: (s, e) => setState(() {
                        startDate = s;
                        endDate = e;
                      }),
                    ),
                    const SizedBox(height: AppSizes.size15),
                    if (!widget.isSalesFilter) ...[
                      FilterStockSection(
                        stockStatus: stockStatus,
                        onStockChanged: (v) => setState(() => stockStatus = v),
                      ),
                      const SizedBox(height: AppSizes.size15),
                    ],
                    FilterCategorySection(
                      isExpanded: isCategoryExpanded,
                      onToggleExpand: () => setState(
                        () => isCategoryExpanded = !isCategoryExpanded,
                      ),
                      searchController: categorySearchController,
                      onSearch: (v) => setState(
                        () => filteredCategories = categories
                            .where(
                              (c) => c.name.toLowerCase().contains(
                                v.toLowerCase(),
                              ),
                            )
                            .toList(),
                      ),
                      filteredCategories: filteredCategories,
                      selectedCategories: selectedCategories,
                      onToggleCategory: (v) => setState(
                        () => selectedCategories.contains(v)
                            ? selectedCategories.remove(v)
                            : selectedCategories.add(v),
                      ),
                    ),
                    const SizedBox(height: AppSizes.size15),
                    FilterBrandSection(
                      isExpanded: isBrandExpanded,
                      onToggleExpand: () =>
                          setState(() => isBrandExpanded = !isBrandExpanded),
                      searchController: brandSearchController,
                      onSearch: (v) => setState(
                        () => filteredBrands = brands
                            .where(
                              (b) => b.name.toLowerCase().contains(
                                v.toLowerCase(),
                              ),
                            )
                            .toList(),
                      ),
                      filteredBrands: filteredBrands,
                      selectedBrands: selectedBrands,
                      onToggleBrand: (v) => setState(
                        () => selectedBrands.contains(v)
                            ? selectedBrands.remove(v)
                            : selectedBrands.add(v),
                      ),
                    ),
                    const SizedBox(height: AppSizes.size20),
                    FilterBottomButtons(
                      onReset: _resetFilters,
                      onApply: _applyFilters,
                    ),
                    const SizedBox(height: AppSizes.size40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
