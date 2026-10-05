import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:community_connect/src/common_widgets/custom_inputs.dart';
import 'package:community_connect/src/common_widgets/translated_text.dart';
import 'package:community_connect/src/theme/app_theme.dart';
import 'package:community_connect/src/utils/responsive_ext.dart';
import '../data/profile_provider.dart';

class StateAndCitySelector extends HookConsumerWidget {
  final ValueNotifier<String?> selectedState;
  final ValueNotifier<String?> selectedCity;

  const StateAndCitySelector({
    super.key,
    required this.selectedState,
    required this.selectedCity,
  });

  static const _defaultStates = [
    'Andaman and Nicobar Islands',
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chandigarh',
    'Chhattisgarh',
    'Dadra and Nagar Haveli and Daman and Diu',
    'Delhi',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jammu and Kashmir',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Ladakh',
    'Lakshadweep',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Puducherry',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentState = useValueListenable(selectedState);
    final currentCity = useValueListenable(selectedCity);
    final statesAsync = ref.watch(statesListProvider);
    final hasState = currentState != null && currentState.trim().isNotEmpty;
    final citiesAsync = hasState
        ? ref.watch(citiesListProvider(currentState.trim()))
        : null;
    final states = {
      ...(statesAsync.value?.isNotEmpty == true
          ? statesAsync.value!
          : _defaultStates),
      if (currentState != null && currentState.isNotEmpty) currentState,
    }.toList()..sort();
    final cities = {
      ...(citiesAsync?.value ?? const <String>[]),
      if (currentCity != null && currentCity.isNotEmpty) currentCity,
    }.toList()..sort();

    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        children: [
          Expanded(
            child: _LocationDropdown(
              label: 'State *',
              hint: 'Select State',
              value: states.contains(currentState) ? currentState : null,
              items: states,
              loading: statesAsync.isLoading,
              onChanged: (value) {
                selectedState.value = value;
                selectedCity.value = null;
              },
              icon: Icons.map_outlined,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: _LocationDropdown(
              label: 'City *',
              hint: hasState ? 'Select City' : 'Select State first',
              value: hasState && cities.contains(currentCity)
                  ? currentCity
                  : null,
              items: cities,
              loading: citiesAsync?.isLoading ?? false,
              onChanged: hasState
                  ? (value) => selectedCity.value = value
                  : null,
              icon: Icons.location_city_rounded,
            ),
          ),
        ],
      ),
    );
  }
}

class _LocationDropdown extends StatelessWidget {
  final String label;
  final String hint;
  final String? value;
  final List<String> items;
  final bool loading;
  final ValueChanged<String?>? onChanged;
  final IconData icon;

  const _LocationDropdown({
    required this.label,
    required this.hint,
    required this.value,
    required this.items,
    required this.loading,
    required this.onChanged,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TranslatedText(
          label,
          style: TextStyle(
            color: AppColors.indigo,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 6.h),
        SearchableDropdownFormField<String>(
          initialValue: value,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: AppColors.indigo),
            suffixIcon: loading
                ? const Padding(
                    padding: EdgeInsets.all(12),
                    child: SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 12.h,
            ),
          ),
          items: items
              .map(
                (item) => DropdownMenuItem(
                  value: item,
                  child: TranslatedText(
                    item,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
          hint: TranslatedText(
            hint,
            style: const TextStyle(overflow: TextOverflow.ellipsis),
          ),
          isExpanded: true,
        ),
      ],
    );
  }
}
