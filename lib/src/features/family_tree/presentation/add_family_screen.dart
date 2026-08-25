import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../theme/app_theme.dart';
import '../../../common_widgets/custom_buttons.dart';
import '../../../common_widgets/custom_inputs.dart';
import 'package:community_connect/src/common_widgets/translated_text.dart';
import '../data/family_provider.dart';

class AddFamilyScreen extends HookConsumerWidget {
  const AddFamilyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final selectedDob = useState<DateTime?>(null);
    final mobileController = useTextEditingController();
    final relation = useState<String?>(null);
    final gender = useState<String>('Male');
    final isLinked = useState(false);
    final isLoading = ref.watch(familyControllerProvider).isLoading;

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: Column(
          children: [
            // Top Section
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: AppColors.border)),
              ),
              child: Row(
                children: [
                  CustomBackButton(onPressed: () => context.pop()),
                  const SizedBox(width: 14),
                  TranslatedText(
                    'Add Family Member',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontSize: 18,
                          color: AppColors.indigo,
                        ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Link to profile card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: const BoxDecoration(
                              color: AppColors.indigoLight,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.link,
                                color: AppColors.indigo, size: 24),
                          ),
                          const SizedBox(width: 16),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TranslatedText(
                                  'Link to existing profile?',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textDark,
                                  ),
                                ),
                                SizedBox(height: 4),
                                TranslatedText(
                                  'Send a connection request to an existing app member',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Switch(
                            value: isLinked.value,
                            onChanged: (v) => isLinked.value = v,
                            activeThumbColor: AppColors.orange,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    CustomInputField(
                      controller: nameController,
                      label: 'Full Name',
                      hintText: 'e.g. Suresh Patil',
                    ),
                    const SizedBox(height: 16),

                    if (isLinked.value) ...[
                      CustomInputField(
                        controller: mobileController,
                        label: 'Linked Mobile Number',
                        hintText: 'e.g. +919876543210',
                      ),
                      const SizedBox(height: 16),
                    ],

                    const TranslatedText(
                      'Relation',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      initialValue: relation.value,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.border),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.border),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: AppColors.orange, width: 2),
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(
                            value: 'Father', child: TranslatedText('Father')),
                        DropdownMenuItem(
                            value: 'Mother', child: TranslatedText('Mother')),
                        DropdownMenuItem(
                            value: 'Spouse', child: TranslatedText('Spouse')),
                        DropdownMenuItem(
                            value: 'Child', child: TranslatedText('Child')),
                        DropdownMenuItem(
                            value: 'Sibling', child: TranslatedText('Sibling')),
                      ],
                      onChanged: (v) => relation.value = v,
                      hint: const TranslatedText('Select Relation',
                          style: TextStyle(
                              color: AppColors.textMuted, fontSize: 14)),
                    ),
                    const SizedBox(height: 16),

                    const TranslatedText(
                      'Gender',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      initialValue: gender.value,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.border),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.border),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: AppColors.orange, width: 2),
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(value: 'Male', child: TranslatedText('Male')),
                        DropdownMenuItem(value: 'Female', child: TranslatedText('Female')),
                      ],
                      onChanged: (v) => gender.value = v!,
                    ),
                    const SizedBox(height: 16),

                    CustomDatePickerField(
                      label: 'Date of Birth (Optional)',
                      hintText: 'YYYY-MM-DD',
                      selectedDate: selectedDob.value,
                      onDateSelected: (date) => selectedDob.value = date,
                      lastDate: DateTime.now(), // Can't be born in the future
                    ),

                    const SizedBox(height: 32),
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : PrimaryButton(
                            text: 'Save & Add',
                            onPressed: () async {
                              if (nameController.text.isEmpty || relation.value == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Please fill name and relation')),
                                );
                                return;
                              }
                              await ref.read(familyControllerProvider.notifier).addFamilyMember({
                                'fullName': nameController.text,
                                'gender': gender.value,
                                'relationshipType': relation.value,
                                'dob': selectedDob.value != null ? "${selectedDob.value!.year}-${selectedDob.value!.month.toString().padLeft(2, '0')}-${selectedDob.value!.day.toString().padLeft(2, '0')}" : null,
                                'isDeceased': false, // Add UI for this if needed
                                'linkedMobile': isLinked.value ? mobileController.text : null,
                              });
                              if (context.mounted) {
                                context.pop();
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
