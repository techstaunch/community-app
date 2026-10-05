import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../common_widgets/custom_inputs.dart';
import '../../../../common_widgets/translated_text.dart';
import '../../../../theme/app_theme.dart';
import '../../../../utils/responsive_ext.dart';
import '../../../profile/presentation/state_city_selector.dart';
import '../../../profile/data/profile_models.dart';
import '../../../profile/data/profile_provider.dart';

const familyMemberAdditionalFieldNames = [
  'photoUrl',
  'state',
  'city',
  'nativeVillage',
  'surname',
  'gotra',
  'subCaste',
  'timeOfBirth',
  'disability',
  'manglik',
  'maternalSurname',
  'maternalGotra',
  'showMobileNumber',
  'showEmail',
  'showGotra',
  'showFamilyInfo',
  'showMaternalInfo',
  'showBusinessInfo',
  'showProfessionalInfo',
  'isFindmatch',
  'address',
  'bio',
  'education',
  'email',
  'height',
  'instagram',
  'facebook',
  'linkedin',
  'twitter',
  'jobCompanyName',
  'jobDesignation',
  'jobIndustry',
  'jobYearsOfExperience',
  'jobCity',
  'jobState',
  'businessName',
  'businessCategory',
  'businessProductsServices',
  'businessWebsite',
  'businessCity',
  'businessState',
  'businessRole',
];

const familyMemberJobFieldNames = [
  'jobCompanyName',
  'jobDesignation',
  'jobIndustry',
  'jobYearsOfExperience',
  'jobCity',
  'jobState',
];

const familyMemberBusinessFieldNames = [
  'businessName',
  'businessCategory',
  'businessProductsServices',
  'businessWebsite',
  'businessCity',
  'businessState',
  'businessRole',
];

String normalizeFamilyMemberMobile(String value) {
  final digits = value.replaceAll(RegExp(r'[^\d]'), '');
  if (digits.length == 12 && digits.startsWith('91')) {
    return digits.substring(2);
  }
  return digits;
}

Map<String, dynamic> familyMemberAdditionalPayload(
  Map<String, TextEditingController> controllers,
) {
  final payload = <String, dynamic>{};
  for (final field in familyMemberAdditionalFieldNames) {
    if (familyMemberJobFieldNames.contains(field) ||
        familyMemberBusinessFieldNames.contains(field)) {
      continue;
    }
    if (field == 'height') {
      continue;
    }
    final value = controllers[field]!.text.trim();
    payload[field] = value.isEmpty ? null : value;
  }
  final feet = controllers['heightFeet']!.text.trim();
  final inches = controllers['heightInches']!.text.trim();
  payload['height'] = feet.isEmpty && inches.isEmpty
      ? null
      : '$feet ft ${inches.isEmpty ? '0' : inches} in';
  final job = <String, dynamic>{};
  for (final field in familyMemberJobFieldNames) {
    final value = controllers[field]!.text.trim();
    final apiField = field.substring(3, 4).toLowerCase() + field.substring(4);
    job[apiField] = value.isEmpty
        ? null
        : field == 'jobYearsOfExperience'
        ? num.tryParse(value)
        : value;
  }
  final business = <String, dynamic>{};
  for (final field in familyMemberBusinessFieldNames) {
    final value = controllers[field]!.text.trim();
    final apiField = field == 'businessName'
        ? 'businessName'
        : field.substring(8, 9).toLowerCase() + field.substring(9);
    business[apiField] = value.isEmpty ? null : value;
  }
  payload['job'] = job;
  payload['business'] = business;
  payload['privacySettings'] = {
    'showMobileNumber': controllers['showMobileNumber']?.text == 'true',
    'showEmail': controllers['showEmail']?.text == 'true',
    'showGotra': controllers['showGotra']?.text == 'true',
    'showFamilyInfo': controllers['showFamilyInfo']?.text == 'true',
    'showMaternalInfo': controllers['showMaternalInfo']?.text == 'true',
    'showBusinessInfo': controllers['showBusinessInfo']?.text == 'true',
    'showProfessionalInfo': controllers['showProfessionalInfo']?.text == 'true',
    'isFindmatch': controllers['isFindmatch']?.text == 'true',
  };
  return payload;
}

Map<String, TextEditingController> createFamilyMemberAdditionalControllers({
  Map<String, String?> initialValues = const {},
}) {
  final controllers = {
    for (final name in familyMemberAdditionalFieldNames)
      name: TextEditingController(text: initialValues[name] ?? ''),
  };
  if (controllers['manglik']!.text.trim().isEmpty) {
    controllers['manglik']!.text = "Don't Know";
  }
  final privacyFields = [
    'showMobileNumber',
    'showEmail',
    'showGotra',
    'showFamilyInfo',
    'showMaternalInfo',
    'showBusinessInfo',
    'showProfessionalInfo',
    'isFindmatch',
  ];
  for (final field in privacyFields) {
    if (controllers[field]!.text.trim().isEmpty) {
      controllers[field]!.text = "false";
    }
  }
  final height = initialValues['height'] ?? '';
  final match = RegExp(r'^(\d+)\s*ft\s*(\d+)?').firstMatch(height);
  controllers['heightFeet'] = TextEditingController(
    text: match?.group(1) ?? '',
  );
  controllers['heightInches'] = TextEditingController(
    text: match?.group(2) ?? '',
  );
  return controllers;
}

void disposeFamilyMemberAdditionalControllers(
  Map<String, TextEditingController> controllers,
) {
  for (final controller in controllers.values) {
    controller.dispose();
  }
}

class FamilyMemberAdditionalFields extends HookConsumerWidget {
  final Map<String, TextEditingController> controllers;

  const FamilyMemberAdditionalFields({super.key, required this.controllers});

  static const _labels = <String, String>{
    'photoUrl': 'Photo URL',
    'state': 'State',
    'city': 'City',
    'nativeVillage': 'Native Village',
    'surname': 'Surname',
    'gotra': 'Gotra',
    'subCaste': 'Sub-caste',
    'timeOfBirth': 'Time of Birth',
    'disability': 'Disability',
    'manglik': 'Manglik',
    'maternalSurname': 'Maternal Surname',
    'maternalGotra': 'Maternal Gotra',
    'address': 'Address',
    'bio': 'Bio',
    'education': 'Education',
    'email': 'Email',
    'height': 'Height',
    'instagram': 'Instagram',
    'facebook': 'Facebook',
    'linkedin': 'LinkedIn',
    'twitter': 'Twitter',
    'jobCompanyName': 'Job Company Name',
    'jobDesignation': 'Job Designation',
    'jobIndustry': 'Job Industry',
    'jobYearsOfExperience': 'Years of Experience',
    'jobCity': 'Job City',
    'jobState': 'Job State',
    'businessName': 'Business Name',
    'businessCategory': 'Business Category',
    'businessProductsServices': 'Products / Services',
    'businessWebsite': 'Business Website',
    'businessCity': 'Business City',
    'businessState': 'Business State',
    'businessRole': 'Business Role',
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTime = useState<TimeOfDay?>(
      CustomTimePickerField.parseTimeString(controllers['timeOfBirth']!.text),
    );
    final selectedState = useState<String?>(
      controllers['state']!.text.trim().isEmpty
          ? null
          : controllers['state']!.text.trim(),
    );
    final selectedCity = useState<String?>(
      controllers['city']!.text.trim().isEmpty
          ? null
          : controllers['city']!.text.trim(),
    );
    final showBusiness = useState(false);
    final selectedJobState = useState<String?>(
      controllers['jobState']!.text.trim().isEmpty
          ? null
          : controllers['jobState']!.text.trim(),
    );
    final selectedJobCity = useState<String?>(
      controllers['jobCity']!.text.trim().isEmpty
          ? null
          : controllers['jobCity']!.text.trim(),
    );
    final selectedBusinessState = useState<String?>(
      controllers['businessState']!.text.trim().isEmpty
          ? null
          : controllers['businessState']!.text.trim(),
    );
    final selectedBusinessCity = useState<String?>(
      controllers['businessCity']!.text.trim().isEmpty
          ? null
          : controllers['businessCity']!.text.trim(),
    );
    useEffect(() {
      void syncHeight() {
        final feet = controllers['heightFeet']!.text.trim();
        final inches = controllers['heightInches']!.text.trim();
        controllers['height']!.text = feet.isEmpty && inches.isEmpty
            ? ''
            : '$feet ft ${inches.isEmpty ? '0' : inches} in';
      }

      controllers['heightFeet']!.addListener(syncHeight);
      controllers['heightInches']!.addListener(syncHeight);
      return () {
        controllers['heightFeet']!.removeListener(syncHeight);
        controllers['heightInches']!.removeListener(syncHeight);
      };
    }, [controllers]);
    useEffect(
      () {
        void syncState() =>
            controllers['state']!.text = selectedState.value ?? '';
        void syncCity() => controllers['city']!.text = selectedCity.value ?? '';
        selectedState.addListener(syncState);
        selectedCity.addListener(syncCity);
        void syncJobState() =>
            controllers['jobState']!.text = selectedJobState.value ?? '';
        void syncJobCity() =>
            controllers['jobCity']!.text = selectedJobCity.value ?? '';
        void syncBusinessState() => controllers['businessState']!.text =
            selectedBusinessState.value ?? '';
        void syncBusinessCity() => controllers['businessCity']!.text =
            selectedBusinessCity.value ?? '';
        selectedJobState.addListener(syncJobState);
        selectedJobCity.addListener(syncJobCity);
        selectedBusinessState.addListener(syncBusinessState);
        selectedBusinessCity.addListener(syncBusinessCity);
        return () {
          selectedState.removeListener(syncState);
          selectedCity.removeListener(syncCity);
          selectedJobState.removeListener(syncJobState);
          selectedJobCity.removeListener(syncJobCity);
          selectedBusinessState.removeListener(syncBusinessState);
          selectedBusinessCity.removeListener(syncBusinessCity);
        };
      },
      [
        selectedState,
        selectedCity,
        selectedJobState,
        selectedJobCity,
        selectedBusinessState,
        selectedBusinessCity,
      ],
    );

    return Column(
      children: [
        // Family-member photo selection is intentionally disabled for now.
        // Re-enable this section when the family-member upload endpoint is ready.
        StateAndCitySelector(
          selectedState: selectedState,
          selectedCity: selectedCity,
        ),
        SizedBox(height: 0.h),
        CustomInputField(
          controller: controllers['nativeVillage']!,
          label: 'Native Village',
          hintText: 'Enter native village',
        ),
        SizedBox(height: 16.h),
        _buildRow(
          _input('Surname', controllers['surname']!),
          _dropdown(
            'Gotra',
            controllers['gotra']!,
            kCommunityGotras,
            'Select Gotra',
          ),
        ),
        SizedBox(height: 16.h),
        CustomInputField(
          controller: controllers['subCaste']!,
          label: 'Sub-caste',
          hintText: 'Enter sub-caste',
        ),
        SizedBox(height: 16.h),
        CustomTimePickerField(
          label: 'Time of Birth',
          selectedTime: selectedTime.value,
          initialTimeString: controllers['timeOfBirth']!.text,
          onTimeSelected: (time) {
            selectedTime.value = time;
            controllers['timeOfBirth']!.text = time == null
                ? ''
                : CustomTimePickerField.formatTimeOfDay(time);
          },
        ),
        SizedBox(height: 16.h),
        _buildRow(
          _input('Disability', controllers['disability']!),
          _dropdown('Manglik', controllers['manglik']!, const [
            'Yes',
            'No',
            "Don't Know",
          ], 'Select Manglik Status'),
        ),
        SizedBox(height: 16.h),
        _buildRow(
          _input('Maternal Surname', controllers['maternalSurname']!),
          _dropdown(
            'Maternal Gotra',
            controllers['maternalGotra']!,
            kCommunityGotras,
            'Select Gotra',
          ),
        ),
        SizedBox(height: 16.h),
        for (final field in [
          'address',
          'bio',
          'education',
          'email',
          'instagram',
          'facebook',
          'linkedin',
          'twitter',
        ]) ...[
          _input(
            _labels[field]!,
            controllers[field]!,
            maxLines: field == 'address' || field == 'bio' ? 3 : 1,
          ),
          SizedBox(height: 16.h),
        ],
        _heightField(context),
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              child: _workTab(
                'Employee / Job',
                !showBusiness.value,
                () => showBusiness.value = false,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _workTab(
                'Business Owner',
                showBusiness.value,
                () => showBusiness.value = true,
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),
        if (!showBusiness.value) ...[
          _input('Job Title / Designation', controllers['jobDesignation']!),
          SizedBox(height: 16.h),
          _input('Company Name', controllers['jobCompanyName']!),
          SizedBox(height: 16.h),
          _dropdown(
            'Industry',
            controllers['jobIndustry']!,
            ref.watch(businessCategoriesListProvider).value ?? const [],
            'Select Industry',
          ),
          SizedBox(height: 16.h),
          _input(
            'Experience (Years)',
            controllers['jobYearsOfExperience']!,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          SizedBox(height: 16.h),
          StateAndCitySelector(
            selectedState: selectedJobState,
            selectedCity: selectedJobCity,
          ),
        ] else ...[
          _input('Business Name', controllers['businessName']!),
          SizedBox(height: 16.h),
          _dropdown(
            'Business Category',
            controllers['businessCategory']!,
            ref.watch(businessCategoriesListProvider).value ?? const [],
            'Select Business Category',
          ),
          SizedBox(height: 16.h),
          _input(
            'Products / Services',
            controllers['businessProductsServices']!,
            maxLines: 3,
          ),
          SizedBox(height: 16.h),
          _input('Website', controllers['businessWebsite']!),
          SizedBox(height: 16.h),
          StateAndCitySelector(
            selectedState: selectedBusinessState,
            selectedCity: selectedBusinessCity,
          ),
          SizedBox(height: 16.h),
          _input('Your Role', controllers['businessRole']!),
        ],
        SizedBox(height: 24.h),
        TranslatedText(
          'Privacy Settings',
          style: TextStyle(
            color: AppColors.textDark,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16.h),
        _privacyToggle(
          'Find Match Privacy',
          'Hide this member from the Find Match directory',
          'isFindmatch',
        ),
        _privacyToggle(
          'Mobile Number Privacy',
          'Hide this member\'s mobile number from others',
          'showMobileNumber',
        ),
        _privacyToggle(
          'Email Privacy',
          'Hide this member\'s email address from others',
          'showEmail',
        ),
        _privacyToggle(
          'Gotra Privacy',
          'Hide this member\'s gotra from others',
          'showGotra',
        ),
        _privacyToggle(
          'Family Info Privacy',
          'Hide this member\'s family information from others',
          'showFamilyInfo',
        ),
        _privacyToggle(
          'Maternal Info Privacy',
          'Hide this member\'s maternal information from others',
          'showMaternalInfo',
        ),
        _privacyToggle(
          'Business Info Privacy',
          'Hide this member\'s business details from others',
          'showBusinessInfo',
        ),
        _privacyToggle(
          'Professional Info Privacy',
          'Hide this member\'s professional details from others',
          'showProfessionalInfo',
        ),
      ],
    );
  }

  Widget _buildRow(Widget first, Widget second) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: first),
      SizedBox(width: 10.w),
      Expanded(child: second),
    ],
  );

  Widget _privacyToggle(String label, String description, String key) =>
      Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TranslatedText(
                      label,
                      style: TextStyle(
                        color: AppColors.indigo,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    TranslatedText(
                      description,
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              ValueListenableBuilder<TextEditingValue>(
                valueListenable: controllers[key]!,
                builder: (context, value, _) {
                  final isOn = value.text == 'true';
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isOn ? Icons.lock : Icons.public,
                            size: 13.r,
                            color: isOn ? AppColors.orange : AppColors.green,
                          ),
                          SizedBox(width: 4.w),
                          TranslatedText(
                            isOn ? 'Private' : 'Public',
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                              color: isOn ? AppColors.orange : AppColors.green,
                            ),
                          ),
                        ],
                      ),
                      Switch(
                        value: isOn,
                        onChanged: (val) {
                          controllers[key]!.text = val.toString();
                        },
                        activeThumbColor: AppColors.orange,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 16.h),
        ],
      );

  Widget _workTab(String label, bool selected, VoidCallback onTap) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: selected ? AppColors.orangeLight : Colors.white,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: selected ? AppColors.orange : AppColors.border,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: selected ? AppColors.orangeDark : AppColors.textMid,
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
            ),
          ),
        ),
      );

  Widget _input(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
    TextInputType? keyboardType,
  }) => CustomInputField(
    controller: controller,
    label: label,
    hintText: 'Enter ${label.toLowerCase()}',
    keyboardType: keyboardType ??
        (label == 'Email'
            ? TextInputType.emailAddress
            : TextInputType.text),
    maxLines: maxLines,
  );

  Widget _heightField(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TranslatedText(
        'Height',
        style: TextStyle(
          color: AppColors.indigo,
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      SizedBox(height: 5.h),
      Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<String>(
              value: controllers['heightFeet']!.text.isNotEmpty && ['2', '3', '4', '5', '6', '7', '8', '9'].contains(controllers['heightFeet']!.text.trim()) ? controllers['heightFeet']!.text.trim() : null,
              items: ['2', '3', '4', '5', '6', '7', '8', '9'].map((ft) {
                return DropdownMenuItem(
                  value: ft,
                  child: Text(ft),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  controllers['heightFeet']!.text = value;
                  Future.delayed(const Duration(milliseconds: 50), () {
                    if (context.mounted) {
                      FocusScope.of(context).nextFocus();
                    }
                  });
                }
              },
              decoration: InputDecoration(
                hintText: 'ft',
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 12.h,
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: DropdownButtonFormField<String>(
              value: controllers['heightInches']!.text.isNotEmpty &&
                      List.generate(12, (i) => i.toString())
                          .contains(controllers['heightInches']!.text.trim())
                  ? controllers['heightInches']!.text.trim()
                  : null,
              items: List.generate(12, (i) => i.toString()).map((inch) {
                return DropdownMenuItem(
                  value: inch,
                  child: Text(inch),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  controllers['heightInches']!.text = value;
                  Future.delayed(const Duration(milliseconds: 50), () {
                    if (context.mounted) {
                      FocusScope.of(context).nextFocus();
                    }
                  });
                }
              },
              decoration: InputDecoration(
                hintText: 'in',
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 12.h,
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  );

  Widget _dropdown(
    String label,
    TextEditingController controller,
    List<String> values,
    String hint,
  ) => Column(
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
        key: ValueKey('$label-${controller.text}'),
        initialValue: values.contains(controller.text) ? controller.text : null,
        items: values
            .map(
              (value) =>
                  DropdownMenuItem(value: value, child: TranslatedText(value)),
            )
            .toList(),
        onChanged: (value) => controller.text = value ?? '',
        hint: TranslatedText(hint),
        isExpanded: true,
      ),
    ],
  );
}
