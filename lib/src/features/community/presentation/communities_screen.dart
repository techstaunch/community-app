import 'package:flutter/material.dart';
import 'package:community_connect/src/common_widgets/app_avatar.dart';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../theme/app_theme.dart';
import '../../../common_widgets/custom_buttons.dart';
import 'package:community_connect/src/common_widgets/translated_text.dart';
import 'package:community_connect/src/utils/responsive_ext.dart';
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
        title: TranslatedText(
          'My Communities',
          style: TextStyle(
            color: AppColors.indigo,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: membershipsState.when(
        skipLoadingOnReload: true,
        skipLoadingOnRefresh: true,
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) {
          String errorMessage = 'Failed to load communities.';
          if (error is DioException && error.response?.data != null && error.response!.data is Map) {
            errorMessage = error.response!.data['message'] ?? errorMessage;
          }
          return Center(
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: Text(
                errorMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        },
        data: (communities) {
          return Padding(
            padding: EdgeInsets.all(20.w),
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
                          separatorBuilder: (context, index) => SizedBox(height: 12.h),
                          itemBuilder: (context, index) {
                            final comm = communities[index];
                            return InkWell(
                              onTap: () {
                                if (comm.id != null) {
                                  context.push('/community_detail/${comm.id}?name=${Uri.encodeComponent(comm.name ?? "Community")}');
                                }
                              },
                              borderRadius: BorderRadius.circular(12.r),
                              child: Container(
                                padding: EdgeInsets.all(16.w),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(color: AppColors.border),
                                ),
                                child: Row(
                                  children: [
                                    AppAvatar(
                                      imageUrl: comm.logoUrl,
                                      size: 40.r,
                                      fallbackWidget: const CircleAvatar(
                                        backgroundColor: AppColors.indigoLight,
                                        child: Icon(Icons.group, color: AppColors.indigo),
                                      ),
                                    ),
                                    SizedBox(width: 16.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          TranslatedText(
                                            comm.name ?? 'Unknown Community',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.sp,
                                            ),
                                          ),
                                          if (comm.description != null)
                                            TranslatedText(
                                              comm.description!,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: AppColors.textMuted,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
                // const SizedBox(height: 16),
                // PrimaryButton(
                //   text: 'Join via Invite Code',
                //   onPressed: () => _showJoinDialog(context, ref),
                // ),
              ],
            ),
          );
        },
      ),
    );
  }

  // void _showJoinDialog(BuildContext context, WidgetRef ref) { ... }
}

/*
  void _showJoinDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) {
        return _JoinCommunityDialog();
      },
    );
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
                  final code = controller.text.trim();
                  if (code.isEmpty) {
                    AppMessenger.showError('Please enter an invite code.');
                    return;
                  }
                  isLoading.value = true;
                  try {
                    await ref.read(myCommunitiesControllerProvider.notifier).joinCommunity(code);
                    if (context.mounted) Navigator.pop(context);
                  } on DioException catch (e) {
                    isLoading.value = false;
                    AppMessenger.showException(e, fallbackMessage: 'We couldn\'t join the community right now. Please try again.');
                  } catch (e) {
                    isLoading.value = false;
                    AppMessenger.showError('Something unexpected happened while joining. Please try again.');
                  }
                },
                child: const TranslatedText('Join', style: TextStyle(color: AppColors.orange, fontWeight: FontWeight.bold)),
              ),
      ],
    );
  }
}

*/
