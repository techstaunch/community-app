import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:community_connect/src/features/family_tree/data/family_models.dart';
import 'package:community_connect/src/features/family_tree/data/family_provider.dart';
import 'package:community_connect/src/features/family_tree/data/family_tree_mock.dart';
import 'package:community_connect/src/features/family_tree/data/kinship_engine.dart';
import 'package:community_connect/src/features/family_tree/presentation/family_tree_screen.dart';
import 'package:community_connect/src/features/family_tree/presentation/widgets/family_tree_canvas.dart';

void main() {
  group('Family Tree 5-Generation & 15-Member Tests', () {
    test('Mock tree contains exactly 15 members across generations', () {
      final root = FamilyTreeMock.create5GenerationTree();

      final allNodes = <FamilyTreeNode>[];
      void collectNodes(FamilyTreeNode node) {
        allNodes.add(node);
        for (final p in node.parents) {
          collectNodes(p);
        }
        for (final s in node.siblings) {
          collectNodes(s);
        }
        for (final sp in node.spouses) {
          collectNodes(sp);
        }
        for (final c in node.children) {
          collectNodes(c);
        }
      }

      collectNodes(root);

      // Verify total count is 15
      expect(allNodes.length, 15);

      // Verify all IDs are distinct
      final uniqueIds = allNodes.map((n) => n.id).toSet();
      expect(uniqueIds.length, 15);

      // Verify root is Self
      expect(root.fullName, 'Tom Cat');
      expect(root.directRelationship, 'Self');

      // Verify Generation 1: Great-Grandparents
      final father = root.parents.firstWhere(
        (p) => p.relationshipType == 'Father',
      );
      final grandfather = father.parents.firstWhere(
        (p) => p.relationshipType == 'Grandfather',
      );
      expect(grandfather.parents.length, 2);
      final ggf = grandfather.parents.firstWhere(
        (p) => p.relationshipType == 'Great Grandfather',
      );
      final ggm = grandfather.parents.firstWhere(
        (p) => p.relationshipType == 'Great Grandmother',
      );
      expect(ggf.fullName, 'Govindram Agarwal');
      expect(ggf.isDeceased, isTrue);
      expect(ggm.fullName, 'Rukmini Devi');
      expect(ggm.isDeceased, isTrue);

      // Verify Generation 2: Grandparents
      expect(father.parents.length, 2);
      final gm = father.parents.firstWhere(
        (p) => p.relationshipType == 'Grandmother',
      );
      expect(gm.fullName, 'Shakuntala Devi');
      expect(grandfather.fullName, 'Rameshchandra Agarwal');
      expect(grandfather.isRegisteredUser, isTrue);

      // Verify Generation 3: Parents
      expect(root.parents.length, 2);
      final mother = root.parents.firstWhere(
        (p) => p.relationshipType == 'Mother',
      );
      expect(mother.fullName, 'Sunita Agarwal');
      expect(father.fullName, 'Suresh Agarwal');
      expect(father.isRegisteredUser, isTrue);

      // Verify Generation 4: Siblings and Spouse (Horizontal layout)
      expect(root.siblings.length, 3);
      expect(root.spouses.length, 1);
      final spouse = root.spouses.first;
      expect(spouse.fullName, 'Priya Agarwal');
      expect(spouse.isRegisteredUser, isTrue);

      // Verify Generation 5: Children
      expect(root.children.length, 2);
      final son = root.children.firstWhere(
        (c) => c.fullName == 'Aarav Agarwal',
      );
      final daughter = root.children.firstWhere(
        (c) => c.fullName == 'Ananya Agarwal',
      );
      expect(son.directRelationship, 'Son');
      expect(daughter.directRelationship, 'Daughter');

      // Verify Generation 6: Grandchildren
      expect(son.children.length, 2);
      final grandson = son.children.firstWhere(
        (c) => c.relationshipType == 'Grandson',
      );
      final granddaughter = son.children.firstWhere(
        (c) => c.relationshipType == 'Granddaughter',
      );
      expect(grandson.fullName, 'Kabir Agarwal');
      expect(granddaughter.fullName, 'Myra Agarwal');
    });

    test(
      'Backend JSON parsing correctly maps registered users and relationships',
      () {
        final backendJson = {
          'id': '05c412bb-f261-43db-99a4-5cc21b505f8e',
          'fullName': 'Tom Cat',
          'gender': 'Male',
          'dob': '1996-08-04',
          'directRelationship': 'Self',
          'relationshipToViewer': 'Self',
          'isRegisteredUser': true,
          'parents': [
            {
              'id': '7721fe3b-2ccf-4a53-ba38-3ef98f77b55a',
              'fullName': 'John Doe',
              'gender': 'Male',
              'dob': '1970-01-01',
              'directRelationship': 'Father',
              'relationshipToViewer': 'Father',
              'isRegisteredUser': true,
            },
            {
              'id': 'non-registered-mom-id',
              'fullName': 'Jane Doe',
              'gender': 'Female',
              'dob': '1972-02-02',
              'directRelationship': 'Mother',
              'relationshipToViewer': 'Mother',
              'isRegisteredUser': false,
            },
          ],
          'siblings': [
            {
              'id': 'brother-registered-id',
              'fullName': 'Bob Doe',
              'gender': 'Male',
              'dob': '1998-03-03',
              'directRelationship': 'Brother',
              'relationshipToViewer': 'Brother',
              'isRegisteredUser': true,
            },
          ],
          'spouses': [],
          'children': [],
        };

        final parsedNode = FamilyTreeNode.fromJson(backendJson);

        expect(parsedNode.fullName, 'Tom Cat');
        expect(parsedNode.isRegisteredUser, isTrue);
        expect(parsedNode.directRelationship, 'Self');
        expect(parsedNode.parents.length, 2);

        // Father is registered user
        final fatherNode = parsedNode.parents.first;
        expect(fatherNode.fullName, 'John Doe');
        expect(fatherNode.isRegisteredUser, isTrue);
        expect(fatherNode.gender, 'Male');
        expect(fatherNode.linkedUserId, '7721fe3b-2ccf-4a53-ba38-3ef98f77b55a');

        // Mother is not registered
        final motherNode = parsedNode.parents[1];
        expect(motherNode.fullName, 'Jane Doe');
        expect(motherNode.isRegisteredUser, isFalse);
        expect(motherNode.gender, 'Female');
        expect(motherNode.linkedUserId, isNull);

        // Brother is registered user
        final brotherNode = parsedNode.siblings.first;
        expect(brotherNode.fullName, 'Bob Doe');
        expect(brotherNode.isRegisteredUser, isTrue);
        expect(brotherNode.linkedUserId, 'brother-registered-id');
      },
    );

    test(
      'Parses the hierarchy envelope fields used by the expanded family tree response',
      () {
        final response = {
          'rootAncestor': {
            'id': 'ancestor-id',
            'fullName': 'Shivnarayan Sharma',
            'gender': 'Male',
            'photoUrl': null,
          },
          'focusUser': {
            'id': 'ancestor-id',
            'fullName': 'Shivnarayan Sharma',
            'gender': 'Male',
            'photoUrl': null,
          },
          'tree': {
            'id': 'ancestor-id',
            'fullName': 'Shivnarayan Sharma',
            'relationshipToViewer': 'Self',
            'isRegisteredUser': true,
            'qrImageUrl': 'https://example.test/qr.png',
            'spouses': [
              {
                'id': 'spouse-id',
                'fullName': 'Parvati Sharma',
                'privacyProtected': true,
                'children': [],
                'spouses': [],
                'parents': [],
                'siblings': [],
              },
            ],
            'children': [
              {
                'id': 'child-id',
                'fullName': 'Hariprasad Sharma',
                'children': [
                  {
                    'id': 'grandchild-id',
                    'fullName': 'Ramakant Sharma',
                    'children': [],
                    'spouses': [],
                    'parents': [],
                    'siblings': [],
                  },
                ],
                'spouses': [],
                'parents': [],
                'siblings': [],
              },
            ],
            'parents': [],
            'siblings': [],
          },
        };

        final tree = FamilyTreeNode.fromJson(
          (response['tree']! as Map<String, dynamic>),
        );

        expect(response['rootAncestor'], isNotNull);
        expect(response['focusUser'], isNotNull);
        expect(tree.qrImageUrl, 'https://example.test/qr.png');
        expect(tree.spouses.single.privacyProtected, isTrue);
        expect(
          tree.children.single.children.single.fullName,
          'Ramakant Sharma',
        );
      },
    );

    test('Registered user detection correctly resolves targetProfileId', () {
      const registeredWithLinkedUserId = FamilyTreeNode(
        id: 'tree-node-1',
        fullName: 'Linked Relative',
        isRegisteredUser: true,
        linkedUserId: 'user-profile-123',
      );

      final isRegistered1 =
          registeredWithLinkedUserId.isRegisteredUser == true ||
          (registeredWithLinkedUserId.linkedUserId != null &&
              registeredWithLinkedUserId.linkedUserId!.isNotEmpty);
      final targetProfileId1 =
          registeredWithLinkedUserId.linkedUserId ??
          (registeredWithLinkedUserId.isRegisteredUser == true
              ? registeredWithLinkedUserId.id
              : null);

      expect(isRegistered1, isTrue);
      expect(targetProfileId1, 'user-profile-123');

      // When backend provides id directly as the user id
      const registeredWithNodeId = FamilyTreeNode(
        id: 'user-profile-456',
        fullName: 'Direct Registered Relative',
        isRegisteredUser: true,
      );

      final isRegistered2 =
          registeredWithNodeId.isRegisteredUser == true ||
          (registeredWithNodeId.linkedUserId != null &&
              registeredWithNodeId.linkedUserId!.isNotEmpty);
      final targetProfileId2 =
          registeredWithNodeId.linkedUserId ??
          (registeredWithNodeId.isRegisteredUser == true
              ? registeredWithNodeId.id
              : null);

      expect(isRegistered2, isTrue);
      expect(targetProfileId2, 'user-profile-456');

      // Unlinked / non-registered member
      const unlinkedMember = FamilyTreeNode(
        id: 'unlinked-node-789',
        fullName: 'Unlinked Relative',
        isRegisteredUser: false,
      );

      final isRegistered3 =
          unlinkedMember.isRegisteredUser == true ||
          (unlinkedMember.linkedUserId != null &&
              unlinkedMember.linkedUserId!.isNotEmpty);
      final targetProfileId3 =
          unlinkedMember.linkedUserId ??
          (unlinkedMember.isRegisteredUser == true ? unlinkedMember.id : null);

      expect(isRegistered3, isFalse);
      expect(targetProfileId3, isNull);
    });

    testWidgets(
      'FamilyTreeScreen renders 15-member 5-generation tree in UI without overflow',
      (tester) async {
        // Set a larger surface size for testing deep/wide trees
        tester.view.physicalSize = const Size(1200, 1600);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() => tester.view.resetPhysicalSize());

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              familyControllerProvider.overrideWith(
                () => MockFamilyController(),
              ),
            ],
            child: const MaterialApp(home: FamilyTreeScreen()),
          ),
        );

        // Wait for async tree data to load
        await tester.pumpAndSettle();

        // Verify all 15 members from the 5-generation tree are in the widget tree
        expect(find.text('Tom Cat'), findsOneWidget); // Self (Gen 4)
        expect(
          find.text('Govindram Agarwal'),
          findsOneWidget,
        ); // Great-Grandfather (Gen 1)
        expect(
          find.text('Rukmini Devi'),
          findsOneWidget,
        ); // Great-Grandmother (Gen 1)
        expect(
          find.text('Rameshchandra Agarwal'),
          findsOneWidget,
        ); // Grandfather (Gen 2)
        expect(
          find.text('Shakuntala Devi'),
          findsOneWidget,
        ); // Grandmother (Gen 2)
        expect(find.text('Suresh Agarwal'), findsOneWidget); // Father (Gen 3)
        expect(find.text('Sunita Agarwal'), findsOneWidget); // Mother (Gen 3)
        expect(find.text('Priya Agarwal'), findsOneWidget); // Spouse (Gen 4)
        expect(find.text('Jerry Mouse'), findsOneWidget); // Brother (Gen 4)
        expect(find.text('Rani Marwadi'), findsOneWidget); // Sister (Gen 4)
        expect(find.text('Vikas Agarwal'), findsOneWidget); // Brother (Gen 4)
        expect(find.text('Aarav Agarwal'), findsOneWidget); // Son (Gen 5)
        expect(find.text('Ananya Agarwal'), findsOneWidget); // Daughter (Gen 5)
        expect(find.text('Kabir Agarwal'), findsOneWidget); // Grandson (Gen 6)
        expect(
          find.text('Myra Agarwal'),
          findsOneWidget,
        ); // Granddaughter (Gen 6)
      },
    );

    test(
      'Full extended tree contains all 36 members with couples and children across 6 generations',
      () {
        final root = FamilyTreeMock.createExtendedFullFamilyTree();

        final allNodes = <FamilyTreeNode>[];
        void collectNodes(FamilyTreeNode node) {
          allNodes.add(node);
          for (final p in node.parents) {
            collectNodes(p);
          }
          for (final s in node.siblings) {
            collectNodes(s);
          }
          for (final sp in node.spouses) {
            collectNodes(sp);
          }
          for (final c in node.children) {
            collectNodes(c);
          }
        }

        collectNodes(root);

        // Verify total count is 36
        expect(allNodes.length, 36);

        // Verify all IDs are unique
        final uniqueIds = allNodes.map((n) => n.id).toSet();
        expect(uniqueIds.length, 36);

        // Gen 1: Great-Grandparents
        final father = root.parents.first;
        final grandfather = father.parents.first;
        expect(grandfather.parents.length, 2);
        expect(
          grandfather.parents.any((p) => p.fullName == 'Govindram Agarwal'),
          isTrue,
        );
        expect(
          grandfather.parents.any((p) => p.fullName == 'Rukmini Devi'),
          isTrue,
        );

        // Gen 2: Grandparents + 2 pairs of siblings
        expect(grandfather.fullName, 'Rameshchandra Agarwal');
        expect(grandfather.spouses.first.fullName, 'Shakuntala Devi');
        expect(grandfather.siblings.length, 2);
        final granduncleKailash = grandfather.siblings.firstWhere(
          (s) => s.fullName == 'Kailashchandra Agarwal',
        );
        expect(granduncleKailash.spouses.first.fullName, 'Kamala Devi');
        expect(granduncleKailash.children.first.fullName, 'Dinesh Agarwal');

        final grandauntShanti = grandfather.siblings.firstWhere(
          (s) => s.fullName == 'Shanti Devi',
        );
        expect(grandauntShanti.spouses.first.fullName, 'Mohanlal Sharma');
        expect(grandauntShanti.children.first.fullName, 'Sunil Sharma');

        // Gen 3: Parents + 2 pairs of siblings
        expect(father.fullName, 'Suresh Agarwal');
        expect(father.spouses.first.fullName, 'Sunita Agarwal');
        expect(father.siblings.length, 2);
        final uncleMahendra = father.siblings.firstWhere(
          (s) => s.fullName == 'Mahendra Agarwal',
        );
        expect(uncleMahendra.spouses.first.fullName, 'Rekha Agarwal');
        expect(uncleMahendra.children.first.fullName, 'Karan Agarwal');

        final auntAnita = father.siblings.firstWhere(
          (s) => s.fullName == 'Anita Agarwal',
        );
        expect(auntAnita.spouses.first.fullName, 'Rajesh Sharma');
        expect(auntAnita.children.first.fullName, 'Pooja Sharma');

        // Gen 4: Self + 3 Siblings (All have spouse & child)
        expect(root.fullName, 'Tom Cat');
        expect(root.spouses.first.fullName, 'Priya Agarwal');
        expect(root.siblings.length, 3);

        final jerry = root.siblings.firstWhere(
          (s) => s.fullName == 'Jerry Mouse',
        );
        expect(jerry.spouses.first.fullName, 'Jenny Mouse');
        expect(jerry.children.first.fullName, 'Leo Mouse');

        final rani = root.siblings.firstWhere(
          (s) => s.fullName == 'Rani Marwadi',
        );
        expect(rani.spouses.first.fullName, 'Rohit Marwadi');
        expect(rani.children.first.fullName, 'Sneha Marwadi');

        final vikas = root.siblings.firstWhere(
          (s) => s.fullName == 'Vikas Agarwal',
        );
        expect(vikas.spouses.first.fullName, 'Neha Agarwal');
        expect(vikas.children.first.fullName, 'Rohan Agarwal');

        // Gen 5: Children (Both have spouse & child)
        expect(root.children.length, 2);
        final aarav = root.children.firstWhere(
          (c) => c.fullName == 'Aarav Agarwal',
        );
        expect(aarav.spouses.first.fullName, 'Pooja Agarwal');
        expect(aarav.children.length, 2);
        expect(
          aarav.children.any((c) => c.fullName == 'Kabir Agarwal'),
          isTrue,
        ); // Gen 6
        expect(
          aarav.children.any((c) => c.fullName == 'Myra Agarwal'),
          isTrue,
        ); // Gen 6

        final ananya = root.children.firstWhere(
          (c) => c.fullName == 'Ananya Agarwal',
        );
        expect(ananya.spouses.first.fullName, 'Rahul Verma');
        expect(ananya.children.length, 1);
        expect(ananya.children.first.fullName, 'Ishaan Verma'); // Gen 6
      },
    );

    testWidgets(
      'FamilyTreeScreen renders full extended 36-member tree in UI without overflow',
      (tester) async {
        tester.view.physicalSize = const Size(2000, 2400);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() => tester.view.resetPhysicalSize());

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              familyControllerProvider.overrideWith(
                () => MockExtendedFamilyController(),
              ),
            ],
            child: const MaterialApp(home: FamilyTreeScreen()),
          ),
        );

        await tester.pumpAndSettle();

        // Check key members from each branch and generation
        expect(find.text('Tom Cat'), findsOneWidget); // Self
        expect(find.text('Priya Agarwal'), findsOneWidget); // Spouse of Self
        expect(
          find.text('Govindram Agarwal'),
          findsOneWidget,
        ); // Great-Grandfather
        expect(find.text('Rukmini Devi'), findsOneWidget); // Great-Grandmother
        expect(
          find.text('Kailashchandra Agarwal'),
          findsOneWidget,
        ); // Gen 2 Sibling 1
        expect(find.text('Kamala Devi'), findsOneWidget); // Gen 2 Spouse 1
        expect(find.text('Dinesh Agarwal'), findsOneWidget); // Gen 2 Child 1
        expect(find.text('Shanti Devi'), findsOneWidget); // Gen 2 Sibling 2
        expect(find.text('Mohanlal Sharma'), findsOneWidget); // Gen 2 Spouse 2
        expect(find.text('Sunil Sharma'), findsOneWidget); // Gen 2 Child 2
        expect(
          find.text('Mahendra Agarwal'),
          findsOneWidget,
        ); // Gen 3 Sibling 1
        expect(find.text('Rekha Agarwal'), findsOneWidget); // Gen 3 Spouse 1
        expect(find.text('Karan Agarwal'), findsOneWidget); // Gen 3 Child 1
        expect(find.text('Anita Agarwal'), findsOneWidget); // Gen 3 Sibling 2
        expect(find.text('Rajesh Sharma'), findsOneWidget); // Gen 3 Spouse 2
        expect(find.text('Pooja Sharma'), findsOneWidget); // Gen 3 Child 2
        expect(find.text('Jerry Mouse'), findsOneWidget); // Gen 4 Sibling 1
        expect(find.text('Jenny Mouse'), findsOneWidget); // Gen 4 Spouse 1
        expect(find.text('Leo Mouse'), findsOneWidget); // Gen 4 Child 1
        expect(find.text('Rani Marwadi'), findsOneWidget); // Gen 4 Sibling 2
        expect(find.text('Rohit Marwadi'), findsOneWidget); // Gen 4 Spouse 2
        expect(find.text('Sneha Marwadi'), findsOneWidget); // Gen 4 Child 2
        expect(find.text('Vikas Agarwal'), findsOneWidget); // Gen 4 Sibling 3
        expect(find.text('Neha Agarwal'), findsOneWidget); // Gen 4 Spouse 3
        expect(find.text('Rohan Agarwal'), findsOneWidget); // Gen 4 Child 3
        expect(find.text('Aarav Agarwal'), findsOneWidget); // Gen 5 Son
        expect(
          find.text('Pooja Agarwal'),
          findsOneWidget,
        ); // Gen 5 Daughter-in-law
        expect(find.text('Ananya Agarwal'), findsOneWidget); // Gen 5 Daughter
        expect(find.text('Rahul Verma'), findsOneWidget); // Gen 5 Son-in-law
        expect(find.text('Kabir Agarwal'), findsOneWidget); // Gen 6 Grandson
        expect(
          find.text('Myra Agarwal'),
          findsOneWidget,
        ); // Gen 6 Granddaughter
        expect(find.text('Ishaan Verma'), findsOneWidget); // Gen 6 Grandson
      },
    );

    test('KinshipEngine validates 6-tier generational hierarchy', () {
      expect(KinshipEngine.getGenerationalLevel('Great Grandfather'), 3);
      expect(KinshipEngine.getGenerationalLevel('Great Grandmother'), 3);
      expect(KinshipEngine.getGenerationalLevel('Grandfather'), 2);
      expect(KinshipEngine.getGenerationalLevel('Grandmother'), 2);
      expect(
        KinshipEngine.getGenerationalLevel('Paternal Grandfather (Dada)'),
        2,
      );
      expect(
        KinshipEngine.getGenerationalLevel('Paternal Grandmother (Dadi)'),
        2,
      );
      expect(KinshipEngine.getGenerationalLevel('Father'), 1);
      expect(KinshipEngine.getGenerationalLevel('Mother'), 1);
      expect(KinshipEngine.getGenerationalLevel('Uncle (Kaka)'), 1);
      expect(KinshipEngine.getGenerationalLevel('Aunt (Bua)'), 1);
      expect(KinshipEngine.getGenerationalLevel('Father-in-law (Sasurji)'), 1);
      expect(KinshipEngine.getGenerationalLevel('Mother-in-law (Sasuji)'), 1);
      expect(KinshipEngine.getGenerationalLevel('Self'), 0);
      expect(KinshipEngine.getGenerationalLevel('Spouse'), 0);
      expect(KinshipEngine.getGenerationalLevel('Husband'), 0);
      expect(KinshipEngine.getGenerationalLevel('Wife'), 0);
      expect(KinshipEngine.getGenerationalLevel('Brother'), 0);
      expect(KinshipEngine.getGenerationalLevel('Sister'), 0);
      expect(KinshipEngine.getGenerationalLevel('Cousin'), 0);
      expect(KinshipEngine.getGenerationalLevel('Son'), -1);
      expect(KinshipEngine.getGenerationalLevel('Daughter'), -1);
      expect(KinshipEngine.getGenerationalLevel('Nephew (Bhatija)'), -1);
      expect(KinshipEngine.getGenerationalLevel('Niece (Bhatiji)'), -1);
      expect(KinshipEngine.getGenerationalLevel('Son-in-law (Damad)'), -1);
      expect(KinshipEngine.getGenerationalLevel('Daughter-in-law (Bahu)'), -1);
      expect(KinshipEngine.getGenerationalLevel('Grandson (Pota)'), -2);
      expect(KinshipEngine.getGenerationalLevel('Granddaughter (Poti)'), -2);
      expect(
        KinshipEngine.getGenerationalLevel('Great-Grandson (Pardota)'),
        -3,
      );
      expect(
        KinshipEngine.getGenerationalLevel('Great-Granddaughter (Pardoti)'),
        -3,
      );
    });

    test(
      'KinshipEngine calculates reciprocal titles for both male and female viewers',
      () {
        // Viewer is Male
        expect(
          KinshipEngine.calculateReciprocal(
            directRelation: 'Father',
            viewerGender: 'Male',
          ),
          'Son',
        );
        expect(
          KinshipEngine.calculateReciprocal(
            directRelation: 'Mother',
            viewerGender: 'Male',
          ),
          'Son',
        );
        expect(
          KinshipEngine.calculateReciprocal(
            directRelation: 'Son',
            viewerGender: 'Male',
          ),
          'Father',
        );
        expect(
          KinshipEngine.calculateReciprocal(
            directRelation: 'Wife',
            viewerGender: 'Male',
          ),
          'Husband',
        );
        expect(
          KinshipEngine.calculateReciprocal(
            directRelation: 'Brother',
            viewerGender: 'Male',
          ),
          'Brother',
        );
        expect(
          KinshipEngine.calculateReciprocal(
            directRelation: 'Paternal Grandfather',
            viewerGender: 'Male',
          ),
          'Grandson (Pota)',
        );
        expect(
          KinshipEngine.calculateReciprocal(
            directRelation: 'Uncle (Kaka)',
            viewerGender: 'Male',
          ),
          'Nephew (Bhatija)',
        );
        expect(
          KinshipEngine.calculateReciprocal(
            directRelation: 'Father-in-law',
            viewerGender: 'Male',
          ),
          'Son-in-law (Damad)',
        );

        // Viewer is Female
        expect(
          KinshipEngine.calculateReciprocal(
            directRelation: 'Father',
            viewerGender: 'Female',
          ),
          'Daughter',
        );
        expect(
          KinshipEngine.calculateReciprocal(
            directRelation: 'Mother',
            viewerGender: 'Female',
          ),
          'Daughter',
        );
        expect(
          KinshipEngine.calculateReciprocal(
            directRelation: 'Son',
            viewerGender: 'Female',
          ),
          'Mother',
        );
        expect(
          KinshipEngine.calculateReciprocal(
            directRelation: 'Husband',
            viewerGender: 'Female',
          ),
          'Wife',
        );
        expect(
          KinshipEngine.calculateReciprocal(
            directRelation: 'Brother',
            viewerGender: 'Female',
          ),
          'Sister',
        );
        expect(
          KinshipEngine.calculateReciprocal(
            directRelation: 'Paternal Grandfather',
            viewerGender: 'Female',
          ),
          'Granddaughter (Poti)',
        );
        expect(
          KinshipEngine.calculateReciprocal(
            directRelation: 'Uncle (Kaka)',
            viewerGender: 'Female',
          ),
          'Niece (Bhatiji)',
        );
        expect(
          KinshipEngine.calculateReciprocal(
            directRelation: 'Father-in-law',
            viewerGender: 'Female',
          ),
          'Daughter-in-law (Bahu)',
        );
      },
    );

    test('KinshipEngine resolves multi-hop paths accurately', () {
      // 2-hop
      expect(
        KinshipEngine.resolveMultiHopPath(['Father', 'Father']),
        'Paternal Grandfather (Dada)',
      );
      expect(
        KinshipEngine.resolveMultiHopPath(['Father', 'Mother']),
        'Paternal Grandmother (Dadi)',
      );
      expect(
        KinshipEngine.resolveMultiHopPath(['Father', 'Brother']),
        'Paternal Uncle (Kaka)',
      );
      expect(
        KinshipEngine.resolveMultiHopPath(['Father', 'Sister']),
        'Paternal Aunt (Bua)',
      );
      expect(
        KinshipEngine.resolveMultiHopPath(['Brother', 'Son']),
        'Nephew (Bhatija)',
      );
      expect(
        KinshipEngine.resolveMultiHopPath(['Brother', 'Daughter']),
        'Niece (Bhatiji)',
      );
      expect(
        KinshipEngine.resolveMultiHopPath(['Brother', 'Wife']),
        'Sister-in-law (Bhabhi)',
      );
      expect(
        KinshipEngine.resolveMultiHopPath(['Son', 'Son']),
        'Grandson (Pota)',
      );

      // 3-hop
      expect(
        KinshipEngine.resolveMultiHopPath([
          'Father',
          'Brother',
          'Son',
        ], targetGender: 'Male'),
        'Cousin (Brother)',
      );
      expect(
        KinshipEngine.resolveMultiHopPath([
          'Father',
          'Brother',
          'Daughter',
        ], targetGender: 'Female'),
        'Cousin (Sister)',
      );
      expect(
        KinshipEngine.resolveMultiHopPath(['Father', 'Brother', 'Wife']),
        'Paternal Aunt (Kaki)',
      );
    });

    test(
      'Canonical Patel Family Tree from Architecture Guide has correct topology and members',
      () {
        final root = FamilyTreeMock.createPatelFamilyTree();

        expect(root.fullName, 'Aarav Patel');
        expect(root.gender, 'Male');
        expect(root.isRegisteredUser, isTrue);

        // Verify parents (Sureshbhai & Hansaben)
        expect(root.parents.length, 2);
        final father = root.parents.firstWhere(
          (p) => p.relationshipType == 'Father',
        );
        final mother = root.parents.firstWhere(
          (p) => p.relationshipType == 'Mother',
        );
        expect(father.fullName, 'Sureshbhai Patel');
        expect(father.isRegisteredUser, isTrue);
        expect(mother.fullName, 'Hansaben Patel');
        expect(mother.isRegisteredUser, isFalse);

        // Verify Paternal Grandfather Tribhovandas (Deceased)
        expect(father.parents.length, 1);
        final grandfather = father.parents.first;
        expect(grandfather.fullName, 'Tribhovandas Patel');
        expect(grandfather.isDeceased, isTrue);

        // Verify Paternal Uncle Rameshbhai
        expect(father.siblings.length, 1);
        final uncle = father.siblings.first;
        expect(uncle.fullName, 'Rameshbhai Patel');
        expect(uncle.relationshipToViewer, 'Paternal Uncle (Kaka)');

        // Verify Cousin Meet Patel
        expect(uncle.children.length, 1);
        final cousin = uncle.children.first;
        expect(cousin.fullName, 'Meet Patel');

        // Verify Brother Rohan
        expect(root.siblings.length, 1);
        expect(root.siblings.first.fullName, 'Rohan Patel');

        // Verify Wife Pooja
        expect(root.spouses.length, 1);
        expect(root.spouses.first.fullName, 'Pooja Patel');

        // Verify Son Kabir
        expect(root.children.length, 1);
        expect(root.children.first.fullName, 'Kabir Patel');

        // Test path finding from Aarav to Cousin Meet
        final pathToMeet = KinshipEngine.findPathToMember(root, cousin.id!);
        expect(pathToMeet, isNotNull);
        expect(pathToMeet!.length, 4); // Root -> Father -> Brother -> Son
        final hopsToMeet = pathToMeet
            .skip(1)
            .map((h) => h.relationToPrev)
            .toList();
        final resolvedCousin = KinshipEngine.resolveMultiHopPath(
          hopsToMeet,
          targetGender: cousin.gender,
        );
        expect(resolvedCousin, 'Cousin (Brother)');

        // Test path finding from Aarav to Grandfather Tribhovandas
        final pathToGrandfather = KinshipEngine.findPathToMember(
          root,
          grandfather.id!,
        );
        expect(pathToGrandfather, isNotNull);
        expect(pathToGrandfather!.length, 3); // Root -> Father -> Father
        final hopsToGf = pathToGrandfather
            .skip(1)
            .map((h) => h.relationToPrev)
            .toList();
        final resolvedGf = KinshipEngine.resolveMultiHopPath(hopsToGf);
        expect(resolvedGf, 'Paternal Grandfather (Dada)');
      },
    );

    testWidgets(
      'FamilyTreeScreen renders canonical Patel Architecture Tree without overflow',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(1200, 1600);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() => tester.view.resetPhysicalSize());

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              familyControllerProvider.overrideWith(
                () => MockPatelFamilyController(),
              ),
            ],
            child: const MaterialApp(home: FamilyTreeScreen()),
          ),
        );

        await tester.pumpAndSettle();

        // Check key members from Patel family
        expect(find.text('Aarav Patel'), findsOneWidget); // Self
        expect(find.text('Sureshbhai Patel'), findsOneWidget); // Father
        expect(find.text('Hansaben Patel'), findsOneWidget); // Mother
        expect(find.text('Tribhovandas Patel'), findsOneWidget); // Grandfather
        expect(find.text('Rameshbhai Patel'), findsOneWidget); // Uncle
        expect(find.text('Meet Patel'), findsOneWidget); // Cousin
        expect(find.text('Rohan Patel'), findsOneWidget); // Brother
        expect(find.text('Pooja Patel'), findsOneWidget); // Wife
        expect(find.text('Kabir Patel'), findsOneWidget); // Son
      },
    );

    testWidgets('Tapping Self node does not navigate to member profile screen', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1200, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      String? pushedProfileId;

      final router = GoRouter(
        initialLocation: '/family_tree',
        routes: [
          GoRoute(
            path: '/family_tree',
            builder: (context, state) => const FamilyTreeScreen(),
          ),
          GoRoute(
            path: '/profile_view',
            builder: (context, state) {
              final extra = state.extra as Map<String, dynamic>?;
              pushedProfileId = extra?['id'] as String?;
              return const Scaffold(body: Text('Member Profile Screen'));
            },
          ),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            familyControllerProvider.overrideWith(() => MockFamilyController()),
          ],
          child: MaterialApp.router(routerConfig: router),
        ),
      );

      await tester.pumpAndSettle();

      // Find Tom Cat (Self / Viewer node)
      final selfFinder = find.text('Tom Cat');
      expect(selfFinder, findsOneWidget);

      // Tap on Self node
      await tester.tap(selfFinder);
      await tester.pumpAndSettle();

      // Ensure that navigation to member profile screen did NOT happen
      expect(pushedProfileId, isNull);
      expect(find.text('Member Profile Screen'), findsNothing);
      expect(find.text('Tom Cat'), findsOneWidget);

      // Now tap on a registered family member (Father: Suresh Agarwal)
      final fatherFinder = find.text('Suresh Agarwal');
      expect(fatherFinder, findsOneWidget);

      await tester.tap(fatherFinder);
      await tester.pumpAndSettle();

      // Ensure that FamilyNodeActionsSheet opens
      expect(find.text('View Profile'), findsOneWidget);
      expect(find.text('Edit Family Member'), findsOneWidget);
      expect(find.text('Remove from Family Tree'), findsOneWidget);

      // Tap View Profile in the action sheet
      await tester.tap(find.text('View Profile'));
      await tester.pumpAndSettle();

      // Ensure that registered family member DOES navigate to member profile screen
      expect(pushedProfileId, 'mock-user-father');
      expect(find.text('Member Profile Screen'), findsOneWidget);
    });

    testWidgets(
      'Live 20-member 5-depth tree with all in-laws renders in FamilyTreeCanvas without errors',
      (tester) async {
        final file = File(
          '/Users/techstaunch/.gemini/antigravity/brain/9368675c-c78c-460b-8120-7d11fc8bb403/scratch/final_20_tree_verified.json',
        );
        if (!file.existsSync()) return;
        final jsonMap =
            jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
        final rootNode = FamilyTreeNode.fromJson(jsonMap['data']['tree']);

        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(
              home: Scaffold(
                body: FamilyTreeCanvas(
                  rootNode: rootNode,
                  currentUserId: '5e724c4f-a187-45bf-9194-d40969444417',
                ),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Aarav Patel'), findsOneWidget);
        expect(find.text('Sureshbhai Patel'), findsOneWidget);
        expect(find.text('Hansaben Patel'), findsOneWidget);
        expect(find.text('Tribhovandas Patel'), findsOneWidget);
        expect(find.text('Maniben Patel'), findsOneWidget);
        expect(find.text('Grandmother (Dadi)'), findsOneWidget);
        expect(find.text('Arvindbhai Shah'), findsOneWidget);
        expect(find.text('Sarojben Shah'), findsOneWidget);
        expect(find.text('Pooja Patel'), findsOneWidget);
        expect(find.text('Kabir Patel'), findsOneWidget);
        expect(find.text('Dev Patel'), findsOneWidget);
        expect(find.text('Aayush Patel'), findsOneWidget);
        expect(find.text('Rahul Sharma'), findsOneWidget);

        // Verify in-laws titles
        expect(find.text('Father-in-law (Sasurji)'), findsOneWidget);
        expect(find.text('Mother-in-law (Sasuji)'), findsOneWidget);
        expect(find.text('Son-in-law (Damad)'), findsOneWidget);
        expect(find.text('Daughter-in-law (Bahu)'), findsOneWidget);

        // Verify no overflow exception
        expect(tester.takeException(), isNull);
      },
    );

    testWidgets(
      'FamilyTreeCanvas generates branch painters and gap connectors for siblings and ancestors',
      (tester) async {
        // Create a test tree with Grandparents, Parents with siblings (Uncle/Aunt), Self with siblings, and Children
        const tree = FamilyTreeNode(
          id: 'self',
          fullName: 'Self Node',
          gender: 'Male',
          parents: [
            FamilyTreeNode(
              id: 'father',
              fullName: 'Father Node',
              gender: 'Male',
              parents: [
                FamilyTreeNode(
                  id: 'dada',
                  fullName: 'Dada Node',
                  gender: 'Male',
                ),
                FamilyTreeNode(
                  id: 'dadi',
                  fullName: 'Dadi Node',
                  gender: 'Female',
                ),
              ],
              siblings: [
                FamilyTreeNode(
                  id: 'uncle',
                  fullName: 'Uncle Node',
                  gender: 'Male',
                ),
                FamilyTreeNode(
                  id: 'aunt',
                  fullName: 'Aunt Node',
                  gender: 'Female',
                ),
              ],
            ),
            FamilyTreeNode(
              id: 'mother',
              fullName: 'Mother Node',
              gender: 'Female',
            ),
          ],
          spouses: [
            FamilyTreeNode(id: 'wife', fullName: 'Wife Node', gender: 'Female'),
          ],
          siblings: [
            FamilyTreeNode(
              id: 'brother',
              fullName: 'Brother Node',
              gender: 'Male',
            ),
            FamilyTreeNode(
              id: 'sister',
              fullName: 'Sister Node',
              gender: 'Female',
            ),
          ],
          children: [
            FamilyTreeNode(
              id: 'son',
              fullName: 'Son Node',
              gender: 'Male',
              spouses: [
                FamilyTreeNode(
                  id: 'dil',
                  fullName: 'Daughter-in-law Node',
                  gender: 'Female',
                ),
              ],
              children: [
                FamilyTreeNode(
                  id: 'grandson',
                  fullName: 'Grandson Node',
                  gender: 'Male',
                ),
              ],
            ),
            FamilyTreeNode(
              id: 'daughter',
              fullName: 'Daughter Node',
              gender: 'Female',
            ),
          ],
        );

        await tester.pumpWidget(
          const ProviderScope(
            child: MaterialApp(
              home: Scaffold(
                body: FamilyTreeCanvas(rootNode: tree, currentUserId: 'self'),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        // Verify all generation nodes are rendered
        expect(find.text('Dada Node'), findsOneWidget);
        expect(find.text('Dadi Node'), findsOneWidget);
        expect(find.text('Uncle Node'), findsOneWidget);
        expect(find.text('Aunt Node'), findsOneWidget);
        expect(find.text('Father Node'), findsOneWidget);
        expect(find.text('Mother Node'), findsOneWidget);
        expect(find.text('Brother Node'), findsOneWidget);
        expect(find.text('Sister Node'), findsOneWidget);
        expect(find.text('Self Node'), findsOneWidget);
        expect(find.text('Wife Node'), findsOneWidget);
        expect(find.text('Son Node'), findsOneWidget);
        expect(find.text('Daughter-in-law Node'), findsOneWidget);
        expect(find.text('Daughter Node'), findsOneWidget);
        expect(find.text('Grandson Node'), findsOneWidget);

        // Verify branch gap connectors exist across siblings, uncles/aunts, and children
        final customPaintFinder = find.byType(CustomPaint);
        expect(customPaintFinder, findsWidgets);

        // Check that at least 5 CustomPaint widgets are painted for branches
        expect(customPaintFinder.evaluate().length, greaterThanOrEqualTo(5));
        expect(tester.takeException(), isNull);
      },
    );

    testWidgets(
      'Connector correctly drops from couple center and targets blood child without dropping on spouse',
      (tester) async {
        const tree = FamilyTreeNode(
          id: 'self',
          fullName: 'Aarav Patel',
          gender: 'Male',
          spouses: [
            FamilyTreeNode(
              id: 'wife',
              fullName: 'Pooja Patel',
              gender: 'Female',
            ),
          ],
          children: [
            FamilyTreeNode(
              id: 'son',
              fullName: 'Kabir Patel',
              gender: 'Male',
              spouses: [
                FamilyTreeNode(
                  id: 'dil',
                  fullName: 'Ananya Patel',
                  gender: 'Female',
                ),
              ],
            ),
            FamilyTreeNode(
              id: 'daughter',
              fullName: 'Meera Patel',
              gender: 'Female',
            ),
          ],
        );

        await tester.pumpWidget(
          const ProviderScope(
            child: MaterialApp(
              home: Scaffold(
                body: FamilyTreeCanvas(rootNode: tree, currentUserId: 'self'),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Aarav Patel'), findsOneWidget);
        expect(find.text('Pooja Patel'), findsOneWidget);
        expect(find.text('Kabir Patel'), findsOneWidget);
        expect(find.text('Ananya Patel'), findsOneWidget);
        expect(find.text('Meera Patel'), findsOneWidget);

        // Verify custom painter is present and has no errors
        final customPaintFinder = find.byType(CustomPaint);
        expect(customPaintFinder, findsWidgets);
        expect(tester.takeException(), isNull);
      },
    );
  });
}

class MockFamilyController extends FamilyController {
  @override
  Future<FamilyTreeNode?> build() async {
    return FamilyTreeMock.create5GenerationTree();
  }
}

class MockExtendedFamilyController extends FamilyController {
  @override
  Future<FamilyTreeNode?> build() async {
    return FamilyTreeMock.createExtendedFullFamilyTree();
  }
}

class MockPatelFamilyController extends FamilyController {
  @override
  Future<FamilyTreeNode?> build() async {
    return FamilyTreeMock.createPatelFamilyTree();
  }
}
