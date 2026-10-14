import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';
import '../search/app_search_bar.dart';

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
                      : AppColors.textFieldBlue,
                  width: state.hasError ? 2.0 : 1.5,
                ),
              ),
              padding: const EdgeInsets.only(
                left: AppSizes.padding10,
                right: AppSizes.padding12,
              ),
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
                          borderRadius: BorderRadius.circular(
                            AppSizes.borderRadius12,
                          ),
                        ),
                        child: Icon(
                          icon,
                          color: AppColors.blue,
                          size: AppSizes.size22,
                        ),
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
                              borderRadius: BorderRadius.circular(
                                AppSizes.borderRadius12,
                              ),
                            ),
                            child: Icon(
                              icon,
                              color: AppColors.blue,
                              size: AppSizes.size22,
                            ),
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
                padding: const EdgeInsets.only(
                  top: 6,
                  left: AppSizes.padding12,
                ),
                child: Text(
                  state.errorText!,
                  style: const TextStyle(
                    color: AppColors.error,
                    fontSize: AppSizes.font12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  static Widget searchable<T>({
    required String label,
    required T? value,
    required List<T> items,
    required String Function(T) itemLabel,
    required ValueChanged<T?> onChanged,
    required IconData icon,
    String? Function(T?)? validator,
    bool showClearOption = false,
  }) {
    return _SearchableDropdownWidget<T>(
      label: label,
      value: value,
      items: items,
      itemLabel: itemLabel,
      onChanged: onChanged,
      icon: icon,
      validator: validator,
      showClearOption: showClearOption,
    );
  }
}

class _SearchableDropdownWidget<T> extends StatefulWidget {
  final String label;
  final T? value;
  final List<T> items;
  final String Function(T) itemLabel;
  final ValueChanged<T?> onChanged;
  final IconData icon;
  final String? Function(T?)? validator;
  final bool showClearOption;

  const _SearchableDropdownWidget({
    required this.label,
    required this.value,
    required this.items,
    required this.itemLabel,
    required this.onChanged,
    required this.icon,
    this.validator,
    this.showClearOption = false,
  });

  @override
  State<_SearchableDropdownWidget<T>> createState() =>
      _SearchableDropdownWidgetState<T>();
}

class _SearchableDropdownWidgetState<T>
    extends State<_SearchableDropdownWidget<T>> {
  Future<void> _showSearchMenu(FormFieldState<T> state) async {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    final result = await showGeneralDialog<dynamic>(
      context: context,
      barrierColor: Colors.transparent,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) {
        final screenWidth = MediaQuery.of(context).size.width;

        // Define a nice width: full width on mobile (minus padding), max 400 on larger screens
        double popupWidth = screenWidth > 600 ? 400.0 : screenWidth - 32.0;
        // If the field itself is larger than our calculated width, use the field's width
        if (size.width > popupWidth) {
          popupWidth = size.width;
        }

        // Calculate left position: start at the field's left edge
        double leftPos = offset.dx;

        // Prevent right overflow
        if (leftPos + popupWidth > screenWidth - 16.0) {
          leftPos = screenWidth - popupWidth - 16.0;
        }

        // Prevent left overflow
        if (leftPos < 16.0) {
          leftPos = 16.0;
        }

        return Stack(
          children: [
            Positioned(
              left: leftPos,
              top: offset.dy + size.height + 4,
              width: popupWidth,
              child: Material(
                elevation: 12,
                borderRadius: BorderRadius.circular(AppSizes.borderRadius20),
                color: AppColors.white,
                child: _SearchMenuContent<T>(
                  items: widget.items,
                  itemLabel: widget.itemLabel,
                  selectedValue: state.value,
                  showClearOption: widget.showClearOption,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (result == 'CLEAR') {
      state.didChange(null);
      widget.onChanged(null);
    } else if (result != null) {
      state.didChange(result as T);
      widget.onChanged(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      initialValue: widget.value,
      validator: widget.validator,
      builder: (FormFieldState<T> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () => _showSearchMenu(state),
              borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
              child: Container(
                height: AppSizes.size60,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
                  border: Border.all(
                    color: state.hasError
                        ? AppColors.error
                        : AppColors.textFieldBlue,
                    width: state.hasError ? 2.0 : 1.5,
                  ),
                ),
                padding: const EdgeInsets.only(
                  left: AppSizes.padding10,
                  right: AppSizes.padding12,
                ),
                child: Row(
                  children: [
                    Container(
                      width: AppSizes.size40,
                      height: AppSizes.size40,
                      decoration: BoxDecoration(
                        color: AppColors.lightBlue,
                        borderRadius: BorderRadius.circular(
                          AppSizes.borderRadius12,
                        ),
                      ),
                      child: Icon(
                        widget.icon,
                        color: AppColors.blue,
                        size: AppSizes.size22,
                      ),
                    ),
                    const SizedBox(width: AppSizes.size10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.label,
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
                            state.value == null
                                ? "Select"
                                : widget.itemLabel(state.value as T),
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
                    const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.blue,
                      size: AppSizes.size28,
                    ),
                  ],
                ),
              ),
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(
                  top: 6,
                  left: AppSizes.padding12,
                ),
                child: Text(
                  state.errorText!,
                  style: const TextStyle(
                    color: AppColors.error,
                    fontSize: AppSizes.font12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _SearchMenuContent<T> extends StatefulWidget {
  final List<T> items;
  final String Function(T) itemLabel;
  final T? selectedValue;
  final bool showClearOption;

  const _SearchMenuContent({
    required this.items,
    required this.itemLabel,
    this.selectedValue,
    this.showClearOption = false,
  });

  @override
  State<_SearchMenuContent<T>> createState() => _SearchMenuContentState<T>();
}

class _SearchMenuContentState<T> extends State<_SearchMenuContent<T>> {
  late TextEditingController _searchController;
  List<T> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _filteredItems = widget.items;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredItems = widget.items.where((item) {
        return widget.itemLabel(item).toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 350),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSizes.padding12),
            child: AppSearchBar(
              controller: _searchController,
              hintText: "Search...",
              showFilter: false,
            ),
          ),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount:
                  _filteredItems.length + (widget.showClearOption ? 1 : 0),
              itemBuilder: (context, index) {
                if (widget.showClearOption && index == 0) {
                  final isAllSelected = widget.selectedValue == null;
                  return InkWell(
                    onTap: () {
                      Navigator.pop(context, 'CLEAR');
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.padding16,
                        vertical: AppSizes.padding12,
                      ),
                      color: isAllSelected
                          ? AppColors.lightBlue
                          : Colors.transparent,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "All",
                              style: TextStyle(
                                fontSize: AppSizes.font16,
                                fontWeight: isAllSelected
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                                color: isAllSelected
                                    ? AppColors.blue
                                    : AppColors.black,
                              ),
                            ),
                          ),
                          if (isAllSelected)
                            const Icon(
                              Icons.check,
                              color: AppColors.blue,
                              size: AppSizes.size20,
                            ),
                        ],
                      ),
                    ),
                  );
                }

                final itemIndex = widget.showClearOption ? index - 1 : index;
                final item = _filteredItems[itemIndex];
                final isSelected = widget.selectedValue == item;
                return InkWell(
                  onTap: () {
                    Navigator.pop(context, item);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.padding16,
                      vertical: AppSizes.padding12,
                    ),
                    color: isSelected
                        ? AppColors.lightBlue
                        : Colors.transparent,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.itemLabel(item),
                            style: TextStyle(
                              fontSize: AppSizes.font16,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              color: isSelected
                                  ? AppColors.blue
                                  : AppColors.black,
                            ),
                          ),
                        ),
                        if (isSelected)
                          const Icon(
                            Icons.check,
                            color: AppColors.blue,
                            size: AppSizes.size20,
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
