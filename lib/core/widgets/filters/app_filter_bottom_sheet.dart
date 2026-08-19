import 'package:flutter/material.dart';

import '../../../data/models/brand_model.dart';
import '../../../data/models/category_model.dart';
import '../../services/brand_service.dart';
import '../../services/category_service.dart';

class AppFilterBottomSheet extends StatefulWidget {
  final bool isSalesFilter;
  const AppFilterBottomSheet({super.key, this.isSalesFilter = false});

  @override
  State<AppFilterBottomSheet> createState() => _AppFilterBottomSheetState();
}

class _AppFilterBottomSheetState extends State<AppFilterBottomSheet> {
  List<BrandModel> brands = [];
  List<CategoryModel> categories = [];
  Set<String> selectedBrands = {};
  Set<String> selectedCategories = {};
  List<String> activeFilters = [];
  List<CategoryModel> filteredCategories = [];
  List<BrandModel> filteredBrands = [];

  TextEditingController categorySearchController = TextEditingController();
  TextEditingController brandSearchController = TextEditingController();

  String selectedDateFilter = "";

  @override
  void initState() {
    super.initState();

    loadFilters();
  }

  void loadFilters() {
    brands = BrandService().getAllBrands();

    categories = CategoryService().getAllCategories();
    filteredCategories = categories;
    filteredBrands = brands;

    setState(() {});
  }

  // Sort Option
  String selectedSort = 'A - Z';

  // Date Range
  DateTime? startDate = DateTime(2026, 6, 5);
  DateTime? endDate = DateTime(2026, 6, 5);

  // Stock Status
  String stockStatus = 'All';

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.93,
      minChildSize: 0.60,
      maxChildSize: 0.95,
      builder: (context, controller) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: Column(
            children: [
              /// Drag Handle
              const SizedBox(height: 10),

              Center(
                child: Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              /// Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "Filter & Sort",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),

              const Divider(),

              Expanded(
                child: SingleChildScrollView(
                  controller: controller,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Active Filters
                      const Text(
                        "ACTIVE FILTERS",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: activeFilters.map((filter) {
                          return Chip(
                            label: Text(filter),
                            deleteIcon: const Icon(Icons.close, size: 18),
                            onDeleted: () {
                              setState(() {
                                activeFilters.remove(filter);
                              });
                            },
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 25),

                      /// SORT BY
                      const Text(
                        "SORT BY",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),

                      const SizedBox(height: 15),

                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          _buildSortChip(
                            "A - Z",
                            isSelected: selectedSort == "A - Z",
                          ),

                          _buildSortChip(
                            "Z - A",
                            isSelected: selectedSort == "Z - A",
                          ),

                          _buildSortChip(
                            "Price: Low to High",
                            isSelected: selectedSort == "Price: Low to High",
                          ),

                          _buildSortChip(
                            "Price: High to Low",
                            isSelected: selectedSort == "Price: High to Low",
                          ),

                          _buildSortChip(
                            "Stock: Low to High",
                            isSelected: selectedSort == "Stock: Low to High",
                          ),

                          _buildSortChip(
                            "Recently Added",
                            isSelected: selectedSort == "Recently Added",
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),

                      const Text(
                        "DATE",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),

                      const SizedBox(height: 15),

                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          _buildDateChip("Today"),
                          _buildDateChip("Last 7 Days"),
                          _buildDateChip("Last 30 Days"),
                          _buildDateChip("This Month"),
                        ],
                      ),

                      const SizedBox(height: 15),

                      Row(
                        children: [
                          Expanded(child: _buildDateField("START DATE", true)),

                          const SizedBox(width: 15),

                          Expanded(child: _buildDateField("END DATE", false)),
                        ],
                      ),

                      const SizedBox(height: 30),

                      if (!widget.isSalesFilter) ...[
                        const Text(
                          "STOCK STATUS",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),

                        const SizedBox(height: 15),

                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            _buildStockStatusChip("All", stockStatus == "All"),
                            _buildStockStatusChip(
                              "In Stock",
                              stockStatus == "In Stock",
                            ),
                            _buildStockStatusChip(
                              "Low Stock",
                              stockStatus == "Low Stock",
                            ),
                            _buildStockStatusChip(
                              "Out of Stock",
                              stockStatus == "Out of Stock",
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),
                      ],

                      const SizedBox(height: 30),

                      const Text(
                        "CATEGORY",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),

                      const SizedBox(height: 10),

                      TextField(
                        controller: categorySearchController,
                        onChanged: (value) {
                          setState(() {
                            filteredCategories = categories.where((category) {
                              return category.name.toLowerCase().contains(
                                value.toLowerCase(),
                              );
                            }).toList();
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Search Category...",
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      _buildCheckboxList(
                        filteredCategories.map((e) => e.name).toList(),
                        selectedCategories,
                      ),

                      const SizedBox(height: 30),
                      const Text(
                        "BRAND",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),

                      const SizedBox(height: 10),

                      TextField(
                        controller: brandSearchController,
                        onChanged: (value) {
                          setState(() {
                            filteredBrands = brands.where((brand) {
                              return brand.name.toLowerCase().contains(
                                value.toLowerCase(),
                              );
                            }).toList();
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Search Brands...",
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      _buildCheckboxList(
                        filteredBrands.map((e) => e.name).toList(),
                        selectedBrands,
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            selectedSort = "A - Z";
                            stockStatus = "All";
                            selectedDateFilter = "";

                            startDate = null;
                            endDate = null;

                            selectedBrands.clear();
                            selectedCategories.clear();
                            activeFilters.clear();

                            categorySearchController.clear();
                            brandSearchController.clear();

                            filteredCategories = categories;
                            filteredBrands = brands;
                          });
                        },
                        child: const Text("Reset"),
                      ),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, {
                            "sort": selectedSort,
                            "stockStatus": stockStatus,
                            "brands": selectedBrands.toList(),
                            "categories": selectedCategories.toList(),
                            "startDate": startDate,
                            "endDate": endDate,
                          });
                        },
                        child: const Text("Apply"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSortChip(String label, {bool isSelected = false}) {
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          setState(() => selectedSort = label);
        }
      },
      selectedColor: const Color(0xFF4A2BFF),
      labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
    );
  }

  Widget _buildDateChip(String label) {
    return ChoiceChip(
      label: Text(label),
      selected: selectedDateFilter == label,
      onSelected: (selected) {
        if (selected) {
          setState(() {
            selectedDateFilter = label;
          });
        }
      },
    );
  }

  Widget _buildDateField(String label, bool isStartDate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),

        const SizedBox(height: 6),

        InkWell(
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: isStartDate
                  ? (startDate ?? DateTime.now())
                  : (endDate ?? DateTime.now()),
              firstDate: DateTime(2020),
              lastDate: DateTime(2100),
            );

            if (picked != null) {
              setState(() {
                if (isStartDate) {
                  startDate = picked;
                } else {
                  endDate = picked;
                }
              });
            }
          },

          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),

            child: Row(
              children: [
                const Icon(Icons.calendar_today, size: 20),

                const SizedBox(width: 8),

                Text(
                  isStartDate
                      ? (startDate == null
                            ? "Select Date"
                            : "${startDate!.day}/${startDate!.month}/${startDate!.year}")
                      : (endDate == null
                            ? "Select Date"
                            : "${endDate!.day}/${endDate!.month}/${endDate!.year}"),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStockStatusChip(String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          stockStatus = label;
        });
      },
      child: Container(
        width: 120,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4A2BFF) : Colors.white,
          border: Border.all(
            color: isSelected ? const Color(0xFF4A2BFF) : Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(label, textAlign: TextAlign.center),
      ),
    );
  }

  Widget _buildCheckboxList(List<String> items, Set<String> selectedSet) {
    return Column(
      children: items.map((item) {
        return CheckboxListTile(
          title: Text(item),
          value: selectedSet.contains(item),
          onChanged: (bool? value) {
            setState(() {
              if (value == true) {
                selectedSet.add(item);
              } else {
                selectedSet.remove(item);
              }
            });
          },
          contentPadding: EdgeInsets.zero,
          dense: true,
        );
      }).toList(),
    );
  }
}
