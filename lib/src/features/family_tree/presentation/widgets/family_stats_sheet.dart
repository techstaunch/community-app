import 'package:flutter/material.dart';
import '../../../../theme/app_theme.dart';
import '../../../../common_widgets/translated_text.dart';
import '../../data/family_models.dart';
import 'package:community_connect/src/utils/responsive_ext.dart';

class FamilyStatsSheet extends StatelessWidget {
  final int totalMembers;
  final int livingMembers;
  final int deceasedMembers;
  final int linkedMembers;
  final Map<int, List<FamilyTreeNode>> genMap;

  const FamilyStatsSheet({
    super.key,
    required this.totalMembers,
    required this.livingMembers,
    required this.deceasedMembers,
    required this.linkedMembers,
    required this.genMap,
  });

  String _getGenTitle(int level) {
    switch (level) {
      case 3:
        return 'Level +3: Great-Grandparents';
      case 2:
        return 'Level +2: Grandparents (Dada, Dadi)';
      case 1:
        return 'Level +1: Parents & In-laws (Father, Mother, Kaka, etc.)';
      case 0:
        return 'Level 0: Peer Generation (Self, Spouse, Siblings, Cousins)';
      case -1:
        return 'Level -1: Children & In-laws (Son, Daughter, etc.)';
      case -2:
        return 'Level -2: Grandchildren (Pota, Poti)';
      case -3:
        return 'Level -3: Great-Grandchildren';
      default:
        return 'Level $level: Relatives';
    }
  }

  Color _getGenColor(int level) {
    switch (level) {
      case 3:
      case 2:
        return AppColors.indigo;
      case 1:
        return AppColors.orangeDark;
      case 0:
        return AppColors.orange;
      case -1:
        return Colors.teal;
      case -2:
      case -3:
        return Colors.deepPurple;
      default:
        return AppColors.textDark;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Sort generations descending (+3 down to -3)
    final sortedLevels = genMap.keys.toList()..sort((a, b) => b.compareTo(a));

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 12.h, bottom: 8.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: AppColors.orangeLight,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(Icons.bar_chart, color: AppColors.orange, size: 20.sp),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TranslatedText(
                        'Family Tree Statistics',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.indigo,
                        ),
                      ),
                      TranslatedText(
                        'Generational metrics and verification summary',
                        style: TextStyle(fontSize: 12.sp, color: AppColors.textMuted),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: AppColors.textMuted),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),

          const Divider(color: AppColors.border, height: 1),

          // Scrollable Content
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 2x2 Stats Summary Grid
                  Row(
                    children: [
                      Expanded(
                        child: _StatCard(
                          title: 'Total Members',
                          value: '$totalMembers',
                          icon: Icons.groups,
                          color: AppColors.indigo,
                          bgColor: AppColors.cream,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: _StatCard(
                          title: 'Living Members',
                          value: '$livingMembers',
                          icon: Icons.favorite,
                          color: Colors.green,
                          bgColor: const Color(0xFFE8F5E9),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Expanded(
                        child: _StatCard(
                          title: 'Deceased',
                          value: '$deceasedMembers',
                          icon: Icons.spa,
                          color: AppColors.textMuted,
                          bgColor: const Color(0xFFF5F5F5),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: _StatCard(
                          title: 'Linked Accounts',
                          value: '$linkedMembers',
                          icon: Icons.link,
                          color: AppColors.orange,
                          bgColor: AppColors.orangeLight,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 24.h),
                  TranslatedText(
                    'Generational Hierarchy Breakdown',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.indigo,
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // Generational breakdown cards
                  ...sortedLevels.map((level) {
                    final members = genMap[level] ?? [];
                    final color = _getGenColor(level);

                    return Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      padding: EdgeInsets.all(12.r),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 8.r,
                                height: 8.r,
                                decoration: BoxDecoration(
                                  color: color,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Text(
                                  _getGenTitle(level),
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: color,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                                decoration: BoxDecoration(
                                  color: color.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Text(
                                  '${members.length} members',
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.bold,
                                    color: color,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Wrap(
                            spacing: 6.w,
                            runSpacing: 6.h,
                            children: members.map((m) {
                              final isLinked = m.isRegisteredUser == true || (m.linkedUserId != null && m.linkedUserId!.isNotEmpty);
                              final isDeceased = m.isDeceased == true || (m.title != null && m.title!.toLowerCase() == 'late');
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                                decoration: BoxDecoration(
                                  color: AppColors.cream,
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(color: AppColors.border),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (isDeceased)
                                      Padding(
                                        padding: EdgeInsets.only(right: 4.w),
                                        child: Icon(Icons.spa, size: 10.sp, color: AppColors.textMuted),
                                      ),
                                    Text(
                                      m.fullName ?? 'Unknown',
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w500,
                                        color: isDeceased ? AppColors.textMuted : AppColors.textDark,
                                      ),
                                    ),
                                    if (isLinked) ...[
                                      SizedBox(width: 4.w),
                                      Icon(Icons.link, size: 10.sp, color: AppColors.orange),
                                    ],
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final Color bgColor;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: color, size: 20.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                TranslatedText(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
