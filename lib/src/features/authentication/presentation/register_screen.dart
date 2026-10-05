import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:community_connect/src/utils/app_messenger.dart';
import 'package:community_connect/src/utils/app_date_formatter.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../common_widgets/app_avatar.dart';
import '../../../theme/app_theme.dart';
import '../../../common_widgets/custom_buttons.dart';
import 'package:community_connect/src/common_widgets/translated_text.dart';
import '../../../common_widgets/custom_inputs.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:community_connect/src/utils/responsive_ext.dart';
import '../../profile/data/profile_provider.dart';
import '../../profile/data/profile_models.dart';
import '../../authentication/data/auth_provider.dart';

class RegisterScreen extends HookConsumerWidget {
  final bool isEditing;
  const RegisterScreen({super.key, this.isEditing = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstNameController = useTextEditingController();
    final emailController = useTextEditingController();
    final lastNameController = useTextEditingController();
    final selectedDob = useState<DateTime?>(null);
    final selectedTimeOfBirth = useState<TimeOfDay?>(null);
    final selectedPhoto = useState<File?>(null);
    final selectedCity = useState<String?>(null);
    final villageController = useTextEditingController();
    final addressController = useTextEditingController();
    final bioController = useTextEditingController();
    final heightFtController = useTextEditingController();
    final heightInController = useTextEditingController();
    final educationController = useTextEditingController();
    final instagramController = useTextEditingController();
    final facebookController = useTextEditingController();
    final linkedinController = useTextEditingController();
    final twitterController = useTextEditingController();
    final phoneController = useTextEditingController();
    final timeOfBirthController = useTextEditingController();
    final disabilityController = useTextEditingController();
    final maternalGotra = useState<String?>(null);
    final manglik = useState<String?>('Don\'t Know');
    final title = useState<String?>('Mr.');
    final selectedState = useState<String?>(null);
    final maternalSurnameController = useTextEditingController();

    final gender = useState('Male');
    final gotra = useState<String?>(null);
    final isSubmitting = useState<bool>(false);

    final profileState = ref.watch(profileControllerProvider);
    final profileData = profileState.value?.profile;

    useEffect(() {
      if (isEditing &&
          profileState.value != null &&
          profileState.value!.profile != null) {
        final core = profileState.value!.profile!;
        emailController.text = profileState.value!.email ?? '';
        final mobile = profileState.value!.mobileNumber ?? '';
        final mobileDigits = mobile.replaceAll(RegExp(r'[^\d]'), '');
        if (mobileDigits.length == 12 && mobileDigits.startsWith('91')) {
          phoneController.text = mobileDigits.substring(2);
        } else {
          phoneController.text = mobileDigits;
        }
        if (core.timeOfBirth != null && core.timeOfBirth!.isNotEmpty) {
          final parsedTime = CustomTimePickerField.parseTimeString(
            core.timeOfBirth!,
          );
          selectedTimeOfBirth.value = parsedTime;
          if (parsedTime != null) {
            timeOfBirthController.text = CustomTimePickerField.formatTimeOfDay(
              parsedTime,
            );
          } else {
            timeOfBirthController.text = core.timeOfBirth ?? '';
          }
        } else {
          timeOfBirthController.text = core.timeOfBirth ?? '';
        }
        disabilityController.text = core.disability ?? '';
        maternalGotra.value = core.maternalGotra;
        manglik.value = core.manglik ?? 'Don\'t Know';
        final names = core.fullName?.split(' ') ?? [];
        if (names.isNotEmpty) {
          firstNameController.text = names.first;
          if (names.length > 1) {
            lastNameController.text = names.sublist(1).join(' ');
          }
        }
        if (core.dob != null && core.dob!.isNotEmpty) {
          selectedDob.value = AppDateFormatter.tryParseDate(core.dob);
        }
        gender.value = core.gender ?? 'Male';
        selectedCity.value = core.city;
        villageController.text = core.nativeVillage ?? '';
        addressController.text = core.address ?? '';
        bioController.text = core.bio ?? '';
        if ([
          '4 ft 0 in',
          '4 ft 1 in',
          '4 ft 2 in',
          '4 ft 3 in',
          '4 ft 4 in',
          '4 ft 5 in',
          '4 ft 6 in',
          '4 ft 7 in',
          '4 ft 8 in',
          '4 ft 9 in',
          '4 ft 10 in',
          '4 ft 11 in',
          '5 ft 0 in',
          '5 ft 1 in',
          '5 ft 2 in',
          '5 ft 3 in',
          '5 ft 4 in',
          '5 ft 5 in',
          '5 ft 6 in',
          '5 ft 7 in',
          '5 ft 8 in',
          '5 ft 9 in',
          '5 ft 10 in',
          '5 ft 11 in',
          '6 ft 0 in',
          '6 ft 1 in',
          '6 ft 2 in',
          '6 ft 3 in',
          '6 ft 4 in',
          '6 ft 5 in',
          '6 ft 6 in',
          '6 ft 7 in',
          '6 ft 8 in',
          '6 ft 9 in',
          '6 ft 10 in',
          '6 ft 11 in',
          '7 ft 0 in',
        ].contains(core.height)) {
          if (core.height != null) {
            final hRegex = RegExp(r"(\d+)\s*ft\s*(\d+)?");
            final match = hRegex.firstMatch(core.height!);
            if (match != null) {
              heightFtController.text = match.group(1) ?? '';
              heightInController.text = match.group(2) ?? '';
            }
          }
        }
        educationController.text = core.education ?? '';
        instagramController.text = core.instagram ?? '';
        facebookController.text = core.facebook ?? '';
        linkedinController.text = core.linkedin ?? '';
        twitterController.text = core.twitter ?? '';
        title.value = core.title ?? 'Mr.';
        selectedState.value = core.state;
        maternalSurnameController.text = core.maternalSurname ?? '';

        final existingGotra = core.gotra;
        if (existingGotra != null && existingGotra.trim().isNotEmpty) {
          gotra.value = existingGotra.trim();
        }
        final existingMaternalGotra = core.maternalGotra;
        if (existingMaternalGotra != null &&
            existingMaternalGotra.trim().isNotEmpty) {
          maternalGotra.value = existingMaternalGotra.trim();
        }
      }
      if (phoneController.text.isEmpty) {
        final rawMobile =
            profileState.value?.mobileNumber ??
            ref.read(authControllerProvider.notifier).currentMobileNumber ??
            '';
        final mobileDigits = rawMobile.replaceAll(RegExp(r'[^\d]'), '');
        if (mobileDigits.length == 12 && mobileDigits.startsWith('91')) {
          phoneController.text = mobileDigits.substring(2);
        } else {
          phoneController.text = mobileDigits;
        }
      }
      return null;
    }, const []);

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20.w, 60.h, 20.w, 36.h),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.orange, AppColors.orangeDark],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36.r),
                bottomRight: Radius.circular(36.r),
              ),
            ),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomBackButton(
                  onPressed: () {
                    if (GoRouter.of(context).canPop()) {
                      context.pop();
                    } else if (!isEditing) {
                      ref.read(authControllerProvider.notifier).logout();
                    } else {
                      context.go('/home');
                    }
                  },
                  dark: false,
                ),
                SizedBox(height: 16.h),
                TranslatedText(
                  isEditing ? 'Edit Profile' : 'Complete Your Profile',
                  style: Theme.of(
                    context,
                  ).textTheme.displayMedium?.copyWith(color: Colors.white),
                ),
                SizedBox(height: 4.h),
                TranslatedText(
                  isEditing
                      ? 'Update your personal details'
                      : 'Tell your community about yourself',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.75),
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: () async {
                        showModalBottomSheet(
                          context: context,
                          builder: (ctx) => SafeArea(
                            child: Wrap(
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.camera_alt_outlined),
                                  title: const Text('Take Photo'),
                                  onTap: () async {
                                    Navigator.pop(ctx);
                                    final picker = ImagePicker();
                                    final image = await picker.pickImage(source: ImageSource.camera);
                                    if (image != null) selectedPhoto.value = File(image.path);
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.photo_library_outlined),
                                  title: const Text('Choose from Gallery'),
                                  onTap: () async {
                                    Navigator.pop(ctx);
                                    final picker = ImagePicker();
                                    final image = await picker.pickImage(source: ImageSource.gallery);
                                    if (image != null) selectedPhoto.value = File(image.path);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.orange,
                            width: 2,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: AppAvatar(
                          imageUrl: profileData?.profilePhotoUrl,
                          localFile: selectedPhoto.value,
                          size: 80.r,
                          fallbackWidget: Icon(
                            Icons.camera_alt_outlined,
                            color: AppColors.orange,
                            size: 28.r,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 14.h),
                  Row(
                    children: [
                      SizedBox(
                        width: 100.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TranslatedText(
                              'Title *',
                              style: TextStyle(
                                color: AppColors.indigo,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 5.h),
                            SearchableDropdownFormField<String>(
                              initialValue: title.value,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 12.h,
                                ),
                              ),
                              items: const [
                                DropdownMenuItem(
                                  value: 'Mr.',
                                  child: Text('Mr.'),
                                ),
                                DropdownMenuItem(
                                  value: 'Ms.',
                                  child: Text('Ms.'),
                                ),
                                DropdownMenuItem(
                                  value: 'Miss',
                                  child: Text('Miss'),
                                ),
                                DropdownMenuItem(
                                  value: 'Mrs.',
                                  child: Text('Mrs.'),
                                ),
                                DropdownMenuItem(
                                  value: 'Late',
                                  child: Text('Late'),
                                ),
                              ],
                              isExpanded: true,
                              onChanged: (v) => title.value = v,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14.h),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TranslatedText(
                              'First Name',
                              style: TextStyle(
                                color: AppColors.indigo,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 5.h),
                            TextField(
                              controller: firstNameController,
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                hintText: 'e.g. Ravi',
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TranslatedText(
                              'Last Name',
                              style: TextStyle(
                                color: AppColors.indigo,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 5.h),
                            TextField(
                              controller: lastNameController,
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                hintText: 'e.g. Agarwal',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14.h),
                  TranslatedText(
                    'Phone Number *',
                    style: TextStyle(
                      color: AppColors.indigo,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      hintText: 'e.g. 9876543210',
                      counterText: '',
                      prefixIcon: Icon(
                        Icons.phone_android_rounded,
                        color: AppColors.indigo,
                      ),
                    ),
                  ),
                  SizedBox(height: 14.h),
                  TranslatedText(
                    'Email Address (Optional)',
                    style: TextStyle(
                      color: AppColors.indigo,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'e.g. name@example.com',
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: AppColors.indigo,
                      ),
                    ),
                  ),
                  SizedBox(height: 14.h),
                  CustomDatePickerField(
                    label: 'Date of Birth *',
                    selectedDate: selectedDob.value,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                    onDateSelected: (date) => selectedDob.value = date,
                  ),
                  SizedBox(height: 14.h),
                  CustomTimePickerField(
                    label: 'Time of Birth',
                    selectedTime: selectedTimeOfBirth.value,
                    initialTimeString: timeOfBirthController.text,
                    onTimeSelected: (time) {
                      selectedTimeOfBirth.value = time;
                      if (time != null) {
                        timeOfBirthController.text =
                            CustomTimePickerField.formatTimeOfDay(time);
                      } else {
                        timeOfBirthController.text = '';
                      }
                    },
                  ),
                  SizedBox(height: 14.h),
                  TranslatedText(
                    'Gender *',
                    style: TextStyle(
                      color: AppColors.indigo,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => gender.value = 'Male',
                        child: _buildChip('Male', gender.value == 'Male'),
                      ),
                      GestureDetector(
                        onTap: () => gender.value = 'Female',
                        child: _buildChip('Female', gender.value == 'Female'),
                      ),
                      GestureDetector(
                        onTap: () => gender.value = 'Other',
                        child: _buildChip('Other', gender.value == 'Other'),
                      ),
                    ],
                  ),
                  SizedBox(height: 14.h),
                  TranslatedText(
                    'Disability',
                    style: TextStyle(
                      color: AppColors.indigo,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  TextField(
                    controller: disabilityController,
                    decoration: InputDecoration(
                      hintText: 'e.g. None / No / description',
                      prefixIcon: Icon(
                        Icons.accessible_rounded,
                        color: AppColors.indigo,
                      ),
                    ),
                  ),
                  SizedBox(height: 14.h),
                  _StateAndCitySelector(
                    selectedState: selectedState,
                    selectedCity: selectedCity,
                  ),
                  SizedBox(height: 14.h),
                  TranslatedText(
                    'Native Village *',
                    style: TextStyle(
                      color: AppColors.indigo,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  TextField(
                    controller: villageController,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      hintText: 'e.g. Valsad',
                      prefixIcon: Icon(
                        Icons.home_work_outlined,
                        color: AppColors.indigo,
                      ),
                    ),
                  ),
                  SizedBox(height: 14.h),
                  TranslatedText(
                    'Gotra *',
                    style: TextStyle(
                      color: AppColors.indigo,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  SearchableDropdownFormField<String>(
                    key: ValueKey('gotra_${gotra.value}'),
                    initialValue:
                        (gotra.value != null &&
                            {
                              ...kCommunityGotras,
                              gotra.value!.trim(),
                            }.contains(gotra.value))
                        ? gotra.value
                        : null,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.account_balance_outlined,
                        color: AppColors.indigo,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 12.h,
                      ),
                    ),
                    items:
                        ({
                              ...kCommunityGotras,
                              if (gotra.value != null &&
                                  gotra.value!.trim().isNotEmpty)
                                gotra.value!.trim(),
                            }.toList()..sort())
                            .map(
                              (g) => DropdownMenuItem(
                                value: g,
                                child: TranslatedText(
                                  g,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            )
                            .toList(),
                    onChanged: (v) => gotra.value = v,
                    hint: const TranslatedText('Select Gotra *'),
                    isExpanded: true,
                  ),
                  SizedBox(height: 14.h),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TranslatedText(
                              'Maternal Gotra',
                              style: TextStyle(
                                color: AppColors.indigo,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 5.h),
                            SearchableDropdownFormField<String>(
                              key: ValueKey(
                                'maternal_gotra_${maternalGotra.value}',
                              ),
                              initialValue:
                                  (maternalGotra.value != null &&
                                      {
                                        ...kCommunityGotras,
                                        maternalGotra.value!.trim(),
                                      }.contains(maternalGotra.value))
                                  ? maternalGotra.value
                                  : null,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.family_restroom_rounded,
                                  color: AppColors.indigo,
                                ),
                                suffixIcon: maternalGotra.value != null
                                    ? IconButton(
                                        icon: const Icon(Icons.clear, size: 16),
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                        onPressed: () =>
                                            maternalGotra.value = null,
                                      )
                                    : null,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 12.h,
                                ),
                              ),
                              items:
                                  ({
                                        ...kCommunityGotras,
                                        if (maternalGotra.value != null &&
                                            maternalGotra.value!
                                                .trim()
                                                .isNotEmpty)
                                          maternalGotra.value!.trim(),
                                      }.toList()..sort())
                                      .map(
                                        (g) => DropdownMenuItem(
                                          value: g,
                                          child: TranslatedText(
                                            g,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      )
                                      .toList(),
                              onChanged: (v) => maternalGotra.value = v,
                              hint: const TranslatedText('Select Gotra'),
                              isExpanded: true,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TranslatedText(
                              'Maternal Surname',
                              style: TextStyle(
                                color: AppColors.indigo,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 5.h),
                            TextField(
                              controller: maternalSurnameController,
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                hintText: 'e.g. Sharma',
                                prefixIcon: Icon(
                                  Icons.badge_outlined,
                                  color: AppColors.indigo,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14.h),
                  TranslatedText(
                    'Manglik',
                    style: TextStyle(
                      color: AppColors.indigo,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  SearchableDropdownFormField<String>(
                    initialValue: manglik.value,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.star_outline_rounded,
                        color: AppColors.indigo,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 12.h,
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'No',
                        child: TranslatedText('No'),
                      ),
                      DropdownMenuItem(
                        value: 'Yes',
                        child: TranslatedText('Yes'),
                      ),
                      DropdownMenuItem(
                        value: 'Anshik',
                        child: TranslatedText('Anshik'),
                      ),
                      DropdownMenuItem(
                        value: 'Don\'t Know',
                        child: TranslatedText('Don\'t Know'),
                      ),
                    ],
                    onChanged: (v) => manglik.value = v,
                    hint: const TranslatedText('Select Manglik Status'),
                  ),
                  SizedBox(height: 14.h),
                  TranslatedText(
                    'Address *',
                    style: TextStyle(
                      color: AppColors.indigo,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  TextField(
                    controller: addressController,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      hintText: 'e.g. 123 Main St',
                      prefixIcon: Icon(
                        Icons.location_on_outlined,
                        color: AppColors.indigo,
                      ),
                    ),
                  ),

                  SizedBox(height: 14.h),
                  TranslatedText(
                    'Bio *',
                    style: TextStyle(
                      color: AppColors.indigo,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  TextField(
                    controller: bioController,
                    maxLines: 3,
                    maxLength: 500,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      hintText: 'Tell us about yourself...',
                      counterText: '',
                    ),
                  ),

                  SizedBox(height: 14.h),
                  Column(
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
                              value: heightFtController.text.isNotEmpty && ['2', '3', '4', '5', '6', '7', '8', '9'].contains(heightFtController.text.trim()) ? heightFtController.text.trim() : null,
                              items: ['2', '3', '4', '5', '6', '7', '8', '9'].map((ft) {
                                return DropdownMenuItem(
                                  value: ft,
                                  child: Text(ft),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  heightFtController.text = value;
                                  // Find the next focusable widget manually to ensure the text field gets focus
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
                              value: heightInController.text.isNotEmpty &&
                                      List.generate(12, (i) => i.toString())
                                          .contains(heightInController.text.trim())
                                  ? heightInController.text.trim()
                                  : null,
                              items: List.generate(12, (i) => i.toString()).map((inch) {
                                return DropdownMenuItem(
                                  value: inch,
                                  child: Text(inch),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  heightInController.text = value;
                                  // Find the next focusable widget manually
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
                  ),

                  SizedBox(height: 14.h),
                  TranslatedText(
                    'Education *',
                    style: TextStyle(
                      color: AppColors.indigo,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  TextField(
                    controller: educationController,
                    decoration: InputDecoration(
                      hintText: 'e.g. B.Tech in Computer Science',
                    ),
                  ),

                  SizedBox(height: 24.h),
                  TranslatedText(
                    'Social Links',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  SizedBox(height: 14.h),

                  TextField(
                    controller: instagramController,
                    decoration: InputDecoration(
                      hintText: 'Instagram Username',
                      prefixIcon: Icon(
                        Icons.camera_alt,
                        color: AppColors.indigo,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  TextField(
                    controller: facebookController,
                    decoration: InputDecoration(
                      hintText: 'Facebook Username',
                      prefixIcon: Icon(Icons.facebook, color: AppColors.indigo),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  TextField(
                    controller: linkedinController,
                    decoration: InputDecoration(
                      hintText: 'LinkedIn Username',
                      prefixIcon: Icon(Icons.work, color: AppColors.indigo),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  TextField(
                    controller: twitterController,
                    decoration: InputDecoration(
                      hintText: 'Twitter Username',
                      prefixIcon: Icon(
                        Icons.alternate_email,
                        color: AppColors.indigo,
                      ),
                    ),
                  ),

                  SizedBox(height: 24.h),
                  (profileState.isLoading || isSubmitting.value)
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () async {
                            final firstName = firstNameController.text.trim();
                            if (firstName.isEmpty) {
                              AppMessenger.showError(
                                'Oops! First Name is required.',
                              );
                              return;
                            }
                            if (firstName.length < 2) {
                              AppMessenger.showError(
                                'First Name must be at least 2 characters.',
                              );
                              return;
                            }
                            final nameRegex = RegExp(
                              r"^[\p{L}\p{M}\s.'-]+$",
                              unicode: true,
                            );
                            if (!nameRegex.hasMatch(firstName)) {
                              AppMessenger.showError(
                                'First Name contains invalid characters.',
                              );
                              return;
                            }

                            final lastName = lastNameController.text.trim();
                            if (lastName.isEmpty) {
                              AppMessenger.showError(
                                'Please enter your Last Name.',
                              );
                              return;
                            }
                            if (lastName.length < 2) {
                              AppMessenger.showError(
                                'Last Name must be at least 2 characters.',
                              );
                              return;
                            }
                            if (!nameRegex.hasMatch(lastName)) {
                              AppMessenger.showError(
                                'Last Name contains invalid characters.',
                              );
                              return;
                            }

                            final phoneRaw = phoneController.text.replaceAll(
                              RegExp(r'[^\d]'),
                              '',
                            );
                            final cleanPhone =
                                (phoneRaw.length == 12 &&
                                    phoneRaw.startsWith('91'))
                                ? phoneRaw.substring(2)
                                : phoneRaw;
                            if (cleanPhone.isEmpty) {
                              AppMessenger.showError(
                                'Phone number is required.',
                              );
                              return;
                            }
                            if (cleanPhone.length != 10 ||
                                !RegExp(r'^[6-9]\d{9}$').hasMatch(cleanPhone)) {
                              AppMessenger.showError(
                                'Please enter a valid 10-digit mobile number starting with 6, 7, 8, or 9.',
                              );
                              return;
                            }

                            final email = emailController.text.trim();
                            if (email.isNotEmpty) {
                              final emailRegex = RegExp(
                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                              );
                              if (!emailRegex.hasMatch(email)) {
                                AppMessenger.showError(
                                  'That email address doesn\'t look quite right.',
                                );
                                return;
                              }
                            }

                            if (selectedDob.value == null) {
                              AppMessenger.showError(
                                'Please select your Date of Birth.',
                              );
                              return;
                            }
                            if (selectedDob.value!.isAfter(DateTime.now())) {
                              AppMessenger.showError(
                                'Date of Birth cannot be in the future.',
                              );
                              return;
                            }
                            if (selectedDob.value!.isBefore(DateTime(1900))) {
                              AppMessenger.showError(
                                'Please select a realistic Date of Birth.',
                              );
                              return;
                            }

                            final timeOfBirth = timeOfBirthController.text
                                .trim();
                            if (timeOfBirth.isNotEmpty) {
                              final validTime =
                                  CustomTimePickerField.parseTimeString(
                                    timeOfBirth,
                                  );
                              if (validTime == null) {
                                AppMessenger.showError(
                                  'Please select a valid Time of Birth.',
                                );
                                return;
                              }
                            }

                            if (gender.value.trim().isEmpty) {
                              AppMessenger.showError(
                                'Please select your Gender.',
                              );
                              return;
                            }

                            final state = selectedState.value ?? '';
                            if (state.isEmpty) {
                              AppMessenger.showError(
                                'Don\'t forget to enter your State.',
                              );
                              return;
                            }
                            if (state.length < 2) {
                              AppMessenger.showError(
                                'Please enter a valid State name.',
                              );
                              return;
                            }

                            final city = selectedCity.value ?? '';
                            if (city.isEmpty) {
                              AppMessenger.showError(
                                'Don\'t forget to enter your City.',
                              );
                              return;
                            }
                            if (city.length < 2) {
                              AppMessenger.showError(
                                'Please enter a valid City name.',
                              );
                              return;
                            }

                            final village = villageController.text.trim();
                            if (village.isEmpty) {
                              AppMessenger.showError(
                                'Native Village is required.',
                              );
                              return;
                            }
                            if (village.length < 2) {
                              AppMessenger.showError(
                                'Please enter a valid Native Village.',
                              );
                              return;
                            }

                            if (gotra.value == null ||
                                gotra.value!.trim().isEmpty) {
                              AppMessenger.showError('Gotra is required.');
                              return;
                            }

                            final address = addressController.text.trim();
                            if (address.isEmpty) {
                              AppMessenger.showError('Address is required.');
                              return;
                            }
                            if (address.length < 5) {
                              AppMessenger.showError(
                                'Please provide a more complete address.',
                              );
                              return;
                            }

                            final bio = bioController.text.trim();
                            if (bio.isEmpty) {
                              AppMessenger.showError('Bio is required.');
                              return;
                            }

                            final education = educationController.text.trim();
                            if (education.isEmpty) {
                              AppMessenger.showError('Education is required.');
                              return;
                            }

                            final ftStr = heightFtController.text.trim();
                            final inStr = heightInController.text.trim();
                            if (ftStr.isNotEmpty || inStr.isNotEmpty) {
                              final ft = int.tryParse(ftStr);
                              final inch = inStr.isNotEmpty
                                  ? int.tryParse(inStr)
                                  : 0;
                              if (ft == null || ft < 3 || ft > 8) {
                                AppMessenger.showError(
                                  'Height in feet should be between 3 and 8 ft.',
                                );
                                return;
                              }
                              if (inch == null || inch < 0 || inch > 11) {
                                AppMessenger.showError(
                                  'Height in inches should be between 0 and 11 in.',
                                );
                                return;
                              }
                            }

                            String sanitizeSocial(String text) {
                              var s = text.trim();
                              if (s.startsWith('@')) s = s.substring(1).trim();
                              return s;
                            }

                            isSubmitting.value = true;
                            try {
                              String dobString = "";
                              if (selectedDob.value != null) {
                                dobString = AppDateFormatter.toApiDate(
                                  selectedDob.value!,
                                );
                              }
                              if (selectedPhoto.value != null) {
                                await ref
                                    .read(profileControllerProvider.notifier)
                                    .uploadProfilePhoto(
                                      selectedPhoto.value!.path,
                                    );
                              }
                              await ref
                                  .read(profileControllerProvider.notifier)
                                  .updateCoreProfile({
                                    'title': title.value,
                                    'fullName': '$firstName $lastName'.trim(),
                                    'email': email,
                                    'surname': lastName,
                                    'dob': dobString,
                                    'gender': gender.value,
                                    'state': state,
                                    'city': city,
                                    'nativeVillage': village,
                                    'gotra': gotra.value,
                                    'mobileNumber': cleanPhone,
                                    'timeOfBirth': timeOfBirth.isNotEmpty
                                        ? timeOfBirth
                                        : null,
                                    'disability': disabilityController.text
                                        .trim(),
                                    'maternalGotra':
                                        (maternalGotra.value != null &&
                                            maternalGotra.value!
                                                .trim()
                                                .isNotEmpty)
                                        ? maternalGotra.value!.trim()
                                        : null,
                                    'maternalSurname': maternalSurnameController
                                        .text
                                        .trim(),
                                    'manglik': manglik.value,
                                    'address': address,
                                    'bio': bio,
                                    'height': ftStr.isNotEmpty
                                        ? '$ftStr ft ${inStr.isNotEmpty ? inStr : "0"} in'
                                        : null,
                                    'education': education,
                                    'instagram': sanitizeSocial(
                                      instagramController.text,
                                    ),
                                    'facebook': sanitizeSocial(
                                      facebookController.text,
                                    ),
                                    'linkedin': sanitizeSocial(
                                      linkedinController.text,
                                    ),
                                    'twitter': sanitizeSocial(
                                      twitterController.text,
                                    ),
                                  });
                              if (!isEditing) {
                                ref
                                    .read(authControllerProvider.notifier)
                                    .completeOnboarding();
                              }
                              if (context.mounted) {
                                if (isEditing) {
                                  context.pop();
                                } else {
                                  context.go('/home');
                                }
                              }
                            } catch (e) {
                              isSubmitting.value = false;
                              AppMessenger.showException(
                                e,
                                fallbackMessage:
                                    'We couldn\'t save your profile right now. Please try again.',
                              );
                            }
                          },
                          child: TranslatedText(
                            isEditing ? 'Save Changes' : 'Save & Continue ',
                          ),
                        ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String label, bool isActive) {
    return Container(
      margin: EdgeInsets.only(right: 8.w),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: isActive ? AppColors.orangeLight : AppColors.cream,
        border: Border.all(
          color: isActive ? AppColors.orange : AppColors.border,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: TranslatedText(
        label,
        style: TextStyle(
          fontSize: 12.sp,
          color: isActive ? AppColors.orangeDark : AppColors.textDark,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }
}

class _StateAndCitySelector extends HookConsumerWidget {
  final ValueNotifier<String?> selectedState;
  final ValueNotifier<String?> selectedCity;

  const _StateAndCitySelector({
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
    final hasSelectedState =
        currentState != null && currentState.trim().isNotEmpty;
    final citiesAsync = hasSelectedState
        ? ref.watch(citiesListProvider(currentState.trim()))
        : null;

    final states = (statesAsync.value != null && statesAsync.value!.isNotEmpty)
        ? statesAsync.value!
        : _defaultStates;
    final stateItems = {
      ...states,
      if (currentState != null && currentState.isNotEmpty) currentState,
    }.toList()..sort();

    final cities =
        (hasSelectedState &&
            citiesAsync != null &&
            citiesAsync.value != null &&
            citiesAsync.value!.isNotEmpty)
        ? citiesAsync.value!
        : const <String>[];
    final cityItems = {
      ...cities,
      if (currentCity != null && currentCity.isNotEmpty) currentCity,
    }.toList()..sort();

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TranslatedText(
                'State *',
                style: TextStyle(
                  color: AppColors.indigo,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 5.h),
              SearchableDropdownFormField<String>(
                key: ValueKey('state_$currentState'),
                initialValue:
                    (currentState != null && stateItems.contains(currentState))
                    ? currentState
                    : null,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.map_outlined,
                    color: AppColors.indigo,
                  ),
                  suffixIcon: statesAsync.isLoading
                      ? SizedBox(
                          width: 16.w,
                          height: 16.w,
                          child: const Center(
                            child: SizedBox(
                              width: 14,
                              height: 14,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                        )
                      : null,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 12.h,
                  ),
                ),
                items: stateItems
                    .map(
                      (s) => DropdownMenuItem(
                        value: s,
                        child: TranslatedText(
                          s,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (val) {
                  selectedState.value = val;
                  selectedCity.value = null;
                },
                hint: const TranslatedText(
                  'Select State',
                  style: TextStyle(overflow: TextOverflow.ellipsis),
                ),
                isExpanded: true,
              ),
            ],
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TranslatedText(
                'City *',
                style: TextStyle(
                  color: AppColors.indigo,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 5.h),
              SearchableDropdownFormField<String>(
                key: ValueKey('city_${currentState}_$currentCity'),
                initialValue:
                    (hasSelectedState &&
                        currentCity != null &&
                        cityItems.contains(currentCity))
                    ? currentCity
                    : null,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.location_city_rounded,
                    color: AppColors.indigo,
                  ),
                  suffixIcon: (citiesAsync?.isLoading ?? false)
                      ? SizedBox(
                          width: 16.w,
                          height: 16.w,
                          child: const Center(
                            child: SizedBox(
                              width: 14,
                              height: 14,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                        )
                      : null,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 12.h,
                  ),
                ),
                items: cityItems
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
                onChanged: hasSelectedState
                    ? (val) => selectedCity.value = val
                    : null,
                hint: TranslatedText(
                  hasSelectedState ? 'Select City' : 'Select State first',
                  style: const TextStyle(overflow: TextOverflow.ellipsis),
                ),
                isExpanded: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
