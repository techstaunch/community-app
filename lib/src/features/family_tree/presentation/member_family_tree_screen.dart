import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/app_messenger.dart';
import '../../../common_widgets/translated_text.dart';
import '../../profile/data/profile_provider.dart';
import '../data/family_models.dart';
import '../data/family_provider.dart';
import '../data/kinship_engine.dart';
import 'widgets/family_tree_canvas.dart';
import 'widgets/family_stats_sheet.dart';
import 'widgets/kinship_path_sheet.dart';
import 'package:community_connect/src/utils/responsive_ext.dart';
import 'package:dio/dio.dart';

class MemberFamilyTreeScreen extends ConsumerWidget {
  final String userId;
  final String? userName;

  const MemberFamilyTreeScreen({
    super.key,
    required this.userId,
    this.userName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final treeAsync = ref.watch(memberFamilyTreeProvider(userId));
    final currentUserId = ref.watch(profileControllerProvider.select((p) => p.value?.id));

    final displayName = (userName != null && userName!.trim().isNotEmpty)
        ? userName!.trim()
        : 'Member';

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar
            Container(
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 12.h),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: AppColors.border)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () => context.pop(),
                          borderRadius: BorderRadius.circular(12.r),
                          child: Container(
                            padding: EdgeInsets.all(8.r),
                            decoration: BoxDecoration(
                              color: AppColors.cream,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Icon(
                              Icons.arrow_back,
                              size: 18.sp,
                              color: AppColors.textDark,
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TranslatedText(
                                '$displayName\'s Family',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: AppColors.textMuted,
                                ),
                              ),
                              TranslatedText(
                                '$displayName\'s Family Tree',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall
                                    ?.copyWith(
                                      fontSize: 17.sp,
                                      color: AppColors.indigo,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.refresh, size: 20.sp, color: AppColors.textDark),
                        tooltip: 'Refresh Tree',
                        onPressed: () {
                          ref.invalidate(memberFamilyTreeProvider(userId));
                          AppMessenger.showInfo('Refreshing family tree...');
                        },
                      ),
                      PopupMenuButton<String>(
                        icon: const Icon(
                          Icons.more_vert,
                          color: AppColors.textDark,
                        ),
                        onSelected: (value) {
                          final treeNode = treeAsync.value;
                          if (value == 'stats') {
                            _showStatsDialog(context, treeNode);
                          }
                          if (value == 'path') {
                            _showPathFinderDialog(context, treeNode);
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'stats',
                            child: TranslatedText('Family Statistics'),
                          ),
                          const PopupMenuItem(
                            value: 'path',
                            child: TranslatedText('Find Relationship Path'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Canvas / Content
            Expanded(
              child: treeAsync.when(
                skipLoadingOnReload: true,
                skipLoadingOnRefresh: true,
                loading: () => const Center(
                  child: CircularProgressIndicator(color: AppColors.orange),
                ),
                error: (error, stack) {
                  String errorMessage = 'Failed to load $displayName\'s family tree.';
                  try {
                    if (error is DioException && error.response?.data != null) {
                      final data = error.response!.data;
                      if (data is Map && data['message'] != null) {
                        errorMessage = data['message'];
                      }
                    }
                  } catch (_) {}
                  return Center(
                  child: Padding(
                    padding: EdgeInsets.all(24.r),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 48.sp,
                          color: AppColors.textMuted,
                        ),
                        SizedBox(height: 12.h),
                        TranslatedText(
                          errorMessage,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.textDark,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        ElevatedButton.icon(
                          onPressed: () =>
                              ref.invalidate(memberFamilyTreeProvider(userId)),
                          icon: Icon(Icons.refresh, size: 18.sp),
                          label: TranslatedText('Retry', style: TextStyle(fontSize: 14.sp)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.orange,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
                },
                data: (treeNode) {
                  if (treeNode == null) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(24.r),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.account_tree_outlined,
                              size: 48.sp,
                              color: AppColors.textMuted,
                            ),
                            SizedBox(height: 12.h),
                            TranslatedText(
                              'No family tree data available for $displayName.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return FamilyTreeCanvas(
                    rootNode: treeNode,
                    currentUserId: currentUserId,
                    focusUserId: userId,
                    isEditable: false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<FamilyTreeNode> _collectAllNodes(FamilyTreeNode root) {
    final list = <FamilyTreeNode>[];
    final visited = <String>{};

    void traverse(FamilyTreeNode node) {
      final key = node.id ?? node.fullName ?? node.hashCode.toString();
      if (visited.contains(key)) return;
      visited.add(key);
      list.add(node);

      for (final p in node.parents) {
        traverse(p);
      }
      for (final sp in node.spouses) {
        traverse(sp);
      }
      for (final s in node.siblings) {
        traverse(s);
      }
      for (final c in node.children) {
        traverse(c);
      }
    }

    traverse(root);
    return list;
  }

  void _showStatsDialog(BuildContext context, FamilyTreeNode? tree) {
    if (tree == null) {
      AppMessenger.showInfo('No family tree loaded.');
      return;
    }

    final allNodes = _collectAllNodes(tree);
    final totalMembers = allNodes.length;
    final isDeceasedFn = (FamilyTreeNode n) => n.isDeceased == true || (n.title != null && n.title!.toLowerCase() == 'late');
    final livingMembers = allNodes.where((n) => !isDeceasedFn(n)).length;
    final deceasedMembers = allNodes.where((n) => isDeceasedFn(n)).length;
    final linkedMembers = allNodes
        .where((n) =>
            n.isRegisteredUser == true ||
            (n.linkedUserId != null && n.linkedUserId!.isNotEmpty))
        .length;

    final Map<int, List<FamilyTreeNode>> genMap = {};
    for (final node in allNodes) {
      final rel = node.directRelationship ?? node.relationshipType ?? 'Relative';
      final level = KinshipEngine.getGenerationalLevel(rel);
      genMap.putIfAbsent(level, () => []).add(node);
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => FamilyStatsSheet(
        totalMembers: totalMembers,
        livingMembers: livingMembers,
        deceasedMembers: deceasedMembers,
        linkedMembers: linkedMembers,
        genMap: genMap,
      ),
    );
  }

  void _showPathFinderDialog(BuildContext context, FamilyTreeNode? root) {
    if (root == null) {
      AppMessenger.showInfo('No family tree loaded.');
      return;
    }

    final allNodes = _collectAllNodes(root);
    final otherMembers = allNodes.where((n) => n.id != root.id).toList();

    if (otherMembers.isEmpty) {
      AppMessenger.showInfo('Not enough members to trace kinship paths.');
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => KinshipPathSheet(
        root: root,
        otherMembers: otherMembers,
      ),
    );
  }
}
