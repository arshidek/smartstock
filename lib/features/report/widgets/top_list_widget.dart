import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/widgets/cards/app_card_widget.dart';

class TopListItemModel {
  final Widget leading;
  final String title;
  final String subtitle;
  final Widget? middleText; // For "ORDERS" in Top Selling
  final Widget trailing;

  TopListItemModel({
    required this.leading,
    required this.title,
    required this.subtitle,
    this.middleText,
    required this.trailing,
  });
}

class TopListWidget extends StatelessWidget {
  final String title;
  final List<TopListItemModel> items;
  final VoidCallback onViewAll;
  final Widget? headerRow; // Used for "PRODUCT   ORDERS   REVENUE% OF TOTAL"
  final Widget? bottomButton; // Used for "VIEW DETAILED SALES"

  const TopListWidget({
    super.key,
    required this.title,
    required this.items,
    required this.onViewAll,
    this.headerRow,
    this.bottomButton,
  });

  @override
  Widget build(BuildContext context) {
    return AppCardWidget(
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                onTap: onViewAll,
                child: const Text(
                  "View All",
                  style: TextStyle(
                    color: Color(0xFF4C2DB3), // Purple from mockup
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          if (headerRow != null && items.isNotEmpty) ...[
            const SizedBox(height: 16),
            headerRow!,
          ],
          const SizedBox(height: 16),
          if (items.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "No data available.",
                  style: TextStyle(color: AppColors.grey, fontSize: 12),
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              separatorBuilder: (context, index) =>
                  const Divider(color: Color(0xFFF1F5F9), height: 32),
              itemBuilder: (context, index) {
                final item = items[index];
                return Row(
                  children: [
                    item.leading,
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: const TextStyle(
                              color: AppColors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            item.subtitle,
                            style: const TextStyle(
                              color: AppColors.grey,
                              fontSize: 10,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    if (item.middleText != null) ...[
                      const SizedBox(width: 8),
                      item.middleText!,
                    ],
                    const SizedBox(width: 8),
                    item.trailing,
                  ],
                );
              },
            ),
          if (bottomButton != null) ...[
            const SizedBox(height: 16),
            bottomButton!,
          ],
        ],
      ),
    );
  }
}
