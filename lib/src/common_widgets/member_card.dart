import 'package:flutter/material.dart';
import '../utils/responsive_ext.dart';
import '../theme/app_theme.dart';

class MemberCard extends StatelessWidget {
  final Widget icon;
  final Widget title;
  final Widget subtitle;
  final Widget? tag;
  final VoidCallback? onTap;

  const MemberCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.tag,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            DefaultTextStyle(
              style: TextStyle(fontSize: 36.sp),
              child: icon,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultTextStyle(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                    child: title,
                  ),
                  SizedBox(height: 2.h),
                  DefaultTextStyle(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.textMuted,
                    ),
                    child: subtitle,
                  ),
                  if (tag != null) ...[
                    SizedBox(height: 4.h),
                    tag!,
                  ]
                ],
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              '›',
              style: TextStyle(
                color: AppColors.textMuted,
                fontSize: 24.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
