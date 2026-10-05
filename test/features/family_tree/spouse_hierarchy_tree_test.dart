import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:community_connect/src/features/family_tree/data/family_models.dart';
import 'package:community_connect/src/features/family_tree/presentation/widgets/family_tree_canvas.dart';

void main() {
  const jsonResponse = '''
{
    "id": "14e3f3a6-3074-4f58-8919-a464b09904ea",
    "title": null,
    "fullName": "Sneha Verma",
    "gender": "Female",
    "dob": "2001-05-12T00:00:00.000Z",
    "photoUrl": null,
    "qrImageUrl": null,
    "linkedMobile": "919800000208",
    "relationshipToViewer": "Other",
    "isRegisteredUser": true,
    "parents": [],
    "spouses": [
        {
            "id": "3ae41aff-9149-4da0-a95f-915468e6ccde",
            "title": null,
            "fullName": "Aditya Verma",
            "gender": "Male",
            "dob": "2000-02-14T00:00:00.000Z",
            "isDeceased": false,
            "isMinor": false,
            "photoUrl": null,
            "qrImageUrl": null,
            "linkedMobile": "919800000206",
            "directRelationship": "Husband",
            "relationshipToViewer": "Other",
            "isRegisteredUser": true,
            "children": [],
            "spouses": [
                {
                    "id": "14e3f3a6-3074-4f58-8919-a464b09904ea",
                    "title": null,
                    "fullName": "Sneha Verma",
                    "gender": "Female",
                    "dob": "2001-05-12T00:00:00.000Z",
                    "isDeceased": false,
                    "isMinor": false,
                    "photoUrl": null,
                    "qrImageUrl": null,
                    "linkedMobile": "919800000208",
                    "directRelationship": "Wife",
                    "relationshipToViewer": "Wife",
                    "isRegisteredUser": true,
                    "children": [],
                    "spouses": [],
                    "parents": [],
                    "siblings": []
                }
            ],
            "parents": [
                {
                    "id": "3bd04161-be66-413c-8a2a-7d0c914480e5",
                    "title": "Shri",
                    "fullName": "Ravi Verma",
                    "gender": "Male",
                    "dob": "1978-03-22T00:00:00.000Z",
                    "isDeceased": false,
                    "isMinor": false,
                    "photoUrl": null,
                    "qrImageUrl": null,
                    "linkedMobile": "919800000203",
                    "directRelationship": "Father",
                    "relationshipToViewer": "Other",
                    "isRegisteredUser": true,
                    "children": [
                        {
                            "id": "3ae41aff-9149-4da0-a95f-915468e6ccde",
                            "title": null,
                            "fullName": "Aditya Verma",
                            "gender": "Male",
                            "dob": "2000-02-14T00:00:00.000Z",
                            "isDeceased": false,
                            "isMinor": false,
                            "photoUrl": null,
                            "qrImageUrl": null,
                            "linkedMobile": "919800000206",
                            "directRelationship": "Son",
                            "relationshipToViewer": "Son",
                            "isRegisteredUser": true,
                            "children": [],
                            "spouses": []
                        },
                        {
                            "id": "b884823c-b3c8-4143-96c6-3aaa76c01f55",
                            "title": null,
                            "fullName": "Nisha Verma",
                            "gender": "Female",
                            "dob": "2003-08-30T00:00:00.000Z",
                            "isDeceased": false,
                            "isMinor": false,
                            "photoUrl": null,
                            "qrImageUrl": null,
                            "linkedMobile": "919800000207",
                            "directRelationship": "Daughter",
                            "relationshipToViewer": "Other",
                            "isRegisteredUser": true,
                            "children": [],
                            "spouses": [],
                            "parents": [
                                {
                                    "id": "3bd04161-be66-413c-8a2a-7d0c914480e5",
                                    "title": "Shri",
                                    "fullName": "Ravi Verma",
                                    "gender": "Male",
                                    "dob": "1978-03-22T00:00:00.000Z",
                                    "isDeceased": false,
                                    "isMinor": false,
                                    "photoUrl": null,
                                    "qrImageUrl": null,
                                    "linkedMobile": "919800000203",
                                    "directRelationship": "Father",
                                    "relationshipToViewer": "Father",
                                    "isRegisteredUser": true,
                                    "children": [],
                                    "spouses": [],
                                    "parents": [],
                                    "siblings": []
                                },
                                {
                                    "id": "a995a30f-26e6-42ec-b71e-e7721d9587db",
                                    "title": "Smt",
                                    "fullName": "Kavita Verma",
                                    "gender": "Female",
                                    "dob": "1981-07-05T00:00:00.000Z",
                                    "isDeceased": false,
                                    "isMinor": false,
                                    "photoUrl": null,
                                    "qrImageUrl": null,
                                    "linkedMobile": "919800000204",
                                    "directRelationship": "Mother",
                                    "relationshipToViewer": "Other",
                                    "isRegisteredUser": true,
                                    "children": [],
                                    "spouses": [],
                                    "parents": [],
                                    "siblings": []
                                }
                            ],
                            "siblings": []
                        }
                    ],
                    "spouses": [
                        {
                            "id": "a995a30f-26e6-42ec-b71e-e7721d9587db",
                            "title": "Smt",
                            "fullName": "Kavita Verma",
                            "gender": "Female",
                            "dob": "1981-07-05T00:00:00.000Z",
                            "isDeceased": false,
                            "isMinor": false,
                            "photoUrl": null,
                            "qrImageUrl": null,
                            "linkedMobile": "919800000204",
                            "directRelationship": "Wife",
                            "relationshipToViewer": "Wife",
                            "isRegisteredUser": true,
                            "children": [],
                            "spouses": [],
                            "parents": [],
                            "siblings": []
                        }
                    ],
                    "parents": [
                        {
                            "id": "33f24444-4f26-4999-bdd9-c2aa672ce6ec",
                            "title": "Late Shri",
                            "fullName": "Hariom Verma",
                            "gender": "Male",
                            "dob": "1950-05-10T00:00:00.000Z",
                            "isDeceased": false,
                            "isMinor": false,
                            "photoUrl": null,
                            "qrImageUrl": null,
                            "linkedMobile": "919800000201",
                            "directRelationship": "Father",
                            "relationshipToViewer": "Other",
                            "isRegisteredUser": true,
                            "children": [
                                {
                                    "id": "3bd04161-be66-413c-8a2a-7d0c914480e5",
                                    "title": "Shri",
                                    "fullName": "Ravi Verma",
                                    "gender": "Male",
                                    "dob": "1978-03-22T00:00:00.000Z",
                                    "isDeceased": false,
                                    "isMinor": false,
                                    "photoUrl": null,
                                    "qrImageUrl": null,
                                    "linkedMobile": "919800000203",
                                    "directRelationship": "Son",
                                    "relationshipToViewer": "Son",
                                    "isRegisteredUser": true,
                                    "children": [],
                                    "spouses": []
                                },
                                {
                                    "id": "9ca7efc9-7548-4dd8-8a37-56b972037854",
                                    "title": null,
                                    "fullName": "Ajay Verma",
                                    "gender": "Male",
                                    "dob": "1982-11-15T00:00:00.000Z",
                                    "isDeceased": false,
                                    "isMinor": false,
                                    "photoUrl": null,
                                    "qrImageUrl": null,
                                    "linkedMobile": "919800000205",
                                    "directRelationship": "Son",
                                    "relationshipToViewer": "Other",
                                    "isRegisteredUser": true,
                                    "children": [],
                                    "spouses": [],
                                    "parents": [],
                                    "siblings": []
                                }
                            ],
                            "spouses": [
                                {
                                    "id": "6e5e9000-f63f-4a52-93b8-3639fe9d3e98",
                                    "title": "Smt",
                                    "fullName": "Shanti Verma",
                                    "gender": "Female",
                                    "dob": "1953-09-18T00:00:00.000Z",
                                    "isDeceased": false,
                                    "isMinor": false,
                                    "photoUrl": null,
                                    "qrImageUrl": null,
                                    "linkedMobile": "919800000202",
                                    "directRelationship": "Wife",
                                    "relationshipToViewer": "Other",
                                    "isRegisteredUser": true,
                                    "children": [],
                                    "spouses": [],
                                    "parents": [],
                                    "siblings": []
                                }
                            ],
                            "parents": [],
                            "siblings": []
                        },
                        {
                            "id": "6e5e9000-f63f-4a52-93b8-3639fe9d3e98",
                            "title": "Smt",
                            "fullName": "Shanti Verma",
                            "gender": "Female",
                            "dob": "1953-09-18T00:00:00.000Z",
                            "isDeceased": false,
                            "isMinor": false,
                            "photoUrl": null,
                            "qrImageUrl": null,
                            "linkedMobile": "919800000202",
                            "directRelationship": "Mother",
                            "relationshipToViewer": "Mother",
                            "isRegisteredUser": true,
                            "children": [],
                            "spouses": [],
                            "parents": [],
                            "siblings": []
                        }
                    ],
                    "siblings": [
                        {
                            "id": "9ca7efc9-7548-4dd8-8a37-56b972037854",
                            "title": null,
                            "fullName": "Ajay Verma",
                            "gender": "Male",
                            "dob": "1982-11-15T00:00:00.000Z",
                            "isDeceased": false,
                            "isMinor": false,
                            "photoUrl": null,
                            "qrImageUrl": null,
                            "linkedMobile": "919800000205",
                            "directRelationship": "Brother",
                            "relationshipToViewer": "Brother",
                            "isRegisteredUser": true,
                            "children": [],
                            "spouses": []
                        }
                    ]
                },
                {
                    "id": "a995a30f-26e6-42ec-b71e-e7721d9587db",
                    "title": "Smt",
                    "fullName": "Kavita Verma",
                    "gender": "Female",
                    "dob": "1981-07-05T00:00:00.000Z",
                    "isDeceased": false,
                    "isMinor": false,
                    "photoUrl": null,
                    "qrImageUrl": null,
                    "linkedMobile": "919800000204",
                    "directRelationship": "Mother",
                    "relationshipToViewer": "Mother",
                    "isRegisteredUser": true,
                    "children": [],
                    "spouses": [],
                    "parents": [],
                    "siblings": []
                }
            ],
            "siblings": [
                {
                    "id": "b884823c-b3c8-4143-96c6-3aaa76c01f55",
                    "title": null,
                    "fullName": "Nisha Verma",
                    "gender": "Female",
                    "dob": "2003-08-30T00:00:00.000Z",
                    "isDeceased": false,
                    "isMinor": false,
                    "photoUrl": null,
                    "qrImageUrl": null,
                    "linkedMobile": "919800000207",
                    "directRelationship": "Sister",
                    "relationshipToViewer": "Sister",
                    "isRegisteredUser": true,
                    "children": [],
                    "spouses": []
                }
            ]
        }
    ],
    "siblings": [],
    "children": []
}
''';

  testWidgets(
    'FamilyTreeCanvas displays entire family tree (grandparents, parents, uncle, siblings) when root user is a spouse',
    (tester) async {
      tester.view.physicalSize = const Size(1800, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final data = json.decode(jsonResponse) as Map<String, dynamic>;
      final rootNode = FamilyTreeNode.fromJson(data);

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: FamilyTreeCanvas(
                rootNode: rootNode,
                focusUserId: '14e3f3a6-3074-4f58-8919-a464b09904ea',
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // 1. Tier 0 - Root & Spouse & Siblings
      expect(find.text('Sneha Verma'), findsOneWidget);
      expect(find.text('Aditya Verma'), findsOneWidget);
      expect(find.text('Nisha Verma'), findsOneWidget);

      // 2. Tier 1 - Parents & Uncle
      expect(find.text('Ravi Verma'), findsOneWidget);
      expect(find.text('Kavita Verma'), findsOneWidget);
      expect(find.text('Ajay Verma'), findsOneWidget);

      // 3. Tier 2 - Grandparents
      expect(find.text('Hariom Verma'), findsOneWidget);
      expect(find.text('Shanti Verma'), findsOneWidget);

      // 4. Relations / Roles
      expect(find.text('Father-in-law (Sasurji)'), findsOneWidget);
      expect(find.text('Mother-in-law (Sasuji)'), findsOneWidget);
      expect(find.text('Paternal Uncle (Kaka)'), findsOneWidget);
      expect(find.text('Grandfather (Dada)'), findsOneWidget);
      expect(find.text('Grandmother (Dadi)'), findsOneWidget);
      expect(find.text('Sister-in-law (Nanad)'), findsOneWidget);
      expect(find.text('Husband'), findsOneWidget);
    },
  );
}
