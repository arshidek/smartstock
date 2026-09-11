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
              height: AppSizes.size60,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
                border: Border.all(
                  color: state.hasError
                      ? AppColors.error
                      :  AppColors.textFieldBlue,
                  width: state.hasError ? 2.0 : 1.5,
                ),
              ),
              padding: const EdgeInsets.only(left: AppSizes.padding10, right: AppSizes.padding12),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<T>(
                  dropdownColor: AppColors.white,
                  elevation: 12,
                  borderRadius: BorderRadius.circular(AppSizes.borderRadius20),
                  value: state.value,
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.blue,
                    size: AppSizes.size28,
                  ),
                  isExpanded: true,
                  itemHeight: AppSizes.size60,
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
                          fontSize: AppSizes.font16,
                        ),
                      ),
                    );
                  }).toList(),
                  hint: Row(
                    children: [
                      Container(
                        width: AppSizes.size40,
                        height: AppSizes.size40,
                        decoration: BoxDecoration(
                          color: AppColors.lightBlue,
                          borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
                        ),
                        child: Icon(icon, color: AppColors.blue, size: AppSizes.size22),
                      ),
                      const SizedBox(width: AppSizes.size10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              label,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: AppSizes.font13,
                                color: AppColors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              "Select",
                              style: TextStyle(
                                fontSize: AppSizes.font15,
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
                            width: AppSizes.size40,
                            height: AppSizes.size40,
                            decoration: BoxDecoration(
                              color: AppColors.lightBlue,
                              borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
                            ),
                            child: Icon(icon, color: AppColors.blue, size: AppSizes.size22),
                          ),
                          const SizedBox(width: AppSizes.size10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  label,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: AppSizes.font13,
                                    color: AppColors.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  itemLabel(item),
                                  style: const TextStyle(
                                    fontSize: AppSizes.font15,
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
                padding: const EdgeInsets.only(top: 6, left: AppSizes.padding12),
                child: Text(
                  state.errorText!,
                  style: const TextStyle(color: AppColors.error, fontSize: AppSizes.font12),
                ),
              ),
          ],
        );
      },
    );
  }
}
