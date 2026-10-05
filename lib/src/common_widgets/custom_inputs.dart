import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/responsive_ext.dart';
import '../theme/app_theme.dart';
import '../utils/app_date_formatter.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final String? hintText;
  final String? initialValue;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final bool readOnly;
  final TextCapitalization textCapitalization;
  final int maxLines;

  const CustomInputField({
    super.key,
    required this.label,
    this.hintText,
    this.initialValue,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.readOnly = false,
    this.textCapitalization = TextCapitalization.none,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.indigo,
            letterSpacing: 0.04,
          ),
        ),
        SizedBox(height: 5.h),
        TextFormField(
          controller: controller,
          initialValue: initialValue,
          obscureText: obscureText,
          keyboardType: keyboardType,
          maxLength: keyboardType == TextInputType.phone ? 10 : null,
          inputFormatters: keyboardType == TextInputType.phone
              ? [FilteringTextInputFormatter.digitsOnly]
              : null,
          readOnly: readOnly,
          textCapitalization: textCapitalization,
          maxLines: maxLines,
          style: TextStyle(fontSize: 14.sp, color: AppColors.textDark),
          decoration: InputDecoration(
            hintText: hintText,
            counterText: '',
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}

class SearchableDropdownFormField<T> extends StatefulWidget {
  final T? initialValue;
  final InputDecoration decoration;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final Widget? hint;
  final bool isExpanded;
  final double? menuMaxHeight;

  const SearchableDropdownFormField({
    super.key,
    this.initialValue,
    this.decoration = const InputDecoration(),
    required this.items,
    required this.onChanged,
    this.hint,
    this.isExpanded = false,
    this.menuMaxHeight,
  });

  @override
  State<SearchableDropdownFormField<T>> createState() =>
      _SearchableDropdownFormFieldState<T>();
}

class _SearchableDropdownFormFieldState<T>
    extends State<SearchableDropdownFormField<T>> {
  T? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  void didUpdateWidget(SearchableDropdownFormField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      _value = widget.initialValue;
    }
  }

  DropdownMenuItem<T>? get _selectedItem {
    for (final item in widget.items) {
      if (item.value == _value) return item;
    }
    return null;
  }

  Future<void> _openMenu() async {
    if (widget.onChanged == null) return;
    final selected = await showDialog<T>(
      context: context,
      builder: (context) => _SearchableDropdownDialog<T>(
        items: widget.items,
        selectedValue: _value,
        maxHeight: widget.menuMaxHeight,
      ),
    );
    if (!mounted || selected == null) return;
    setState(() => _value = selected);
    widget.onChanged!(selected);
  }

  @override
  Widget build(BuildContext context) {
    final selectedItem = _selectedItem;
    return GestureDetector(
      onTap: _openMenu,
      child: InputDecorator(
        decoration: widget.decoration.copyWith(
          enabled: widget.onChanged != null,
          suffixIcon: const Icon(Icons.arrow_drop_down),
        ),
        isEmpty: selectedItem == null,
        child: selectedItem?.child ?? widget.hint,
      ),
    );
  }
}

class _SearchableDropdownDialog<T> extends StatefulWidget {
  final List<DropdownMenuItem<T>> items;
  final T? selectedValue;
  final double? maxHeight;

  const _SearchableDropdownDialog({
    required this.items,
    required this.selectedValue,
    this.maxHeight,
  });

  @override
  State<_SearchableDropdownDialog<T>> createState() =>
      _SearchableDropdownDialogState<T>();
}

class _SearchableDropdownDialogState<T>
    extends State<_SearchableDropdownDialog<T>> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.trim().toLowerCase();
    final filteredItems = widget.items.where((item) {
      final value = item.value?.toString().toLowerCase() ?? '';
      return query.isEmpty || value.contains(query);
    }).toList();
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    final width = screenWidth.clamp(240.0, 420.0).toDouble();
    const searchAndPaddingHeight = 88.0;
    const itemHeight = 44.0;
    final contentHeight =
        searchAndPaddingHeight + (filteredItems.length * itemHeight);
    final height = (widget.maxHeight ?? contentHeight)
        .clamp(96.0, screenHeight * 0.7)
        .toDouble();

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: width, maxHeight: height),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _searchController,
                autofocus: true,
                onChanged: (_) => setState(() {}),
                decoration: const InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  isDense: true,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: (height - searchAndPaddingHeight).clamp(0.0, 320.0),
                child: filteredItems.isEmpty
                    ? const Center(child: Text('No options found'))
                    : ListView.builder(
                        itemCount: filteredItems.length,
                        itemBuilder: (context, index) {
                          final item = filteredItems[index];
                          return InkWell(
                            onTap: () => Navigator.of(context).pop(item.value),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12,
                              ),
                              child: item.child,
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomDatePickerField extends StatelessWidget {
  final String label;
  final String? hintText;
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDateSelected;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final Widget? prefixIcon;
  final bool enabled;

  const CustomDatePickerField({
    super.key,
    required this.label,
    required this.onDateSelected,
    this.hintText,
    this.selectedDate,
    this.firstDate,
    this.lastDate,
    this.prefixIcon,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    String formattedDate = '';
    if (selectedDate != null) {
      formattedDate = AppDateFormatter.formatDateOnly(selectedDate);
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.indigo,
            letterSpacing: 0.04,
          ),
        ),
        SizedBox(height: 5.h),
        TextFormField(
          key: ValueKey(formattedDate),
          initialValue: formattedDate,
          readOnly: true,
          enabled: enabled,
          onTap: !enabled
              ? null
              : () async {
                  final now = DateTime.now();
                  final effectiveLastDate = lastDate ?? DateTime(2100);
                  DateTime initial = selectedDate ?? now;
                  if (initial.isAfter(effectiveLastDate)) {
                    initial = effectiveLastDate;
                  }
                  final date = await showDatePicker(
                    context: context,
                    initialDate: initial,
                    firstDate: firstDate ?? DateTime(1900),
                    lastDate: effectiveLastDate,
                    helpText: 'SELECT ${label.toUpperCase()}',
                  );
                  if (date != null) {
                    onDateSelected(date);
                  }
                },
          style: TextStyle(fontSize: 14.sp, color: AppColors.textDark),
          decoration: InputDecoration(
            hintText: hintText ?? 'Select Date',
            prefixIcon: prefixIcon,
            suffixIcon: Icon(
              Icons.calendar_today,
              color: AppColors.orange,
              size: 20.r,
            ),
          ),
        ),
      ],
    );
  }
}

class CustomTimePickerField extends StatelessWidget {
  final String label;
  final String? hintText;
  final TimeOfDay? selectedTime;
  final String? initialTimeString;
  final ValueChanged<TimeOfDay?> onTimeSelected;
  final Widget? prefixIcon;
  final bool enabled;

  const CustomTimePickerField({
    super.key,
    required this.label,
    required this.onTimeSelected,
    this.hintText,
    this.selectedTime,
    this.initialTimeString,
    this.prefixIcon,
    this.enabled = true,
  });

  static TimeOfDay? parseTimeString(String? timeStr) {
    if (timeStr == null || timeStr.trim().isEmpty) return null;
    final regex = RegExp(
      r'^(\d{1,2}):(\d{2})(?::\d{2})?\s*(AM|PM|am|pm)?$',
      caseSensitive: false,
    );
    final match = regex.firstMatch(timeStr.trim());
    if (match != null) {
      int hour = int.parse(match.group(1)!);
      final minute = int.parse(match.group(2)!);
      final period = match.group(3)?.toUpperCase();
      if (period == 'PM' && hour < 12) hour += 12;
      if (period == 'AM' && hour == 12) hour = 0;
      if (hour >= 0 && hour < 24 && minute >= 0 && minute < 60) {
        return TimeOfDay(hour: hour, minute: minute);
      }
    }
    return null;
  }

  static String formatTimeOfDay(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    String formattedTime = '';
    if (selectedTime != null) {
      formattedTime = formatTimeOfDay(selectedTime!);
    } else if (initialTimeString != null &&
        initialTimeString!.trim().isNotEmpty) {
      final parsed = parseTimeString(initialTimeString);
      if (parsed != null) {
        formattedTime = formatTimeOfDay(parsed);
      } else {
        formattedTime = initialTimeString!.trim();
      }
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.indigo,
            letterSpacing: 0.04,
          ),
        ),
        SizedBox(height: 5.h),
        TextFormField(
          key: ValueKey(formattedTime),
          initialValue: formattedTime,
          readOnly: true,
          enabled: enabled,
          onTap: !enabled
              ? null
              : () async {
                  final initial =
                      selectedTime ??
                      parseTimeString(formattedTime) ??
                      TimeOfDay.now();
                  final time = await showTimePicker(
                    context: context,
                    initialTime: initial,
                    helpText: 'SELECT ${label.toUpperCase()}',
                  );
                  if (time != null) {
                    onTimeSelected(time);
                  }
                },
          style: TextStyle(fontSize: 14.sp, color: AppColors.textDark),
          decoration: InputDecoration(
            hintText: hintText ?? 'e.g. 10:30 AM',
            prefixIcon:
                prefixIcon ??
                const Icon(Icons.access_time_rounded, color: AppColors.indigo),
            suffixIcon: formattedTime.isNotEmpty
                ? IconButton(
                    icon: Icon(
                      Icons.close_rounded,
                      color: AppColors.textMuted,
                      size: 20.r,
                    ),
                    onPressed: !enabled ? null : () => onTimeSelected(null),
                  )
                : Icon(
                    Icons.access_time_rounded,
                    color: AppColors.orange,
                    size: 20.r,
                  ),
          ),
        ),
      ],
    );
  }
}
