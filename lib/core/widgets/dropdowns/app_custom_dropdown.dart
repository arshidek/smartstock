import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';

class AppCustomDropdown {
  static Widget dropdown<T>({
    required String label,
    required T? value,
    required List<T> items,
    required String Function(T) itemLabel,
    required ValueChanged<T?> onChanged,
    required IconData icon,
    String? Function(T?)? validator,
  }) {
    return FormField<T>(
      initialValue: value,
      validator: validator,
      builder: (FormFieldState<T> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 68,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppSizes.borderRadius20),
                border: Border.all(
                  color: state.hasError
                      ? AppColors.error
                      : const Color(0xFFD6E4FF),
                  width: state.hasError ? 2.0 : 1.5,
                ),
              ),
              padding: const EdgeInsets.only(left: 10, right: 14),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<T>(
                  dropdownColor: AppColors.white,
                  elevation: 12,
                  borderRadius: BorderRadius.circular(AppSizes.borderRadius20),
                  value: state.value,
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.blue,
                    size: 28,
                  ),
                  isExpanded: true,
                  itemHeight: 68,
                  onChanged: (T? newValue) {
                    state.didChange(newValue);
                    onChanged(newValue);
                  },
                  items: items.map((item) {
                    return DropdownMenuItem<T>(
                      value: item,
                      child: Text(
                        itemLabel(item),
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    );
                  }).toList(),
                  hint: Row(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: AppColors.lightBlue,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(icon, color: AppColors.blue, size: 22),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              label,
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              "Select",
                              style: TextStyle(
                                fontSize: 15,
                                color: AppColors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  selectedItemBuilder: (BuildContext context) {
                    return items.map<Widget>((item) {
                      return Row(
                        children: [
                          Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              color: AppColors.lightBlue,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(icon, color: AppColors.blue, size: 22),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  label,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: AppColors.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  itemLabel(item),
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }).toList();
                  },
                ),
              ),
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 6, left: 12),
                child: Text(
                  state.errorText!,
                  style: const TextStyle(color: AppColors.error, fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }
}
