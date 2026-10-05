import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'responsive_ext.dart';
import '../theme/app_theme.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class AppMessenger {
  static void showSuccess(String message) {
    _showSnackBar('Success!', message, AppColors.green, Icons.check_circle_rounded);
  }

  static void showError(String message) {
    _showSnackBar('Oops!', message, AppColors.red, Icons.error_rounded);
  }

  static void showInfo(String message) {
    _showSnackBar('Heads up!', message, AppColors.indigo, Icons.info_rounded);
  }

  static void showException(dynamic exception, {String fallbackMessage = 'Oops! Something went wrong.'}) {
    if (exception is DioException) {
      final data = exception.response?.data;
      if (data != null && data is Map<String, dynamic>) {
        if (data['errors'] != null && data['errors'] is List && (data['errors'] as List).isNotEmpty) {
          final errorList = data['errors'] as List;
          final messages = errorList.map((e) => e is Map ? (e['message'] ?? e.toString()) : e.toString()).join('\n');
          showError(messages);
          return;
        }
        if (data['message'] != null) {
          showError(data['message'].toString());
          return;
        }
      }
      
      if (exception.type == DioExceptionType.connectionTimeout || 
          exception.type == DioExceptionType.receiveTimeout) {
        showError('It seems your connection is a bit slow. Please try again.');
        return;
      }
      if (exception.type == DioExceptionType.connectionError) {
        showError('No internet connection found. Please check your network.');
        return;
      }
      
      showError('We are having trouble reaching the server right now. Please try again later.');
    } else {
      showError(fallbackMessage);
    }
  }

  static void _showSnackBar(String title, String message, Color color, IconData icon) {
    final messenger = scaffoldMessengerKey.currentState;
    if (messenger == null) return;

    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        padding: EdgeInsets.zero,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        duration: const Duration(seconds: 4),
        content: Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.12),
                blurRadius: 16.r,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(color: color.withValues(alpha: 0.2), width: 1.5),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 24.r),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: AppColors.textDark,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.3,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      message,
                      style: TextStyle(
                        color: AppColors.textMid,
                        fontSize: 13.5.sp,
                        height: 1.4,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
