import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_theme.dart';
import '../../../common_widgets/tags_chips.dart';
import 'package:community_connect/src/common_widgets/translated_text.dart';
import '../data/search_provider.dart';

class SearchScreen extends HookConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchMode = useState(1); // 1 = Marriage, 2 = Career
    final searchController = useTextEditingController();
    final searchState = ref.watch(searchControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top Section
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: AppColors.border)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TranslatedText(
                    'Find Members',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontSize: 18,
                          color: AppColors.indigo,
                        ),
                  ),
                  const SizedBox(height: 10),
                  // Search Bar
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: AppColors.border, width: 1.5),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        const TranslatedText('🔍', style: TextStyle(fontSize: 16)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            onSubmitted: (value) {
                              ref.read(searchControllerProvider.notifier).search(value);
                            },
                            decoration: const InputDecoration(
                              hintText: 'Name, profession, gotra...',
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              hintStyle: TextStyle(
                                fontSize: 13,
                                color: AppColors.textMuted,
                              ),
                            ),
                            style: const TextStyle(fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Filter Button
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => _showAdvancedFilters(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.orangeLight,
                            border: Border.all(color: AppColors.orange),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.tune,
                                  size: 16, color: AppColors.orangeDark),
                              SizedBox(width: 6),
                              TranslatedText('Filters (2)',
                                  style: TextStyle(
                                      color: AppColors.orangeDark,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // View Mode Toggle
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: AppColors.border)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TranslatedText(
                    'View mode:',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textMuted,
                    ),
                  ),
                  Row(
                    children: [
                      CustomChip(
                        text: '💍 Marriage',
                        isActive: searchMode.value == 1,
                        onTap: () => searchMode.value = 1,
                      ),
                      CustomChip(
                        text: '💼 Career',
                        isActive: searchMode.value == 2,
                        onTap: () => searchMode.value = 2,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Results List
            Expanded(
              child: HookBuilder(
                builder: (context) {
                  final searchQuery = useValueListenable(searchController).text;
                  return CustomScrollView(
                    slivers: [
                      if (searchQuery.isEmpty) ...[
                    // Recent Searches
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const TranslatedText('Recent Searches',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textDark)),
                            TranslatedText('Clear', style: TextStyle(color: AppColors.orange, fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _buildActionChip(Icons.history, 'Patil in Surat', () => searchController.text = 'Patil in Surat'),
                            _buildActionChip(Icons.history, 'Software Engineers', () => searchController.text = 'Software Engineers'),
                            _buildActionChip(Icons.history, 'Kashyap Gotra', () => searchController.text = 'Kashyap Gotra'),
                          ],
                        ),
                      ),
                    ),

                    // Saved Searches
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 24, 20, 10),
                        child: TranslatedText('Saved Searches',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.textDark)),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _buildActionChip(Icons.bookmark, 'Doctors in Pune', () => searchController.text = 'Doctors in Pune'),
                            _buildActionChip(Icons.bookmark, 'Business Owners', () => searchController.text = 'Business Owners'),
                          ],
                        ),
                      ),
                    ),

                    // Suggested Members
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 24, 20, 0),
                        child: TranslatedText('Smart Suggestions',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.textDark)),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 140,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          children: [
                            _buildSuggestedCard(
                                context, 'https://i.pravatar.cc/150?u=rohit', 'Rohit', 'Surat'),
                            _buildSuggestedCard(context, 'https://i.pravatar.cc/150?u=pooja', 'Pooja', 'Pune'),
                            _buildSuggestedCard(
                                context, 'https://i.pravatar.cc/150?u=amit', 'Amit', 'Mumbai'),
                            _buildSuggestedCard(
                                context, 'https://i.pravatar.cc/150?u=neha', 'Neha', 'Nashik'),
                          ],
                        ),
                      ),
                    ),
                  ],
                      if (searchQuery.isNotEmpty) ...[
                        searchState.when(
                          data: (results) {
                            if (results.isEmpty) {
                              return const SliverToBoxAdapter(
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: TranslatedText('No members found',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: AppColors.textMuted)),
                                ),
                              );
                            }
                            return SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  final result = results[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
                                    child: _buildMemberCard(
                                      context,
                                      imageUrl: result.profilePhotoUrl ?? 'https://i.pravatar.cc/150',
                                      name: result.fullName ?? 'Unknown',
                                      verified: true, // You can update this to check real verification status
                                      subtitle: '· ${result.city ?? 'Unknown'} · ${result.companyName ?? 'Unknown'}',
                                      tag: result.designation ?? result.companyName ?? 'Member',
                                      onTap: () => context.push('/profile_view'), // Ideally push with ID
                                    ),
                                  );
                                },
                                childCount: results.length,
                              ),
                            );
                          },
                          loading: () => const SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.all(40),
                              child: Center(child: CircularProgressIndicator()),
                            ),
                          ),
                          error: (error, stack) => SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text('Error: $error', textAlign: TextAlign.center),
                            ),
                          ),
                        ),
                      ],
                    ],
                  );
                },
          ),
        ),
      ],
        ),
      ),
    );
  }

  Widget _buildSuggestedCard(
      BuildContext context, String imageUrl, String name, String city) {
    return Container(
      width: 100,
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
          CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(imageUrl),
          ),
          const SizedBox(height: 8),
          TranslatedText(name,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          TranslatedText(city,
              style: const TextStyle(color: AppColors.textMuted, fontSize: 10)),
        ],
      ),
    );
  }

  void _showAdvancedFilters(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height * 0.7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TranslatedText('Advanced Filters',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.indigo)),
                  TextButton(
                    onPressed: () {
                      context.pop();
                      // Logic to clear filters
                    },
                    child: const TranslatedText('Clear All',
                        style: TextStyle(
                            color: AppColors.orange,
                            fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
              const Divider(),
              Expanded(
                child: ListView(
                  children: const [
                    SizedBox(height: 10),
                    TranslatedText('By Profession',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark)),
                    SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        CustomChip(text: 'Engineer', isActive: true),
                        CustomChip(text: 'Doctor', isActive: false),
                        CustomChip(text: 'Business', isActive: false),
                        CustomChip(text: 'Lawyer', isActive: false),
                        CustomChip(text: 'Teacher', isActive: false),
                      ],
                    ),
                    SizedBox(height: 24),
                    TranslatedText('By Gotra',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark)),
                    SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        CustomChip(text: 'Kashyap', isActive: false),
                        CustomChip(text: 'Bharadwaj', isActive: false),
                        CustomChip(text: 'Atri', isActive: false),
                        CustomChip(text: 'Vashisht', isActive: false),
                      ],
                    ),
                    SizedBox(height: 24),
                    TranslatedText('By City',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark)),
                    SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        CustomChip(text: 'Surat', isActive: true),
                        CustomChip(text: 'Pune', isActive: false),
                        CustomChip(text: 'Mumbai', isActive: false),
                        CustomChip(text: 'Nashik', isActive: false),
                      ],
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () => context.pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.orange,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const TranslatedText('Apply Filters',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMemberCard(
    BuildContext context, {
    required String imageUrl,
    required String name,
    required bool verified,
    required String subtitle,
    required String tag,
    required VoidCallback onTap,
    int? familyCount,
    int? profileCompletion,
    bool isBusiness = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage(imageUrl),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      TranslatedText(
                        name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark,
                        ),
                      ),
                      if (verified) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE6F4EC),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const TranslatedText(
                            '✓ Verified',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: AppColors.green,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  TranslatedText(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textMuted,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.orangeLight,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TranslatedText(
                          tag,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.orangeDark,
                          ),
                        ),
                      ),
                      if (isBusiness)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.indigo.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const TranslatedText(
                            '💼 Business',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.indigo,
                            ),
                          ),
                        ),
                      if (familyCount != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.cream,
                            border: Border.all(color: AppColors.border),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.family_restroom,
                                  size: 12, color: AppColors.textMuted),
                              const SizedBox(width: 4),
                              TranslatedText(
                                '$familyCount',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textMuted,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  if (profileCompletion != null) ...[
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: profileCompletion / 100,
                              backgroundColor: AppColors.border,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  AppColors.green),
                              minHeight: 4,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        TranslatedText(
                          '$profileCompletion% Complete',
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.textMuted,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 8),
            const TranslatedText(
              '›',
              style: TextStyle(
                color: AppColors.textMuted,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionChip(IconData icon, String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: AppColors.textMuted),
            const SizedBox(width: 6),
            TranslatedText(text, style: const TextStyle(fontSize: 13, color: AppColors.textDark)),
          ],
        ),
      ),
    );
  }
}
