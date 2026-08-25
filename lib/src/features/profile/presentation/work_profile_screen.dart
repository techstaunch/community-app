import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_theme.dart';
import 'package:community_connect/src/common_widgets/translated_text.dart';
import '../data/profile_provider.dart';

class WorkProfileScreen extends HookConsumerWidget {
  final bool? initialIsBusiness;
  const WorkProfileScreen({super.key, this.initialIsBusiness});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isBusiness = useState(initialIsBusiness ?? false);
    
    // Job Controllers
    final jobTitleController = useTextEditingController();
    final companyController = useTextEditingController();
    final industryController = useTextEditingController();
    final experienceController = useTextEditingController();

    // Business Controllers
    final businessNameController = useTextEditingController();
    final businessTypeController = useTextEditingController();
    final productsController = useTextEditingController();
    final addressController = useTextEditingController();

    final profileState = ref.watch(profileControllerProvider);
    
    useEffect(() {
      if (profileState.value != null) {
        final job = profileState.value!.job;
        final business = profileState.value!.business;
        
        if (business != null && business.id != null) {
          businessNameController.text = business.businessName ?? '';
          businessTypeController.text = business.category ?? '';
          productsController.text = business.productsServices ?? '';
          addressController.text = business.address ?? '';
          if (initialIsBusiness == null && job == null) isBusiness.value = true;
        }
        
        if (job != null && job.id != null) {
          jobTitleController.text = job.designation ?? '';
          companyController.text = job.companyName ?? '';
          industryController.text = job.industry ?? '';
          experienceController.text = job.yearsOfExperience?.toString() ?? '';
          if (initialIsBusiness == null && business == null) isBusiness.value = false;
        }
      }
      return null;
    }, const []);

    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        title: TranslatedText((profileState.value?.job != null || profileState.value?.business != null) ? 'Edit Work Profile' : 'Add Work Profile', style: const TextStyle(color: AppColors.textDark)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => isBusiness.value = false,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: !isBusiness.value ? AppColors.orangeLight : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: !isBusiness.value ? AppColors.orange : AppColors.border),
                      ),
                      alignment: Alignment.center,
                      child: TranslatedText('Employee / Job', style: TextStyle(color: !isBusiness.value ? AppColors.orangeDark : AppColors.textMid, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () => isBusiness.value = true,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: isBusiness.value ? AppColors.indigoLight : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: isBusiness.value ? AppColors.indigo : AppColors.border),
                      ),
                      alignment: Alignment.center,
                      child: TranslatedText('Business Owner', style: TextStyle(color: isBusiness.value ? AppColors.indigo : AppColors.textMid, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            if (!isBusiness.value) ...[
              _buildField('Job Title / Designation', 'e.g. Software Engineer', jobTitleController),
              _buildField('Company Name', 'e.g. Tata Consultancy Services', companyController),
              _buildField('Industry', 'e.g. Information Technology', industryController),
              _buildField('Experience (Years)', 'e.g. 4', experienceController),
            ] else ...[
              _buildField('Business Name', 'e.g. TechSoft Solutions', businessNameController),
              _buildField('Business Type', 'e.g. B2B / IT Services', businessTypeController),
              _buildField('Products / Services', 'e.g. Web Development, SEO', productsController),
              _buildField('Office Address / City', 'e.g. Surat, Gujarat', addressController),
            ],

            const SizedBox(height: 32),
            profileState.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: () async {
                      try {
                        if (isBusiness.value) {
                          await ref.read(profileControllerProvider.notifier).updateBusinessDetails({
                            'businessName': businessNameController.text,
                            'category': businessTypeController.text,
                            'productsServices': productsController.text,
                            'address': addressController.text,
                          });
                        } else {
                          await ref.read(profileControllerProvider.notifier).updateJobDetails({
                            'designation': jobTitleController.text,
                            'companyName': companyController.text,
                            'industry': industryController.text,
                            'yearsOfExperience': int.tryParse(experienceController.text) ?? 0,
                          });
                        }
                        if (context.mounted) {
                          context.pop();
                        }
                      } catch (e) {
                        if (context.mounted) {
                          String message = 'Failed to update';
                          if (e is DioException && e.response?.data != null) {
                            message = e.response!.data['message'] ?? message;
                          }
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
                        }
                      }
                    },
                    child: const TranslatedText('Save Work Profile'),
                  ),
            const SizedBox(height: 12),
            if (!profileState.isLoading && (
              (!isBusiness.value && profileState.value?.job != null && profileState.value!.job!.id != null) ||
              (isBusiness.value && profileState.value?.business != null && profileState.value!.business!.id != null)
            ))
              TextButton(
                onPressed: () async {
                  try {
                    if (isBusiness.value) {
                      await ref.read(profileControllerProvider.notifier).deleteBusinessDetails();
                    } else {
                      await ref.read(profileControllerProvider.notifier).deleteJobDetails();
                    }
                    if (context.mounted) {
                      context.pop();
                    }
                  } catch (e) {
                    if (context.mounted) {
                      String message = 'Failed to delete';
                      if (e is DioException && e.response?.data != null) {
                        message = e.response!.data['message'] ?? message;
                      }
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
                    }
                  }
                },
                child: const TranslatedText(
                  'Delete Work Profile',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TranslatedText(label, style: const TextStyle(color: AppColors.indigo, fontSize: 12, fontWeight: FontWeight.w600)),
          const SizedBox(height: 5),
          TextField(controller: controller, decoration: InputDecoration(hintText: hint)),
        ],
      ),
    );
  }
}
