import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/brand_service.dart';
import '../../../../core/services/category_service.dart';
import '../../../../data/models/brand_model.dart';
import '../../../../data/models/category_model.dart';
import '../../../../data/models/product_model.dart';
import '../../widgets/product_detail_app_bar.dart';
import 'mobile/mobile_product_detail_screen.dart';
import 'web/web_product_detail_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final BrandService _brandService = BrandService();
  final CategoryService _categoryService = CategoryService();

  BrandModel? _brand;
  CategoryModel? _category;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    _brand = _brandService.getBrandById(widget.product.brandId);
    _category = _categoryService.getCategoryById(widget.product.categoryId);
  }

  String _formatDateTime(DateTime dateTime) {
    final monthNames = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    final month = monthNames[dateTime.month - 1];
    return "$month ${dateTime.day}, ${dateTime.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: ProductDetailAppBar(
        product: widget.product,
        onRefresh: () {
          setState(() {
            _loadData();
          });
        },
      ),
      body: kIsWeb
          ? WebProductDetailScreen(
              product: widget.product,
              brand: _brand,
              category: _category,
              formattedDate: _formatDateTime(widget.product.createdAt),
            )
          : MobileProductDetailScreen(
              product: widget.product,
              brand: _brand,
              category: _category,
              formattedDate: _formatDateTime(widget.product.createdAt),
            ),
    );
  }
}
