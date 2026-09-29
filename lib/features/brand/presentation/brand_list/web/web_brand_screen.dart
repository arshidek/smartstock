import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smartstock_inventory/app/app_navigation.dart';
import 'package:smartstock_inventory/core/constants/app_colors.dart';
import 'package:smartstock_inventory/core/constants/app_sizes.dart';
import 'package:smartstock_inventory/core/services/brand_service.dart';
import 'package:smartstock_inventory/core/services/product_service.dart';
import 'package:smartstock_inventory/core/widgets/search/app_search_bar.dart';
import 'package:smartstock_inventory/data/models/brand_model.dart';
import 'package:smartstock_inventory/features/brand/function/brand_functions.dart';
import 'package:smartstock_inventory/features/brand/widgets/brand_list_view.dart';
import '../../add_brand/add_brand_bottom_sheet.dart';

class WebBrandScreen extends StatefulWidget {
  const WebBrandScreen({super.key});

  @override
  State<WebBrandScreen> createState() => _WebBrandScreenState();
}

class _WebBrandScreenState extends State<WebBrandScreen> {
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
        title: const Text("Brands Management", style: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold, fontSize: AppSizes.font24)),
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.background),
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.padding25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 400,
                child: AppSearchBar(
                  controller: _searchController,
                  hintText: "Search Brands...",
                  showFilter: false,
                  onChanged: (value) => setState(() {}),
                ),
              ),
              const SizedBox(height: AppSizes.size24),
              Expanded(
                child: ValueListenableBuilder<Box<BrandModel>>(
                  valueListenable: BrandService().box.listenable(),
                  builder: (context, box, child) {
                    final brands = box.values.toList()..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
                    final searchBrands = _brandFunctions.searchBrands(brands: brands, query: _searchController.text);
                    return BrandListView(brands: searchBrands, isTabletOrWeb: true, productService: _productService);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await AppNavigation.showBottomSheet<bool>(context, const AddBrandBottomSheet());
        },
        backgroundColor: AppColors.blue,
        icon:  Icon(Icons.add, color: AppColors.white),
        label:  Text("Add Brand", style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
