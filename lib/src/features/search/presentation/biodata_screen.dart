import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_theme.dart';
import '../../../common_widgets/custom_buttons.dart';
import 'package:community_connect/src/common_widgets/translated_text.dart';

class BiodataScreen extends StatelessWidget {
  const BiodataScreen({super.key});

  Future<void> _exportPdf(BuildContext context) async {
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

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
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
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
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
                      const SizedBox(width: 14),
                      TranslatedText(
                        'Marriage Profile',
                        style:
                            Theme.of(context).textTheme.displaySmall?.copyWith(
                                  fontSize: 18,
                                  color: AppColors.indigo,
                                ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => _exportPdf(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.orangeLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.download,
                              size: 14, color: AppColors.orangeDark),
                          SizedBox(width: 4),
                          TranslatedText(
                            'Biodata',
                            style: TextStyle(
                              fontSize: 12,
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
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Profile Card
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.border),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Header Gradient
                          Container(
                            height: 100,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.orangeLight,
                                  AppColors.orange
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                            ),
                          ),
                          // Content
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                // Avatar (Overlapping)
                                Transform.translate(
                                  offset: const Offset(0, -50),
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: AppColors.cream, width: 4),
                                      image: const DecorationImage(
                                        image: NetworkImage('https://i.pravatar.cc/150?u=aarti'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Transform.translate(
                                  offset: const Offset(0, -30),
                                  child: Column(
                                    children: [
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TranslatedText(
                                            'Aarti Agarwal',
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.textDark,
                                            ),
                                          ),
                                          SizedBox(width: 6),
                                          Icon(Icons.verified,
                                              color: AppColors.green, size: 18),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          _buildTag('💼 Software Engineer'),
                                          const SizedBox(width: 8),
                                          _buildTag('📍 Surat'),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      // Stats
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12),
                                        decoration: BoxDecoration(
                                          color: AppColors.cream,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            _buildStat('Age', '26 yrs'),
                                            Container(
                                                width: 1,
                                                height: 30,
                                                color: AppColors.border),
                                            _buildStat('Height', '5\'4"'),
                                            Container(
                                                width: 1,
                                                height: 30,
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

                    const SizedBox(height: 20),

                    // Actions
                    Row(
                      children: [
                        Expanded(
                          child: PrimaryButton(
                            text: 'Connect Request',
                            onPressed: () {},
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: OutlinePrimaryButton(
                            text: 'Share Profile',
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Detail Section
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TranslatedText(
                            'Education & Profession',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.indigo,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildDetailRow('Degree', 'B.E. Computer Science'),
                          _buildDetailRow('College', 'NIT Surat'),
                          _buildDetailRow('Occupation', 'Software Engineer'),
                          _buildDetailRow('Company', 'TCS, Pune'),
                          _buildDetailRow('Annual Income', '12-15 LPA'),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Divider(color: AppColors.border),
                          ),
                          const TranslatedText(
                            'Family Details',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.indigo,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildDetailRow(
                              'Father', 'Sanjay Agarwal (Businessman)'),
                          _buildDetailRow('Mother', 'Sunita Agarwal (Homemaker)'),
                          _buildDetailRow('Siblings', '1 Brother (Married)'),
                          _buildDetailRow('Native', 'Navsari, Gujarat'),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Divider(color: AppColors.border),
                          ),
                          const TranslatedText(
                            'Astrology (Kundali)',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.indigo,
                            ),
                          ),
                          const SizedBox(height: 16),
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

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.indigoLight,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TranslatedText(
        text,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: AppColors.indigo,
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        TranslatedText(
          label,
          style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
        ),
        const SizedBox(height: 4),
        TranslatedText(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: TranslatedText(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textMuted,
              ),
            ),
          ),
          Expanded(
            child: TranslatedText(
              value,
              style: const TextStyle(
                fontSize: 13,
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
