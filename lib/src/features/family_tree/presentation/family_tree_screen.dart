import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../theme/app_theme.dart';
import 'package:community_connect/src/common_widgets/translated_text.dart';
import '../../../utils/app_messenger.dart';
import '../data/family_provider.dart';
import '../data/family_models.dart';
import '../data/family_tree_mock.dart';
import '../data/kinship_engine.dart';
import 'widgets/family_tree_canvas.dart';
import 'widgets/family_stats_sheet.dart';
import 'widgets/kinship_path_sheet.dart';
import '../../profile/data/profile_provider.dart';
import 'package:community_connect/src/utils/responsive_ext.dart';
import 'package:dio/dio.dart';

class FamilyTreeScreen extends HookConsumerWidget {
  const FamilyTreeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final treeMode = useState<String>('live');

    final treeState = ref.watch(familyControllerProvider);
    final currentUserId = ref.watch(
      profileControllerProvider.select((p) => p.value?.id),
    );
    final activeTree = treeMode.value == 'patel'
        ? AsyncValue.data(FamilyTreeMock.createPatelFamilyTree())
        : treeMode.value == 'test_15'
        ? AsyncValue.data(FamilyTreeMock.create5GenerationTree())
        : treeMode.value == 'test_full'
        ? AsyncValue.data(FamilyTreeMock.createExtendedFullFamilyTree())
        : treeState;

    final surname = ref.watch(
      profileControllerProvider.select((p) => p.value?.profile?.surname),
    );
    final familyName = surname != null && surname.isNotEmpty
        ? '$surname Parivar'
        : 'Family Tree';

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TranslatedText(
                          familyName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: AppColors.textMuted,
                          ),
                        ),
                        TranslatedText(
                          'Family Tree',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.displaySmall
                              ?.copyWith(
                                fontSize: 20.sp,
                                color: AppColors.indigo,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      // Quick Switcher Button for testing
                      // InkWell(
                      //   onTap: () {
                      //     if (treeMode.value == 'live') {
                      //       treeMode.value = 'patel';
                      //       AppMessenger.showInfo(
                      //         'Loaded Patel Family Tree (Canonical Architecture Spec)!',
                      //       );
                      //     } else if (treeMode.value == 'patel') {
                      //       treeMode.value = 'test_15';
                      //       AppMessenger.showInfo(
                      //         'Loaded 5-Generation Test Tree with 15 Members!',
                      //       );
                      //     } else if (treeMode.value == 'test_15') {
                      //       treeMode.value = 'test_full';
                      //       AppMessenger.showInfo(
                      //         'Loaded Full Extended Tree with 36 Members & Spouses!',
                      //       );
                      //     } else {
                      //       treeMode.value = 'live';
                      //       AppMessenger.showInfo(
                      //         'Switched to Live Family Tree.',
                      //       );
                      //     }
                      //   },
                      //   borderRadius: BorderRadius.circular(12.r),
                      //   child: Container(
                      //     padding: EdgeInsets.symmetric(
                      //       horizontal: 8.w,
                      //       vertical: 6.h,
                      //     ),
                      //     decoration: BoxDecoration(
                      //       color: treeMode.value != 'live'
                      //           ? AppColors.orangeLight
                      //           : AppColors.cream,
                      //       borderRadius: BorderRadius.circular(12.r),
                      //       border: Border.all(
                      //         color: treeMode.value != 'live'
                      //             ? AppColors.orange
                      //             : AppColors.border,
                      //       ),
                      //     ),
                      //     child: Row(
                      //       mainAxisSize: MainAxisSize.min,
                      //       children: [
                      //         Icon(
                      //           treeMode.value != 'live'
                      //               ? Icons.science
                      //               : Icons.science_outlined,
                      //           size: 14.sp,
                      //           color: treeMode.value != 'live'
                      //               ? AppColors.orange
                      //               : AppColors.textMuted,
                      //         ),
                      //         SizedBox(width: 4.w),
                      //         Text(
                      //           treeMode.value == 'patel'
                      //               ? 'Patel Spec'
                      //               : treeMode.value == 'test_15'
                      //               ? '15-Gen Test'
                      //               : treeMode.value == 'test_full'
                      //               ? '36-Member Test'
                      //               : 'Test Tree',
                      //           style: TextStyle(
                      //             fontSize: 11.sp,
                      //             fontWeight: FontWeight.bold,
                      //             color: treeMode.value != 'live'
                      //                 ? AppColors.orange
                      //                 : AppColors.textMuted,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      SizedBox(width: 6.w),
                      IconButton(
                        icon: Icon(
                          Icons.refresh,
                          size: 20.sp,
                          color: AppColors.textDark,
                        ),
                        tooltip: 'Refresh Tree',
                        onPressed: () {
                          if (treeMode.value != 'live') {
                            treeMode.value = 'live';
                          }
                          ref.read(familyControllerProvider.notifier).refresh();
                          AppMessenger.showInfo('Refreshing family tree...');
                        },
                      ),
                      // PopupMenuButton<String>(
                      //   icon: const Icon(
                      //     Icons.more_vert,
                      //     color: AppColors.textDark,
                      //   ),
                      //   onSelected: (value) {
                      //     if (value == 'stats') {
                      //       _showStatsDialog(context, activeTree.value);
                      //     }
                      //     if (value == 'path') {
                      //       _showPathFinderDialog(context, activeTree.value);
                      //     }
                      //   },
                      //   itemBuilder: (context) => [
                      //     const PopupMenuItem(
                      //       value: 'stats',
                      //       child: TranslatedText('Family Statistics'),
                      //     ),
                      //     const PopupMenuItem(
                      //       value: 'path',
                      //       child: TranslatedText(
                      //         'Relationship Path & Kinship',
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(width: 6.w),
                      GestureDetector(
                        onTap: () => _showAddMemberOptions(context),
                        child: Container(
                          width: 38.r,
                          height: 38.r,
                          decoration: BoxDecoration(
                            color: AppColors.orange,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.add_rounded,
                            size: 20.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Expanded(
              child: activeTree.when(
                skipLoadingOnReload: true,
                skipLoadingOnRefresh: true,
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) {
                  String errorMessage = 'Error loading family tree';
                  try {
                    if (error is DioException && error.response?.data != null) {
                      final data = error.response!.data;
                      if (data is Map && data['message'] != null) {
                        errorMessage = data['message'];
                      }
                    }
                  } catch (_) {}
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TranslatedText(
                          errorMessage,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.textMuted,
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        ElevatedButton.icon(
                          onPressed: () {
                            ref
                                .read(familyControllerProvider.notifier)
                                .refresh();
                          },
                          icon: Icon(Icons.refresh, size: 16.sp),
                          label: TranslatedText(
                            'Retry',
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                data: (treeNode) {
                  if (treeNode == null) {
                    return Center(
                      child: Text(
                        'No family data. Click + to Add Member.',
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    );
                  }

                  return FamilyTreeCanvas(
                    rootNode: treeNode,
                    currentUserId: currentUserId,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddMemberOptions(BuildContext context) {
    context.push('/add_family');
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
    final isDeceasedFn = (FamilyTreeNode n) =>
        n.isDeceased == true ||
        (n.title != null && n.title!.toLowerCase() == 'late');
    final livingMembers = allNodes.where((n) => !isDeceasedFn(n)).length;
    final deceasedMembers = allNodes.where((n) => isDeceasedFn(n)).length;
    final linkedMembers = allNodes
        .where(
          (n) =>
              n.isRegisteredUser == true ||
              (n.linkedUserId != null && n.linkedUserId!.isNotEmpty),
        )
        .length;

    // Generational breakdown
    final Map<int, List<FamilyTreeNode>> genMap = {};
    for (final node in allNodes) {
      final rel =
          node.directRelationship ?? node.relationshipType ?? 'Relative';
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
      AppMessenger.showInfo('Add more family members to trace kinship paths.');
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) =>
          KinshipPathSheet(root: root, otherMembers: otherMembers),
    );
  }
}
