import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../theme/app_theme.dart';
import '../../../../utils/app_messenger.dart';
import '../../../../common_widgets/custom_buttons.dart';
import '../../../../common_widgets/custom_inputs.dart';
import '../../../../common_widgets/translated_text.dart';
import 'package:community_connect/src/features/profile/data/profile_provider.dart';
import '../../data/family_models.dart';
import '../../data/family_provider.dart';
import 'package:community_connect/src/utils/responsive_ext.dart';
import 'package:community_connect/src/utils/app_date_formatter.dart';
import 'family_member_additional_fields.dart';

class EditFamilyMemberSheet extends HookConsumerWidget {
  final FamilyTreeNode node;

  const EditFamilyMemberSheet({super.key, required this.node});

  static const List<Map<String, String>> maleRelations = [
    {'value': 'Father', 'label': 'Father (Papa / Pitaji)'},
    {'value': 'Husband', 'label': 'Husband (Pati)'},
    {'value': 'Brother', 'label': 'Brother (Bhai)'},
    {'value': 'Son', 'label': 'Son (Beta)'},
    {'value': 'Grandfather', 'label': 'Paternal Grandfather (Dada)'},
    {'value': 'Grandson', 'label': 'Grandson (Pota)'},
    {'value': 'Uncle', 'label': 'Paternal Uncle (Kaka / Tauji)'},
    {'value': 'Nephew', 'label': 'Nephew (Bhatija)'},
    {'value': 'Father-in-law', 'label': 'Father-in-law (Sasurji)'},
    {'value': 'Son-in-law', 'label': 'Son-in-law (Damad)'},
    {'value': 'Great-Grandson', 'label': 'Great-Grandson (Pardota)'},
  ];

  static const List<Map<String, String>> femaleRelations = [
    {'value': 'Mother', 'label': 'Mother (Mummy / Mataji)'},
    {'value': 'Wife', 'label': 'Wife (Patni)'},
    {'value': 'Sister', 'label': 'Sister (Behen)'},
    {'value': 'Daughter', 'label': 'Daughter (Beti)'},
    {'value': 'Grandmother', 'label': 'Paternal Grandmother (Dadi)'},
    {'value': 'Granddaughter', 'label': 'Granddaughter (Poti)'},
    {'value': 'Aunt', 'label': 'Paternal Aunt (Bua / Kaki)'},
    {'value': 'Niece', 'label': 'Niece (Bhatiji)'},
    {'value': 'Mother-in-law', 'label': 'Mother-in-law (Sasuji)'},
    {'value': 'Daughter-in-law', 'label': 'Daughter-in-law (Bahu)'},
    {'value': 'Great-Granddaughter', 'label': 'Great-Granddaughter (Pardoti)'},
  ];

  static String? _normalizeTitle(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    switch (value.trim().toLowerCase()) {
      case 'mr':
      case 'mr.':
        return 'Mr';
      case 'mrs':
      case 'mrs.':
        return 'Mrs';
      case 'ms':
      case 'ms.':
      case 'miss':
        return 'Miss';
      case 'late':
        return 'Late';
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showAdditionalDetails = useState(false);
    final linkedProfileAsync =
        showAdditionalDetails.value && node.linkedUserId != null
        ? ref.watch(memberProfileProvider(node.linkedUserId!))
        : null;
    final linkedProfile = linkedProfileAsync?.hasValue == true
        ? linkedProfileAsync!.value
        : null;
    final core = linkedProfile?.profile;
    final job = linkedProfile?.job;
    final business = linkedProfile?.business;
    final nameController = useTextEditingController(text: node.fullName ?? '');
    final mobileController = useTextEditingController(
      text: normalizeFamilyMemberMobile(node.linkedMobile ?? ''),
    );
    final additionalControllers = useMemoized(
      () => createFamilyMemberAdditionalControllers(
        initialValues: {
          'photoUrl': core?.profilePhotoUrl ?? node.photoUrl,
          'state': core?.state ?? node.state,
          'city': core?.city ?? node.city,
          'nativeVillage': core?.nativeVillage ?? node.nativeVillage,
          'surname': core?.surname ?? node.surname,
          'gotra': core?.gotra ?? node.gotra,
          'subCaste': core?.subCaste ?? node.subCaste,
          'timeOfBirth': core?.timeOfBirth ?? node.timeOfBirth,
          'disability': core?.disability ?? node.disability,
          'manglik': core?.manglik ?? node.manglik ?? "Don't Know",
          'maternalSurname': core?.maternalSurname ?? node.maternalSurname,
          'maternalGotra': core?.maternalGotra ?? node.maternalGotra,
          'address': core?.address ?? node.address,
          'bio': core?.bio ?? node.bio,
          'education': core?.education ?? node.education,
          'email': linkedProfile?.email ?? node.email,
          'height': core?.height ?? node.height,
          'instagram': core?.instagram ?? node.instagram,
          'facebook': core?.facebook ?? node.facebook,
          'linkedin': core?.linkedin ?? node.linkedin,
          'twitter': core?.twitter ?? node.twitter,
          'jobCompanyName':
              job?.companyName ?? node.job?['companyName']?.toString(),
          'jobDesignation':
              job?.designation ?? node.job?['designation']?.toString(),
          'jobIndustry': job?.industry ?? node.job?['industry']?.toString(),
          'jobYearsOfExperience':
              job?.yearsOfExperience?.toString() ??
              node.job?['yearsOfExperience']?.toString(),
          'jobCity': job?.city ?? node.job?['city']?.toString(),
          'jobState': job?.state ?? node.job?['state']?.toString(),
          'businessName':
              business?.businessName ??
              node.business?['businessName']?.toString(),
          'businessCategory':
              business?.category ?? node.business?['category']?.toString(),
          'businessProductsServices':
              business?.productsServices ??
              node.business?['productsServices']?.toString(),
          'businessWebsite':
              business?.website ?? node.business?['website']?.toString(),
          'businessCity': business?.city ?? node.business?['city']?.toString(),
          'businessState':
              business?.state ?? node.business?['state']?.toString(),
          'businessRole': business?.role ?? node.business?['role']?.toString(),
          'showMobileNumber': linkedProfile?.privacySettings?.showMobileNumber?.toString() ??
              node.privacySettings?.showMobileNumber?.toString() ??
              'false',
          'showEmail': linkedProfile?.privacySettings?.showEmail?.toString() ??
              node.privacySettings?.showEmail?.toString() ??
              'false',
          'showGotra': linkedProfile?.privacySettings?.showGotra?.toString() ??
              node.privacySettings?.showGotra?.toString() ??
              'false',
          'showFamilyInfo': linkedProfile?.privacySettings?.showFamilyInfo?.toString() ??
              node.privacySettings?.showFamilyInfo?.toString() ??
              'false',
          'showMaternalInfo': linkedProfile?.privacySettings?.showMaternalInfo?.toString() ??
              node.privacySettings?.showMaternalInfo?.toString() ??
              'false',
          'showBusinessInfo': linkedProfile?.privacySettings?.showBusinessInfo?.toString() ??
              node.privacySettings?.showBusinessInfo?.toString() ??
              'false',
          'showProfessionalInfo': linkedProfile?.privacySettings?.showProfessionalInfo?.toString() ??
              node.privacySettings?.showProfessionalInfo?.toString() ??
              'false',
          'isFindmatch': linkedProfile?.privacySettings?.isFindmatch?.toString() ??
              node.privacySettings?.isFindmatch?.toString() ??
              'false',
        },
      ),
      [linkedProfile],
    );
    useEffect(
      () =>
          () => disposeFamilyMemberAdditionalControllers(additionalControllers),
      [additionalControllers],
    );

    DateTime? initialParsedDob;
    if (node.dob != null && node.dob!.isNotEmpty) {
      initialParsedDob = AppDateFormatter.tryParseDate(node.dob);
    }
    final selectedDob = useState<DateTime?>(initialParsedDob);

    final initialGender =
        (node.gender != null && node.gender!.toLowerCase() == 'female')
        ? 'Female'
        : 'Male';
    final gender = useState<String>(initialGender);

    final isFemale = gender.value == 'Female';
    final availableRelations = isFemale ? femaleRelations : maleRelations;

    final initialRelation =
        node.relationshipType ??
        node.directRelationship ??
        node.relationshipToViewer ??
        (isFemale ? 'Mother' : 'Father');

    final matchedRelation =
        availableRelations.any((r) => r['value'] == initialRelation)
        ? initialRelation
        : (availableRelations.first['value']!);

    final selectedRelation = useState<String>(matchedRelation);
    final isDeceased = useState<bool>(node.isDeceased == true || (node.title != null && node.title!.toLowerCase() == 'late'));
    final isSubmitting = useState<bool>(false);
    final title = useState<String?>(_normalizeTitle(node.title));

    bool calculateIsMinor(DateTime? dob) {
      if (dob == null) return false;
      final now = DateTime.now();
      var age = now.year - dob.year;
      if (now.month < dob.month ||
          (now.month == dob.month && now.day < dob.day)) {
        age--;
      }

      return age < 18;
    }

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
        left: 20.w,
        right: 20.w,
        top: 12.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drag Handle
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              // Sheet Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TranslatedText(
                    'Edit Family Member',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      size: 20.sp,
                      color: AppColors.textMuted,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // Relative Header Preview
              Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: AppColors.cream,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    // Family-member profile photos are disabled until the
                    // dedicated family-member upload flow is available.
                    Icon(
                      Icons.person_outline,
                      size: 48.r,
                      color: AppColors.textMuted,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            nameController.text.isNotEmpty
                                ? nameController.text
                                : (node.fullName ?? 'Unknown'),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textDark,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 2.h,
                                ),
                                decoration: BoxDecoration(
                                  color: isFemale
                                      ? Colors.pink.withValues(alpha: 0.1)
                                      : AppColors.indigo.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: Text(
                                  gender.value,
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.bold,
                                    color: isFemale
                                        ? Colors.pink
                                        : AppColors.indigo,
                                  ),
                                ),
                              ),
                              if (node.isRegisteredUser == true ||
                                  (node.linkedUserId != null &&
                                      node.linkedUserId!.isNotEmpty)) ...[
                                SizedBox(width: 6.w),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 2.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFF10B981,
                                    ).withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(6.r),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.link,
                                        size: 11.sp,
                                        color: const Color(0xFF10B981),
                                      ),
                                      SizedBox(width: 3.w),
                                      Text(
                                        'Linked Account',
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF10B981),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              // Field 0: Title
              TranslatedText(
                'Title',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.indigo,
                  letterSpacing: 0.04,
                ),
              ),
              SizedBox(height: 6.h),
              SearchableDropdownFormField<String>(
                initialValue: title.value,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 12.h,
                  ),
                ),
                items: const [
                  DropdownMenuItem(value: 'Mr', child: Text('Mr.')),
                  DropdownMenuItem(value: 'Mrs', child: Text('Mrs.')),
                  DropdownMenuItem(value: 'Miss', child: Text('Miss')),
                  DropdownMenuItem(value: 'Late', child: Text('Late')),
                ],
                onChanged: (val) {
                  title.value = val;
                  if (val == 'Late') {
                    isDeceased.value = true;
                  } else if (val == 'Mr') {
                    gender.value = 'Male';
                  } else if (val == 'Mrs' || val == 'Miss') {
                    gender.value = 'Female';
                  }
                },
                hint: const Text('Select Title (Optional)'),
                isExpanded: true,
              ),
              /* DropdownButton<String>(
                    isExpanded: true,
                    value: title.value,
                    hint: TranslatedText(
                      'Select Title (Optional)',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textMuted,
                      ),
                    ),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: AppColors.textDark,
                    ),
                    items: const [
                      DropdownMenuItem(value: 'Mr', child: Text('Mr.')),
                      DropdownMenuItem(value: 'Mrs', child: Text('Mrs.')),
                      DropdownMenuItem(value: 'Miss', child: Text('Miss')),
                      DropdownMenuItem(value: 'Late', child: Text('Late')),
                    ],
                    onChanged: (val) {
                      title.value = val;
                      if (val == 'Late') {
                        isDeceased.value = true;
                      } else if (val == 'Mr') {
                        gender.value = 'Male';
                      } else if (val == 'Mrs' || val == 'Miss') {
                        gender.value = 'Female';
                      }
                    },
                  ), */
              SizedBox(height: 16.h),

              // Field 1: Full Name
              CustomInputField(
                label: 'Full Name',
                hintText: 'Enter relative\'s full name',
                controller: nameController,
                prefixIcon: Icon(
                  Icons.person_outline,
                  size: 20.sp,
                  color: AppColors.textMuted,
                ),
              ),
              SizedBox(height: 16.h),

              // Field 2: Gender
              TranslatedText(
                'Gender',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.indigo,
                  letterSpacing: 0.04,
                ),
              ),
              SizedBox(height: 6.h),
              Row(
                children: [
                  Expanded(
                    child: _buildGenderOption(
                      label: 'Male',
                      icon: Icons.male,
                      isSelected: gender.value == 'Male',
                      onTap: () {
                        gender.value = 'Male';
                        if (!maleRelations.any(
                          (r) => r['value'] == selectedRelation.value,
                        )) {
                          selectedRelation.value =
                              maleRelations.first['value']!;
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _buildGenderOption(
                      label: 'Female',
                      icon: Icons.female,
                      isSelected: gender.value == 'Female',
                      onTap: () {
                        gender.value = 'Female';
                        if (!femaleRelations.any(
                          (r) => r['value'] == selectedRelation.value,
                        )) {
                          selectedRelation.value =
                              femaleRelations.first['value']!;
                        }
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // Field 3: Relationship Type
              TranslatedText(
                'Relationship',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.indigo,
                  letterSpacing: 0.04,
                ),
              ),
              SizedBox(height: 6.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.border),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value:
                        availableRelations.any(
                          (r) => r['value'] == selectedRelation.value,
                        )
                        ? selectedRelation.value
                        : availableRelations.first['value'],
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: AppColors.textDark,
                    ),
                    items: availableRelations.map((r) {
                      return DropdownMenuItem<String>(
                        value: r['value'],
                        child: TranslatedText(
                          r['label'] ?? r['value']!,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.textDark,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        selectedRelation.value = val;
                      }
                    },
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              // Field 4: Date of Birth
              TranslatedText(
                'Date of Birth',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.indigo,
                  letterSpacing: 0.04,
                ),
              ),
              SizedBox(height: 6.h),
              InkWell(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDob.value ?? DateTime(1995, 1, 1),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    selectedDob.value = picked;
                  }
                },
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 14.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 18.sp,
                        color: AppColors.textMuted,
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          selectedDob.value != null
                              ? AppDateFormatter.formatDateOnly(
                                  selectedDob.value!,
                                )
                              : 'Select Date of Birth (optional)',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: selectedDob.value != null
                                ? AppColors.textDark
                                : AppColors.textMuted,
                          ),
                        ),
                      ),
                      if (selectedDob.value != null)
                        GestureDetector(
                          onTap: () => selectedDob.value = null,
                          child: Icon(
                            Icons.clear,
                            size: 18.sp,
                            color: AppColors.textMuted,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              // Field 5: Mobile Number
              CustomInputField(
                label: 'Mobile Number',
                hintText: 'Enter 10-digit mobile number',
                controller: mobileController,
                keyboardType: TextInputType.phone,
                prefixIcon: Icon(
                  Icons.phone_outlined,
                  size: 20.sp,
                  color: AppColors.textMuted,
                ),
              ),
              SizedBox(height: 16.h),

              // Is Deceased Switch
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: AppColors.cream.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.r),
                          decoration: BoxDecoration(
                            color: isDeceased.value
                                ? AppColors.textMuted.withValues(alpha: 0.15)
                                : AppColors.orangeLight,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isDeceased.value
                                ? Icons.history_edu
                                : Icons.favorite,
                            size: 18.sp,
                            color: isDeceased.value
                                ? AppColors.textMuted
                                : AppColors.orange,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TranslatedText(
                              'Is Deceased',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textDark,
                              ),
                            ),
                            TranslatedText(
                              isDeceased.value
                                  ? 'Marked as late / passed away'
                                  : 'Living family member',
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Switch(
                      value: isDeceased.value,
                      activeThumbColor: AppColors.orange,
                      onChanged: (val) => isDeceased.value = val,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              TextButton.icon(
                onPressed: () =>
                    showAdditionalDetails.value = !showAdditionalDetails.value,
                icon: Icon(
                  showAdditionalDetails.value
                      ? Icons.expand_less
                      : Icons.expand_more,
                ),
                label: const Text('Additional Profile Details'),
              ),
              if (showAdditionalDetails.value)
                if (linkedProfileAsync?.isLoading == true)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: CircularProgressIndicator(color: AppColors.orange),
                    ),
                  )
                else
                  FamilyMemberAdditionalFields(
                    key: ValueKey(
                      '${linkedProfile?.id ?? node.id}-${core?.state}-${core?.city}',
                    ),
                    controllers: additionalControllers,
                  ),

              // Save Changes Button
              isSubmitting.value
                  ? const Center(
                      child: CircularProgressIndicator(color: AppColors.orange),
                    )
                  : PrimaryButton(
                      text: 'Save Changes',
                      onPressed: () async {
                        final name = nameController.text.trim();
                        if (name.isEmpty) {
                          AppMessenger.showInfo('Please enter a full name.');
                          return;
                        }
                        if (name.length < 2) {
                          AppMessenger.showInfo(
                            'Full Name must be at least 2 characters.',
                          );
                          return;
                        }

                        final mobile = normalizeFamilyMemberMobile(
                          mobileController.text,
                        );
                        final isMinor = calculateIsMinor(selectedDob.value);
                        final isLinkedMember =
                            node.linkedUserId != null &&
                                node.linkedUserId!.isNotEmpty ||
                            node.isRegisteredUser == true;
                        if (!isLinkedMember &&
                            !isDeceased.value &&
                            !isMinor &&
                            mobile.isEmpty) {
                          AppMessenger.showInfo(
                            'Mobile number is required for living adults.',
                          );
                          return;
                        }
                        if (mobile.isNotEmpty &&
                            (mobile.length != 10 ||
                                !RegExp(r'^[6-9]\d{9}$').hasMatch(mobile))) {
                          AppMessenger.showInfo(
                            'Please enter a valid 10-digit mobile number or leave it blank.',
                          );
                          return;
                        }

                        final currentTree = ref
                            .read(familyControllerProvider)
                            .value;
                        final newRel = selectedRelation.value;

                        // Biological singular limits check (excluding the current node itself)
                        if (currentTree != null) {
                          if (newRel == 'Father') {
                            final otherFathers = currentTree.parents.where(
                              (p) =>
                                  (p.relationshipType == 'Father' ||
                                      p.directRelationship == 'Father') &&
                                  p.id != node.id,
                            );
                            if (otherFathers.isNotEmpty) {
                              AppMessenger.showInfo(
                                'You can only have 1 Father in your family tree.',
                              );
                              return;
                            }
                          }
                          if (newRel == 'Mother') {
                            final otherMothers = currentTree.parents.where(
                              (p) =>
                                  (p.relationshipType == 'Mother' ||
                                      p.directRelationship == 'Mother') &&
                                  p.id != node.id,
                            );
                            if (otherMothers.isNotEmpty) {
                              AppMessenger.showInfo(
                                'You can only have 1 Mother in your family tree.',
                              );
                              return;
                            }
                          }
                          if (newRel == 'Husband' ||
                              newRel == 'Wife' ||
                              newRel == 'Spouse') {
                            final otherSpouses = currentTree.spouses.where(
                              (s) => s.id != node.id,
                            );
                            if (otherSpouses.isNotEmpty) {
                              AppMessenger.showInfo(
                                'You can only register 1 Current Spouse (Husband or Wife).',
                              );
                              return;
                            }
                          }
                        }

                        final data = <String, dynamic>{
                          'title': title.value,
                          'fullName': name,
                          'gender': gender.value,
                          'relationshipType': newRel,
                          'isDeceased': isDeceased.value,
                          'isMinor': isMinor,
                          'dob': selectedDob.value == null
                              ? null
                              : AppDateFormatter.toApiDate(selectedDob.value!),
                          'linkedMobile': mobile.isEmpty ? null : mobile,
                          ...familyMemberAdditionalPayload(
                            additionalControllers,
                          ),
                        };

                        isSubmitting.value = true;
                        try {
                          final memberId = node.id;
                          if (memberId == null || memberId.isEmpty) {
                            AppMessenger.showInfo(
                              'Cannot modify mock or unsaved family member.',
                            );
                            Navigator.of(context).pop();
                            return;
                          }

                          await ref
                              .read(familyControllerProvider.notifier)
                              .updateFamilyMember(memberId, data);
                          ref.invalidate(profileControllerProvider);
                          ref.invalidate(memberProfileProvider(memberId));
                          if (node.linkedUserId != null) {
                            ref.invalidate(memberProfileProvider(node.linkedUserId!));
                          }

                          if (context.mounted) {
                            Navigator.of(context).pop();
                            AppMessenger.showSuccess(
                              'Family member updated successfully!',
                            );
                          }
                        } on DioException catch (e) {
                          final resData = e.response?.data;
                          if (resData is Map && resData['message'] != null) {
                            AppMessenger.showError(
                              resData['message'].toString(),
                            );
                          } else {
                            AppMessenger.showError(
                              e.message ?? 'Failed to update family member.',
                            );
                          }
                        } catch (e) {
                          AppMessenger.showError(e.toString());
                        } finally {
                          isSubmitting.value = false;
                        }
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGenderOption({
    required String label,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.indigoLight.withValues(alpha: 0.4)
              : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? AppColors.indigo : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18.sp,
              color: isSelected ? AppColors.indigo : AppColors.textMuted,
            ),
            SizedBox(width: 6.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? AppColors.indigo : AppColors.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
