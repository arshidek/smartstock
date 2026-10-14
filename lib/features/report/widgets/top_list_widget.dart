import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/widgets/cards/app_card_widget.dart';

class TopListItemModel {
  final Widget leading;
  final String title;
  final String subtitle;
  final Widget? middleText;
  final Widget trailing;
  final VoidCallback? onTap;

  TopListItemModel({
    required this.leading,
    required this.title,
    required this.subtitle,
    this.middleText,
    required this.trailing,
    this.onTap,
  });
}

class TopListWidget extends StatelessWidget {
  final String title;
  final List<TopListItemModel> items;
  final VoidCallback onViewAll;
  final Widget? headerRow;
  final Widget? bottomButton;

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
                  fontSize: AppSizes.font18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              if (items.isNotEmpty)
                InkWell(
                  onTap: onViewAll,
                  child: const Text(
                    "View All",
                    style: TextStyle(
                      color: AppColors.blue,
                      fontSize: AppSizes.font12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          if (headerRow != null && items.isNotEmpty) ...[
            const SizedBox(height: AppSizes.padding16),
            headerRow!,
          ],
          const SizedBox(height: AppSizes.padding16),
          if (items.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: AppSizes.padding20),
                child: Text(
                  "No data available.",
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: AppSizes.font14,
                  ),
                ),
              ),
            )
          else
            Column(
              children: items.take(5).toList().asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                Widget productPart = Row(
                  children: [
                    item.leading,
                    const SizedBox(width: AppSizes.padding12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: const TextStyle(
                              color: AppColors.black,
                              fontSize: AppSizes.font16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (item.subtitle.isNotEmpty) ...[
                            const SizedBox(height: 2),
                            Text(
                              item.subtitle,
                              style: const TextStyle(
                                color: AppColors.grey,
                                fontSize: AppSizes.font12,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                );

                Widget rowWidget;
                if (headerRow != null) {
                  rowWidget = Row(
                    children: [
                      Expanded(flex: 2, child: productPart),
                      if (item.middleText != null)
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.center,
                            child: item.middleText!,
                          ),
                        ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: item.trailing,
                        ),
                      ),
                    ],
                  );
                } else {
                  rowWidget = Row(
                    children: [
                      Expanded(child: productPart),
                      if (item.middleText != null) ...[
                        const SizedBox(width: AppSizes.padding8),
                        item.middleText!,
                      ],
                      const SizedBox(width: AppSizes.padding8),
                      item.trailing,
                    ],
                  );
                }

                return Column(
                  children: [
                    InkWell(onTap: item.onTap, child: rowWidget),
                    if (index < (items.length > 5 ? 5 : items.length) - 1)
                      const Divider(
                        color: AppColors.lightBlue,
                        height: AppSizes.padding30,
                      ),
                  ],
                );
              }).toList(),
            ),
          if (bottomButton != null) ...[
            const SizedBox(height: AppSizes.padding16),
            bottomButton!,
          ],
        ],
      ),
    );
  }
}
