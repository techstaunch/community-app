import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../../theme/app_theme.dart';
import 'dart:math' as math;
import 'package:community_connect/src/common_widgets/translated_text.dart';
import '../data/family_provider.dart';
import '../data/family_models.dart';

class FamilyTreeScreen extends HookConsumerWidget {
  const FamilyTreeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transformationController = useTransformationController();
    final treeKey = useMemoized(() => GlobalKey());
    final viewportKey = useMemoized(() => GlobalKey());
    
    final treeState = ref.watch(familyControllerProvider);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final RenderBox? treeBox = treeKey.currentContext?.findRenderObject() as RenderBox?;
        final RenderBox? viewportBox = viewportKey.currentContext?.findRenderObject() as RenderBox?;
        
        if (treeBox != null && viewportBox != null) {
          final childSize = treeBox.size;
          final viewportSize = viewportBox.size;
          
          final scaleX = viewportSize.width / childSize.width;
          final scaleY = viewportSize.height / childSize.height;
          
          final scale = math.min(scaleX, scaleY).clamp(0.1, 1.0) * 0.95;
          final dx = (viewportSize.width - (childSize.width * scale)) / 2;
          final dy = (viewportSize.height - (childSize.height * scale)) / 2;
          
          transformationController.value = Matrix4.identity()
            ..translate(dx, dy, 0.0)
            ..scale(scale, scale, 1.0);
        }
      });
      return null;
    }, [treeState]);

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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TranslatedText(
                        'Agarwal Parivar',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textMuted,
                        ),
                      ),
                      TranslatedText(
                        'My Family Tree',
                        style:
                            Theme.of(context).textTheme.displaySmall?.copyWith(
                                  fontSize: 18,
                                  color: AppColors.indigo,
                                ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const TranslatedText('🔍', style: TextStyle(fontSize: 20)),
                      const SizedBox(width: 8),
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.more_vert, color: AppColors.textDark),
                        onSelected: (value) {
                          if (value == 'stats') _showStatsDialog(context);
                          if (value == 'path') _showPathFinderDialog(context);
                          if (value == 'export') _exportTreePdf(context);
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(value: 'stats', child: TranslatedText('Family Statistics')),
                          const PopupMenuItem(value: 'path', child: TranslatedText('Relationship Path')),
                          const PopupMenuItem(value: 'export', child: TranslatedText('Export as PDF')),
                        ],
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () => _showAddMemberOptions(context),
                        child: Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: AppColors.orange,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          child: const TranslatedText('➕',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Expanded(
              key: viewportKey,
              child: treeState.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => const Center(child: Text('Error loading family tree')),
                data: (treeNode) {
                  if (treeNode == null) {
                    return const Center(child: Text('No family data. Click + to add members.'));
                  }
                  
                  return Stack(
                    children: [
                      InteractiveViewer(
                        transformationController: transformationController,
                        constrained: false,
                        boundaryMargin: const EdgeInsets.all(double.infinity),
                        minScale: 0.1,
                        maxScale: 4.0,
                        child: Container(
                          key: treeKey,
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
                          child: _buildDynamicTree(treeNode),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        right: 20,
                        child: FloatingActionButton(
                          mini: true,
                          backgroundColor: AppColors.white,
                          onPressed: () {
                            transformationController.value = Matrix4.identity();
                          },
                          child: const Icon(Icons.center_focus_strong, color: AppColors.indigo),
                        ),
                      ),
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

  Widget _buildDynamicTree(FamilyTreeNode node) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildTreeNode(node.photoUrl ?? 'https://i.pravatar.cc/150', node.fullName ?? 'Unknown', node.relationshipType ?? 'Member', node.relationshipType == 'Me'),
        if (node.children.isNotEmpty) ...[
          _buildVerticalLine(),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: node.children.map((childNode) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _buildDynamicTree(childNode),
              );
            }).toList(),
          ),
        ]
      ],
    );
  }

  Widget _buildTreeNode(String imageUrl, String name, String relation, bool isMe) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isMe ? AppColors.orangeLight : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isMe ? AppColors.orange : AppColors.border,
          width: isMe ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isMe ? 0.12 : 0.05),
            blurRadius: isMe ? 15 : 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundImage: NetworkImage(imageUrl),
          ),
          const SizedBox(height: 10),
          TranslatedText(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: isMe ? Colors.white : AppColors.cream,
              borderRadius: BorderRadius.circular(6),
            ),
            child: TranslatedText(
              relation,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.textMuted,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalLine() {
    return Container(
      width: 2,
      height: 40,
      color: AppColors.border,
    );
  }

  void _showAddMemberOptions(BuildContext context) {
    context.push('/add_family');
  }

  Future<void> _exportTreePdf(BuildContext context) async {
    // simplified
  }

  void _showStatsDialog(BuildContext context) {
    // simplified
  }

  void _showPathFinderDialog(BuildContext context) {
    // simplified
  }
}
