import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_theme.dart';
import '../../../common_widgets/app_refresh_indicator.dart';
import '../../../common_widgets/tags_chips.dart';
import '../../../common_widgets/custom_inputs.dart';
import 'package:community_connect/src/common_widgets/translated_text.dart';
import 'package:community_connect/src/common_widgets/app_avatar.dart';
import 'package:community_connect/src/utils/responsive_ext.dart';
import '../../community/data/community_provider.dart';
import '../data/search_provider.dart';
import '../../profile/data/profile_provider.dart';
import '../../profile/data/profile_models.dart';

class SearchScreen extends HookConsumerWidget {
  final int initialTab;
  const SearchScreen({super.key, this.initialTab = 0});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final searchState = ref.watch(searchControllerProvider);
    final selectedTab = useState<int>(initialTab);
    final membershipStatusAsync = ref.watch(
      currentUserMembershipStatusProvider,
    );
    final isMembershipApproved =
        (membershipStatusAsync.value ?? 'Approved').toLowerCase() == 'approved';
    final searchText = useValueListenable(searchController);
    final searchNotifier = ref.read(searchControllerProvider.notifier);
    final canRefresh =
        !isMembershipApproved ||
        searchText.text.trim().isNotEmpty ||
        searchNotifier.activeFiltersCount > 0;

    useEffect(() {
      selectedTab.value = initialTab;
      return null;
    }, [initialTab]);

    final scrollController = useScrollController();
    useEffect(() {
      void onScroll() {
        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200) {
          ref.read(searchControllerProvider.notifier).loadMore();
        }
      }

      scrollController.addListener(onScroll);
      return () => scrollController.removeListener(onScroll);
    }, [scrollController]);

    useEffect(() {
      Future.microtask(() {
        ref
            .read(searchControllerProvider.notifier)
            .switchTab(selectedTab.value);
      });
      return null;
    }, [selectedTab.value]);

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: AppColors.border)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      TranslatedText(
                        'Search & Directory',
                        style: Theme.of(context).textTheme.displaySmall
                            ?.copyWith(
                              fontSize: 18.sp,
                              color: AppColors.indigo,
                            ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: AppColors.cream,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: [
                        _buildTabButton('Business', 0, selectedTab),
                        _buildTabButton('Find Match', 1, selectedTab),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),

                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          enabled: isMembershipApproved,
                          style: TextStyle(fontSize: 14.sp),
                          textInputAction: TextInputAction.search,
                          onChanged: (val) {
                            ref
                                .read(searchControllerProvider.notifier)
                                .search(query: val);
                          },
                          onSubmitted: (val) {
                            ref
                                .read(searchControllerProvider.notifier)
                                .search(query: val, immediate: true);
                          },
                          decoration: InputDecoration(
                            hintText: selectedTab.value == 0
                                ? 'Search businesses...'
                                : 'Search matches...',
                            hintStyle: TextStyle(
                              color: AppColors.textMuted,
                              fontSize: 13.sp,
                            ),
                            prefixIcon: Icon(
                              Icons.search_rounded,
                              color: AppColors.textMuted,
                              size: 20.r,
                            ),
                            suffixIcon: searchController.text.isNotEmpty
                                ? GestureDetector(
                                    onTap: () {
                                      searchController.clear();
                                      ref
                                          .read(
                                            searchControllerProvider.notifier,
                                          )
                                          .search(query: '', immediate: true);
                                    },
                                    child: Icon(
                                      Icons.close,
                                      size: 18.r,
                                      color: AppColors.textMuted,
                                    ),
                                  )
                                : null,
                            filled: true,
                            fillColor: Colors.white,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 12.h,
                              horizontal: 14.w,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14.r),
                              borderSide: const BorderSide(
                                color: AppColors.border,
                                width: 1.5,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14.r),
                              borderSide: const BorderSide(
                                color: AppColors.border,
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14.r),
                              borderSide: const BorderSide(
                                color: AppColors.orange,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      GestureDetector(
                        onTap: isMembershipApproved
                            ? () => _showAdvancedFilters(
                                  context,
                                  ref,
                                  selectedTab.value,
                                )
                            : null,
                        child: Container(
                          padding: EdgeInsets.all(11.r),
                          decoration: BoxDecoration(
                            color:
                                ref
                                        .read(searchControllerProvider.notifier)
                                        .activeFiltersCount >
                                    0
                                ? AppColors.orange
                                : AppColors.orangeLight,
                            borderRadius: BorderRadius.circular(14.r),
                            border: Border.all(
                              color: AppColors.orange.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Icon(
                            Icons.tune_rounded,
                            size: 20.r,
                            color:
                                ref
                                        .read(searchControllerProvider.notifier)
                                        .activeFiltersCount >
                                    0
                                ? Colors.white
                                : AppColors.orangeDark,
                          ),
                        ),
                      ),
                    ],
                  ),

                  if (ref
                          .read(searchControllerProvider.notifier)
                          .activeFiltersCount >
                      0) ...[
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.orangeLight,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            '${ref.read(searchControllerProvider.notifier).activeFiltersCount} filter(s) active',
                            style: TextStyle(
                              color: AppColors.orangeDark,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        GestureDetector(
                          onTap: () {
                            searchController.clear();
                            ref
                                .read(searchControllerProvider.notifier)
                                .clearFiltersAndSearch();
                          },
                          child: TranslatedText(
                            'Clear',
                            style: TextStyle(
                              color: AppColors.orange,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            Expanded(
              child: AppRefreshIndicator(
                enabled: canRefresh,
                onRefresh: () async {
                  if (!isMembershipApproved) {
                    await ref.refresh(myCommunitiesControllerProvider.future);
                    await ref.refresh(currentUserMembershipStatusProvider.future);
                  }
                  await ref.read(searchControllerProvider.notifier).refresh();
                },
                child: CustomScrollView(
                  controller: scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    searchState.when(
                      skipLoadingOnReload: true,
                      skipLoadingOnRefresh: true,
                      data: (results) {
                        if (!isMembershipApproved) {
                          return const SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.all(30),
                              child: TranslatedText(
                                'Your membership is pending approval. You can view member profiles once approved.',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: AppColors.textMuted),
                              ),
                            ),
                          );
                        }

                        if (results.isEmpty) {
                          final hasQuery = searchController.text
                              .trim()
                              .isNotEmpty;
                          final hasFilters =
                              ref
                                  .read(searchControllerProvider.notifier)
                                  .activeFiltersCount >
                              0;
                          if (!hasQuery && !hasFilters) {
                            return SliverFillRemaining(
                              hasScrollBody: false,
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 32.w,
                                    vertical: 24.h,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 140.r,
                                        height: 140.r,
                                        padding: EdgeInsets.all(22.r),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColors.indigo
                                                  .withValues(alpha: 0.08),
                                              blurRadius: 20,
                                              offset: const Offset(0, 8),
                                            ),
                                          ],
                                        ),
                                        child: Image.asset(
                                          selectedTab.value == 0
                                              ? 'assets/images/business_icon.png'
                                              : 'assets/images/icon_matrimony.png',
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      SizedBox(height: 20.h),
                                      TranslatedText(
                                        selectedTab.value == 0
                                            ? 'Search Businesses'
                                            : 'Find Your Match',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.indigo,
                                        ),
                                      ),
                                      SizedBox(height: 8.h),
                                      TranslatedText(
                                        selectedTab.value == 0
                                            ? 'Find community businesses, professionals, and services by name, category, or location.'
                                            : 'Search prospective matrimonial profiles by name, gotra, age range, or location.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          color: AppColors.textMuted,
                                          height: 1.4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                          return SliverFillRemaining(
                            hasScrollBody: false,
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(32.r),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.search_off_rounded,
                                      size: 56.r,
                                      color: AppColors.textMuted.withValues(
                                        alpha: 0.5,
                                      ),
                                    ),
                                    SizedBox(height: 12.h),
                                    TranslatedText(
                                      selectedTab.value == 0
                                          ? 'No businesses found'
                                          : 'No matches found',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textDark,
                                      ),
                                    ),
                                    SizedBox(height: 6.h),
                                    const TranslatedText(
                                      'Try adjusting your search terms or filters.',
                                      style: TextStyle(
                                        color: AppColors.textMuted,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                        return SliverList(
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            final result = results[index];
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom: 10.h,
                                left: 20.w,
                                right: 20.w,
                                top: index == 0 ? 16.h : 0,
                              ),
                              child: _buildMemberCard(
                                context,
                                imageUrl: result.profilePhotoUrl,
                                name: result.fullName ?? 'Unknown',
                                verified: result.isVerified == true,
                                subtitle: () {
                                  final city = (result.city != null && result.city!.trim().isNotEmpty)
                                      ? result.city!.trim()
                                      : null;
                                  final desig = (result.designation != null && result.designation!.trim().isNotEmpty)
                                      ? result.designation!.trim()
                                      : null;
                                  final company = (result.businessName != null && result.businessName!.trim().isNotEmpty)
                                      ? result.businessName!.trim()
                                      : ((result.companyName != null && result.companyName!.trim().isNotEmpty)
                                          ? result.companyName!.trim()
                                          : null);
                                  final parts = [?city, ?desig, ?company];
                                  return parts.join(' · ');
                                }(),
                                tag: () {
                                  final company = (result.businessName != null && result.businessName!.trim().isNotEmpty)
                                      ? result.businessName!.trim()
                                      : ((result.companyName != null && result.companyName!.trim().isNotEmpty)
                                          ? result.companyName!.trim()
                                          : null);
                                  final desig = (result.designation != null && result.designation!.trim().isNotEmpty)
                                      ? result.designation!.trim()
                                      : null;
                                  if (selectedTab.value == 0) {
                                    return company ?? desig ?? 'Business';
                                  }
                                  if (result.gender != null && result.gender!.trim().isNotEmpty) {
                                    final age = result.calculatedAge;
                                    return '${result.gender!.trim()}${age != null ? ' ($age yrs)' : ''}';
                                  }
                                  return desig ?? 'Member';
                                }(),
                                onTap: () => context.push(
                                  '/profile_view',
                                  extra: {'id': result.id},
                                ),
                              ),
                            );
                          }, childCount: results.length),
                        );
                      },
                      loading: () => const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.all(40),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      ),
                      error: (error, stack) => SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            'Error: $error',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(
    String title,
    int index,
    ValueNotifier<int> selectedTab,
  ) {
    final isSelected = selectedTab.value == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => selectedTab.value = index,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: TranslatedText(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? AppColors.indigo : AppColors.textMuted,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMemberCard(
    BuildContext context, {
    String? imageUrl,
    required String name,
    required bool verified,
    required String subtitle,
    required String tag,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            AppAvatar(imageUrl: imageUrl, size: 56.r),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      TranslatedText(
                        name,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark,
                        ),
                      ),
                      if (verified) ...[
                        SizedBox(width: 6.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE6F4EC),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: TranslatedText(
                            '✓ Verified',
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.green,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 2.h),
                  if (subtitle.trim().replaceAll('·', '').isNotEmpty)
                    TranslatedText(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textMuted,
                      ),
                    ),
                  if (tag.trim().isNotEmpty) ...[
                    SizedBox(height: 6.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 3.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.orangeLight,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: TranslatedText(
                        tag.trim(),
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.orangeDark,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: AppColors.textMuted, size: 24.sp),
          ],
        ),
      ),
    );
  }

  void _showAdvancedFilters(
    BuildContext context,
    WidgetRef ref,
    int selectedTab,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return HookConsumer(
          builder: (context, ref, child) {
            final notifier = ref.read(searchControllerProvider.notifier);
            final ageMinController = useTextEditingController(
              text: notifier.currentAgeMin?.toString() ?? '',
            );
            final ageMaxController = useTextEditingController(
              text: notifier.currentAgeMax?.toString() ?? '',
            );

            final selectedState = useState<String?>(notifier.currentState);
            final selectedCity = useState<String?>(notifier.currentCity);
            final selectedGotra = useState<String?>(notifier.currentGotra);
            final surnameController = useTextEditingController(
              text: notifier.currentSurname ?? '',
            );
            final gender = useState<String?>(notifier.currentGender);
            final occupation = useState<String?>(notifier.currentOccupation);
            final businessCategory = useState<String?>(
              notifier.currentBusinessCategory,
            );

            final statesAsync = ref.watch(statesListProvider);
            final hasSelectedState =
                selectedState.value != null &&
                selectedState.value!.trim().isNotEmpty;
            final citiesAsync = hasSelectedState
                ? ref.watch(citiesListProvider(selectedState.value!.trim()))
                : null;
            final businessCategoriesAsync = ref.watch(
              businessCategoriesListProvider,
            );

            final states =
                statesAsync.value ??
                const [
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
            final stateList = {
              ...states,
              if (selectedState.value != null) selectedState.value!,
            }.toList()..sort();

            final cities =
                (hasSelectedState &&
                    citiesAsync != null &&
                    citiesAsync.value != null &&
                    citiesAsync.value!.isNotEmpty)
                ? citiesAsync.value!
                : const <String>[];
            final cityList = {
              ...cities,
              if (selectedCity.value != null && selectedCity.value!.isNotEmpty)
                selectedCity.value!,
            }.toList()..sort();

            final categories =
                businessCategoriesAsync.value ??
                const [
                  'Agriculture & Farming',
                  'Automobile & Auto Components',
                  'Banking, Financial Services & Insurance (BFSI)',
                  'Building, Construction & Real Estate',
                  'Chemicals, Petrochemicals & Plastics',
                  'Textiles, Apparel & Fashion',
                  'Education, Training & Coaching',
                  'Electricals, Electronics & Energy',
                  'Food, Beverages & Restaurants (FMCG)',
                  'Gems, Diamonds & Jewellery',
                  'Healthcare, Hospitals & Pharmaceuticals',
                  'Hospitality, Travel & Tourism',
                  'Information Technology (IT) & Software',
                  'Logistics, Transport & Warehousing',
                  'Manufacturing & Heavy Engineering',
                  'Media, Advertising & Events',
                  'Personal Care, Beauty & Fitness',
                  'Professional, Legal & Business Services',
                  'Retail & Wholesale Trading',
                  'Handicrafts, Art & Culture',
                  'Other / Specialized Services',
                ];
            final catList = {
              ...categories,
              if (businessCategory.value != null) businessCategory.value!,
            }.toList()..sort();
            final gotraList = {
              ...kCommunityGotras,
              if (selectedGotra.value != null &&
                  selectedGotra.value!.isNotEmpty)
                selectedGotra.value!,
            }.toList()..sort();

            String filterTitle = selectedTab == 0
                ? 'Business Filters'
                : 'Matrimony Filters';

            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                padding: EdgeInsets.all(20.w),
                height: MediaQuery.of(context).size.height * 0.75,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TranslatedText(
                          filterTitle,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.indigo,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            ageMinController.clear();
                            ageMaxController.clear();
                            selectedState.value = null;
                            selectedCity.value = null;
                            selectedGotra.value = null;
                            surnameController.clear();
                            gender.value = null;
                            occupation.value = null;
                            businessCategory.value = null;
                            ref
                                .read(searchControllerProvider.notifier)
                                .clearFiltersAndSearch();
                            context.pop();
                          },
                          child: const TranslatedText(
                            'Clear All',
                            style: TextStyle(
                              color: AppColors.orange,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    Expanded(
                      child: ListView(
                        children: [
                          if (selectedTab == 0) ...[
                            const TranslatedText(
                              'Business Category',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.textDark,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            SearchableDropdownFormField<String>(
                              key: ValueKey(
                                'filter_cat_${businessCategory.value}',
                              ),
                              initialValue:
                                  (businessCategory.value != null &&
                                      catList.contains(businessCategory.value))
                                  ? businessCategory.value
                                  : null,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                isDense: true,
                              ),
                              hint: const TranslatedText('Select Category'),
                              items: catList
                                  .map(
                                    (c) => DropdownMenuItem(
                                      value: c,
                                      child: Text(
                                        c,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (v) {
                                businessCategory.value = v;
                              },
                              isExpanded: true,
                            ),
                            SizedBox(height: 16.h),
                          ],
                          if (selectedTab == 1) ...[
                            const TranslatedText(
                              'Looking For',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.textDark,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Wrap(
                              spacing: 8.w,
                              runSpacing: 8.h,
                              children: [
                                CustomChip(
                                  text: 'Bride (Female)',
                                  isActive: gender.value == 'Female',
                                  onTap: () =>
                                      gender.value = gender.value == 'Female'
                                      ? null
                                      : 'Female',
                                ),
                                CustomChip(
                                  text: 'Groom (Male)',
                                  isActive: gender.value == 'Male',
                                  onTap: () => gender.value =
                                      gender.value == 'Male' ? null : 'Male',
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),
                            const TranslatedText(
                              'Gotra',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.textDark,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            SearchableDropdownFormField<String>(
                              key: ValueKey(
                                'filter_gotra_1_${selectedGotra.value}',
                              ),
                              initialValue:
                                  (selectedGotra.value != null &&
                                      gotraList.contains(selectedGotra.value))
                                  ? selectedGotra.value
                                  : null,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                isDense: true,
                                suffixIcon: selectedGotra.value != null
                                    ? IconButton(
                                        icon: const Icon(Icons.clear, size: 16),
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                        onPressed: () =>
                                            selectedGotra.value = null,
                                      )
                                    : null,
                              ),
                              hint: const TranslatedText('Select Gotra'),
                              items: gotraList
                                  .map(
                                    (g) => DropdownMenuItem(
                                      value: g,
                                      child: Text(
                                        g,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (v) => selectedGotra.value = v,
                              isExpanded: true,
                            ),
                            SizedBox(height: 12.h),
                            TextField(
                              controller: surnameController,
                              decoration: const InputDecoration(
                                labelText: 'Surname',
                                border: OutlineInputBorder(),
                                isDense: true,
                              ),
                            ),
                            SizedBox(height: 16.h),
                            const TranslatedText(
                              'Age Range',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.textDark,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: ageMinController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      labelText: 'Min Age',
                                      border: OutlineInputBorder(),
                                      isDense: true,
                                      counterText: '',
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16.w),
                                Expanded(
                                  child: TextField(
                                    controller: ageMaxController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      labelText: 'Max Age',
                                      border: OutlineInputBorder(),
                                      isDense: true,
                                      counterText: '',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),
                          ],
                          const TranslatedText(
                            'State',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          SearchableDropdownFormField<String>(
                            key: ValueKey(
                              'filter_state_${selectedState.value}',
                            ),
                            initialValue:
                                (selectedState.value != null &&
                                    stateList.contains(selectedState.value))
                                ? selectedState.value
                                : null,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              isDense: true,
                            ),
                            hint: const TranslatedText('Select State'),
                            items: stateList
                                .map(
                                  (s) => DropdownMenuItem(
                                    value: s,
                                    child: Text(
                                      s,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (v) {
                              selectedState.value = v;
                              selectedCity.value = null;
                            },
                            isExpanded: true,
                          ),
                          SizedBox(height: 16.h),
                          const TranslatedText(
                            'City',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          SearchableDropdownFormField<String>(
                            key: ValueKey(
                              'filter_city_${selectedState.value}_${selectedCity.value}',
                            ),
                            initialValue:
                                (hasSelectedState &&
                                    selectedCity.value != null &&
                                    cityList.contains(selectedCity.value))
                                ? selectedCity.value
                                : null,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              isDense: true,
                              suffixIcon: (citiesAsync?.isLoading ?? false)
                                  ? SizedBox(
                                      width: 16.w,
                                      height: 16.w,
                                      child: const Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      ),
                                    )
                                  : null,
                            ),
                            hint: TranslatedText(
                              hasSelectedState
                                  ? 'Select City'
                                  : 'Select State first',
                            ),
                            items: cityList
                                .map(
                                  (c) => DropdownMenuItem(
                                    value: c,
                                    child: Text(
                                      c,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: hasSelectedState
                                ? (v) {
                                    selectedCity.value = v;
                                  }
                                : null,
                            isExpanded: true,
                          ),
                          SizedBox(height: 16.h),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        final minStr = ageMinController.text.trim();
                        final maxStr = ageMaxController.text.trim();
                        final ageMin = minStr.isNotEmpty
                            ? int.tryParse(minStr)
                            : null;
                        final ageMax = maxStr.isNotEmpty
                            ? int.tryParse(maxStr)
                            : null;

                        ref
                            .read(searchControllerProvider.notifier)
                            .applyAdvancedFilters(
                              stateName: selectedState.value,
                              city: selectedCity.value,
                              ageMin: selectedTab == 1 ? ageMin : null,
                              ageMax: selectedTab == 1 ? ageMax : null,
                              gender: selectedTab == 1 ? gender.value : null,
                              gotra:
                                  (selectedTab == 1 &&
                                      selectedGotra.value != null &&
                                      selectedGotra.value!.isNotEmpty)
                                  ? selectedGotra.value
                                  : null,
                              surname:
                                  (selectedTab == 1 &&
                                      surnameController.text.trim().isNotEmpty)
                                  ? surnameController.text.trim()
                                  : null,
                              businessCategory: selectedTab == 0
                                  ? businessCategory.value
                                  : null,
                            );
                        context.pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.orange,
                        elevation: 0,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: const TranslatedText(
                        'Apply Filters',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
