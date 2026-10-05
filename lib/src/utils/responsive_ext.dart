import 'package:flutter_screenutil/flutter_screenutil.dart' as su;
export 'package:flutter_screenutil/flutter_screenutil.dart' hide SizeExtension;

/// Safe responsive extension on [num] that uses ScreenUtil scaling when initialized,
/// but safely falls back to standard values in unit/widget tests or when ScreenUtil
/// is not initialized.
extension ResponsiveNum on num {
  double get sp {
    try {
      return su.SizeExtension(this).sp;
    } catch (_) {
      return toDouble();
    }
  }

  double get h {
    try {
      return su.SizeExtension(this).h;
    } catch (_) {
      return toDouble();
    }
  }

  double get w {
    try {
      return su.SizeExtension(this).w;
    } catch (_) {
      return toDouble();
    }
  }

  double get r {
    try {
      return su.SizeExtension(this).r;
    } catch (_) {
      return toDouble();
    }
  }
}
