import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:community_connect/src/utils/app_messenger.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_theme.dart';
import '../../../common_widgets/custom_inputs.dart';
import 'package:community_connect/src/common_widgets/translated_text.dart';
import '../data/profile_provider.dart';
import 'state_city_selector.dart';
import 'package:community_connect/src/utils/responsive_ext.dart';

class WorkProfileScreen extends HookConsumerWidget {
  final bool? initialIsBusiness;
  const WorkProfileScreen({super.key, this.initialIsBusiness});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isBusiness = useState(initialIsBusiness ?? false);

    // Job Controllers
    final jobTitleController = useTextEditingController();
    final companyController = useTextEditingController();
    final selectedIndustry = useState<String?>(null);
    final experienceController = useTextEditingController();
    final selectedJobState = useState<String?>(null);
    final selectedJobCity = useState<String?>(null);

    // Business Controllers
    final businessNameController = useTextEditingController();
    final selectedCategory = useState<String?>(null);
    final productsController = useTextEditingController();
    final selectedBusinessState = useState<String?>(null);
    final selectedBusinessCity = useState<String?>(null);
    final websiteController = useTextEditingController();
    final roleController = useTextEditingController();

    final profileState = ref.watch(profileControllerProvider);

    useEffect(() {
      if (profileState.value != null) {
        final job = profileState.value!.job;
        final business = profileState.value!.business;

        if (business != null && business.id != null) {
          businessNameController.text = business.businessName ?? '';
          selectedCategory.value = business.category;
          productsController.text = business.productsServices ?? '';
          selectedBusinessState.value = business.state;
          selectedBusinessCity.value = business.city;
          websiteController.text = business.website ?? '';
          roleController.text = business.role ?? '';
          if (initialIsBusiness == null && job == null) isBusiness.value = true;
        }

        if (job != null && job.id != null) {
          jobTitleController.text = job.designation ?? '';
          companyController.text = job.companyName ?? '';
          selectedIndustry.value = job.industry;
          experienceController.text = job.yearsOfExperience?.toString() ?? '';
          selectedJobState.value = job.state;
          selectedJobCity.value = job.city;
          if (initialIsBusiness == null && business == null) {
            isBusiness.value = false;
          }
        }
      }
      return null;
    }, const []);

    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        title: TranslatedText(
          (profileState.value?.job != null ||
                  profileState.value?.business != null)
              ? 'Edit Work Profile'
              : 'Add Work Profile',
          style: TextStyle(color: AppColors.textDark, fontSize: 18.sp),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => isBusiness.value = false,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      decoration: BoxDecoration(
                        color: !isBusiness.value
                            ? AppColors.orangeLight
                            : Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: !isBusiness.value
                              ? AppColors.orange
                              : AppColors.border,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: TranslatedText(
                        'Employee / Job',
                        style: TextStyle(
                          color: !isBusiness.value
                              ? AppColors.orangeDark
                              : AppColors.textMid,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: GestureDetector(
                    onTap: () => isBusiness.value = true,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      decoration: BoxDecoration(
                        color: isBusiness.value
                            ? AppColors.indigoLight
                            : Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: isBusiness.value
                              ? AppColors.indigo
                              : AppColors.border,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: TranslatedText(
                        'Business Owner',
                        style: TextStyle(
                          color: isBusiness.value
                              ? AppColors.indigo
                              : AppColors.textMid,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),

            if (!isBusiness.value) ...[
              _buildField(
                'Job Title / Designation *',
                'e.g. Software Engineer',
                jobTitleController,
                textCapitalization: TextCapitalization.words,
              ),
              _buildField(
                'Company Name *',
                'e.g. Tata Consultancy Services',
                companyController,
                textCapitalization: TextCapitalization.words,
              ),
              _buildCategoryDropdown(
                label: 'Industry',
                hint: 'Select Industry',
                selectedValue: selectedIndustry,
                categories: ref.watch(businessCategoriesListProvider),
              ),
              _buildField(
                'Experience (Years)',
                'e.g. 4',
                experienceController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 2,
              ),
              StateAndCitySelector(
                selectedState: selectedJobState,
                selectedCity: selectedJobCity,
              ),
            ] else ...[
              _buildField(
                'Business Name *',
                'e.g. Patel Enterprises',
                businessNameController,
                textCapitalization: TextCapitalization.words,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TranslatedText(
                      'Business Category *',
                      style: TextStyle(
                        color: AppColors.indigo,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    ref
                        .watch(businessCategoriesListProvider)
                        .when(
                          data: (categories) {
                            final items = {...categories};
                            if (selectedCategory.value != null &&
                                selectedCategory.value!.isNotEmpty) {
                              items.add(selectedCategory.value!);
                            }
                            return SearchableDropdownFormField<String>(
                              initialValue: selectedCategory.value,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 14.w,
                                  vertical: 12.h,
                                ),
                              ),
                              items: items
                                  .map(
                                    (c) => DropdownMenuItem(
                                      value: c,
                                      child: TranslatedText(
                                        c,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (val) => selectedCategory.value = val,
                              hint: const TranslatedText(
                                'Select Business Category',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              isExpanded: true,
                            );
                          },
                          loading: () =>
                              const Center(child: CircularProgressIndicator()),
                          error: (error, stack) =>
                              SearchableDropdownFormField<String>(
                                initialValue: selectedCategory.value,
                                items: const [],
                                onChanged: null,
                                hint: const TranslatedText(
                                  'Failed to load categories',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                isExpanded: true,
                              ),
                        ),
                  ],
                ),
              ),
              _buildField(
                'Products / Services',
                'e.g. Web Development, SEO',
                productsController,
                textCapitalization: TextCapitalization.sentences,
              ),
              _buildField(
                'Website',
                'e.g. https://example.com',
                websiteController,
                keyboardType: TextInputType.url,
              ),
              StateAndCitySelector(
                selectedState: selectedBusinessState,
                selectedCity: selectedBusinessCity,
              ),
              _buildField(
                'Your Role',
                'e.g. Founder / CEO',
                roleController,
                textCapitalization: TextCapitalization.words,
              ),
            ],

            SizedBox(height: 32.h),
            profileState.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: () async {
                      if (isBusiness.value) {
                        final bName = businessNameController.text.trim();
                        if (bName.isEmpty) {
                          AppMessenger.showError(
                            'Please enter your Business Name.',
                          );
                          return;
                        }
                        final bType = selectedCategory.value?.trim() ?? '';
                        if (bType.isEmpty) {
                          AppMessenger.showError(
                            'Please select your Business Category.',
                          );
                          return;
                        }
                        var website = websiteController.text.trim();
                        if (website.isNotEmpty) {
                          if (!website.startsWith('http://') &&
                              !website.startsWith('https://')) {
                            website = 'https://$website';
                          }
                          final uri = Uri.tryParse(website);
                          if (uri == null || !uri.hasAuthority) {
                            AppMessenger.showError(
                              'Please enter a valid website URL.',
                            );
                            return;
                          }
                        }

                        try {
                          await ref
                              .read(profileControllerProvider.notifier)
                              .updateBusinessDetails({
                                'businessName': bName,
                                'category': bType,
                                'productsServices': productsController.text
                                    .trim(),
                                'website': website,
                                'state':
                                    selectedBusinessState.value?.trim() ?? '',
                                'city':
                                    selectedBusinessCity.value?.trim() ?? '',
                                'role': roleController.text.trim(),
                              });
                          if (context.mounted) {
                            context.pop();
                          }
                        } catch (e) {
                          AppMessenger.showException(
                            e,
                            fallbackMessage:
                                'We couldn\'t save your work profile right now. Please try again.',
                          );
                        }
                      } else {
                        final designation = jobTitleController.text.trim();
                        if (designation.isEmpty) {
                          AppMessenger.showError(
                            'Please enter your Job Title / Designation.',
                          );
                          return;
                        }
                        final company = companyController.text.trim();
                        if (company.isEmpty) {
                          AppMessenger.showError(
                            'Please enter your Company Name.',
                          );
                          return;
                        }
                        final expStr = experienceController.text.trim();
                        num expYears = 0;
                        if (expStr.isNotEmpty) {
                          final parsed = num.tryParse(expStr);
                          if (parsed == null || parsed < 0 || parsed > 60) {
                            AppMessenger.showError(
                              'Please enter a valid number of years of experience (0-60).',
                            );
                            return;
                          }
                          expYears = parsed;
                        }

                        try {
                          await ref
                              .read(profileControllerProvider.notifier)
                              .updateJobDetails({
                                'designation': designation,
                                'companyName': company,
                                'industry':
                                    selectedIndustry.value?.trim() ?? '',
                                'yearsOfExperience': expYears,
                                'state': selectedJobState.value?.trim() ?? '',
                                'city': selectedJobCity.value?.trim() ?? '',
                              });
                          if (context.mounted) {
                            context.pop();
                          }
                        } catch (e) {
                          AppMessenger.showException(
                            e,
                            fallbackMessage:
                                'We couldn\'t save your work profile right now. Please try again.',
                          );
                        }
                      }
                    },
                    child: TranslatedText(
                      'Save Work Profile',
                      style: TextStyle(fontSize: 15.sp),
                    ),
                  ),
            SizedBox(height: 12.h),
            if (!profileState.isLoading &&
                ((!isBusiness.value &&
                        profileState.value?.job != null &&
                        (profileState.value!.job!.id != null ||
                            profileState.value!.job!.companyName != null)) ||
                    (isBusiness.value &&
                        profileState.value?.business != null &&
                        (profileState.value!.business!.id != null ||
                            profileState.value!.business!.businessName !=
                                null))))
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Delete Work Profile'),
                      content: const Text(
                        'Are you sure you want to delete your work profile?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () async {
                            Navigator.pop(context);
                            try {
                              if (isBusiness.value) {
                                await ref
                                    .read(profileControllerProvider.notifier)
                                    .deleteBusinessDetails();
                              } else {
                                await ref
                                    .read(profileControllerProvider.notifier)
                                    .deleteJobDetails();
                              }
                              if (context.mounted) {
                                context.pop();
                              }
                            } catch (e) {
                              AppMessenger.showException(
                                e,
                                fallbackMessage:
                                    'We couldn\'t delete your work profile right now. Please try again.',
                              );
                            }
                          },
                          child: const Text(
                            'Delete',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                child: TranslatedText(
                  'Delete Work Profile',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(
    String label,
    String hint,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    int? maxLength,
    TextCapitalization textCapitalization = TextCapitalization.none,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
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
          TextField(
            controller: controller,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            maxLength: maxLength,
            textCapitalization: textCapitalization,
            style: TextStyle(fontSize: 14.sp),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(fontSize: 14.sp),
              counterText: '',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryDropdown({
    required String label,
    required String hint,
    required ValueNotifier<String?> selectedValue,
    required AsyncValue<List<String>> categories,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
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
          categories.when(
            data: (values) {
              final items = {...values};
              if (selectedValue.value != null &&
                  selectedValue.value!.isNotEmpty) {
                items.add(selectedValue.value!);
              }
              return SearchableDropdownFormField<String>(
                initialValue: selectedValue.value,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 12.h,
                  ),
                ),
                items: items
                    .map(
                      (value) => DropdownMenuItem(
                        value: value,
                        child: TranslatedText(
                          value,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) => selectedValue.value = value,
                hint: TranslatedText(
                  hint,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                isExpanded: true,
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => SearchableDropdownFormField<String>(
              initialValue: selectedValue.value,
              items: const [],
              onChanged: null,
              hint: const TranslatedText(
                'Failed to load industries',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              isExpanded: true,
            ),
          ),
        ],
      ),
    );
  }
}
