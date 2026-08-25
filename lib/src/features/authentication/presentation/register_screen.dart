import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_theme.dart';
import '../../../common_widgets/custom_buttons.dart';
import 'package:community_connect/src/common_widgets/translated_text.dart';
import '../../../common_widgets/custom_inputs.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import '../../profile/data/profile_provider.dart';
import '../../authentication/data/auth_provider.dart';

class RegisterScreen extends HookConsumerWidget {
  final bool isEditing;
  const RegisterScreen({super.key, this.isEditing = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstNameController = useTextEditingController();
    final lastNameController = useTextEditingController();
    final selectedDob = useState<DateTime?>(null);
    final selectedPhoto = useState<File?>(null);
    final cityController = useTextEditingController();
    final villageController = useTextEditingController();
    
    final gender = useState('Male');
    final gotra = useState<String?>(null);
    final isSubmitting = useState<bool>(false);

    final profileState = ref.watch(profileControllerProvider);
    final profileData = profileState.value?.profile;

    useEffect(() {
      if (isEditing && profileState.value != null && profileState.value!.profile != null) {
        final core = profileState.value!.profile!;
        final names = core.fullName?.split(' ') ?? [];
        if (names.isNotEmpty) {
          firstNameController.text = names.first;
          if (names.length > 1) {
            lastNameController.text = names.sublist(1).join(' ');
          }
        }
        if (core.dob != null && core.dob!.isNotEmpty) {
           try {
             selectedDob.value = DateTime.parse(core.dob!);
           } catch (e) {
             // Ignore parsing error
           }
        }
        gender.value = core.gender ?? 'Male';
        cityController.text = core.city ?? '';
        villageController.text = core.nativeVillage ?? '';
        
        final existingGotra = core.gotra;
        if (['Kashyap', 'Bharadwaj', 'Vashisht', 'Atri'].contains(existingGotra)) {
          gotra.value = existingGotra;
        }
      }
      return null;
    }, const []);

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 36),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.orange, AppColors.orangeDark],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
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
                const SizedBox(height: 16),
                TranslatedText(
                  isEditing ? 'Edit Profile' : 'Complete Your Profile',
                  style: Theme.of(
                    context,
                  ).textTheme.displayMedium?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 4),
                TranslatedText(
                  isEditing ? 'Update your personal details' : 'Tell your community about yourself',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.75),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: () async {
                        final picker = ImagePicker();
                        final image = await picker.pickImage(source: ImageSource.gallery);
                        if (image != null) {
                          selectedPhoto.value = File(image.path);
                        }
                      },
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: AppColors.orangeLight,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.orange,
                            width: 2,
                            style: BorderStyle.solid,
                          ),
                          image: selectedPhoto.value != null
                              ? DecorationImage(
                                  image: FileImage(selectedPhoto.value!),
                                  fit: BoxFit.cover,
                                )
                              : (profileData?.profilePhotoUrl != null
                                  ? DecorationImage(
                                      image: NetworkImage(profileData!.profilePhotoUrl!),
                                      fit: BoxFit.cover,
                                    )
                                  : null),
                        ),
                        child: selectedPhoto.value == null && profileData?.profilePhotoUrl == null
                            ? const Center(
                                child: TranslatedText('📷', style: TextStyle(fontSize: 28)),
                              )
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TranslatedText(
                              'First Name',
                              style: TextStyle(
                                color: AppColors.indigo,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 5),
                            TextField(
                              controller: firstNameController,
                              decoration: const InputDecoration(
                                hintText: 'e.g. Ravi',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TranslatedText(
                              'Last Name',
                              style: TextStyle(
                                color: AppColors.indigo,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 5),
                            TextField(
                              controller: lastNameController,
                              decoration: const InputDecoration(
                                hintText: 'e.g. Patil',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  CustomDatePickerField(
                    label: 'Date of Birth',
                    selectedDate: selectedDob.value,
                    onDateSelected: (date) => selectedDob.value = date,
                  ),
                  const SizedBox(height: 14),
                  const TranslatedText(
                    'Gender',
                    style: TextStyle(
                      color: AppColors.indigo,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      GestureDetector(onTap: () => gender.value = 'Male', child: _buildChip('Male', gender.value == 'Male')),
                      GestureDetector(onTap: () => gender.value = 'Female', child: _buildChip('Female', gender.value == 'Female')),
                      GestureDetector(onTap: () => gender.value = 'Other', child: _buildChip('Other', gender.value == 'Other')),
                    ],
                  ),
                  const SizedBox(height: 14),
                  const TranslatedText(
                    'City',
                    style: TextStyle(
                      color: AppColors.indigo,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextField(
                    controller: cityController,
                    decoration: const InputDecoration(hintText: 'e.g. Surat'),
                  ),
                  const SizedBox(height: 14),
                  const TranslatedText(
                    'Native Village',
                    style: TextStyle(
                      color: AppColors.indigo,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextField(
                    controller: villageController,
                    decoration: const InputDecoration(hintText: 'e.g. Valsad'),
                  ),
                  const SizedBox(height: 14),
                  const TranslatedText(
                    'Gotra',
                    style: TextStyle(
                      color: AppColors.indigo,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  DropdownButton<String>(isExpanded: true,
                    
                    value: gotra.value,
                    items: const [
                      DropdownMenuItem(
                        value: 'Kashyap',
                        child: TranslatedText('Kashyap'),
                      ),
                      DropdownMenuItem(
                        value: 'Bharadwaj',
                        child: TranslatedText('Bharadwaj'),
                      ),
                      DropdownMenuItem(
                        value: 'Vashisht',
                        child: TranslatedText('Vashisht'),
                      ),
                      DropdownMenuItem(value: 'Atri', child: TranslatedText('Atri')),
                    ],
                    onChanged: (v) => gotra.value = v,
                    hint: const TranslatedText('Select Gotra'),
                  ),

                  const SizedBox(height: 24),
                  (profileState.isLoading || isSubmitting.value) 
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                    onPressed: () async {
                      isSubmitting.value = true;
                      try {
                        String dobString = "";
                        if (selectedDob.value != null) {
                          dobString = "${selectedDob.value!.year.toString().padLeft(4, '0')}-${selectedDob.value!.month.toString().padLeft(2, '0')}-${selectedDob.value!.day.toString().padLeft(2, '0')}";
                        }
                        if (selectedPhoto.value != null) {
                          await ref.read(profileControllerProvider.notifier).uploadProfilePhoto(selectedPhoto.value!.path);
                        }
                        await ref.read(profileControllerProvider.notifier).updateCoreProfile({
                          'fullName': '${firstNameController.text} ${lastNameController.text}'.trim(),
                          'surname': lastNameController.text.trim(),
                          'dob': dobString,
                          'gender': gender.value,
                          'city': cityController.text,
                          'nativeVillage': villageController.text,
                          'gotra': gotra.value,
                        });
                        if (context.mounted) {
                          if (isEditing) {
                            context.pop();
                          } else {
                            context.go('/pending_verification');
                          }
                        }
                      } catch (e) {
                        if (context.mounted) {
                          String message = 'Failed to update profile';
                          if (e is DioException && e.response?.data != null) {
                            message = e.response!.data['message'] ?? message;
                            final errors = e.response!.data['errors'] as List<dynamic>?;
                            if (errors != null && errors.isNotEmpty) {
                              message = errors.map((e) => "${e['field']}: ${e['message']}").join(', ');
                            }
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(message)),
                          );
                        }
                      }
                    },
                    child: TranslatedText(isEditing ? 'Save Changes' : 'Save & Continue '),
                  ),
                  const SizedBox(height: 20),
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
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isActive ? AppColors.orangeLight : AppColors.cream,
        border: Border.all(
          color: isActive ? AppColors.orange : AppColors.border,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TranslatedText(
        label,
        style: TextStyle(
          fontSize: 12,
          color: isActive ? AppColors.orangeDark : AppColors.textDark,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }
}
