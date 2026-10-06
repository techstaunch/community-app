import 'dart:async';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:community_connect/src/common_widgets/app_avatar.dart';
import 'package:community_connect/src/utils/app_messenger.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../theme/app_theme.dart';
import '../../../common_widgets/custom_buttons.dart';
import '../../../common_widgets/custom_inputs.dart';
import 'package:community_connect/src/common_widgets/translated_text.dart';
import '../data/family_provider.dart';
import '../data/family_repository.dart';
import '../data/family_models.dart';
import '../../community/data/community_provider.dart';
import '../../profile/data/profile_provider.dart';
import '../../search/data/search_models.dart';
import '../../search/data/search_repository.dart';
import 'package:community_connect/src/utils/responsive_ext.dart';
import 'package:community_connect/src/utils/app_date_formatter.dart';
import 'widgets/family_member_additional_fields.dart';

class AddFamilyScreen extends HookConsumerWidget {
  const AddFamilyScreen({super.key});

  /// Supported relationships as per architecture guide (Paternal only, no maternal)
  static const List<Map<String, String>> supportedRelations = [
    {'value': 'Father', 'label': 'Father (Papa / Pitaji)', 'gender': 'Male'},
    {'value': 'Mother', 'label': 'Mother (Mummy / Mataji)', 'gender': 'Female'},
    {'value': 'Husband', 'label': 'Husband (Pati)', 'gender': 'Male'},
    {'value': 'Wife', 'label': 'Wife (Patni)', 'gender': 'Female'},
    {'value': 'Brother', 'label': 'Brother (Bhai)', 'gender': 'Male'},
    {'value': 'Sister', 'label': 'Sister (Behen)', 'gender': 'Female'},
    {'value': 'Son', 'label': 'Son (Beta)', 'gender': 'Male'},
    {'value': 'Daughter', 'label': 'Daughter (Beti)', 'gender': 'Female'},
    {
      'value': 'Grandfather',
      'label': 'Paternal Grandfather (Dada)',
      'gender': 'Male',
    },
    {
      'value': 'Grandmother',
      'label': 'Paternal Grandmother (Dadi)',
      'gender': 'Female',
    },
    {'value': 'Grandson', 'label': 'Grandson (Pota)', 'gender': 'Male'},
    {
      'value': 'Granddaughter',
      'label': 'Granddaughter (Poti)',
      'gender': 'Female',
    },
    {
      'value': 'Uncle',
      'label': 'Paternal Uncle (Kaka / Tauji)',
      'gender': 'Male',
    },
    {
      'value': 'Aunt',
      'label': 'Paternal Aunt (Bua / Kaki)',
      'gender': 'Female',
    },
    {'value': 'Nephew', 'label': 'Nephew (Bhatija)', 'gender': 'Male'},
    {'value': 'Niece', 'label': 'Niece (Bhatiji)', 'gender': 'Female'},
    {
      'value': 'Father-in-law',
      'label': 'Father-in-law (Sasurji)',
      'gender': 'Male',
    },
    {
      'value': 'Mother-in-law',
      'label': 'Mother-in-law (Sasuji)',
      'gender': 'Female',
    },
    {'value': 'Son-in-law', 'label': 'Son-in-law (Damad)', 'gender': 'Male'},
    {
      'value': 'Daughter-in-law',
      'label': 'Daughter-in-law (Bahu)',
      'gender': 'Female',
    },
    {
      'value': 'Great-Grandson',
      'label': 'Great-Grandson (Pardota)',
      'gender': 'Male',
    },
    {
      'value': 'Great-Granddaughter',
      'label': 'Great-Granddaughter (Pardoti)',
      'gender': 'Female',
    },
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final phoneController = useTextEditingController();
    final additionalControllers = useMemoized(
      createFamilyMemberAdditionalControllers,
    );
    final showAdditionalDetails = useState(false);
    useEffect(
      () =>
          () => disposeFamilyMemberAdditionalControllers(additionalControllers),
      const [],
    );
    final selectedDob = useState<DateTime?>(null);
    final relation = useState<String?>(null);
    final gender = useState<String>('Male');
    final title = useState<String?>(null);
    final additionType = useState<String>('new'); // 'new' or 'existing'
    final isLinked = useState(false);
    final isDeceased = useState(false);
    final linkedUserId = useState<String?>(null);
    final linkedMobile = useState<String?>(null);
    final debounceTimer = useRef<Timer?>(null);
    final isLoading = ref.watch(familyControllerProvider).isLoading;
    final membershipStatus =
        ref.watch(currentUserMembershipStatusProvider).value ?? 'Approved';
    final isMembershipApproved = membershipStatus.toLowerCase() == 'approved';

    final isCreatingNew = additionType.value == 'new';
    
    final localPhotoPath = useState<String?>(null);
    final localPhotoBytes = useState<Uint8List?>(null);
    final isUploadingPhoto = useState<bool>(false);
    final uploadedPhotoUrl = useState<String?>(null);


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

    final isMinor = calculateIsMinor(selectedDob.value);
    final isPhoneOptional = isDeceased.value || isMinor;

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: Column(
          children: [
            // Top Section
            Container(
              padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 12.h),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: AppColors.border)),
              ),
              child: Row(
                children: [
                  CustomBackButton(onPressed: () => context.pop()),
                  SizedBox(width: 14.w),
                  TranslatedText(
                    'Add Family Member',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontSize: 18.sp,
                      color: AppColors.indigo,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (!isMembershipApproved)
                      Container(
                        margin: EdgeInsets.only(bottom: 16.h),
                        padding: EdgeInsets.all(12.r),
                        decoration: BoxDecoration(
                          color: Colors.amber.shade50,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: Colors.amber.shade300),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: Colors.amber.shade800,
                              size: 20.sp,
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Text(
                                'Family tree creation requires an approved community membership. Your profile is currently awaiting admin verification ($membershipStatus).',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.amber.shade900,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    // Member Addition Type Selector
                    Container(
                      padding: EdgeInsets.all(4.r),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                additionType.value = 'new';
                                isLinked.value = false;
                                linkedUserId.value = null;
                                linkedMobile.value = null;
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                decoration: BoxDecoration(
                                  color: isCreatingNew
                                      ? AppColors.orange
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(9.r),
                                ),
                                child: Center(
                                  child: TranslatedText(
                                    'Create New Member',
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold,
                                      color: isCreatingNew
                                          ? Colors.white
                                          : AppColors.textDark,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                additionType.value = 'existing';
                                isLinked.value = true;
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                decoration: BoxDecoration(
                                  color: !isCreatingNew
                                      ? AppColors.orange
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(9.r),
                                ),
                                child: Center(
                                  child: TranslatedText(
                                    'Add Member',
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold,
                                      color: !isCreatingNew
                                          ? Colors.white
                                          : AppColors.textDark,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),

                    if (isCreatingNew) ...[
                      // Photo Upload
                      Center(
                        child: AppAvatar(
                          imageUrl: null,
                          memoryBytes: localPhotoBytes.value,
                          size: 80.r,
                          isUploading: isUploadingPhoto.value,
                          fallbackWidget: Icon(
                            Icons.person_add_alt_1_outlined,
                            size: 40.r,
                            color: AppColors.textMuted,
                          ),
                          onEdit: () async {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                              ),
                              builder: (ctx) => SafeArea(
                                child: Wrap(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(16.w),
                                      child: TranslatedText(
                                        'Profile Photo',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textDark,
                                        ),
                                      ),
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.camera_alt_outlined, color: AppColors.indigo),
                                      title: const TranslatedText('Take a Photo'),
                                      onTap: () async {
                                        Navigator.pop(ctx);
                                        final picker = ImagePicker();
                                        final XFile? image = await picker.pickImage(source: ImageSource.camera);
                                        if (image != null) {
                                          final bytes = await image.readAsBytes();
                                          localPhotoBytes.value = bytes;
                                          localPhotoPath.value = image.path;
                                          isUploadingPhoto.value = true;
                                          try {
                                            final url = await ref.read(familyRepositoryProvider).uploadFamilyMemberPhoto(image.path);
                                            uploadedPhotoUrl.value = url;
                                          } catch (e) {
                                            AppMessenger.showError('Failed to upload photo');
                                            localPhotoBytes.value = null;
                                            localPhotoPath.value = null;
                                          } finally {
                                            isUploadingPhoto.value = false;
                                          }
                                        }
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.photo_library_outlined, color: AppColors.indigo),
                                      title: const TranslatedText('Choose from Gallery'),
                                      onTap: () async {
                                        Navigator.pop(ctx);
                                        final picker = ImagePicker();
                                        final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                                        if (image != null) {
                                          final bytes = await image.readAsBytes();
                                          localPhotoBytes.value = bytes;
                                          localPhotoPath.value = image.path;
                                          isUploadingPhoto.value = true;
                                          try {
                                            final url = await ref.read(familyRepositoryProvider).uploadFamilyMemberPhoto(image.path);
                                            uploadedPhotoUrl.value = url;
                                          } catch (e) {
                                            AppMessenger.showError('Failed to upload photo');
                                            localPhotoBytes.value = null;
                                            localPhotoPath.value = null;
                                          } finally {
                                            isUploadingPhoto.value = false;
                                          }
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 24.h),
                      
                      // Title Dropdown
                      TranslatedText(
                        'Title',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      SearchableDropdownFormField<String>(
                        initialValue: title.value,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 14.h,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: const BorderSide(
                              color: AppColors.border,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: const BorderSide(
                              color: AppColors.border,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: const BorderSide(
                              color: AppColors.orange,
                              width: 2,
                            ),
                          ),
                          hintText: 'Select Title (e.g. Mr., Mrs., Late)',
                          hintStyle: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.textMuted,
                          ),
                        ),
                        items: const [
                          DropdownMenuItem(value: 'Mr', child: Text('Mr.')),
                          DropdownMenuItem(value: 'Mrs', child: Text('Mrs.')),
                          DropdownMenuItem(value: 'Miss', child: Text('Miss')),
                          DropdownMenuItem(value: 'Late', child: Text('Late')),
                        ],
                        onChanged: (v) {
                          title.value = v;
                          if (v == 'Late') {
                            isDeceased.value = true;
                          } else if (v == 'Mr') {
                            gender.value = 'Male';
                          } else if (v == 'Mrs' || v == 'Miss') {
                            gender.value = 'Female';
                          }
                        },
                      ),
                      SizedBox(height: 16.h),

                      // Create New Member Form
                      CustomInputField(
                        controller: nameController,
                        label: 'Full Name',
                        hintText: 'e.g. Suresh Agarwal',
                        textCapitalization: TextCapitalization.words,
                      ),
                      SizedBox(height: 16.h),

                      CustomInputField(
                        controller: phoneController,
                        label: isPhoneOptional
                            ? 'Mobile Number (Optional)'
                            : 'Mobile Number *',
                        hintText: isPhoneOptional
                            ? 'Optional for ${isDeceased.value ? 'deceased' : 'minor'} members'
                            : '10-digit mobile number (required for living adults)',
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: 16.h),
                    ] else ...[
                      // Link Existing Member Mode
                      if (linkedUserId.value != null) ...[
                        // Linked Member Selected Card
                        Container(
                          padding: EdgeInsets.all(14.r),
                          decoration: BoxDecoration(
                            color: AppColors.indigoLight.withValues(
                              alpha: 0.35,
                            ),
                            borderRadius: BorderRadius.circular(14.r),
                            border: Border.all(
                              color: AppColors.indigo.withValues(alpha: 0.6),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8.r),
                                decoration: const BoxDecoration(
                                  color: AppColors.indigo,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.link,
                                  color: Colors.white,
                                  size: 20.sp,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            nameController.text,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.sp,
                                              color: AppColors.textDark,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 6.w,
                                            vertical: 2.h,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF10B981),
                                            borderRadius: BorderRadius.circular(
                                              6.r,
                                            ),
                                          ),
                                          child: Text(
                                            'Linked',
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (linkedMobile.value != null &&
                                        linkedMobile.value!.isNotEmpty)
                                      Padding(
                                        padding: EdgeInsets.only(top: 2.0.h),
                                        child: Text(
                                          'Mobile: ${linkedMobile.value}',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: AppColors.textMuted,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  linkedUserId.value = null;
                                  linkedMobile.value = null;
                                  nameController.clear();
                                },
                                child: Text(
                                  'Change',
                                  style: TextStyle(
                                    color: AppColors.orange,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.h),
                      ] else ...[
                        TranslatedText(
                          'Search App Member',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textDark,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Autocomplete<SearchResult>(
                          optionsBuilder:
                              (TextEditingValue textEditingValue) async {
                                if (textEditingValue.text.isEmpty) {
                                  return const Iterable<SearchResult>.empty();
                                }

                                if (debounceTimer.value?.isActive ?? false) {
                                  debounceTimer.value!.cancel();
                                }

                                final completer =
                                    Completer<Iterable<SearchResult>>();

                                debounceTimer.value = Timer(
                                  const Duration(milliseconds: 400),
                                  () async {
                                    try {
                                      final repo = ref.read(
                                        searchRepositoryProvider,
                                      );
                                      final results = await repo
                                          .searchLinkableMembers(
                                            query: textEditingValue.text,
                                          );
                                      completer.complete(results);
                                    } catch (e) {
                                      completer.complete(
                                        const Iterable<SearchResult>.empty(),
                                      );
                                    }
                                  },
                                );

                                return completer.future;
                              },
                          displayStringForOption: (SearchResult option) =>
                              option.fullName ?? 'Unknown',
                          onSelected: (SearchResult selection) {
                            linkedUserId.value = selection.id;
                            linkedMobile.value = selection.mobileNumber;
                            nameController.text = selection.fullName ?? '';
                            if (selection.gender != null) {
                              final g = selection.gender!.trim().toLowerCase();
                              if (g == 'male') {
                                gender.value = 'Male';
                              } else if (g == 'female') {
                                gender.value = 'Female';
                              }
                            }
                            if (selection.dob != null &&
                                selection.dob!.isNotEmpty) {
                              selectedDob.value = AppDateFormatter.tryParseDate(
                                selection.dob,
                              );
                            } else {
                              selectedDob.value = null;
                            }
                          },
                          optionsViewBuilder:
                              (
                                BuildContext context,
                                AutocompleteOnSelected<SearchResult> onSelected,
                                Iterable<SearchResult> options,
                              ) {
                                return Align(
                                  alignment: Alignment.topLeft,
                                  child: Material(
                                    elevation: 4.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxHeight: 250.h,
                                        maxWidth:
                                            MediaQuery.of(context).size.width -
                                            40.w,
                                      ),
                                      child: ListView.separated(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        itemCount: options.length,
                                        separatorBuilder: (context, index) =>
                                            const Divider(
                                              height: 1,
                                              color: AppColors.border,
                                            ),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                              final SearchResult option =
                                                  options.elementAt(index);

                                              final List<String> subtitleParts =
                                                  [];
                                              if (option.mobileNumber != null &&
                                                  option
                                                      .mobileNumber!
                                                      .isNotEmpty) {
                                                subtitleParts.add(
                                                  option.mobileNumber!,
                                                );
                                              }
                                              if (option.city != null &&
                                                  option.city!.isNotEmpty) {
                                                subtitleParts.add(option.city!);
                                              }
                                              if (option.designation != null &&
                                                  option
                                                      .designation!
                                                      .isNotEmpty) {
                                                subtitleParts.add(
                                                  option.designation!,
                                                );
                                              }

                                              return ListTile(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                      horizontal: 16.w,
                                                      vertical: 4.h,
                                                    ),
                                                leading: AppAvatar(
                                                  imageUrl:
                                                      option.profilePhotoUrl,
                                                  size: 40.r,
                                                ),
                                                title: Text(
                                                  option.fullName ?? 'Unknown',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14.sp,
                                                    color: AppColors.textDark,
                                                  ),
                                                ),
                                                subtitle:
                                                    subtitleParts.isNotEmpty
                                                    ? Text(
                                                        subtitleParts.join(
                                                          ' • ',
                                                        ),
                                                        style: TextStyle(
                                                          fontSize: 12.sp,
                                                          color: AppColors
                                                              .textMuted,
                                                        ),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      )
                                                    : null,
                                                onTap: () {
                                                  onSelected(option);
                                                },
                                              );
                                            },
                                      ),
                                    ),
                                  ),
                                );
                              },
                          fieldViewBuilder:
                              (
                                context,
                                textEditingController,
                                focusNode,
                                onFieldSubmitted,
                              ) {
                                return TextField(
                                  controller: textEditingController,
                                  focusNode: focusNode,
                                  style: TextStyle(fontSize: 14.sp),
                                  decoration: InputDecoration(
                                    hintText:
                                        'Type to search member by name...',
                                    hintStyle: TextStyle(fontSize: 14.sp),
                                    prefixIcon: const Icon(
                                      Icons.search,
                                      color: AppColors.textMuted,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                      vertical: 14.h,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                      borderSide: const BorderSide(
                                        color: AppColors.border,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                      borderSide: const BorderSide(
                                        color: AppColors.border,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                      borderSide: const BorderSide(
                                        color: AppColors.orange,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                );
                              },
                        ),
                        SizedBox(height: 16.h),
                      ],
                    ],

                    Row(
                      children: [
                        Switch(
                          value: isDeceased.value,
                          onChanged: (v) {
                            isDeceased.value = v;
                            if (v && title.value == null) {
                              title.value = 'Late';
                            } else if (!v && title.value == 'Late') {
                              title.value = null;
                            }
                          },
                          activeThumbColor: AppColors.orange,
                        ),
                        SizedBox(width: 8.w),
                        TranslatedText(
                          'Is this member deceased?',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textDark,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    TranslatedText(
                      'Relation',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    SearchableDropdownFormField<String>(
                      initialValue: relation.value,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 14.h,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: const BorderSide(color: AppColors.border),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: const BorderSide(color: AppColors.border),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: const BorderSide(
                            color: AppColors.orange,
                            width: 2,
                          ),
                        ),
                      ),
                      items: supportedRelations.map((r) {
                        return DropdownMenuItem<String>(
                          value: r['value'],
                          child: TranslatedText(
                            r['label']!,
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        );
                      }).toList(),
                      onChanged: (v) {
                        relation.value = v;
                        final match = supportedRelations.firstWhere(
                          (r) => r['value'] == v,
                          orElse: () => {},
                        );
                        if (match['gender'] != null) {
                          gender.value = match['gender']!;
                        }
                      },
                      hint: TranslatedText(
                        'Select Relation',
                        style: TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    TranslatedText(
                      'Gender',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    SearchableDropdownFormField<String>(
                      key: ValueKey(gender.value),
                      initialValue: gender.value,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor:
                            (isLinked.value && linkedUserId.value != null)
                            ? Colors.grey.shade100
                            : Colors.white,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 14.h,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: const BorderSide(color: AppColors.border),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: const BorderSide(color: AppColors.border),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: const BorderSide(
                            color: AppColors.orange,
                            width: 2,
                          ),
                        ),
                      ),
                      items: [
                        DropdownMenuItem(
                          value: 'Male',
                          child: TranslatedText(
                            'Male',
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'Female',
                          child: TranslatedText(
                            'Female',
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ),
                      ],
                      onChanged: (isLinked.value && linkedUserId.value != null)
                          ? null
                          : (v) => gender.value = v!,
                    ),
                    SizedBox(height: 16.h),

                    CustomDatePickerField(
                      label: 'Date of Birth (Optional)',
                      hintText: 'YYYY-MM-DD',
                      selectedDate: selectedDob.value,
                      onDateSelected: (date) => selectedDob.value = date,
                      lastDate: DateTime.now(), // Can't be born in the future
                      enabled: !(isLinked.value && linkedUserId.value != null),
                    ),

                    SizedBox(height: 16.h),
                    TextButton.icon(
                      onPressed: () => showAdditionalDetails.value =
                          !showAdditionalDetails.value,
                      icon: Icon(
                        showAdditionalDetails.value
                            ? Icons.expand_less
                            : Icons.expand_more,
                      ),
                      label: const Text('Additional Profile Details'),
                    ),
                    if (showAdditionalDetails.value)
                      FamilyMemberAdditionalFields(
                        controllers: additionalControllers,
                      ),
                    SizedBox(height: 32.h),
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : PrimaryButton(
                            text: 'Save & Add',
                            onPressed: () async {
                              if (!isMembershipApproved) {
                                AppMessenger.showInfo(
                                  'Family tree creation requires an approved community membership. Your profile status is currently $membershipStatus.',
                                );
                                return;
                              }

                              final name = nameController.text.trim();
                              if (name.isEmpty || relation.value == null) {
                                AppMessenger.showInfo(
                                  'Oops! Please fill in both the name and relation.',
                                );
                                return;
                              }
                              if (name.length < 2) {
                                AppMessenger.showInfo(
                                  'Full Name must be at least 2 characters.',
                                );
                                return;
                              }
                              final nameRegex = RegExp(
                                r"^[\p{L}\p{M}\s.'-]+$",
                                unicode: true,
                              );
                              if (!nameRegex.hasMatch(name)) {
                                AppMessenger.showInfo(
                                  'Full Name contains invalid characters.',
                                );
                                return;
                              }

                              const maleRelations = [
                                'Father',
                                'Husband',
                                'Brother',
                                'Son',
                                'Grandfather',
                                'Grandson',
                                'Uncle',
                                'Nephew',
                                'Father-in-law',
                                'Son-in-law',
                                'Great-Grandson',
                              ];
                              const femaleRelations = [
                                'Mother',
                                'Wife',
                                'Sister',
                                'Daughter',
                                'Grandmother',
                                'Granddaughter',
                                'Aunt',
                                'Niece',
                                'Mother-in-law',
                                'Daughter-in-law',
                                'Great-Granddaughter',
                              ];

                              if (maleRelations.contains(relation.value) &&
                                  gender.value != 'Male') {
                                AppMessenger.showInfo(
                                  '${relation.value} must be Male.',
                                );
                                return;
                              }

                              if (femaleRelations.contains(relation.value) &&
                                  gender.value != 'Female') {
                                AppMessenger.showInfo(
                                  '${relation.value} must be Female.',
                                );
                                return;
                              }

                              if (selectedDob.value != null &&
                                  selectedDob.value!.isAfter(DateTime.now())) {
                                AppMessenger.showInfo(
                                  'Date of Birth cannot be in the future.',
                                );
                                return;
                              }

                              if (isCreatingNew) {
                                final phone = normalizeFamilyMemberMobile(
                                  phoneController.text,
                                );
                                if (!isPhoneOptional) {
                                  if (phone.isEmpty) {
                                    AppMessenger.showInfo(
                                      'Mobile number is mandatory for living adult members.',
                                    );
                                    return;
                                  }
                                  if (phone.length != 10 ||
                                      !RegExp(
                                        r'^[6-9]\d{9}$',
                                      ).hasMatch(phone)) {
                                    AppMessenger.showInfo(
                                      'Please enter a valid 10-digit mobile number starting with 6-9.',
                                    );
                                    return;
                                  }
                                } else {
                                  if (phone.isNotEmpty &&
                                      (phone.length != 10 ||
                                          !RegExp(
                                            r'^[6-9]\d{9}$',
                                          ).hasMatch(phone))) {
                                    AppMessenger.showInfo(
                                      'Please enter a valid 10-digit mobile number or leave it blank.',
                                    );
                                    return;
                                  }
                                }
                              }

                              // Integrity Constraint 1: Self-Addition Block
                              final myProfile = ref
                                  .read(profileControllerProvider)
                                  .value;
                              if (myProfile != null) {
                                if (linkedUserId.value != null &&
                                    linkedUserId.value == myProfile.id) {
                                  AppMessenger.showInfo(
                                    'You cannot add yourself as a family member in your own tree.',
                                  );
                                  return;
                                }
                                final enteredPhone = isCreatingNew
                                    ? normalizeFamilyMemberMobile(
                                        phoneController.text,
                                      )
                                    : (linkedMobile.value?.trim() ?? '');
                                if (enteredPhone.isNotEmpty &&
                                    myProfile.mobileNumber != null &&
                                    enteredPhone ==
                                        myProfile.mobileNumber!.trim()) {
                                  AppMessenger.showInfo(
                                    'You cannot add your own phone number as a family member.',
                                  );
                                  return;
                                }
                              }

                              // Integrity Constraint 2 & 3: Singular Limits & Duplicate Protection
                              final currentTree = ref
                                  .read(familyControllerProvider)
                                  .value;
                              if (currentTree != null) {
                                if (relation.value == 'Father') {
                                  final hasFather = currentTree.parents.any(
                                    (p) =>
                                        p.relationshipType == 'Father' ||
                                        p.directRelationship == 'Father',
                                  );
                                  if (hasFather) {
                                    AppMessenger.showInfo(
                                      'You can only have 1 Father in your family tree.',
                                    );
                                    return;
                                  }
                                }

                                if (relation.value == 'Mother') {
                                  final hasMother = currentTree.parents.any(
                                    (p) =>
                                        p.relationshipType == 'Mother' ||
                                        p.directRelationship == 'Mother',
                                  );
                                  if (hasMother) {
                                    AppMessenger.showInfo(
                                      'You can only have 1 Mother in your family tree.',
                                    );
                                    return;
                                  }
                                }

                                if (relation.value == 'Husband' ||
                                    relation.value == 'Wife' ||
                                    relation.value == 'Spouse') {
                                  if (currentTree.spouses.isNotEmpty) {
                                    AppMessenger.showInfo(
                                      'You can only register 1 Current Spouse (Husband or Wife).',
                                    );
                                    return;
                                  }
                                }

                                // Duplicate Protection for linked accounts
                                if (linkedUserId.value != null) {
                                  final allLinkedIds = <String>{};
                                  void collectIds(FamilyTreeNode n) {
                                    if (n.linkedUserId != null) {
                                      allLinkedIds.add(n.linkedUserId!);
                                    }
                                    if (n.isRegisteredUser == true &&
                                        n.id != null) {
                                      allLinkedIds.add(n.id!);
                                    }
                                    for (final p in n.parents) {
                                      collectIds(p);
                                    }
                                    for (final s in n.siblings) {
                                      collectIds(s);
                                    }
                                    for (final sp in n.spouses) {
                                      collectIds(sp);
                                    }
                                    for (final c in n.children) {
                                      collectIds(c);
                                    }
                                  }

                                  collectIds(currentTree);
                                  if (allLinkedIds.contains(
                                    linkedUserId.value,
                                  )) {
                                    AppMessenger.showInfo(
                                      'This registered member is already added to your family tree.',
                                    );
                                    return;
                                  }
                                }
                              }

                              if (isCreatingNew) {
                                final phone = normalizeFamilyMemberMobile(
                                  phoneController.text,
                                );
                                if (!isDeceased.value &&
                                    !isMinor &&
                                    phone.isEmpty) {
                                  AppMessenger.showError(
                                    'Mobile number is required for living adults.',
                                  );
                                  return;
                                }
                                if (phone.isNotEmpty &&
                                    (phone.length != 10 ||
                                        !RegExp(r'^[6-9]\d{9}$').hasMatch(phone))) {
                                  AppMessenger.showError(
                                    'Please enter a valid 10-digit mobile number or leave it blank.',
                                  );
                                  return;
                                }
                              }

                              final mappedRelation = relation.value!;

                              final data = <String, dynamic>{
                                if (title.value != null &&
                                    title.value!.isNotEmpty)
                                  'title': title.value,
                                'fullName': name,
                                'gender': gender.value,
                                'relationshipType': mappedRelation,
                                'isDeceased': isDeceased.value,
                                'isMinor': isMinor,
                                ...familyMemberAdditionalPayload(
                                  additionalControllers,
                                ),
                              };
                              if (selectedDob.value != null) {
                                data['dob'] = AppDateFormatter.toApiDate(
                                  selectedDob.value!,
                                );
                              }
                              if (isCreatingNew) {
                                final phone = normalizeFamilyMemberMobile(
                                  phoneController.text,
                                );
                                if (phone.isNotEmpty) {
                                  data['linkedMobile'] = phone;
                                }
                              } else {
                                if (linkedMobile.value != null &&
                                    linkedMobile.value!.isNotEmpty) {
                                  data['linkedMobile'] = linkedMobile.value;
                                }
                                if (linkedUserId.value != null) {
                                  data['linkedUserId'] = linkedUserId.value;
                                }
                              }

                              if (uploadedPhotoUrl.value != null) {
                                data['photoUrl'] = uploadedPhotoUrl.value;
                              }

                              try {
                                await ref
                                    .read(familyControllerProvider.notifier)
                                    .addFamilyMember(data);
                                ref.invalidate(memberFamilyTreeProvider);
                                ref.invalidate(profileControllerProvider);
                                if (context.mounted) {
                                  context.pop();
                                }
                              } on DioException catch (e) {
                                final resData = e.response?.data;
                                if (resData is Map &&
                                    resData['errors'] is List &&
                                    resData['errors'].isNotEmpty) {
                                  final firstError = resData['errors'][0];
                                  AppMessenger.showError(
                                    "${firstError['field']}: ${firstError['message']}",
                                  );
                                } else if (resData is Map &&
                                    resData['message'] != null) {
                                  AppMessenger.showError(
                                    resData['message'].toString(),
                                  );
                                } else {
                                  AppMessenger.showError(
                                    e.message ??
                                        'An error occurred while adding family member.',
                                  );
                                }
                              } catch (e) {
                                AppMessenger.showError(e.toString());
                              }
                            },
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
}
