import 'family_models.dart';

class FamilyTreeMock {
  static FamilyTreeNode create5GenerationTree() {
    // Generation 1: Great-Grandparents
    final greatGrandfather = const FamilyTreeNode(
      id: 'mock-ggf-1',
      fullName: 'Govindram Agarwal',
      gender: 'Male',
      dob: '1920-05-10',
      relationshipType: 'Great Grandfather',
      directRelationship: 'Great Grandfather',
      relationshipToViewer: 'Great Grandfather',
      isDeceased: true,
      isRegisteredUser: false,
    );

    final greatGrandmother = const FamilyTreeNode(
      id: 'mock-ggm-1',
      fullName: 'Rukmini Devi',
      gender: 'Female',
      dob: '1924-08-12',
      relationshipType: 'Great Grandmother',
      directRelationship: 'Great Grandmother',
      relationshipToViewer: 'Great Grandmother',
      isDeceased: true,
      isRegisteredUser: false,
    );

    // Generation 2: Grandparents (Parents of Father)
    final grandmother = const FamilyTreeNode(
      id: 'mock-gm-1',
      fullName: 'Shakuntala Devi',
      gender: 'Female',
      dob: '1948-11-20',
      relationshipType: 'Grandmother',
      directRelationship: 'Grandmother',
      relationshipToViewer: 'Paternal Grandmother',
      isDeceased: false,
      isRegisteredUser: false,
    );

    final grandfather = FamilyTreeNode(
      id: 'mock-gf-1',
      fullName: 'Rameshchandra Agarwal',
      gender: 'Male',
      dob: '1945-08-15',
      relationshipType: 'Grandfather',
      directRelationship: 'Grandfather',
      relationshipToViewer: 'Paternal Grandfather',
      isDeceased: false,
      isRegisteredUser: true,
      linkedUserId: 'mock-user-gf',
      parents: [greatGrandfather, greatGrandmother],
    );

    // Generation 3: Parents & Uncle
    final mother = const FamilyTreeNode(
      id: 'mock-m-1',
      fullName: 'Sunita Agarwal',
      gender: 'Female',
      dob: '1974-06-25',
      relationshipType: 'Mother',
      directRelationship: 'Mother',
      relationshipToViewer: 'Mother',
      isDeceased: false,
      isRegisteredUser: false,
    );

    final father = FamilyTreeNode(
      id: 'mock-f-1',
      fullName: 'Suresh Agarwal',
      gender: 'Male',
      dob: '1970-02-14',
      relationshipType: 'Father',
      directRelationship: 'Father',
      relationshipToViewer: 'Father',
      isDeceased: false,
      isRegisteredUser: true,
      linkedUserId: 'mock-user-father',
      parents: [grandfather, grandmother],
    );

    // Generation 4: Siblings & Spouses
    final brotherJerry = const FamilyTreeNode(
      id: 'f2b48cea-18c5-4050-8de7-eba5052a2db8',
      fullName: 'Jerry Mouse',
      gender: 'Male',
      dob: '1998-04-05',
      relationshipType: 'Brother',
      directRelationship: 'Brother',
      relationshipToViewer: 'Brother',
      isDeceased: false,
      isRegisteredUser: false,
    );

    final sisterRani = const FamilyTreeNode(
      id: '79cb1a42-3497-49f9-b8fa-97db2550491f',
      fullName: 'Rani Marwadi',
      gender: 'Female',
      dob: '2000-08-02',
      relationshipType: 'Sister',
      directRelationship: 'Sister',
      relationshipToViewer: 'Sister',
      isDeceased: false,
      isRegisteredUser: true,
      linkedUserId: '7721fe3b-2ccf-4a53-ba38-3ef98f77b55a',
    );

    final brotherVikas = const FamilyTreeNode(
      id: 'mock-bro-2',
      fullName: 'Vikas Agarwal',
      gender: 'Male',
      dob: '2003-01-15',
      relationshipType: 'Brother',
      directRelationship: 'Brother',
      relationshipToViewer: 'Brother',
      isDeceased: false,
      isRegisteredUser: false,
    );

    final wifePriya = const FamilyTreeNode(
      id: 'mock-spouse-1',
      fullName: 'Priya Agarwal',
      gender: 'Female',
      dob: '1997-12-10',
      relationshipType: 'Wife',
      directRelationship: 'Wife',
      relationshipToViewer: 'Spouse',
      isDeceased: false,
      isRegisteredUser: true,
      linkedUserId: 'mock-user-priya',
    );

    // Generation 5 & 6: Children & Grandchildren
    final granddaughterMyra = const FamilyTreeNode(
      id: 'mock-gd-1',
      fullName: 'Myra Agarwal',
      gender: 'Female',
      dob: '2047-05-15',
      relationshipType: 'Granddaughter',
      directRelationship: 'Daughter',
      relationshipToViewer: 'Granddaughter',
      isDeceased: false,
      isRegisteredUser: false,
    );

    final grandsonKabir = const FamilyTreeNode(
      id: 'mock-gs-1',
      fullName: 'Kabir Agarwal',
      gender: 'Male',
      dob: '2045-01-01',
      relationshipType: 'Grandson',
      directRelationship: 'Son',
      relationshipToViewer: 'Grandson',
      isDeceased: false,
      isRegisteredUser: false,
    );

    final sonAarav = FamilyTreeNode(
      id: 'mock-son-1',
      fullName: 'Aarav Agarwal',
      gender: 'Male',
      dob: '2020-03-12',
      relationshipType: 'Son',
      directRelationship: 'Son',
      relationshipToViewer: 'Son',
      isDeceased: false,
      isRegisteredUser: false,
      children: [grandsonKabir, granddaughterMyra],
    );

    final daughterAnanya = const FamilyTreeNode(
      id: 'mock-dau-1',
      fullName: 'Ananya Agarwal',
      gender: 'Female',
      dob: '2022-07-28',
      relationshipType: 'Daughter',
      directRelationship: 'Daughter',
      relationshipToViewer: 'Daughter',
      isDeceased: false,
      isRegisteredUser: false,
    );

    // Root Node: Tom Cat (Self / Viewer)
    return FamilyTreeNode(
      id: '05c412bb-f261-43db-99a4-5cc21b505f8e',
      fullName: 'Tom Cat',
      gender: 'Male',
      dob: '1996-08-04',
      relationshipType: 'Self',
      directRelationship: 'Self',
      relationshipToViewer: 'Self',
      isDeceased: false,
      isRegisteredUser: true,
      parents: [father, mother],
      siblings: [brotherJerry, sisterRani, brotherVikas],
      spouses: [wifePriya],
      children: [sonAarav, daughterAnanya],
    );
  }

  /// Complex 6-generation family tree with 36 members:
  /// - Gen 1: Great-Grandparents
  /// - Gen 2: Grandparents + 2 pairs of siblings (each with spouse & child)
  /// - Gen 3: Parents + 2 pairs of siblings (each with spouse & child)
  /// - Gen 4: Self + 3 Siblings (every single one has a spouse and child)
  /// - Gen 5: Children (every single one has a spouse and child)
  /// - Gen 6: Grandchildren
  static FamilyTreeNode createExtendedFullFamilyTree() {
    // -------------------------------------------------------------
    // GENERATION 1: Great-Grandparents
    // -------------------------------------------------------------
    const greatGrandfather = FamilyTreeNode(
      id: 'mock-ext-ggf-1',
      fullName: 'Govindram Agarwal',
      gender: 'Male',
      dob: '1920-05-10',
      relationshipType: 'Great Grandfather',
      directRelationship: 'Great Grandfather',
      relationshipToViewer: 'Great Grandfather',
      isDeceased: true,
      isRegisteredUser: false,
    );

    const greatGrandmother = FamilyTreeNode(
      id: 'mock-ext-ggm-1',
      fullName: 'Rukmini Devi',
      gender: 'Female',
      dob: '1924-08-12',
      relationshipType: 'Great Grandmother',
      directRelationship: 'Great Grandmother',
      relationshipToViewer: 'Great Grandmother',
      isDeceased: true,
      isRegisteredUser: false,
    );

    // -------------------------------------------------------------
    // GENERATION 2: Grandparents & 2 Pairs of Siblings
    // -------------------------------------------------------------
    // Gen 2 Sibling Pair 1: Granduncle Kailash + Grandaunt Kamala -> child Dinesh
    const dineshAgarwal = FamilyTreeNode(
      id: 'mock-ext-gf-bro-c1',
      fullName: 'Dinesh Agarwal',
      gender: 'Male',
      dob: '1968-10-05',
      relationshipType: 'Uncle',
      directRelationship: 'Son',
      relationshipToViewer: 'First Cousin Once Removed',
      isDeceased: false,
      isRegisteredUser: false,
    );

    const grandauntKamala = FamilyTreeNode(
      id: 'mock-ext-gf-bro-sp1',
      fullName: 'Kamala Devi',
      gender: 'Female',
      dob: '1946-07-19',
      relationshipType: 'Grandaunt',
      directRelationship: 'Wife',
      relationshipToViewer: 'Grandaunt',
      isDeceased: false,
      isRegisteredUser: false,
    );

    final granduncleKailash = FamilyTreeNode(
      id: 'mock-ext-gf-bro-1',
      fullName: 'Kailashchandra Agarwal',
      gender: 'Male',
      dob: '1942-03-11',
      relationshipType: 'Granduncle',
      directRelationship: 'Brother',
      relationshipToViewer: 'Paternal Granduncle',
      isDeceased: false,
      isRegisteredUser: false,
      spouses: const [grandauntKamala],
      children: const [dineshAgarwal],
    );

    // Gen 2 Sibling Pair 2: Grandaunt Shanti + Granduncle Mohanlal -> child Sunil
    const sunilSharma = FamilyTreeNode(
      id: 'mock-ext-gf-sis-c1',
      fullName: 'Sunil Sharma',
      gender: 'Male',
      dob: '1972-09-14',
      relationshipType: 'Uncle',
      directRelationship: 'Son',
      relationshipToViewer: 'First Cousin Once Removed',
      isDeceased: false,
      isRegisteredUser: false,
    );

    const granduncleMohanlal = FamilyTreeNode(
      id: 'mock-ext-gf-sis-sp1',
      fullName: 'Mohanlal Sharma',
      gender: 'Male',
      dob: '1947-04-18',
      relationshipType: 'Granduncle',
      directRelationship: 'Husband',
      relationshipToViewer: 'Granduncle',
      isDeceased: false,
      isRegisteredUser: false,
    );

    final grandauntShanti = FamilyTreeNode(
      id: 'mock-ext-gf-sis-1',
      fullName: 'Shanti Devi',
      gender: 'Female',
      dob: '1950-12-01',
      relationshipType: 'Grandaunt',
      directRelationship: 'Sister',
      relationshipToViewer: 'Paternal Grandaunt',
      isDeceased: false,
      isRegisteredUser: true,
      linkedUserId: 'mock-user-shanti',
      spouses: const [granduncleMohanlal],
      children: const [sunilSharma],
    );

    // Gen 2 Grandparents
    const grandmotherShakuntala = FamilyTreeNode(
      id: 'mock-ext-gm-1',
      fullName: 'Shakuntala Devi',
      gender: 'Female',
      dob: '1948-11-20',
      relationshipType: 'Grandmother',
      directRelationship: 'Grandmother',
      relationshipToViewer: 'Paternal Grandmother',
      isDeceased: false,
      isRegisteredUser: false,
    );

    final grandfatherRamesh = FamilyTreeNode(
      id: 'mock-ext-gf-1',
      fullName: 'Rameshchandra Agarwal',
      gender: 'Male',
      dob: '1945-08-15',
      relationshipType: 'Grandfather',
      directRelationship: 'Grandfather',
      relationshipToViewer: 'Paternal Grandfather',
      isDeceased: false,
      isRegisteredUser: true,
      linkedUserId: 'mock-user-gf',
      parents: const [greatGrandfather, greatGrandmother],
      spouses: const [grandmotherShakuntala],
      siblings: [granduncleKailash, grandauntShanti],
    );

    // -------------------------------------------------------------
    // GENERATION 3: Parents & 2 Pairs of Siblings
    // -------------------------------------------------------------
    // Gen 3 Sibling Pair 1: Uncle Mahendra + Aunt Rekha -> child Karan
    const karanAgarwal = FamilyTreeNode(
      id: 'mock-ext-f-bro-c1',
      fullName: 'Karan Agarwal',
      gender: 'Male',
      dob: '1995-11-12',
      relationshipType: 'Cousin',
      directRelationship: 'Son',
      relationshipToViewer: 'Cousin Brother',
      isDeceased: false,
      isRegisteredUser: false,
    );

    const auntRekha = FamilyTreeNode(
      id: 'mock-ext-f-bro-sp1',
      fullName: 'Rekha Agarwal',
      gender: 'Female',
      dob: '1971-03-22',
      relationshipType: 'Aunt',
      directRelationship: 'Wife',
      relationshipToViewer: 'Paternal Aunt',
      isDeceased: false,
      isRegisteredUser: false,
    );

    final uncleMahendra = FamilyTreeNode(
      id: 'mock-ext-f-bro-1',
      fullName: 'Mahendra Agarwal',
      gender: 'Male',
      dob: '1967-09-08',
      relationshipType: 'Uncle',
      directRelationship: 'Brother',
      relationshipToViewer: 'Paternal Uncle',
      isDeceased: false,
      isRegisteredUser: true,
      linkedUserId: 'mock-user-mahendra',
      spouses: const [auntRekha],
      children: const [karanAgarwal],
    );

    // Gen 3 Sibling Pair 2: Aunt Anita + Uncle Rajesh -> child Pooja
    const poojaSharma = FamilyTreeNode(
      id: 'mock-ext-f-sis-c1',
      fullName: 'Pooja Sharma',
      gender: 'Female',
      dob: '1997-06-18',
      relationshipType: 'Cousin',
      directRelationship: 'Daughter',
      relationshipToViewer: 'Cousin Sister',
      isDeceased: false,
      isRegisteredUser: false,
    );

    const uncleRajesh = FamilyTreeNode(
      id: 'mock-ext-f-sis-sp1',
      fullName: 'Rajesh Sharma',
      gender: 'Male',
      dob: '1969-08-30',
      relationshipType: 'Uncle',
      directRelationship: 'Husband',
      relationshipToViewer: 'Uncle (Fufa)',
      isDeceased: false,
      isRegisteredUser: false,
    );

    final auntAnita = FamilyTreeNode(
      id: 'mock-ext-f-sis-1',
      fullName: 'Anita Agarwal',
      gender: 'Female',
      dob: '1973-11-04',
      relationshipType: 'Aunt',
      directRelationship: 'Sister',
      relationshipToViewer: 'Paternal Aunt (Bua)',
      isDeceased: false,
      isRegisteredUser: false,
      spouses: const [uncleRajesh],
      children: const [poojaSharma],
    );

    // Gen 3 Parents
    const motherSunita = FamilyTreeNode(
      id: 'mock-ext-m-1',
      fullName: 'Sunita Agarwal',
      gender: 'Female',
      dob: '1974-06-25',
      relationshipType: 'Mother',
      directRelationship: 'Mother',
      relationshipToViewer: 'Mother',
      isDeceased: false,
      isRegisteredUser: false,
    );

    final fatherSuresh = FamilyTreeNode(
      id: 'mock-ext-f-1',
      fullName: 'Suresh Agarwal',
      gender: 'Male',
      dob: '1970-02-14',
      relationshipType: 'Father',
      directRelationship: 'Father',
      relationshipToViewer: 'Father',
      isDeceased: false,
      isRegisteredUser: true,
      linkedUserId: 'mock-user-father',
      parents: [grandfatherRamesh],
      spouses: const [motherSunita],
      siblings: [uncleMahendra, auntAnita],
    );

    // -------------------------------------------------------------
    // GENERATION 4: Siblings & Spouses (Everyone has spouse & child)
    // -------------------------------------------------------------
    // 1. Brother Jerry Mouse + Jenny Mouse -> Leo Mouse
    const leoMouse = FamilyTreeNode(
      id: 'mock-ext-jerry-c1',
      fullName: 'Leo Mouse',
      gender: 'Male',
      dob: '2024-01-10',
      relationshipType: 'Nephew',
      directRelationship: 'Son',
      relationshipToViewer: 'Nephew',
      isDeceased: false,
      isRegisteredUser: false,
    );

    const jennyMouse = FamilyTreeNode(
      id: 'mock-ext-jerry-sp1',
      fullName: 'Jenny Mouse',
      gender: 'Female',
      dob: '1999-05-14',
      relationshipType: 'Sister-in-law',
      directRelationship: 'Wife',
      relationshipToViewer: 'Sister-in-law',
      isDeceased: false,
      isRegisteredUser: false,
    );

    final brotherJerry = FamilyTreeNode(
      id: 'mock-ext-jerry-1',
      fullName: 'Jerry Mouse',
      gender: 'Male',
      dob: '1998-04-05',
      relationshipType: 'Brother',
      directRelationship: 'Brother',
      relationshipToViewer: 'Brother',
      isDeceased: false,
      isRegisteredUser: false,
      spouses: const [jennyMouse],
      children: const [leoMouse],
    );

    // 2. Sister Rani Marwadi + Rohit Marwadi -> Sneha Marwadi
    const snehaMarwadi = FamilyTreeNode(
      id: 'mock-ext-rani-c1',
      fullName: 'Sneha Marwadi',
      gender: 'Female',
      dob: '2025-03-15',
      relationshipType: 'Niece',
      directRelationship: 'Daughter',
      relationshipToViewer: 'Niece',
      isDeceased: false,
      isRegisteredUser: false,
    );

    const rohitMarwadi = FamilyTreeNode(
      id: 'mock-ext-rani-sp1',
      fullName: 'Rohit Marwadi',
      gender: 'Male',
      dob: '1998-11-25',
      relationshipType: 'Brother-in-law',
      directRelationship: 'Husband',
      relationshipToViewer: 'Brother-in-law',
      isDeceased: false,
      isRegisteredUser: true,
      linkedUserId: 'mock-user-rohit',
    );

    final sisterRani = FamilyTreeNode(
      id: 'mock-ext-rani-1',
      fullName: 'Rani Marwadi',
      gender: 'Female',
      dob: '2000-08-02',
      relationshipType: 'Sister',
      directRelationship: 'Sister',
      relationshipToViewer: 'Sister',
      isDeceased: false,
      isRegisteredUser: true,
      linkedUserId: '7721fe3b-2ccf-4a53-ba38-3ef98f77b55a',
      spouses: const [rohitMarwadi],
      children: const [snehaMarwadi],
    );

    // 3. Brother Vikas Agarwal + Neha Agarwal -> Rohan Agarwal
    const rohanAgarwal = FamilyTreeNode(
      id: 'mock-ext-vikas-c1',
      fullName: 'Rohan Agarwal',
      gender: 'Male',
      dob: '2025-06-20',
      relationshipType: 'Nephew',
      directRelationship: 'Son',
      relationshipToViewer: 'Nephew',
      isDeceased: false,
      isRegisteredUser: false,
    );

    const nehaAgarwal = FamilyTreeNode(
      id: 'mock-ext-vikas-sp1',
      fullName: 'Neha Agarwal',
      gender: 'Female',
      dob: '2004-09-09',
      relationshipType: 'Sister-in-law',
      directRelationship: 'Wife',
      relationshipToViewer: 'Sister-in-law',
      isDeceased: false,
      isRegisteredUser: false,
    );

    final brotherVikas = FamilyTreeNode(
      id: 'mock-ext-vikas-1',
      fullName: 'Vikas Agarwal',
      gender: 'Male',
      dob: '2003-01-15',
      relationshipType: 'Brother',
      directRelationship: 'Brother',
      relationshipToViewer: 'Brother',
      isDeceased: false,
      isRegisteredUser: false,
      spouses: const [nehaAgarwal],
      children: const [rohanAgarwal],
    );

    // 4. Spouse of Tom Cat: Priya Agarwal
    const wifePriya = FamilyTreeNode(
      id: 'mock-ext-spouse-1',
      fullName: 'Priya Agarwal',
      gender: 'Female',
      dob: '1997-12-10',
      relationshipType: 'Wife',
      directRelationship: 'Wife',
      relationshipToViewer: 'Spouse',
      isDeceased: false,
      isRegisteredUser: true,
      linkedUserId: 'mock-user-priya',
    );

    // -------------------------------------------------------------
    // GENERATION 5 & 6: Children (Everyone has spouse & child) -> Grandchildren
    // -------------------------------------------------------------
    // Aarav's Children (Gen 6 Grandchildren):
    const grandsonKabir = FamilyTreeNode(
      id: 'mock-ext-gs-1',
      fullName: 'Kabir Agarwal',
      gender: 'Male',
      dob: '2045-01-01',
      relationshipType: 'Grandson',
      directRelationship: 'Son',
      relationshipToViewer: 'Grandson',
      isDeceased: false,
      isRegisteredUser: false,
    );

    const granddaughterMyra = FamilyTreeNode(
      id: 'mock-ext-gd-1',
      fullName: 'Myra Agarwal',
      gender: 'Female',
      dob: '2047-05-15',
      relationshipType: 'Granddaughter',
      directRelationship: 'Daughter',
      relationshipToViewer: 'Granddaughter',
      isDeceased: false,
      isRegisteredUser: false,
    );

    // Aarav's Spouse:
    const poojaAgarwal = FamilyTreeNode(
      id: 'mock-ext-aarav-sp1',
      fullName: 'Pooja Agarwal',
      gender: 'Female',
      dob: '2021-08-14',
      relationshipType: 'Daughter-in-law',
      directRelationship: 'Wife',
      relationshipToViewer: 'Daughter-in-law',
      isDeceased: false,
      isRegisteredUser: false,
    );

    // Son Aarav Agarwal:
    final sonAarav = FamilyTreeNode(
      id: 'mock-ext-son-1',
      fullName: 'Aarav Agarwal',
      gender: 'Male',
      dob: '2020-03-12',
      relationshipType: 'Son',
      directRelationship: 'Son',
      relationshipToViewer: 'Son',
      isDeceased: false,
      isRegisteredUser: false,
      spouses: const [poojaAgarwal],
      children: const [grandsonKabir, granddaughterMyra],
    );

    // Ananya's Child (Gen 6 Grandchild):
    const grandsonIshaan = FamilyTreeNode(
      id: 'mock-ext-ananya-c1',
      fullName: 'Ishaan Verma',
      gender: 'Male',
      dob: '2046-10-10',
      relationshipType: 'Grandson',
      directRelationship: 'Son',
      relationshipToViewer: 'Grandson',
      isDeceased: false,
      isRegisteredUser: false,
    );

    // Ananya's Spouse:
    const rahulVerma = FamilyTreeNode(
      id: 'mock-ext-ananya-sp1',
      fullName: 'Rahul Verma',
      gender: 'Male',
      dob: '2021-12-05',
      relationshipType: 'Son-in-law',
      directRelationship: 'Husband',
      relationshipToViewer: 'Son-in-law',
      isDeceased: false,
      isRegisteredUser: false,
    );

    // Daughter Ananya Agarwal:
    final daughterAnanya = FamilyTreeNode(
      id: 'mock-ext-dau-1',
      fullName: 'Ananya Agarwal',
      gender: 'Female',
      dob: '2022-07-28',
      relationshipType: 'Daughter',
      directRelationship: 'Daughter',
      relationshipToViewer: 'Daughter',
      isDeceased: false,
      isRegisteredUser: false,
      spouses: const [rahulVerma],
      children: const [grandsonIshaan],
    );

    // -------------------------------------------------------------
    // ROOT NODE: Tom Cat (Self / Viewer)
    // -------------------------------------------------------------
    return FamilyTreeNode(
      id: '05c412bb-f261-43db-99a4-5cc21b505f8e',
      fullName: 'Tom Cat',
      gender: 'Male',
      dob: '1996-08-04',
      relationshipType: 'Self',
      directRelationship: 'Self',
      relationshipToViewer: 'Self',
      isDeceased: false,
      isRegisteredUser: true,
      parents: [fatherSuresh],
      siblings: [brotherJerry, sisterRani, brotherVikas],
      spouses: const [wifePriya],
      children: [sonAarav, daughterAnanya],
    );
  }

  /// Canonical Patel Family implementation from Section 7 of Architecture Guide:
  /// - Focus: Aarav Patel (Self, Level 0, 28, Male)
  /// - Level +2: Tribhovandas Patel (Paternal Grandfather, Deceased, Unlinked)
  /// - Level +1: Sureshbhai Patel (Father, Linked)
  ///             Hansaben Patel (Mother, Unlinked)
  ///             Rameshbhai Patel (Paternal Uncle / Kaka, Linked via Father's Brother)
  /// - Level  0: Aarav Patel (Self)
  ///             Pooja Patel (Wife, Linked)
  ///             Rohan Patel (Brother, Linked)
  ///             Meet Patel (Cousin, Linked via Uncle Rameshbhai's Son)
  /// - Level -1: Kabir Patel (Son, Unlinked, Age 3)
  static FamilyTreeNode createPatelFamilyTree() {
    // Level +2: Paternal Grandfather (Dada) - Tribhovandas Patel
    const tribhovandas = FamilyTreeNode(
      id: 'patel-gf-1',
      fullName: 'Tribhovandas Patel',
      gender: 'Male',
      dob: '1944-02-10',
      relationshipType: 'Grandfather',
      directRelationship: 'Father',
      relationshipToViewer: 'Paternal Grandfather (Dada)',
      isDeceased: true,
      isRegisteredUser: false,
    );

    // Level 0: Meet Patel (Cousin - Rameshbhai's Son)
    const meetPatel = FamilyTreeNode(
      id: 'patel-cousin-meet',
      fullName: 'Meet Patel',
      gender: 'Male',
      dob: '2004-06-15',
      relationshipType: 'Cousin',
      directRelationship: 'Son',
      relationshipToViewer: 'Cousin (Brother)',
      isDeceased: false,
      isRegisteredUser: true,
      linkedUserId: 'user-patel-meet',
      linkedMobile: '9876543210',
    );

    // Level +1: Rameshbhai Patel (Paternal Uncle / Kaka - Sureshbhai's Brother)
    final rameshbhai = FamilyTreeNode(
      id: 'patel-uncle-ramesh',
      fullName: 'Rameshbhai Patel',
      gender: 'Male',
      dob: '1972-04-18',
      relationshipType: 'Uncle',
      directRelationship: 'Brother',
      relationshipToViewer: 'Paternal Uncle (Kaka)',
      isDeceased: false,
      isRegisteredUser: true,
      linkedUserId: 'user-patel-ramesh',
      linkedMobile: '9876543211',
      children: const [meetPatel],
    );

    // Level +1: Sureshbhai Patel (Father)
    final sureshbhai = FamilyTreeNode(
      id: 'patel-father-suresh',
      fullName: 'Sureshbhai Patel',
      gender: 'Male',
      dob: '1970-08-12',
      relationshipType: 'Father',
      directRelationship: 'Father',
      relationshipToViewer: 'Father',
      isDeceased: false,
      isRegisteredUser: true,
      linkedUserId: 'user-patel-suresh',
      linkedMobile: '9876543212',
      parents: const [tribhovandas],
      siblings: [rameshbhai],
    );

    // Level +1: Hansaben Patel (Mother - Unlinked)
    const hansaben = FamilyTreeNode(
      id: 'patel-mother-hansa',
      fullName: 'Hansaben Patel',
      gender: 'Female',
      dob: '1974-11-20',
      relationshipType: 'Mother',
      directRelationship: 'Mother',
      relationshipToViewer: 'Mother',
      isDeceased: false,
      isRegisteredUser: false,
    );

    // Level 0: Rohan Patel (Brother - Linked)
    const rohanPatel = FamilyTreeNode(
      id: 'patel-brother-rohan',
      fullName: 'Rohan Patel',
      gender: 'Male',
      dob: '2002-09-05',
      relationshipType: 'Brother',
      directRelationship: 'Brother',
      relationshipToViewer: 'Brother',
      isDeceased: false,
      isRegisteredUser: true,
      linkedUserId: 'user-patel-rohan',
      linkedMobile: '9876543213',
    );

    // Level 0: Pooja Patel (Wife - Linked)
    const poojaPatel = FamilyTreeNode(
      id: 'patel-wife-pooja',
      fullName: 'Pooja Patel',
      gender: 'Female',
      dob: '2000-03-25',
      relationshipType: 'Wife',
      directRelationship: 'Wife',
      relationshipToViewer: 'Spouse',
      isDeceased: false,
      isRegisteredUser: true,
      linkedUserId: 'user-patel-pooja',
      linkedMobile: '9876543214',
    );

    // Level -1: Kabir Patel (Son - Unlinked, Age 3)
    const kabirPatel = FamilyTreeNode(
      id: 'patel-son-kabir',
      fullName: 'Kabir Patel',
      gender: 'Male',
      dob: '2023-01-10',
      relationshipType: 'Son',
      directRelationship: 'Son',
      relationshipToViewer: 'Son',
      isDeceased: false,
      isRegisteredUser: false,
    );

    // Level 0: Aarav Patel (Self / Main Perspective)
    return FamilyTreeNode(
      id: 'patel-self-aarav',
      fullName: 'Aarav Patel',
      gender: 'Male',
      dob: '1998-05-14',
      relationshipType: 'Self',
      directRelationship: 'Self',
      relationshipToViewer: 'Self',
      isDeceased: false,
      isRegisteredUser: true,
      linkedUserId: 'user-patel-aarav',
      linkedMobile: '9876543215',
      parents: [sureshbhai, hansaben],
      siblings: const [rohanPatel],
      spouses: const [poojaPatel],
      children: const [kabirPatel],
    );
  }
}
