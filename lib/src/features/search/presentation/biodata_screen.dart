import 'package:flutter/material.dart';
import 'package:community_connect/src/common_widgets/app_avatar.dart';
import 'package:community_connect/src/utils/responsive_ext.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_theme.dart';
import '../../../common_widgets/custom_buttons.dart';
import 'package:community_connect/src/common_widgets/translated_text.dart';

class BiodataScreen extends StatelessWidget {
  const BiodataScreen({super.key});

  Future<pw.Document> _buildPdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Header(
                level: 0,
                child: pw.Text('Aarti Agarwal - Marriage Biodata',
                    style: pw.TextStyle(
                        fontSize: 24, fontWeight: pw.FontWeight.bold)),
              ),
              pw.SizedBox(height: 20),
              pw.Text('Personal Details',
                    style: pw.TextStyle(
                        fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.Bullet(text: 'Date of Birth: 15 Aug 2000'),
              pw.Bullet(text: 'Height: 5\'4"'),
              pw.Bullet(text: 'Gotra: Kashyap'),
              pw.SizedBox(height: 20),
              pw.Text('Education & Work',
                    style: pw.TextStyle(
                        fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.Bullet(text: 'Education: B.E. Computer Science'),
              pw.Bullet(text: 'Occupation: Software Engineer at TCS'),
              pw.SizedBox(height: 20),
              pw.Text('Family Details',
                    style: pw.TextStyle(
                        fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.Bullet(text: 'Father: Sanjay Agarwal'),
              pw.Bullet(text: 'Mother: Sunita Agarwal'),
            ],
          );
        },
      ),
    );

    return pdf;
  }

  Future<void> _exportPdf(BuildContext context) async {
    final pdf = await _buildPdf();
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }

  Future<void> _sharePdf(BuildContext context) async {
    final pdf = await _buildPdf();
    await Printing.sharePdf(
        bytes: await pdf.save(), filename: 'Aarti_Agarwal_Biodata.pdf');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: Column(
          children: [
            // Top Section
            Container(
              padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 12.h),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: AppColors.border)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CustomBackButton(onPressed: () => context.pop()),
                      SizedBox(width: 14.w),
                      TranslatedText(
                        'Marriage Profile',
                        style:
                            Theme.of(context).textTheme.displaySmall?.copyWith(
                                  fontSize: 18.sp,
                                  color: AppColors.indigo,
                                ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => _exportPdf(context),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: AppColors.orangeLight,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.download,
                              size: 14.r, color: AppColors.orangeDark),
                          SizedBox(width: 4.w),
                          TranslatedText(
                            'Biodata',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.orangeDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  children: [
                    // Profile Card
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: AppColors.border),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10.r,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Header Gradient
                          Container(
                            height: 100.h,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  AppColors.orangeLight,
                                  AppColors.orange
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16.r),
                                topRight: Radius.circular(16.r),
                              ),
                            ),
                          ),
                          // Content
                          Padding(
                            padding: EdgeInsets.all(20.w),
                            child: Column(
                              children: [
                                // Avatar (Overlapping)
                                Transform.translate(
                                  offset: Offset(0, -50.h),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: AppColors.cream, width: 4.w),
                                    ),
                                    child: AppAvatar(
                                      imageUrl: null, // Replace with actual URL if available
                                      size: 72.r,
                                    ),
                                  ),
                                ),
                                Transform.translate(
                                  offset: Offset(0, -30.h),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: TranslatedText(
                                              'Aarti Agarwal',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 22.sp,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.textDark,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 6.w),
                                          Icon(Icons.verified,
                                              color: AppColors.green, size: 18.r),
                                        ],
                                      ),
                                      SizedBox(height: 10.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                           _buildTag('Software Engineer', icon: Icons.work_outline),
                                           SizedBox(width: 8.w),
                                           _buildTag('Surat', icon: Icons.location_on_outlined),
                                        ],
                                      ),
                                      SizedBox(height: 16.h),
                                      // Stats
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 12.h),
                                        decoration: BoxDecoration(
                                          color: AppColors.cream,
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            _buildStat('Age', '26 yrs'),
                                            Container(
                                                width: 1.w,
                                                height: 30.h,
                                                color: AppColors.border),
                                            _buildStat('Height', '5\'4"'),
                                            Container(
                                                width: 1.w,
                                                height: 30.h,
                                                color: AppColors.border),
                                            _buildStat('Gotra', 'Kashyap'),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20.h),

                    // Actions
                    Row(
                      children: [
                        Expanded(
                          child: PrimaryButton(
                            text: 'Connect Request',
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: OutlinePrimaryButton(
                            text: 'Share Profile',
                            onPressed: () => _sharePdf(context),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20.h),

                    // Detail Section
                    Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TranslatedText(
                            'Education & Profession',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.indigo,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          _buildDetailRow('Degree', 'B.E. Computer Science'),
                          _buildDetailRow('College', 'NIT Surat'),
                          _buildDetailRow('Occupation', 'Software Engineer'),
                          _buildDetailRow('Company', 'TCS, Pune'),
                          _buildDetailRow('Annual Income', '12-15 LPA'),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            child: const Divider(color: AppColors.border),
                          ),
                          TranslatedText(
                            'Family Details',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.indigo,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          _buildDetailRow(
                              'Father', 'Sanjay Agarwal (Businessman)'),
                          _buildDetailRow('Mother', 'Sunita Agarwal (Homemaker)'),
                          _buildDetailRow('Siblings', '1 Brother (Married)'),
                          _buildDetailRow('Native', 'Navsari, Gujarat'),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            child: const Divider(color: AppColors.border),
                          ),
                          TranslatedText(
                            'Astrology (Kundali)',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.indigo,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          _buildDetailRow('Rashi', 'Mesh (Aries)'),
                          _buildDetailRow('Nakshatra', 'Ashwini'),
                          _buildDetailRow('Manglik', 'No'),
                          _buildDetailRow('Birth Time', '10:45 AM'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String text, {IconData? icon}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.indigoLight,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12.r, color: AppColors.indigo),
            SizedBox(width: 4.w),
          ],
          TranslatedText(
            text,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.indigo,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        TranslatedText(
          label,
          style: TextStyle(fontSize: 11.sp, color: AppColors.textMuted),
        ),
        SizedBox(height: 4.h),
        TranslatedText(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110.w,
            child: TranslatedText(
              label,
              style: TextStyle(
                fontSize: 13.sp,
                color: AppColors.textMuted,
              ),
            ),
          ),
          Expanded(
            child: TranslatedText(
              value,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
