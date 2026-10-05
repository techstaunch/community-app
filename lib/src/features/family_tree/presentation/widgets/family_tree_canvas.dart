import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;
import '../../../../theme/app_theme.dart';
import '../../../../utils/responsive_ext.dart';
import '../../../../utils/app_messenger.dart';
import '../../../../common_widgets/app_avatar.dart';
import '../../../../common_widgets/translated_text.dart';
import '../../data/family_models.dart';
import '../../data/relation_display_helper.dart';
import 'family_node_actions_sheet.dart';

class FamilyTreeCanvas extends HookWidget {
  final FamilyTreeNode rootNode;
  final String? currentUserId;
  final String? focusUserId;
  final TransformationController? controller;
  final bool isEditable;

  const FamilyTreeCanvas({
    super.key,
    required this.rootNode,
    this.currentUserId,
    this.focusUserId,
    this.controller,
    this.isEditable = true,
  });

  @override
  Widget build(BuildContext context) {
    final internalController = useTransformationController();
    final transformationController = controller ?? internalController;
    final treeKey = useMemoized(() => GlobalKey());
    final viewportKey = useMemoized(() => GlobalKey());

    void centerTree() {
      final RenderBox? treeBox =
          treeKey.currentContext?.findRenderObject() as RenderBox?;
      final RenderBox? viewportBox =
          viewportKey.currentContext?.findRenderObject() as RenderBox?;

      if (treeBox != null && viewportBox != null) {
        final childSize = treeBox.size;
        final viewportSize = viewportBox.size;

        if (childSize.width == 0 || childSize.height == 0) return;

        final scaleX = viewportSize.width / childSize.width;
        final scaleY = viewportSize.height / childSize.height;

        final maxInitialScale = viewportSize.width > 600 ? 1.25 : 1.0;
        final scale =
            math.min(scaleX, scaleY).clamp(0.1, maxInitialScale) * 0.95;
        final dx = (viewportSize.width - (childSize.width * scale)) / 2;
        final dy = (viewportSize.height - (childSize.height * scale)) / 2;

        // ignore: deprecated_member_use
        transformationController.value = Matrix4.identity()
          // ignore: deprecated_member_use
          ..translate(dx, dy, 0.0)
          // ignore: deprecated_member_use
          ..scale(scale, scale, 1.0);
      }
    }

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        centerTree();
      });
      return null;
    }, [rootNode]);

    return Container(
      key: viewportKey,
      color: AppColors.cream,
      child: Stack(
        children: [
          InteractiveViewer(
            transformationController: transformationController,
            constrained: false,
            boundaryMargin: const EdgeInsets.all(double.infinity),
            minScale: 0.1,
            maxScale: 4.0,
            child: Container(
              key: treeKey,
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 80,
              ),
              child: _buildTieredTree(
                rootNode,
                context,
                currentUserId: currentUserId,
              ),
            ),
          ),
          Positioned(
            bottom: 20.h,
            right: 20.w,
            child: FloatingActionButton(
              heroTag: 'family_tree_canvas_fab_${rootNode.id ?? rootNode.fullName}',
              mini: true,
              backgroundColor: AppColors.white,
              onPressed: () {
                centerTree();
              },
              child: Icon(
                Icons.center_focus_strong,
                color: AppColors.indigo,
                size: 20.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTieredTree(
    FamilyTreeNode rootNode,
    BuildContext context, {
    String? currentUserId,
  }) {
    final tiers = _extractTiers(rootNode, currentUserId: currentUserId);
    if (tiers.isEmpty) return const SizedBox();

    final tierWidths = tiers.map((t) => _getTierWidth(t)).toList();
    final maxTierWidth = tierWidths.reduce(math.max);

    return SizedBox(
      width: maxTierWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (int i = 0; i < tiers.length; i++) ...[
            if (i > 0) ...[
              _buildTierConnector(
                parentTier: tiers[i - 1],
                parentTierWidth: tierWidths[i - 1],
                childTier: tiers[i],
                childTierWidth: tierWidths[i],
                canvasWidth: maxTierWidth,
              ),
            ],
            _buildTierWidget(tiers[i], context, currentUserId),
          ],
        ],
      ),
    );
  }

  Widget _buildTierConnector({
    required _GenerationTier parentTier,
    required double parentTierWidth,
    required _GenerationTier childTier,
    required double childTierWidth,
    required double canvasWidth,
  }) {
    final parentTierLeft = (canvasWidth - parentTierWidth) / 2.0;
    final childTierLeft = (canvasWidth - childTierWidth) / 2.0;

    final connections = _getConnections(
      parentTier,
      parentTierLeft,
      childTier,
      childTierLeft,
    );

    return CustomPaint(
      size: Size(canvasWidth, 32.0),
      painter: _TierConnectorPainter(connections: connections),
    );
  }

  double _getTierWidth(_GenerationTier tier) {
    if (tier.units.isEmpty) return 0.0;
    double w = 0.0;
    for (int i = 0; i < tier.units.length; i++) {
      if (i > 0) w += 24.0;
      w += tier.units[i].width;
    }
    return w;
  }

  double _getUnitLeftInTier(_GenerationTier tier, int index) {
    double left = 0.0;
    for (int i = 0; i < index; i++) {
      left += tier.units[i].width + 24.0;
    }
    return left;
  }

  Widget _buildTierWidget(
    _GenerationTier tier,
    BuildContext context,
    String? currentUserId,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < tier.units.length; i++) ...[
          if (i > 0) const SizedBox(width: 24),
          _buildUnitWidget(tier.units[i], context, currentUserId),
        ],
      ],
    );
  }

  Widget _buildUnitWidget(
    _TierUnit unit,
    BuildContext context,
    String? currentUserId,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTreeNode(
          unit.person,
          context,
          isRoot: unit.isRoot,
          currentUserId: currentUserId,
          contextRole: unit.contextRole,
        ),
        if (unit.spouse != null) ...[
          _buildSpouseConnector(),
          _buildTreeNode(
            unit.spouse!,
            context,
            isRoot: false,
            currentUserId: currentUserId,
            contextRole: _getSpouseRole(
              unit.person,
              unit.spouse!,
              isRoot: unit.isRoot,
              personContextRole: unit.contextRole,
              currentUserId: currentUserId,
            ),
          ),
        ],
      ],
    );
  }

  bool _isSameNode(FamilyTreeNode? a, FamilyTreeNode? b) {
    if (a == null || b == null) return false;
    if (a.id != null && a.id!.isNotEmpty && b.id != null && b.id!.isNotEmpty) {
      return a.id == b.id;
    }
    if (a.fullName != null && a.fullName!.isNotEmpty && b.fullName != null && b.fullName!.isNotEmpty) {
      return a.fullName!.toLowerCase().trim() == b.fullName!.toLowerCase().trim();
    }
    return false;
  }

  List<_GenerationTier> _extractTiers(
    FamilyTreeNode root, {
    String? currentUserId,
  }) {
    final tiers = <_GenerationTier>[];

    // 1. Trace ancestors upwards
    FamilyTreeNode? lineageParent;
    FamilyTreeNode? spouseParent;
    bool isLineageFromSpouse = false;

    FamilyTreeNode? primarySpouse;
    if (root.spouses.isNotEmpty) {
      primarySpouse = root.spouses.firstWhere(
        (s) => s.parents.isNotEmpty || s.siblings.isNotEmpty,
        orElse: () => root.spouses.first,
      );
    }

    final candidateParents = <FamilyTreeNode>[];
    if (root.parents.isNotEmpty) {
      candidateParents.addAll(root.parents);
    } else if (primarySpouse != null && primarySpouse.parents.isNotEmpty) {
      candidateParents.addAll(primarySpouse.parents);
      isLineageFromSpouse = true;
    }

    if (candidateParents.isNotEmpty) {
      final primaryParents = <FamilyTreeNode>[];
      for (final p in candidateParents) {
        final isSpouseOfOther = primaryParents.any((primary) =>
            primary.spouses.any((sp) => _isSameNode(sp, p)));
        if (!isSpouseOfOther) {
          primaryParents.add(p);
        }
      }

      if (primaryParents.length >= 2) {
        final p0 = primaryParents[0];
        final p1 = primaryParents[1];
        if (p0.parents.isNotEmpty || p0.siblings.isNotEmpty) {
          lineageParent = p0;
          spouseParent = p1;
        } else if (p1.parents.isNotEmpty || p1.siblings.isNotEmpty) {
          lineageParent = p1;
          spouseParent = p0;
        } else {
          if (p0.gender?.toLowerCase() == 'male') {
            lineageParent = p0;
            spouseParent = p1;
          } else {
            lineageParent = p1;
            spouseParent = p0;
          }
        }
      } else if (primaryParents.isNotEmpty) {
        lineageParent = primaryParents.first;
      }
    }

    FamilyTreeNode? grandFather;
    FamilyTreeNode? grandMother;
    if (lineageParent != null && lineageParent.parents.isNotEmpty) {
      if (lineageParent.parents.length >= 2) {
        final gp0 = lineageParent.parents[0];
        final gp1 = lineageParent.parents[1];
        if (gp0.gender?.toLowerCase() == 'female' ||
            (gp0.relationshipToViewer ?? gp0.directRelationship ?? '').toLowerCase().contains('mother') ||
            (gp0.relationshipToViewer ?? gp0.directRelationship ?? '').toLowerCase().contains('dadi')) {
          grandFather = gp1;
          grandMother = gp0;
        } else {
          grandFather = gp0;
          grandMother = gp1;
        }
      } else {
        grandFather = lineageParent.parents.first;
        if (grandFather.spouses.isNotEmpty) {
          grandMother = grandFather.spouses.first;
        }
      }
    }

    FamilyTreeNode? greatGrandFather;
    FamilyTreeNode? greatGrandMother;
    if (grandFather != null && grandFather.parents.isNotEmpty) {
      if (grandFather.parents.length >= 2) {
        final gg0 = grandFather.parents[0];
        final gg1 = grandFather.parents[1];
        if (gg0.gender?.toLowerCase() == 'female') {
          greatGrandFather = gg1;
          greatGrandMother = gg0;
        } else {
          greatGrandFather = gg0;
          greatGrandMother = gg1;
        }
      } else {
        greatGrandFather = grandFather.parents.first;
        if (greatGrandFather.spouses.isNotEmpty) {
          greatGrandMother = greatGrandFather.spouses.first;
        }
      }
    }

    // Great-Grandparents (Tier +3)
    if (greatGrandFather != null) {
      tiers.add(_GenerationTier(
        level: 3,
        units: [
          _TierUnit(
            person: greatGrandFather,
            spouse: greatGrandMother,
            contextRole: 'Great-Grandfather',
            children: [grandFather!],
          ),
        ],
      ));
    }

    // Grandparents (Tier +2)
    if (grandFather != null) {
      final gpUnits = <_TierUnit>[];
      final childrenOfGrandparents = <FamilyTreeNode>[
        lineageParent!,
        ...lineageParent.siblings,
      ];
      final gpChildren = grandFather.children.isNotEmpty
          ? grandFather.children
          : childrenOfGrandparents;
      gpUnits.add(_TierUnit(
        person: grandFather,
        spouse: grandMother ?? (grandFather.spouses.isNotEmpty ? grandFather.spouses.first : null),
        contextRole: 'Grandfather (Dada)',
        children: gpChildren,
      ));
      for (final s in grandFather.siblings) {
        gpUnits.add(_TierUnit(
          person: s,
          spouse: s.spouses.isNotEmpty ? s.spouses.first : null,
          contextRole: _getDisplayRelation(s),
          children: s.children,
        ));
      }
      tiers.add(_GenerationTier(level: 2, units: gpUnits));
    }

    // Parents & Uncles/Aunts & Gen 2 Cousins (Tier +1)
    if (lineageParent != null) {
      final parentUnits = <_TierUnit>[];
      final spouse = spouseParent ?? (lineageParent.spouses.isNotEmpty ? lineageParent.spouses.first : null);
      
      final childrenOfParents = <FamilyTreeNode>[];
      if (lineageParent.children.isNotEmpty) {
        for (final c in lineageParent.children) {
          if (!childrenOfParents.any((e) => _isSameNode(e, c))) {
            childrenOfParents.add(c);
          }
        }
      }
      if (!isLineageFromSpouse) {
        if (!childrenOfParents.any((e) => _isSameNode(e, root))) {
          childrenOfParents.add(root);
        }
        for (final s in root.siblings) {
          final r = (s.relationshipToViewer ?? s.directRelationship ?? s.relationshipType ?? '').toLowerCase();
          if (!r.contains('in_law') && !r.contains('in-law')) {
            if (!childrenOfParents.any((e) => _isSameNode(e, s))) {
              childrenOfParents.add(s);
            }
          }
        }
      } else if (primarySpouse != null) {
        if (!childrenOfParents.any((e) => _isSameNode(e, primarySpouse))) {
          childrenOfParents.add(primarySpouse);
        }
        for (final s in primarySpouse.siblings) {
          if (!childrenOfParents.any((e) => _isSameNode(e, s))) {
            childrenOfParents.add(s);
          }
        }
      }

      final parentRole = (lineageParent.gender?.toLowerCase() == 'male')
          ? (isLineageFromSpouse ? 'Father-in-law (Sasurji)' : 'Father')
          : (isLineageFromSpouse ? 'Mother-in-law (Sasuji)' : 'Mother');

      parentUnits.add(_TierUnit(
        person: lineageParent,
        spouse: spouse,
        contextRole: parentRole,
        children: childrenOfParents,
      ));

      for (final s in lineageParent.siblings) {
        final uncleAuntRole = (s.gender?.toLowerCase() == 'female')
            ? 'Paternal Aunt (Kaki)'
            : 'Paternal Uncle (Kaka)';
        parentUnits.add(_TierUnit(
          person: s,
          spouse: s.spouses.isNotEmpty ? s.spouses.first : null,
          contextRole: uncleAuntRole,
          children: s.children,
        ));
      }

      // Include children of granduncles/grandaunts (e.g. Dinesh Agarwal, Sunil Sharma)
      if (grandFather != null) {
        for (final s in grandFather.siblings) {
          for (final c in s.children) {
            final alreadyPresent = parentUnits.any((u) => _isSameNode(c, u.person));
            if (!alreadyPresent) {
              parentUnits.add(_TierUnit(
                person: c,
                spouse: c.spouses.isNotEmpty ? c.spouses.first : null,
                contextRole: _getDisplayRelation(c),
                children: c.children,
              ));
            }
          }
        }
      }

      // Include in-law parents
      final inLawParents = <FamilyTreeNode>[];
      if (!isLineageFromSpouse) {
        // From root.parents if in-laws were placed there
        for (final p in root.parents) {
          if (!_isSameNode(p, lineageParent) &&
              !_isSameNode(p, spouse)) {
            inLawParents.add(p);
          }
        }
        // Also check root.spouses' parents
        for (final sp in root.spouses) {
          for (final p in sp.parents) {
            if (!inLawParents.any((e) => _isSameNode(e, p))) {
              inLawParents.add(p);
            }
          }
        }
      }

      if (inLawParents.isNotEmpty) {
        FamilyTreeNode? maleParent;
        FamilyTreeNode? femaleParent;
        for (final p in inLawParents) {
          final gender = (p.gender ?? '').toLowerCase();
          final rel = (p.relationshipToViewer ?? p.directRelationship ?? '').toLowerCase();
          if (gender == 'male' || rel.contains('father')) {
            maleParent ??= p;
          } else {
            femaleParent ??= p;
          }
        }

        if (maleParent != null && femaleParent != null && maleParent != femaleParent) {
          final inLawChildren = <FamilyTreeNode>[
            ...root.spouses,
            ...root.siblings.where((s) {
              final r = (s.relationshipToViewer ?? s.directRelationship ?? '').toLowerCase();
              final name = s.fullName?.toLowerCase() ?? '';
              return r.contains('brother_in_law') ||
                  r.contains('brother-in-law') ||
                  (maleParent?.fullName != null &&
                      name.split(' ').last == maleParent!.fullName!.toLowerCase().split(' ').last);
            }),
          ];

          parentUnits.add(_TierUnit(
            person: maleParent,
            spouse: femaleParent,
            contextRole: _getDisplayRelation(maleParent),
            children: inLawChildren,
          ));
        } else {
          for (final p in inLawParents) {
            parentUnits.add(_TierUnit(
              person: p,
              spouse: p.spouses.isNotEmpty ? p.spouses.first : null,
              contextRole: _getDisplayRelation(p),
            ));
          }
        }
      }

      tiers.add(_GenerationTier(level: 1, units: parentUnits));
    }

    final rawRootRel = (root.relationshipToViewer ??
            root.directRelationship ??
            root.relationshipType ??
            '')
        .toLowerCase();
    final isRootMe = (currentUserId != null &&
            currentUserId.isNotEmpty &&
            (root.id == currentUserId || root.linkedUserId == currentUserId)) ||
        (focusUserId != null &&
            focusUserId!.isNotEmpty &&
            (root.id == focusUserId || root.linkedUserId == focusUserId)) ||
        rawRootRel == 'self' ||
        rawRootRel == 'me';

    final isViewerChildOfRoot = !isRootMe &&
        ((currentUserId != null &&
                currentUserId.isNotEmpty &&
                root.children.any((c) =>
                    c.id == currentUserId ||
                    c.linkedUserId == currentUserId ||
                    c.relationshipToViewer?.toLowerCase() == 'self' ||
                    c.directRelationship?.toLowerCase() == 'self')) ||
            root.children.any((c) =>
                c.relationshipToViewer?.toLowerCase() == 'self' ||
                c.directRelationship?.toLowerCase() == 'self'));

    final rootContextRole = isViewerChildOfRoot
        ? ((root.gender?.toLowerCase() == 'female') ? 'Mother' : 'Father')
        : (isRootMe ? 'Self' : null);

    // Root Node, Siblings & First Cousins (Tier 0)
    final rootUnits = <_TierUnit>[];
    final rootSpouse = primarySpouse ?? (root.spouses.isNotEmpty ? root.spouses.first : null);
    rootUnits.add(_TierUnit(
      person: root,
      spouse: rootSpouse,
      isRoot: true,
      contextRole: rootContextRole,
      children: root.children.isNotEmpty ? root.children : (rootSpouse?.children ?? const []),
    ));

    final allSiblings = <FamilyTreeNode>[];

    void addOrMergeSibling(FamilyTreeNode node) {
      final idx = allSiblings.indexWhere((e) => _isSameNode(e, node));
      if (idx == -1) {
        allSiblings.add(node);
      } else {
        final existing = allSiblings[idx];
        allSiblings[idx] = existing.copyWith(
          spouses: existing.spouses.isNotEmpty ? existing.spouses : node.spouses,
          children: existing.children.isNotEmpty ? existing.children : node.children,
          title: existing.title ?? node.title,
          gender: existing.gender ?? node.gender,
          dob: existing.dob ?? node.dob,
          photoUrl: existing.photoUrl ?? node.photoUrl,
          qrImageUrl: existing.qrImageUrl ?? node.qrImageUrl,
          linkedMobile: existing.linkedMobile ?? node.linkedMobile,
          isRegisteredUser: existing.isRegisteredUser ?? node.isRegisteredUser,
          isDeceased: existing.isDeceased ?? node.isDeceased,
          relationshipToViewer: (existing.relationshipToViewer != null &&
                  existing.relationshipToViewer!.toLowerCase().trim() != 'other' &&
                  existing.relationshipToViewer!.toLowerCase().trim() != 'member')
              ? existing.relationshipToViewer
              : (node.relationshipToViewer ?? existing.relationshipToViewer),
          directRelationship: (existing.directRelationship != null &&
                  existing.directRelationship!.toLowerCase().trim() != 'other' &&
                  existing.directRelationship!.toLowerCase().trim() != 'member')
              ? existing.directRelationship
              : (node.directRelationship ?? existing.directRelationship),
        );
      }
    }

    for (final s in root.siblings) {
      addOrMergeSibling(s);
    }
    for (final sp in root.spouses) {
      for (final s in sp.siblings) {
        final isRoot = _isSameNode(root, s);
        final isSpouse = _isSameNode(sp, s);
        if (!isRoot && !isSpouse) {
          addOrMergeSibling(s);
        }
      }
    }
    for (final p in candidateParents) {
      for (final c in p.children) {
        final isRoot = _isSameNode(root, c);
        final isSpouse = root.spouses.any((sp) => _isSameNode(sp, c));
        if (!isRoot && !isSpouse) {
          addOrMergeSibling(c);
        }
      }
    }

    for (final s in allSiblings) {
      String? contextRole;
      if (isLineageFromSpouse) {
        final g = s.gender?.toLowerCase();
        contextRole = (g == 'female') ? 'Sister-in-law (Nanad)' : 'Brother-in-law (Devar/Jeth)';
      } else {
        final g = s.gender?.toLowerCase();
        final r = (s.relationshipToViewer ?? s.directRelationship ?? '').toLowerCase();
        if (r.contains('brother')) {
          contextRole = 'Brother';
        } else if (r.contains('sister')) {
          contextRole = 'Sister';
        } else if (g == 'female') {
          contextRole = 'Sister';
        } else {
          contextRole = 'Brother';
        }
      }
      rootUnits.add(_TierUnit(
        person: s,
        spouse: s.spouses.isNotEmpty ? s.spouses.first : null,
        contextRole: contextRole,
        children: s.children,
      ));
    }

    // Include children of uncles/aunts (e.g. Meet Patel, Karan Agarwal, Pooja Sharma)
    if (lineageParent != null) {
      for (final s in lineageParent.siblings) {
        for (final c in s.children) {
          final alreadyPresent = rootUnits.any((u) => _isSameNode(c, u.person));
          if (!alreadyPresent) {
            rootUnits.add(_TierUnit(
              person: c,
              spouse: c.spouses.isNotEmpty ? c.spouses.first : null,
              contextRole: _getDisplayRelation(c),
              children: c.children,
            ));
          }
        }
      }
    }
    tiers.add(_GenerationTier(level: 0, units: rootUnits));

    // Descendants (Tiers -1, -2, -3, ...)
    final rawChildren = <FamilyTreeNode>[];
    for (final u in rootUnits) {
      for (final c in u.children) {
        if (!rawChildren.any((e) => _isSameNode(e, c))) {
          rawChildren.add(c);
        }
      }
    }
    for (final c in root.children) {
      if (!rawChildren.any((e) => _isSameNode(e, c))) {
        rawChildren.add(c);
      }
    }
    for (final sp in root.spouses) {
      for (final c in sp.children) {
        if (!rawChildren.any((e) => _isSameNode(e, c))) {
          rawChildren.add(c);
        }
      }
    }

    List<FamilyTreeNode> filterSpouses(List<FamilyTreeNode> list) {
      final allSpouseIds = <String>{};
      final allSpouseNames = <String>{};
      for (final c in list) {
        for (final sp in c.spouses) {
          if (sp.id != null && sp.id!.isNotEmpty) allSpouseIds.add(sp.id!);
          if (sp.fullName != null && sp.fullName!.isNotEmpty) {
            allSpouseNames.add(sp.fullName!.toLowerCase().trim());
          }
        }
      }
      return list.where((c) {
        if (c.id != null && allSpouseIds.contains(c.id)) return false;
        if (c.fullName != null && allSpouseNames.contains(c.fullName!.toLowerCase().trim())) {
          return false;
        }
        return true;
      }).toList();
    }

    List<FamilyTreeNode> currentChildren = filterSpouses(rawChildren);
    int currentLevel = -1;
    final visitedChildIds = <String>{};

    while (currentChildren.isNotEmpty) {
      currentChildren = currentChildren.where((c) {
        final key = c.id ?? c.fullName ?? '';
        if (key.isNotEmpty && visitedChildIds.contains(key)) return false;
        if (key.isNotEmpty) visitedChildIds.add(key);
        return true;
      }).toList();

      if (currentChildren.isEmpty) break;

      final tierUnits = <_TierUnit>[];
      final nextChildren = <FamilyTreeNode>[];

      for (final child in currentChildren) {
        final spouse = child.spouses.isNotEmpty ? child.spouses.first : null;

        String? contextRole;
        if (currentLevel == -1) {
          final isChildOfRoot = rootUnits.any((u) => u.isRoot && u.children.any((c) => _isSameNode(c, child)));
          final parentUnit = rootUnits.firstWhere(
            (u) => u.children.any((c) => _isSameNode(c, child)),
            orElse: () => rootUnits.first,
          );
          final g = child.gender?.toLowerCase();
          if (isChildOfRoot) {
            if (isViewerChildOfRoot) {
              final isMe = (currentUserId != null &&
                      (child.id == currentUserId || child.linkedUserId == currentUserId)) ||
                  child.relationshipToViewer?.toLowerCase() == 'self' ||
                  child.directRelationship?.toLowerCase() == 'self';
              if (isMe) {
                contextRole = 'Self';
              } else {
                contextRole = (g == 'female') ? 'Sister' : 'Brother';
              }
            } else {
              contextRole = (g == 'female') ? 'Daughter' : 'Son';
            }
          } else {
            final pRole = (parentUnit.contextRole ?? '').toLowerCase();
            if (pRole.contains('sister')) {
              contextRole = (g == 'female') ? 'Niece (Bhanji)' : 'Nephew (Bhanja)';
            } else {
              contextRole = (g == 'female') ? 'Niece (Bhatiji)' : 'Nephew (Bhatija)';
            }
          }
        } else if (currentLevel == -2) {
          final prevTier = tiers.firstWhere((t) => t.level == -1, orElse: () => tiers.last);
          final parentUnit = prevTier.units.firstWhere(
            (u) => u.children.any((c) => _isSameNode(c, child)),
            orElse: () => prevTier.units.first,
          );
          final pRole = (parentUnit.contextRole ?? '').toLowerCase();
          final g = child.gender?.toLowerCase();
          if (pRole.contains('nephew') || pRole.contains('niece')) {
            contextRole = (g == 'female') ? 'Grandniece' : 'Grandnephew';
          } else {
            contextRole = (g == 'female') ? 'Granddaughter (Poti)' : 'Grandson (Pota)';
          }
        } else if (currentLevel <= -3) {
          final g = child.gender?.toLowerCase();
          contextRole = (g == 'female') ? 'Great-Granddaughter' : 'Great-Grandson';
        }

        tierUnits.add(_TierUnit(
          person: child,
          spouse: spouse,
          contextRole: contextRole ?? _getDisplayRelation(child),
          children: child.children.isNotEmpty
              ? child.children
              : (spouse?.children ?? const []),
        ));

        if (child.children.isNotEmpty) {
          nextChildren.addAll(child.children);
        } else if (spouse != null && spouse.children.isNotEmpty) {
          nextChildren.addAll(spouse.children);
        }
      }

      tiers.add(_GenerationTier(level: currentLevel, units: tierUnits));
      currentChildren = filterSpouses(nextChildren);
      currentLevel--;
    }

    return tiers;
  }

  List<_LineageConnection> _getConnections(
    _GenerationTier parentTier,
    double parentTierLeft,
    _GenerationTier childTier,
    double childTierLeft,
  ) {
    final connections = <_LineageConnection>[];

    for (int pIdx = 0; pIdx < parentTier.units.length; pIdx++) {
      final pUnit = parentTier.units[pIdx];
      if (pUnit.children.isEmpty) continue;

      final pUnitLeft = parentTierLeft + _getUnitLeftInTier(parentTier, pIdx);
      final parentDropX = pUnitLeft + pUnit.coupleCenter;

      final childrenDropX = <double>[];
      for (int cIdx = 0; cIdx < childTier.units.length; cIdx++) {
        final cUnit = childTier.units[cIdx];
        final isPrimaryChild = pUnit.children.any((c) => _isSameNode(c, cUnit.person));
        final isSpouseChild = cUnit.spouse != null &&
            pUnit.children.any((c) => _isSameNode(c, cUnit.spouse!));

        if (isPrimaryChild) {
          final cUnitLeft = childTierLeft + _getUnitLeftInTier(childTier, cIdx);
          childrenDropX.add(cUnitLeft + 60.0);
        } else if (isSpouseChild) {
          final cUnitLeft = childTierLeft + _getUnitLeftInTier(childTier, cIdx);
          childrenDropX.add(cUnitLeft + 220.0);
        }
      }

      if (childrenDropX.isNotEmpty) {
        connections.add(_LineageConnection(
          parentDropX: parentDropX,
          childrenDropX: childrenDropX,
        ));
      }
    }

    // Fallback: If no explicit match found, connect the lineage parent to all children in next tier
    if (connections.isEmpty && childTier.units.isNotEmpty) {
      int bestParentIdx = parentTier.units.indexWhere((u) => u.children.isNotEmpty);
      if (bestParentIdx == -1) {
        bestParentIdx = parentTier.units.indexWhere((u) => u.isRoot);
      }
      if (bestParentIdx == -1) {
        bestParentIdx = 0;
      }
      final pUnit = parentTier.units[bestParentIdx];
      final pUnitLeft = parentTierLeft + _getUnitLeftInTier(parentTier, bestParentIdx);
      final parentDropX = pUnitLeft + pUnit.coupleCenter;

      final childrenDropX = <double>[];
      for (int cIdx = 0; cIdx < childTier.units.length; cIdx++) {
        final cUnit = childTier.units[cIdx];
        final rel = (cUnit.person.relationshipToViewer ??
                cUnit.person.directRelationship ??
                cUnit.contextRole ??
                '')
            .toLowerCase();
        if (rel.contains('in_law') || rel.contains('in-law')) continue;
        childrenDropX.add(childTierLeft + _getUnitLeftInTier(childTier, cIdx) + 60.0);
      }

      if (childrenDropX.isNotEmpty) {
        connections.add(_LineageConnection(
          parentDropX: parentDropX,
          childrenDropX: childrenDropX,
        ));
      }
    }

    return connections;
  }

  String? _getSpouseRole(
    FamilyTreeNode person,
    FamilyTreeNode spouse, {
    bool isRoot = false,
    String? personContextRole,
    String? currentUserId,
  }) {
    final isPersonMe = (currentUserId != null &&
            currentUserId.isNotEmpty &&
            (person.id == currentUserId || person.linkedUserId == currentUserId)) ||
        (focusUserId != null &&
            focusUserId!.isNotEmpty &&
            (person.id == focusUserId || person.linkedUserId == focusUserId)) ||
        (person.relationshipToViewer?.toLowerCase() == 'self') ||
        (person.directRelationship?.toLowerCase() == 'self') ||
        (personContextRole?.toLowerCase() == 'self');

    if (isPersonMe || (isRoot && (personContextRole == null || personContextRole == 'Self'))) {
      return (spouse.gender?.toLowerCase() == 'male') ? 'Husband' : 'Wife';
    }

    final roleSource = (personContextRole ??
            (person.relationshipToViewer != null &&
                    person.relationshipToViewer!.toLowerCase().trim() != 'other' &&
                    person.relationshipToViewer!.toLowerCase().trim() != 'member'
                ? person.relationshipToViewer!
                : (person.relationshipType != null &&
                        person.relationshipType!.toLowerCase().trim() != 'other' &&
                        person.relationshipType!.toLowerCase().trim() != 'member'
                    ? person.relationshipType!
                    : (person.directRelationship ?? '')))).toLowerCase().trim();
    if (roleSource.contains('father-in-law') || roleSource.contains('sasur')) {
      return 'Mother-in-law (Sasuji)';
    }
    if (roleSource.contains('mother-in-law') || roleSource.contains('sasu')) {
      return 'Father-in-law (Sasurji)';
    }
    if (roleSource.contains('great-grand') || roleSource.contains('great grand')) {
      return (spouse.gender?.toLowerCase() == 'male') ? 'Great-Grandfather' : 'Great-Grandmother';
    }
    if (roleSource.contains('grandfather') || roleSource.contains('dada') || roleSource.contains('nana')) {
      return 'Grandmother (Dadi)';
    }
    if (roleSource.contains('grandmother') || roleSource.contains('dadi') || roleSource.contains('nani')) {
      return 'Grandfather (Dada)';
    }
    if (roleSource == 'father' || (roleSource.contains('father') && !roleSource.contains('in-law') && !roleSource.contains('in_law'))) {
      return 'Mother';
    }
    if (roleSource == 'mother' || (roleSource.contains('mother') && !roleSource.contains('in-law') && !roleSource.contains('in_law'))) {
      return 'Father';
    }
    if (roleSource.contains('brother')) {
      return 'Sister-in-law (Bhabhi)';
    }
    if (roleSource.contains('sister')) {
      return 'Brother-in-law (Jija)';
    }
    if (roleSource.contains('uncle') || roleSource.contains('kaka')) {
      return 'Paternal Aunt (Kaki)';
    }
    if (roleSource.contains('aunt') || roleSource.contains('kaki')) {
      return 'Paternal Uncle (Kaka)';
    }
    if (roleSource.contains('son')) {
      return 'Daughter-in-law (Bahu)';
    }
    if (roleSource.contains('daughter')) {
      return 'Son-in-law (Damad)';
    }
    if (roleSource.contains('nephew')) {
      return 'Niece-in-law (Bahu)';
    }
    if (roleSource.contains('niece')) {
      return 'Nephew-in-law (Damad)';
    }

    final spouseRel = (spouse.relationshipToViewer != null &&
            spouse.relationshipToViewer!.toLowerCase().trim() != 'other' &&
            spouse.relationshipToViewer!.toLowerCase().trim() != 'member'
        ? spouse.relationshipToViewer!
        : (spouse.directRelationship ?? spouse.relationshipType ?? '')).toLowerCase().trim();
    if (spouseRel.isNotEmpty &&
        spouseRel != 'spouse' &&
        spouseRel != 'wife' &&
        spouseRel != 'husband' &&
        spouseRel != 'other' &&
        spouseRel != 'member') {
      return _getDisplayRelation(spouse);
    }

    final rel = (personContextRole ??
            (person.relationshipToViewer != null &&
                    person.relationshipToViewer!.toLowerCase().trim() != 'other' &&
                    person.relationshipToViewer!.toLowerCase().trim() != 'member'
                ? person.relationshipToViewer!
                : (person.directRelationship ?? person.relationshipType ?? '')))
        .toLowerCase();
    if (rel.contains('great-grand') || rel.contains('great grand')) {
      return (spouse.gender?.toLowerCase() == 'male') ? 'Great-Grandfather' : 'Great-Grandmother';
    }
    if (rel.contains('grandfather') || rel.contains('grand father') || rel.contains('dada') || rel.contains('nana')) {
      return 'Grandmother (Dadi)';
    }
    if (rel.contains('grandmother') || rel.contains('grand mother') || rel.contains('dadi') || rel.contains('nani')) {
      return 'Grandfather (Dada)';
    }
    if (rel.contains('father_in_law') || rel.contains('father-in-law') || rel.contains('sasur')) {
      return 'Mother-in-law (Sasuji)';
    }
    if (rel.contains('mother_in_law') || rel.contains('mother-in-law') || rel.contains('sasu')) {
      return 'Father-in-law (Sasurji)';
    }
    if (rel.contains('father')) {
      return 'Mother';
    }
    if (rel.contains('mother')) {
      return 'Father';
    }
    if (rel.contains('son')) {
      return 'Daughter-in-law (Bahu)';
    }
    if (rel.contains('daughter')) {
      return 'Son-in-law (Damad)';
    }
    if (rel.contains('brother')) {
      return 'Sister-in-law (Bhabhi)';
    }
    if (rel.contains('sister')) {
      return 'Brother-in-law (Jija)';
    }
    if (rel.contains('uncle') || rel.contains('kaka')) {
      return 'Paternal Aunt (Kaki)';
    }
    if (rel.contains('aunt') || rel.contains('kaki')) {
      return 'Paternal Uncle (Kaka)';
    }
    return (spouse.gender?.toLowerCase() == 'male') ? 'Husband' : 'Wife';
  }

  String _getDisplayRelation(
    FamilyTreeNode node, {
    bool isCurrentUserId = false,
    String? contextRole,
  }) {
    if (isCurrentUserId) return 'Self';
    if (contextRole != null && contextRole.isNotEmpty) return contextRole;

    final rel = (node.relationshipToViewer != null &&
            node.relationshipToViewer!.toLowerCase().trim() != 'other' &&
            node.relationshipToViewer!.toLowerCase().trim() != 'member' &&
            node.relationshipToViewer!.trim().isNotEmpty)
        ? node.relationshipToViewer!
        : (node.directRelationship ?? node.relationshipType ?? 'Member');

    final relLower = rel.toLowerCase().trim();

    if (relLower == 'self' || relLower == 'me') {
      return '';
    }

    if (relLower == 'father') return 'Father';
    if (relLower == 'mother') return 'Mother';
    if (relLower == 'brother') return 'Brother';
    if (relLower == 'sister') return 'Sister';
    if (relLower == 'son') return 'Son';
    if (relLower == 'daughter') return 'Daughter';
    if (relLower == 'husband') return 'Husband';
    if (relLower == 'wife') return 'Wife';
    if (relLower == 'nephew' || relLower == 'bhatija') return 'Nephew (Bhatija)';
    if (relLower == 'niece' || relLower == 'bhatiji') return 'Niece (Bhatiji)';
    if (relLower == 'grandnephew') return 'Grandnephew';
    if (relLower == 'grandniece') return 'Grandniece';

    if (relLower == 'father_in_law' || relLower == 'father-in-law') {
      return 'Father-in-law (Sasurji)';
    }
    if (relLower == 'mother_in_law' || relLower == 'mother-in-law') {
      return 'Mother-in-law (Sasuji)';
    }
    if (relLower == 'brother_in_law' || relLower == 'brother-in-law') {
      return 'Brother-in-law (Sala)';
    }
    if (relLower == 'sister_in_law' || relLower == 'sister-in-law') {
      return 'Sister-in-law (Bhabhi)';
    }
    if (relLower == 'son_in_law' || relLower == 'son-in-law') {
      return 'Son-in-law (Damad)';
    }
    if (relLower == 'daughter_in_law' || relLower == 'daughter-in-law') {
      return 'Daughter-in-law (Bahu)';
    }
    if (relLower == 'paternal grandfather' || relLower == 'paternal_grandfather') {
      return 'Grandfather (Dada)';
    }
    if (relLower == 'paternal grandmother' || relLower == 'paternal_grandmother') {
      return 'Grandmother (Dadi)';
    }
    if (relLower == 'paternal uncle' || relLower == 'paternal_uncle') {
      return 'Paternal Uncle (Kaka)';
    }
    if (relLower == 'paternal aunt' || relLower == 'paternal_aunt') {
      return 'Paternal Aunt (Kaki)';
    }
    if (relLower == 'great grandson' || relLower == 'great_grandson') {
      return 'Great-Grandson';
    }
    if (relLower == 'grandson') {
      return 'Grandson (Pota)';
    }
    if (relLower == 'granddaughter') {
      return 'Granddaughter (Poti)';
    }

    return RelationDisplayHelper.format(rel);
  }

  Widget _buildSpouseConnector() {
    return SizedBox(
      width: 40,
      height: 76,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 8, height: 2, color: AppColors.orange),
              Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  color: AppColors.orangeLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.favorite,
                  size: 10,
                  color: AppColors.orange,
                ),
              ),
              Container(width: 8, height: 2, color: AppColors.orange),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTreeNode(
    FamilyTreeNode node,
    BuildContext context, {
    bool isRoot = false,
    String? currentUserId,
    String? contextRole,
  }) {
    final rawRel = (node.relationshipToViewer ??
            node.directRelationship ??
            node.relationshipType ??
            '')
        .toLowerCase();

    final isCurrentUserId = (currentUserId != null &&
            currentUserId.isNotEmpty &&
            (node.id == currentUserId || node.linkedUserId == currentUserId));

    final isMe = rawRel == 'self' ||
        rawRel == 'me' ||
        node.relationshipToViewer?.toLowerCase() == 'self' ||
        node.directRelationship?.toLowerCase() == 'self' ||
        node.relationshipType?.toLowerCase() == 'self' ||
        isCurrentUserId ||
        (focusUserId != null &&
            focusUserId!.isNotEmpty &&
            (node.id == focusUserId || node.linkedUserId == focusUserId));

    final relation = _getDisplayRelation(node, isCurrentUserId: isCurrentUserId, contextRole: contextRole);
    final name = node.fullName ?? 'Unknown';
    final isDeceased = node.isDeceased == true ||
        (node.title != null && node.title!.toLowerCase().contains('late'));
    final isMinor = node.isMinor ?? false;


    final isRegistered = node.isRegisteredUser == true ||
        (node.linkedUserId != null && node.linkedUserId!.isNotEmpty );

    final targetProfileId = node.linkedUserId ??
        (node.isRegisteredUser == true ? node.id : null);

    String fallbackAsset = 'assets/images/young_male_avatar.jpg';
    final relLower = relation.toLowerCase();
    final genderLower = (node.gender ?? '').toLowerCase();

    if (relLower.contains('grand') ||
        relLower == 'father' ||
        relLower == 'mother' ||
        relLower.contains('in_law') ||
        relLower.contains('in-law')) {
      fallbackAsset = (genderLower == 'female' || relLower.contains('mother'))
          ? 'assets/images/older_female_avatar.jpg'
          : 'assets/images/older_male_avatar.jpg';
    } else if (genderLower == 'female' ||
        relLower == 'sister' ||
        relLower == 'daughter' ||
        relLower == 'wife') {
      fallbackAsset = 'assets/images/young_female_avatar.jpg';
    } else {
      fallbackAsset = 'assets/images/young_male_avatar.jpg';
    }

    return GestureDetector(
      onTap: () {
        if (isMe) {
          return;
        }
        if (isEditable) {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (ctx) => FamilyNodeActionsSheet(node: node),
          );
          return;
        }
        if (isRegistered && targetProfileId != null) {
          if (currentUserId != null && targetProfileId == currentUserId) {
            return;
          }
          if (focusUserId != null && targetProfileId == focusUserId) {
            return;
          }
          context.push('/profile_view', extra: {
            'id': targetProfileId,
            'isFromMyFamilyTree': isEditable,
            'node': node,
          });
        } else {
          AppMessenger.showInfo(
            'This family member is not registered on the app.',
          );
        }
      },
      child: Container(
        width: 120,
        constraints: const BoxConstraints(minHeight: 136),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
          color: isDeceased
              ? AppColors.cream
              : (isMe ? AppColors.orangeLight : Colors.white),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isDeceased
                ? AppColors.textMuted
                : (isMe
                    ? AppColors.orange
                    : (isRegistered
                        ? AppColors.indigo
                        : AppColors.border.withValues(alpha: 0.6))),
            width: (isMe || isRegistered) ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isMe ? 0.12 : (isRegistered ? 0.08 : 0.04)),
              blurRadius: isMe ? 15 : 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                AppAvatar(
                  imageUrl: node.photoUrl,
                  size: 52,
                  fallbackWidget: ClipRRect(
                    borderRadius: BorderRadius.circular(26),
                    child: Image.asset(
                      fallbackAsset,
                      fit: BoxFit.cover,
                      width: 52,
                      height: 52,
                    ),
                  ),
                ),
                if (isDeceased)
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.4),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.white70,
                      size: 20,
                    ),
                  ),
                if (!isMe)
                  Positioned(
                    top: -6,
                    right: -10,
                    child: Builder(
                      builder: (context) {
                        String text = '';
                        Color bgColor = AppColors.textMuted;
                        if (isDeceased) {
                          text = 'Late';
                        } else if (isMinor) {
                          text = 'Minor';
                        } else if (!isRegistered) {
                          text = 'Unverified';
                        } else {
                          text = 'Linked';
                          bgColor = const Color(0xFF10B981);
                        }

                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: bgColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.white, width: 1.5),
                          ),
                          child: Text(
                            text,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            TranslatedText(
              name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isDeceased ? AppColors.textMuted : AppColors.textDark,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 6),
            if (relation.isNotEmpty && relation.toLowerCase() != 'other')
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: isMe ? Colors.white : AppColors.cream,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: TranslatedText(
                  relation,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textMuted,
                    height: 1.1,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

}

class _GenerationTier {
  final int level;
  final List<_TierUnit> units;

  const _GenerationTier({
    required this.level,
    required this.units,
  });
}

class _TierUnit {
  final FamilyTreeNode person;
  final FamilyTreeNode? spouse;
  final bool isRoot;
  final String? contextRole;
  final List<FamilyTreeNode> children;

  const _TierUnit({
    required this.person,
    this.spouse,
    this.isRoot = false,
    this.contextRole,
    this.children = const [],
  });

  double get width => spouse != null ? 280.0 : 120.0;
  double get coupleCenter => spouse != null ? 140.0 : 60.0;
}

class _LineageConnection {
  final double parentDropX;
  final List<double> childrenDropX;

  const _LineageConnection({
    required this.parentDropX,
    required this.childrenDropX,
  });
}

class _TierConnectorPainter extends CustomPainter {
  final List<_LineageConnection> connections;

  const _TierConnectorPainter({
    required this.connections,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.border
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    for (final conn in connections) {
      final parentX = conn.parentDropX;
      final children = conn.childrenDropX;

      if (children.isEmpty) {
        canvas.drawLine(Offset(parentX, 0), Offset(parentX, 16.0), paint);
        continue;
      }

      if (children.length == 1) {
        final childX = children.first;
        if ((parentX - childX).abs() < 2.0) {
          canvas.drawLine(Offset(parentX, 0), Offset(parentX, 32.0), paint);
        } else {
          const r = 8.0;
          final dir = childX > parentX ? 1.0 : -1.0;
          final actualR = math.min(r, (parentX - childX).abs() / 2.0);

          final path = Path()
            ..moveTo(parentX, 0)
            ..lineTo(parentX, 16.0 - actualR)
            ..quadraticBezierTo(
              parentX,
              16.0,
              parentX + (dir * actualR),
              16.0,
            )
            ..lineTo(childX - (dir * actualR), 16.0)
            ..quadraticBezierTo(
              childX,
              16.0,
              childX,
              16.0 + actualR,
            )
            ..lineTo(childX, 32.0);
          canvas.drawPath(path, paint);
        }
      } else {
        final minChildX = children.reduce(math.min);
        final maxChildX = children.reduce(math.max);
        final branchStartX = math.min(parentX, minChildX);
        final branchEndX = math.max(parentX, maxChildX);

        // 1. Parent trunk down to branch line
        canvas.drawLine(Offset(parentX, 0), Offset(parentX, 16.0), paint);

        // 2. Continuous horizontal branch line spanning all children and parent
        canvas.drawLine(
          Offset(branchStartX, 16.0),
          Offset(branchEndX, 16.0),
          paint,
        );

        // 3. Child vertical drops from branch line down into each child card
        for (final childX in children) {
          canvas.drawLine(
            Offset(childX, 16.0),
            Offset(childX, 32.0),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _TierConnectorPainter oldDelegate) {
    if (oldDelegate.connections.length != connections.length) return true;
    for (int i = 0; i < connections.length; i++) {
      if (oldDelegate.connections[i].parentDropX != connections[i].parentDropX) {
        return true;
      }
      if (oldDelegate.connections[i].childrenDropX.length !=
          connections[i].childrenDropX.length) {
        return true;
      }
    }
    return false;
  }
}
