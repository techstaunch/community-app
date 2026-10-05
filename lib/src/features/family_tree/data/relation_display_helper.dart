/// Maps raw relationship type strings from the API to user-friendly display names.
///
/// Used by both the family tree canvas and the bottom sheet to ensure
/// consistent relationship labels throughout the UI.
class RelationDisplayHelper {
  RelationDisplayHelper._();

  /// Converts a raw relationship string (e.g. 'father_in_law') to a
  /// user-friendly display name (e.g. 'Father-in-law (Sasurji)').
  static String format(String? rawRelation) {
    final rel = rawRelation ?? 'Member';
    final relLower = rel.toLowerCase().trim();

    const mapping = <String, String>{
      'father_in_law': 'Father-in-law (Sasurji)',
      'father-in-law': 'Father-in-law (Sasurji)',
      'mother_in_law': 'Mother-in-law (Sasuji)',
      'mother-in-law': 'Mother-in-law (Sasuji)',
      'brother_in_law': 'Brother-in-law (Sala)',
      'brother-in-law': 'Brother-in-law (Sala)',
      'sister_in_law': 'Sister-in-law (Bhabhi)',
      'sister-in-law': 'Sister-in-law (Bhabhi)',
      'son_in_law': 'Son-in-law (Damad)',
      'son-in-law': 'Son-in-law (Damad)',
      'daughter_in_law': 'Daughter-in-law (Bahu)',
      'daughter-in-law': 'Daughter-in-law (Bahu)',
      'paternal grandfather': 'Grandfather (Dada)',
      'paternal_grandfather': 'Grandfather (Dada)',
      'paternal grandmother': 'Grandmother (Dadi)',
      'paternal_grandmother': 'Grandmother (Dadi)',
      'paternal uncle': 'Paternal Uncle (Kaka)',
      'paternal_uncle': 'Paternal Uncle (Kaka)',
      'paternal aunt': 'Paternal Aunt (Kaki)',
      'paternal_aunt': 'Paternal Aunt (Kaki)',
      'great grandson': 'Great-Grandson',
      'great_grandson': 'Great-Grandson',
      'grandson': 'Grandson (Pota)',
      'granddaughter': 'Granddaughter (Poti)',
    };

    return mapping[relLower] ?? rel;
  }

  /// Resolves the best available relationship string from a family tree node's
  /// multiple relationship fields, in order of priority.
  static String resolve({
    String? relationshipToViewer,
    String? directRelationship,
    String? relationshipType,
  }) {
    final raw = relationshipToViewer ?? directRelationship ?? relationshipType ?? 'Member';
    return format(raw);
  }
}
