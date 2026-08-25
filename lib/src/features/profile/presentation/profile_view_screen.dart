import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_theme.dart';
import '../../../common_widgets/custom_buttons.dart';
import 'package:community_connect/src/common_widgets/translated_text.dart';

class ProfileViewScreen extends HookWidget {
  const ProfileViewScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
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
                        'Member Profile',
                        style:
                            Theme.of(context).textTheme.displaySmall?.copyWith(
                                  fontSize: 18,
                                  color: AppColors.indigo,
                                ),
                      ),
                    ],
                  ),
                  const TranslatedText('⋮',
                      style:
                          TextStyle(fontSize: 24, color: AppColors.textDark)),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Header Section
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: AppColors.indigo,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 64,
                                      height: 64,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.white, width: 2),
                                        image: const DecorationImage(
                                          image: NetworkImage('https://i.pravatar.cc/150?u=suresh'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const TranslatedText(
                                            'Suresh Kulkarni',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Row(
                                            children: [
                                              _buildTag('CEO'),
                                              const SizedBox(width: 8),
                                              _buildTag('📍 Mumbai'),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ),

                          const SizedBox(height: 20),

                          const SizedBox(height: 20),

                          // Tabs and Content wrapped in HookBuilder
                          HookBuilder(
                            builder: (context) {
                              final activeTab = useState(0);
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      _buildTab('About', 0, activeTab),
                                      _buildTab('Business', 1, activeTab),
                                      _buildTab('Family', 2, activeTab),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: activeTab.value == 0
                                        ? _buildAboutTab()
                                        : activeTab.value == 1
                                            ? _buildBusinessTab()
                                            : _buildFamilyTab(),
                                  ),
                                ],
                              );
                            },
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
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: TranslatedText(
        text,
        style: const TextStyle(
          fontSize: 10,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildTab(String text, int index, ValueNotifier<int> activeTab) {
    final isActive = activeTab.value == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => activeTab.value = index,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isActive ? AppColors.indigo : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: TranslatedText(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
              color: isActive ? AppColors.indigo : AppColors.textMuted,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAboutTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TranslatedText(
          'Basic Info',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.indigo,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: [
              _buildInfoRow('Age', '45 Years'),
              _buildInfoRow('Blood Group', 'B+'),
              _buildInfoRow('Gotra', 'Atri'),
              _buildInfoRow('Native', 'Pune'),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const TranslatedText(
          'Bio',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.indigo,
          ),
        ),
        const SizedBox(height: 12),
        const TranslatedText(
          'Running a software consultancy firm in Mumbai for the last 15 years. Specialized in enterprise solutions and cloud infrastructure. Always happy to mentor young professionals from our community.',
          style: TextStyle(
            fontSize: 14,
            height: 1.5,
            color: AppColors.textMid,
          ),
        ),
        const SizedBox(height: 20),
        const TranslatedText(
          'Community Contributions',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.indigo,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.orangeLight,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Column(
            children: [
              Row(
                children: [
                  Icon(Icons.volunteer_activism, color: AppColors.orangeDark, size: 20),
                  SizedBox(width: 8),
                  TranslatedText('Donated ₹11,000 for Navratri', style: TextStyle(color: AppColors.orangeDark, fontWeight: FontWeight.w600, fontSize: 13)),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.event_available, color: AppColors.orangeDark, size: 20),
                  SizedBox(width: 8),
                  TranslatedText('Core Committee Member (2025)', style: TextStyle(color: AppColors.orangeDark, fontWeight: FontWeight.w600, fontSize: 13)),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const TranslatedText(
          'Social Links',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.indigo,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildSocialIcon(Icons.link, 'LinkedIn'),
            const SizedBox(width: 16),
            _buildSocialIcon(Icons.camera_alt, 'Instagram'),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.border),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.indigo, size: 24),
        ),
        const SizedBox(height: 4),
        TranslatedText(label, style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
      ],
    );
  }

  Widget _buildBusinessTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TranslatedText(
          'Business Profile',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.indigo,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.indigoLight,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: const Icon(Icons.business_center,
                        color: AppColors.indigo),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TranslatedText(
                          'TechSoft Solutions',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                        TranslatedText(
                          'IT Services & Consultancy',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Divider(color: AppColors.border),
              ),
              _buildInfoRow('Role', 'Founder & CEO'),
              _buildInfoRow('Employees', '50-100'),
              _buildInfoRow('Services', 'Web Dev, Cloud, DevOps'),
              _buildInfoRow('Address', 'Andheri West, Mumbai'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
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

  Widget _buildFamilyTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TranslatedText(
          'Immediate Family',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.indigo,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildFamilyMemberCard('https://i.pravatar.cc/150?u=sunita', 'Sunita Kulkarni', 'Wife'),
              _buildFamilyMemberCard('https://i.pravatar.cc/150?u=rohan', 'Rohan Kulkarni', 'Son'),
              _buildFamilyMemberCard('https://i.pravatar.cc/150?u=priya2', 'Priya Kulkarni', 'Daughter'),
            ],
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.indigo,
              side: const BorderSide(color: AppColors.border, width: 1.5),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const TranslatedText('View Full Family Tree', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        )
      ],
    );
  }

  Widget _buildFamilyMemberCard(String imageUrl, String name, String relation) {
    return Container(
      width: 105,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(radius: 20, backgroundImage: NetworkImage(imageUrl)),
          const SizedBox(height: 8),
          TranslatedText(name, textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          TranslatedText(relation, style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
        ],
      ),
    );
  }
}
