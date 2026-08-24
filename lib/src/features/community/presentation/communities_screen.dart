import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../theme/app_theme.dart';
import '../../../common_widgets/custom_buttons.dart';
import '../../../common_widgets/custom_inputs.dart';
import 'package:community_connect/src/common_widgets/translated_text.dart';
import '../data/community_provider.dart';

class CommunitiesScreen extends HookConsumerWidget {
  const CommunitiesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final membershipsState = ref.watch(myCommunitiesControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: CustomBackButton(onPressed: () => context.pop()),
        title: const TranslatedText(
          'My Communities',
          style: TextStyle(
            color: AppColors.indigo,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: membershipsState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (communities) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: communities.isEmpty
                      ? const Center(
                          child: TranslatedText('You are not part of any communities yet.'),
                        )
                      : ListView.separated(
                          itemCount: communities.length,
                          separatorBuilder: (context, index) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final comm = communities[index];
                            return Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppColors.border),
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: AppColors.indigoLight,
                                    backgroundImage: comm.logoUrl != null ? NetworkImage(comm.logoUrl!) : null,
                                    child: comm.logoUrl == null ? const Icon(Icons.group, color: AppColors.indigo) : null,
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        TranslatedText(
                                          comm.name ?? 'Unknown Community',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        if (comm.description != null)
                                          TranslatedText(
                                            comm.description!,
                                            style: const TextStyle(
                                              color: AppColors.textMuted,
                                              fontSize: 12,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
                const SizedBox(height: 16),
                PrimaryButton(
                  text: 'Join via Invite Code',
                  onPressed: () => _showJoinDialog(context, ref),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showJoinDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) {
        return _JoinCommunityDialog();
      },
    );
  }
}

class _JoinCommunityDialog extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final isLoading = useState(false);

    return AlertDialog(
      title: const TranslatedText('Join Community'),
      content: CustomInputField(
        controller: controller,
        label: 'Invite Code',
        hintText: 'Enter code here',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const TranslatedText('Cancel', style: TextStyle(color: AppColors.textMuted)),
        ),
        isLoading.value
            ? const CircularProgressIndicator()
            : TextButton(
                onPressed: () async {
                  if (controller.text.isEmpty) return;
                  isLoading.value = true;
                  try {
                    await ref.read(myCommunitiesControllerProvider.notifier).joinCommunity(controller.text);
                    if (context.mounted) Navigator.pop(context);
                  } catch (e) {
                    isLoading.value = false;
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                  }
                },
                child: const TranslatedText('Join', style: TextStyle(color: AppColors.orange, fontWeight: FontWeight.bold)),
              ),
      ],
    );
  }
}
