import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../utils/responsive_ext.dart';
import '../theme/app_theme.dart';
import 'translated_text.dart';

class SlideToContinueButton extends HookWidget {
  final VoidCallback onSlideCompleted;
  final String text;

  const SlideToContinueButton({
    super.key,
    required this.onSlideCompleted,
    this.text = 'Slide to Continue >>',
  });

  @override
  Widget build(BuildContext context) {
    final dragPosition = useState<double>(0.0);
    final isCompleted = useState<bool>(false);
    final buttonHeight = 60.0.h;
    final thumbSize = 52.0.r;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxWidth = constraints.maxWidth;
        final double maxDragPosition = maxWidth - thumbSize - 8.w;

        return Container(
          height: buttonHeight,
          decoration: BoxDecoration(
            color: AppColors.orangeLight,
            borderRadius: BorderRadius.circular(30.r),
            border: Border.all(color: AppColors.orange.withValues(alpha: 0.5)),
          ),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              // Filled Background Track
              AnimatedContainer(
                duration: dragPosition.value == 0 ? const Duration(milliseconds: 200) : Duration.zero,
                height: buttonHeight,
                width: dragPosition.value + thumbSize + 8.w,
                decoration: BoxDecoration(
                  color: AppColors.orange.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(30.r),
                ),
              ),

              // Background Text
              Center(
                child: TranslatedText(
                  text,
                  style: TextStyle(
                    color: AppColors.orangeDark.withValues(alpha: 0.8),
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
              ),
              
              // Sliding Thumb
              AnimatedPositioned(
                duration: dragPosition.value == 0 ? const Duration(milliseconds: 200) : Duration.zero,
                left: dragPosition.value + 4.w,
                child: GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    if (isCompleted.value) return;
                    
                    double newPos = dragPosition.value + details.delta.dx;
                    if (newPos < 0) newPos = 0;
                    if (newPos > maxDragPosition) {
                      newPos = maxDragPosition;
                      isCompleted.value = true;
                      onSlideCompleted();
                    }
                    dragPosition.value = newPos;
                  },
                  onHorizontalDragEnd: (details) {
                    if (!isCompleted.value) {
                      dragPosition.value = 0;
                    }
                  },
                  child: Container(
                    width: thumbSize,
                    height: thumbSize,
                    decoration: const BoxDecoration(
                      color: AppColors.orange,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 20.r,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
