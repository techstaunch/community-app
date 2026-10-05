import 'family_models.dart';

/// KinshipEngine handles bidirectional reciprocal relationships,
/// generational tier calculation, and multi-hop kinship resolution
/// as specified in the Community Connect Family Tree Architecture.
///
/// NOTE: Maternal relationships (Nana, Nani, Mama, Mami, etc.) are excluded
/// as per the project requirements; focuses strictly on Paternal and direct lines.
class KinshipEngine {
  /// Resolves the generational level relative to Self (Level 0)
  /// - Level +2: Grandparents (Dada, Dadi)
  /// - Level +1: Parents & In-laws (Father, Mother, Sasurji, Sasuji, Kaka, Bua)
  /// - Level  0: Current / Peer Generation (Self, Spouse, Brother, Sister, Cousin, In-laws)
  /// - Level -1: Children & In-laws (Son, Daughter, Damad, Bahu, Bhatija, Bhatiji)
  /// - Level -2: Grandchildren (Pota, Poti)
  /// - Level -3: Great-Grandchildren (Pardota, Pardoti)
  static int getGenerationalLevel(String relationship) {
    final rel = relationship.trim().toLowerCase();
    
    // Level +2: Grandparents
    if (rel.contains('great-grand') || rel.contains('great grand')) {
      if (rel.contains('father') || rel.contains('mother') || rel.contains('parent')) {
        return 3; // Level +3 if great-grandparents exist
      }
    }
    if (rel.contains('grand') && (rel.contains('father') || rel.contains('mother') || rel.contains('parent') || rel.contains('dada') || rel.contains('dadi'))) {
      return 2;
    }
    
    // Level +1: Parents & In-Laws
    if (rel == 'father' || rel == 'mother' || rel == 'parent' ||
        rel.contains('pitaji') || rel.contains('papa') || rel.contains('mataji') || rel.contains('mummy') ||
        rel.contains('father-in-law') || rel.contains('mother-in-law') || rel.contains('sasur') || rel.contains('sasu') ||
        rel.contains('uncle') || rel.contains('kaka') || rel.contains('tau') ||
        rel.contains('aunt') || rel.contains('kaki') || rel.contains('bua') || rel.contains('fui')) {
      return 1;
    }
    
    // Level 0: Self, Spouse, Siblings, Cousins, Peers
    if (rel == 'self' || rel == 'me' ||
        rel == 'spouse' || rel == 'husband' || rel == 'wife' || rel.contains('pati') || rel.contains('patni') ||
        rel == 'brother' || rel == 'sister' || rel == 'sibling' || rel.contains('bhai') || rel.contains('behen') ||
        rel.contains('brother-in-law') || rel.contains('sister-in-law') || rel.contains('sala') || rel.contains('jija') || rel.contains('devar') || rel.contains('bhabhi') ||
        rel.contains('cousin')) {
      return 0;
    }
    
    // Level -1: Children & In-Laws
    if (rel == 'son' || rel == 'daughter' || rel == 'child' || rel.contains('beta') || rel.contains('beti') ||
        rel.contains('son-in-law') || rel.contains('daughter-in-law') || rel.contains('damad') || rel.contains('bahu') ||
        rel.contains('nephew') || rel.contains('niece') || rel.contains('bhatija') || rel.contains('bhatiji')) {
      return -1;
    }
    
    // Level -2: Grandchildren
    if (rel == 'grandson' || rel == 'granddaughter' || rel == 'grandchild' || rel.contains('pota') || rel.contains('poti') || rel.contains('dohitra') || rel.contains('dohitri')) {
      return -2;
    }

    // Level -3: Great-Grandchildren
    if (rel.contains('great-grandson') || rel.contains('great-granddaughter') || rel.contains('great grandchild') || rel.contains('pardota') || rel.contains('pardoti')) {
      return -3;
    }
    
    return 0;
  }

  /// Calculates reciprocal title that User B sees for User A based on User A's gender.
  /// Example: When User A (Male) adds User B as "Father", User B sees User A as "Son".
  static String calculateReciprocal({
    required String directRelation,
    required String viewerGender,
  }) {
    final rel = directRelation.trim().toLowerCase();
    final isMale = viewerGender.trim().toLowerCase() == 'male';

    if (rel == 'father' || rel == 'mother') {
      return isMale ? 'Son' : 'Daughter';
    }
    if (rel == 'son' || rel == 'daughter' || rel == 'child') {
      return isMale ? 'Father' : 'Mother';
    }
    if (rel == 'husband') {
      return 'Wife';
    }
    if (rel == 'wife') {
      return 'Husband';
    }
    if (rel == 'spouse') {
      return isMale ? 'Husband' : 'Wife';
    }
    if (rel == 'brother' || rel == 'sister' || rel == 'sibling') {
      return isMale ? 'Brother' : 'Sister';
    }
    if (rel.contains('grandfather') || rel.contains('grandmother') || rel.contains('dada') || rel.contains('dadi')) {
      return isMale ? 'Grandson (Pota)' : 'Granddaughter (Poti)';
    }
    if (rel.contains('grandson') || rel.contains('granddaughter')) {
      return isMale ? 'Paternal Grandfather (Dada)' : 'Paternal Grandmother (Dadi)';
    }
    if (rel == 'father-in-law' || rel == 'mother-in-law') {
      return isMale ? 'Son-in-law (Damad)' : 'Daughter-in-law (Bahu)';
    }
    if (rel == 'son-in-law' || rel == 'daughter-in-law') {
      return isMale ? 'Father-in-law (Sasurji)' : 'Mother-in-law (Sasuji)';
    }
    if (rel.contains('uncle') || rel.contains('kaka') || rel.contains('aunt') || rel.contains('bua')) {
      return isMale ? 'Nephew (Bhatija)' : 'Niece (Bhatiji)';
    }
    if (rel.contains('nephew') || rel.contains('niece') || rel.contains('bhatija') || rel.contains('bhatiji')) {
      return isMale ? 'Paternal Uncle (Kaka)' : 'Paternal Aunt (Bua)';
    }
    if (rel.contains('cousin')) {
      return 'Cousin';
    }
    if (rel.contains('great-grandson') || rel.contains('great-granddaughter') || rel.contains('great grandchild')) {
      return isMale ? 'Great-Grandfather' : 'Great-Grandmother';
    }
    if (rel.contains('great-grandfather') || rel.contains('great-grandmother')) {
      return isMale ? 'Great-Grandson (Pardota)' : 'Great-Granddaughter (Pardoti)';
    }

    return 'Relative';
  }

  /// Multi-Hop Kinship Resolution
  /// Resolves the relationship from Viewer's perspective by traversing path hops.
  /// E.g. [Father, Brother, Son] -> "Cousin"
  static String resolveMultiHopPath(List<String> hops, {String? targetGender}) {
    if (hops.isEmpty) return 'Self';
    if (hops.length == 1) return hops.first;

    final normalized = hops.map((h) => h.toLowerCase().trim()).toList();
    final isTargetFemale = (targetGender ?? '').toLowerCase() == 'female';

    // 2-Hop Resolutions
    if (normalized.length == 2) {
      final h1 = normalized[0];
      final h2 = normalized[1];

      // Father -> Father = Paternal Grandfather
      if (h1 == 'father' && h2 == 'father') return 'Paternal Grandfather (Dada)';
      // Father -> Mother = Paternal Grandmother
      if (h1 == 'father' && h2 == 'mother') return 'Paternal Grandmother (Dadi)';
      // Father -> Brother = Paternal Uncle (Kaka)
      if (h1 == 'father' && (h2 == 'brother' || h2 == 'sibling')) return 'Paternal Uncle (Kaka)';
      // Father -> Sister = Paternal Aunt (Bua)
      if (h1 == 'father' && h2 == 'sister') return 'Paternal Aunt (Bua)';
      
      // Sibling -> Son = Nephew (Bhatija)
      if ((h1 == 'brother' || h1 == 'sister') && h2 == 'son') return 'Nephew (Bhatija)';
      // Sibling -> Daughter = Niece (Bhatiji)
      if ((h1 == 'brother' || h1 == 'sister') && h2 == 'daughter') return 'Niece (Bhatiji)';

      // Spouse -> Father = Father-in-law (Sasurji)
      if ((h1 == 'husband' || h1 == 'wife' || h1 == 'spouse') && h2 == 'father') return 'Father-in-law (Sasurji)';
      // Spouse -> Mother = Mother-in-law (Sasuji)
      if ((h1 == 'husband' || h1 == 'wife' || h1 == 'spouse') && h2 == 'mother') return 'Mother-in-law (Sasuji)';
      // Spouse -> Brother = Brother-in-law (Devar/Jija/Sala)
      if ((h1 == 'husband' || h1 == 'wife' || h1 == 'spouse') && h2 == 'brother') return 'Brother-in-law (Devar/Sala)';
      // Spouse -> Sister = Sister-in-law (Nanad/Bhabhi/Sali)
      if ((h1 == 'husband' || h1 == 'wife' || h1 == 'spouse') && h2 == 'sister') return 'Sister-in-law (Nanad/Sali)';

      // Sibling -> Spouse
      if (h1 == 'brother' && (h2 == 'wife' || h2 == 'spouse')) return 'Sister-in-law (Bhabhi)';
      if (h1 == 'sister' && (h2 == 'husband' || h2 == 'spouse')) return 'Brother-in-law (Jija)';

      // Grandparent relations
      if (h1.contains('grandfather') && (h2 == 'brother' || h2 == 'sibling')) return 'Great-Uncle (Dada)';
      if (h1.contains('grandfather') && h2 == 'father') return 'Great-Grandfather';
      if (h1.contains('grandfather') && h2 == 'mother') return 'Great-Grandmother';

      // Child -> Son = Grandson (Pota)
      if ((h1 == 'son' || h1 == 'daughter') && h2 == 'son') return 'Grandson (Pota)';
      // Child -> Daughter = Granddaughter (Poti)
      if ((h1 == 'son' || h1 == 'daughter') && h2 == 'daughter') return 'Granddaughter (Poti)';
      // Child -> Spouse
      if (h1 == 'son' && (h2 == 'wife' || h2 == 'spouse')) return 'Daughter-in-law (Bahu)';
      if (h1 == 'daughter' && (h2 == 'husband' || h2 == 'spouse')) return 'Son-in-law (Damad)';
    }

    // 3-Hop Resolutions
    if (normalized.length == 3) {
      final h1 = normalized[0];
      final h2 = normalized[1];
      final h3 = normalized[2];

      // Father -> Brother -> Son/Daughter = Cousin
      if (h1 == 'father' && (h2 == 'brother' || h2 == 'sibling') && (h3 == 'son' || h3 == 'daughter' || h3 == 'child')) {
        return isTargetFemale ? 'Cousin (Sister)' : 'Cousin (Brother)';
      }
      // Father -> Brother -> Wife = Paternal Aunt (Kaki)
      if (h1 == 'father' && (h2 == 'brother' || h2 == 'sibling') && (h3 == 'wife' || h3 == 'spouse')) {
        return 'Paternal Aunt (Kaki)';
      }
      // Father -> Sister -> Husband = Paternal Uncle (Fupa)
      if (h1 == 'father' && h2 == 'sister' && (h3 == 'husband' || h3 == 'spouse')) {
        return 'Paternal Uncle (Fupa)';
      }
      // Grandparent -> Parent -> Child
      if ((h1 == 'grandfather' || h1 == 'grandmother') && (h2 == 'father' || h2 == 'mother') && (h3 == 'son' || h3 == 'daughter')) {
        return isTargetFemale ? 'Sister' : 'Brother';
      }
      // Child -> Child -> Child = Great-Grandchild
      if ((h1 == 'son' || h1 == 'daughter') && (h2 == 'son' || h2 == 'daughter') && (h3 == 'son' || h3 == 'daughter')) {
        return isTargetFemale ? 'Great-Granddaughter (Pardoti)' : 'Great-Grandson (Pardota)';
      }
    }

    return isTargetFemale ? 'Relative (Female)' : 'Relative (Male)';
  }

  /// Traverses the family tree to discover the kinship path from Root (Viewer) to Target
  static List<KinshipHop>? findPathToMember(FamilyTreeNode root, String targetId) {
    if (root.id == targetId) {
      return [KinshipHop(node: root, relationToPrev: 'Self')];
    }

    final visited = <String>{};

    List<KinshipHop>? dfs(FamilyTreeNode current, List<KinshipHop> currentPath) {
      if (current.id != null) {
        if (visited.contains(current.id)) return null;
        visited.add(current.id!);
      }

      if (current.id == targetId) {
        return currentPath;
      }

      // Check parents
      for (final p in current.parents) {
        final res = dfs(p, [...currentPath, KinshipHop(node: p, relationToPrev: p.directRelationship ?? p.relationshipType ?? 'Parent')]);
        if (res != null) return res;
      }

      // Check spouses
      for (final sp in current.spouses) {
        final res = dfs(sp, [...currentPath, KinshipHop(node: sp, relationToPrev: sp.directRelationship ?? sp.relationshipType ?? 'Spouse')]);
        if (res != null) return res;
      }

      // Check siblings
      for (final s in current.siblings) {
        final res = dfs(s, [...currentPath, KinshipHop(node: s, relationToPrev: s.directRelationship ?? s.relationshipType ?? 'Sibling')]);
        if (res != null) return res;
      }

      // Check children
      for (final c in current.children) {
        final res = dfs(c, [...currentPath, KinshipHop(node: c, relationToPrev: c.directRelationship ?? c.relationshipType ?? 'Child')]);
        if (res != null) return res;
      }

      return null;
    }

    return dfs(root, [KinshipHop(node: root, relationToPrev: 'Self')]);
  }
}

class KinshipHop {
  final FamilyTreeNode node;
  final String relationToPrev;

  const KinshipHop({
    required this.node,
    required this.relationToPrev,
  });
}
