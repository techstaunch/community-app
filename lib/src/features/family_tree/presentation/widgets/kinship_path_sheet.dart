import 'package:flutter/material.dart';
import '../../../../theme/app_theme.dart';
import '../../../../utils/responsive_ext.dart';
import '../../../../common_widgets/translated_text.dart';
import '../../../../common_widgets/app_avatar.dart';
import '../../data/family_models.dart';
import '../../data/kinship_engine.dart';

class KinshipPathSheet extends StatefulWidget {
  final FamilyTreeNode root;
  final List<FamilyTreeNode> otherMembers;

  const KinshipPathSheet({
    super.key,
    required this.root,
    required this.otherMembers,
  });

  @override
  State<KinshipPathSheet> createState() => _KinshipPathSheetState();
}

class _KinshipPathSheetState extends State<KinshipPathSheet> {
  late String _selectedId;

  @override
  void initState() {
    super.initState();
    _selectedId = widget.otherMembers.isNotEmpty ? (widget.otherMembers.first.id ?? '') : '';
  }

  String _getGenTierLabel(int level) {
    switch (level) {
      case 3:
        return 'Level +3: Great-Grandparent Generation';
      case 2:
        return 'Level +2: Grandparent Generation';
      case 1:
        return 'Level +1: Parent / Uncle Generation';
      case 0:
        return 'Level 0: Same Generation (Peer)';
      case -1:
        return 'Level -1: Child Generation';
      case -2:
        return 'Level -2: Grandchild Generation';
      case -3:
        return 'Level -3: Great-Grandchild Generation';
      default:
        return 'Level $level: Generational Tier';
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
    final selectedMember = widget.otherMembers.firstWhere(
      (m) => m.id == _selectedId,
      orElse: () => widget.otherMembers.first,
    );

    final path = KinshipEngine.findPathToMember(widget.root, selectedMember.id ?? '') ?? [];
    final hops = path.length > 1 ? path.skip(1).map((h) => h.relationToPrev).toList() : <String>[];
    
    // Resolve relation from Viewer perspective
    final resolvedRelation = hops.isNotEmpty
        ? KinshipEngine.resolveMultiHopPath(hops, targetGender: selectedMember.gender)
        : (selectedMember.relationshipToViewer ?? selectedMember.relationshipType ?? 'Relative');

    final genLevel = KinshipEngine.getGenerationalLevel(resolvedRelation);
    final genColor = _getGenColor(genLevel);

    // Calculate reciprocal (what target sees for viewer)
    final directRelation = hops.isNotEmpty ? hops.first : (selectedMember.directRelationship ?? 'Relative');
    final reciprocalTitle = KinshipEngine.calculateReciprocal(
      directRelation: directRelation,
      viewerGender: widget.root.gender ?? 'Male',
    );

    final isLinked = selectedMember.isRegisteredUser == true || (selectedMember.linkedUserId != null && selectedMember.linkedUserId!.isNotEmpty);
    final isDeceased = selectedMember.isDeceased == true || (selectedMember.title != null && selectedMember.title!.toLowerCase() == 'late');

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.88,
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
                  child: Icon(Icons.alt_route, color: AppColors.orange, size: 20.sp),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TranslatedText(
                        'Kinship & Relationship Path',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.indigo,
                        ),
                      ),
                      TranslatedText(
                        'Multi-hop traversal and reciprocal calculations',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12.sp, color: AppColors.textMuted),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: AppColors.textMuted, size: 22.sp),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),

          const Divider(color: AppColors.border, height: 1),

          // Content
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Select Relative Dropdown
                  TranslatedText(
                    'Select Relative to Inspect',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: AppColors.cream,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedId,
                        isExpanded: true,
                        icon: Icon(Icons.arrow_drop_down, color: AppColors.indigo, size: 24.sp),
                        items: widget.otherMembers.map((m) {
                          return DropdownMenuItem<String>(
                            value: m.id,
                            child: Row(
                              children: [
                                AppAvatar(
                                  size: 24.r,
                                  gender: m.gender,
                                  imageUrl: m.photoUrl,
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: Text(
                                    m.fullName ?? 'Unknown',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textDark,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6.r),
                                    border: Border.all(color: AppColors.border),
                                  ),
                                  child: Text(
                                    m.directRelationship ?? m.relationshipType ?? 'Relative',
                                    style: TextStyle(fontSize: 11.sp, color: AppColors.textMuted),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (newId) {
                          if (newId != null) {
                            setState(() {
                              _selectedId = newId;
                            });
                          }
                        },
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Selected Relative Main Card
                  Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: AppColors.border),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            AppAvatar(
                              size: 52.r,
                              gender: selectedMember.gender,
                              imageUrl: selectedMember.photoUrl,
                            ),
                            SizedBox(width: 14.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          selectedMember.fullName ?? 'Unknown',
                                          style: TextStyle(
                                            fontSize: 17.sp,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.indigo,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      if (isDeceased) ...[
                                        SizedBox(width: 6.w),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius: BorderRadius.circular(6.r),
                                          ),
                                          child: Text(
                                            'Deceased',
                                            style: TextStyle(fontSize: 10.sp, color: AppColors.textMuted),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                  SizedBox(height: 4.h),
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                                        decoration: BoxDecoration(
                                          color: genColor.withValues(alpha: 0.1),
                                          borderRadius: BorderRadius.circular(6.r),
                                        ),
                                        child: Text(
                                          resolvedRelation,
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.bold,
                                            color: genColor,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 8.w),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                                        decoration: BoxDecoration(
                                          color: isLinked ? AppColors.orangeLight : AppColors.cream,
                                          borderRadius: BorderRadius.circular(6.r),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              isLinked ? Icons.link : Icons.link_off,
                                              size: 11.sp,
                                              color: isLinked ? AppColors.orange : AppColors.textMuted,
                                            ),
                                            SizedBox(width: 4.w),
                                            Text(
                                              isLinked ? 'Linked' : 'Manual',
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w600,
                                                color: isLinked ? AppColors.orange : AppColors.textMuted,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 16.h),
                        const Divider(color: AppColors.border, height: 1),
                        SizedBox(height: 12.h),

                        // Generational Tier Badge
                        Row(
                          children: [
                            Icon(Icons.layers_outlined, size: 16.sp, color: AppColors.textMuted),
                            SizedBox(width: 6.w),
                            TranslatedText(
                              'Hierarchy Tier: ',
                              style: TextStyle(fontSize: 12.sp, color: AppColors.textMuted),
                            ),
                            Text(
                              _getGenTierLabel(genLevel),
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: genColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Multi-Hop Path Visualizer
                  TranslatedText(
                    'Step-by-Step Kinship Trail',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.indigo,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(14.r),
                    decoration: BoxDecoration(
                      color: AppColors.cream,
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: path.isEmpty
                        ? const TranslatedText('No path resolved')
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (int i = 0; i < path.length; i++) ...[
                                Row(
                                  children: [
                                    Container(
                                      width: 26.r,
                                      height: 26.r,
                                      decoration: BoxDecoration(
                                        color: i == 0
                                            ? AppColors.indigo
                                            : i == path.length - 1
                                                ? AppColors.orange
                                                : Colors.white,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: i == 0
                                              ? AppColors.indigo
                                              : i == path.length - 1
                                                  ? AppColors.orange
                                                  : AppColors.border,
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        '${i + 1}',
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.bold,
                                          color: (i == 0 || i == path.length - 1)
                                              ? Colors.white
                                              : AppColors.textDark,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            i == 0
                                                ? '${path[i].node.fullName ?? "You"} (Self / Viewer)'
                                                : (path[i].node.fullName ?? 'Unknown'),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w600,
                                              color: (i == 0 || i == path.length - 1)
                                                  ? AppColors.indigo
                                                  : AppColors.textDark,
                                            ),
                                          ),
                                          if (i > 0)
                                            Text(
                                              'Relationship: ${path[i].relationToPrev}',
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
                                if (i < path.length - 1)
                                  Container(
                                    margin: EdgeInsets.only(left: 12.w),
                                    height: 18.h,
                                    width: 2.w,
                                    color: AppColors.orange.withValues(alpha: 0.5),
                                  ),
                              ],
                            ],
                          ),
                  ),

                  SizedBox(height: 20.h),

                  // Reciprocal Perspective Card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(14.r),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(color: Colors.blue.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.swap_horiz, color: Colors.blue.shade700, size: 18.sp),
                            SizedBox(width: 8.w),
                            Text(
                              'Reciprocal Kinship View',
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade900,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'From ${selectedMember.fullName ?? "Relative"}\'s perspective, you are their:',
                          style: TextStyle(fontSize: 12.sp, color: Colors.blue.shade800),
                        ),
                        SizedBox(height: 4.h),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: Colors.blue.shade300),
                          ),
                          child: Text(
                            reciprocalTitle,
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade900,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
