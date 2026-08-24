import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_theme.dart';
import 'package:community_connect/src/common_widgets/translated_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TranslatedText(
                        'Welcome back',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textMuted,
                        ),
                      ),
                      TranslatedText(
                        'Patil Samaj 🏡',
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                              fontSize: 18,
                              color: AppColors.indigo,
                            ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.push('/notifications'),
                        child: Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: AppColors.orangeLight,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              const TranslatedText('🔔', style: TextStyle(fontSize: 18)),
                              Positioned(
                                top: 4,
                                right: 4,
                                child: Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: AppColors.red,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () => context.go('/my_profile'),
                        child: Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: AppColors.orangeLight,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.orange,
                              width: 2,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: const TranslatedText('👤', style: TextStyle(fontSize: 18)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: AppColors.border)),
              ),
              child: GestureDetector(
                onTap: () => context.go('/search'),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.border, width: 1.5),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Row(
                    children: [
                      TranslatedText('🔍', style: TextStyle(fontSize: 16)),
                      SizedBox(width: 8),
                      TranslatedText(
                        'Search members, profession, city...',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TranslatedText(
                      'Recently Joined',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.indigo,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildRecentMember('👨', 'Arjun P.', 'Engineer'),
                          _buildRecentMember('👩', 'Priya M.', 'Doctor'),
                          _buildRecentMember('👨', 'Suresh D.', 'Business'),
                          _buildRecentMember('👩', 'Meena K.', 'Teacher'),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    const TranslatedText(
                      'Community Announcements',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.indigo,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildAnnouncementCard(
                      title: 'Annual Samaj Gathering 2025',
                      subtitle: '15 Feb · Surat Community Hall',
                      desc: 'All families are invited. Register before Jan 30th.',
                    ),
                    _buildAnnouncementCard(
                      title: 'Marriage Bureau Registration Open',
                      subtitle: '2 days ago',
                    ),

                    const SizedBox(height: 16),
                    const TranslatedText(
                      'Quick Actions',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.indigo,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(child: _buildQuickAction('🌳', 'Family Tree', () => context.go('/family_tree'))),
                        const SizedBox(width: 10),
                        Expanded(child: _buildQuickAction('💍', 'Find Match', () => context.go('/search'))),
                        const SizedBox(width: 10),
                        Expanded(child: _buildQuickAction('🏘️', 'Communities', () => context.push('/communities'))),
                      ],
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

  Widget _buildRecentMember(String emoji, String name, String tag) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          TranslatedText(emoji, style: const TextStyle(fontSize: 30)),
          const SizedBox(height: 4),
          TranslatedText(
            name,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 3),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.orangeLight,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TranslatedText(
              tag,
              style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w600,
                color: AppColors.orangeDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnnouncementCard({required String title, required String subtitle, String? desc}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
        border: const Border(
          left: BorderSide(color: AppColors.indigo, width: 3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TranslatedText(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 3),
          TranslatedText(
            subtitle,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.textMuted,
            ),
          ),
          if (desc != null) ...[
            const SizedBox(height: 5),
            TranslatedText(
              desc,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textMid,
              ),
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildQuickAction(String emoji, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            TranslatedText(emoji, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 6),
            TranslatedText(
              title,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

