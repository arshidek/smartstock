import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';
import '../search/app_search_bar.dart';

class AppSearchableDropdown<T> extends StatefulWidget {
  final String label;
  final T? value;
  final List<T> items;
  final String Function(T) itemLabel;
  final ValueChanged<T?> onChanged;
  final IconData icon;
  final String? Function(T?)? validator;

  const AppSearchableDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.itemLabel,
    required this.onChanged,
    required this.icon,
    this.validator,
  });

  @override
  State<AppSearchableDropdown<T>> createState() =>
      _AppSearchableDropdownState<T>();
}

class _AppSearchableDropdownState<T> extends State<AppSearchableDropdown<T>> {
  Future<void> _showSearchMenu(FormFieldState<T> state) async {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    final result = await showGeneralDialog<T>(
      context: context,
      barrierColor: Colors.transparent,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Stack(
          children: [
            Positioned(
              left: offset.dx,
              top: offset.dy + size.height + 4,
              width: size.width,
              child: Material(
                elevation: 12,
                borderRadius: BorderRadius.circular(AppSizes.borderRadius20),
                color: AppColors.white,
                child: _SearchMenuContent<T>(
                  items: widget.items,
                  itemLabel: widget.itemLabel,
                  selectedValue: state.value,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (result != null) {
      state.didChange(result);
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

  const _SearchMenuContent({
    required this.items,
    required this.itemLabel,
    this.selectedValue,
  });

  @override
  State<_SearchMenuContent<T>> createState() => _SearchMenuContentState<T>();
}

class _SearchMenuContentState<T> extends State<_SearchMenuContent<T>> {
  final TextEditingController _searchController = TextEditingController();
  List<T> _filteredItems = [];

  @override
  void initState() {
    super.initState();
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
              itemCount: _filteredItems.length,
              itemBuilder: (context, index) {
                final item = _filteredItems[index];
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
