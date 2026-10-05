import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:community_connect/src/features/family_tree/data/family_models.dart';
import 'package:community_connect/src/features/family_tree/presentation/widgets/family_tree_canvas.dart';

void main() {
  const jsonResponse = '''
{
    "id": "2e9819be-d5f9-4e20-b507-b4f19c31dc9a",
    "title": "Shri",
    "fullName": "Suresh Sharma",
    "gender": "Male",
    "dob": "1978-06-30T00:00:00.000Z",
    "photoUrl": null,
    "qrImageUrl": "https://wvuqqqumigichqmomonk.supabase.co/storage/v1/object/public/community-data/qrcodes/qr-2e9819be-d5f9-4e20-b507-b4f19c31dc9a.png",
    "linkedMobile": "919800000005",
    "relationshipToViewer": "Other",
    "isRegisteredUser": true,
    "parents": [
        {
            "id": "e6fef8c2-2d5d-46f3-b0ef-4b150fa4f991",
            "title": "Shri",
            "fullName": "Raghunath Sharma",
            "gender": "Male",
            "dob": "1951-03-15T00:00:00.000Z",
            "isDeceased": false,
            "isMinor": false,
            "photoUrl": null,
            "qrImageUrl": null,
            "linkedMobile": "919800000001",
            "directRelationship": "Father",
            "relationshipToViewer": "Other",
            "isRegisteredUser": true,
            "children": [
                {
                    "id": "2e9819be-d5f9-4e20-b507-b4f19c31dc9a",
                    "title": "Shri",
                    "fullName": "Suresh Sharma",
                    "gender": "Male",
                    "dob": "1978-06-30T00:00:00.000Z",
                    "isDeceased": false,
                    "isMinor": false,
                    "photoUrl": null,
                    "qrImageUrl": null,
                    "linkedMobile": "919800000005",
                    "directRelationship": "Son",
                    "relationshipToViewer": "Son",
                    "isRegisteredUser": true,
                    "children": [],
                    "spouses": []
                },
                {
                    "id": "4903c93a-195b-4e63-b969-986784f26bf2",
                    "title": "Shri",
                    "fullName": "Dinesh Sharma",
                    "gender": "Male",
                    "dob": "1974-11-05T00:00:00.000Z",
                    "isDeceased": false,
                    "isMinor": false,
                    "photoUrl": null,
                    "qrImageUrl": null,
                    "linkedMobile": "919800000003",
                    "directRelationship": "Son",
                    "relationshipToViewer": "Other",
                    "isRegisteredUser": true,
                    "children": [
                        {
                            "id": "ca96ddf8-8a7d-419d-8bb4-8e05fd6fe9c6",
                            "title": null,
                            "fullName": "Rohit Sharma",
                            "gender": "Male",
                            "dob": "1998-01-12T00:00:00.000Z",
                            "isDeceased": false,
                            "isMinor": false,
                            "photoUrl": null,
                            "qrImageUrl": null,
                            "linkedMobile": "919800000006",
                            "directRelationship": "Son",
                            "relationshipToViewer": "Other",
                            "isRegisteredUser": true,
                            "children": [
                                {
                                    "id": "7446f43b-0cf9-4451-9e71-8f70046e358f",
                                    "title": null,
                                    "fullName": "Arjun Sharma",
                                    "gender": "Male",
                                    "dob": "2021-12-01T00:00:00.000Z",
                                    "isDeceased": false,
                                    "isMinor": false,
                                    "photoUrl": null,
                                    "qrImageUrl": null,
                                    "linkedMobile": "919800000009",
                                    "directRelationship": "Son",
                                    "relationshipToViewer": "Other",
                                    "isRegisteredUser": true,
                                    "children": [],
                                    "spouses": [],
                                    "parents": [],
                                    "siblings": []
                                }
                            ],
                            "spouses": []
                        },
                        {
                            "id": "843dbc6e-7429-4ed8-b055-82c69f9bfedf",
                            "title": null,
                            "fullName": "Priya Sharma",
                            "gender": "Female",
                            "dob": "2000-09-08T00:00:00.000Z",
                            "isDeceased": false,
                            "isMinor": false,
                            "photoUrl": null,
                            "qrImageUrl": null,
                            "linkedMobile": "919800000007",
                            "directRelationship": "Daughter",
                            "relationshipToViewer": "Daughter",
                            "isRegisteredUser": true,
                            "children": [],
                            "spouses": []
                        },
                        {
                            "id": "3b1c3320-a4a3-4258-a7c7-8902069141b9",
                            "title": null,
                            "fullName": "Karan Sharma",
                            "gender": "Male",
                            "dob": "2002-04-25T00:00:00.000Z",
                            "isDeceased": false,
                            "isMinor": false,
                            "photoUrl": null,
                            "qrImageUrl": null,
                            "linkedMobile": "919800000008",
                            "directRelationship": "Son",
                            "relationshipToViewer": "Son",
                            "isRegisteredUser": true,
                            "children": [],
                            "spouses": []
                        }
                    ],
                    "spouses": [
                        {
                            "id": "d1e58153-b4ae-4d5d-ad79-e51b4b44bcea",
                            "title": "Smt",
                            "fullName": "Sunita Sharma",
                            "gender": "Female",
                            "dob": "1976-02-18T00:00:00.000Z",
                            "isDeceased": false,
                            "isMinor": false,
                            "photoUrl": null,
                            "qrImageUrl": null,
                            "linkedMobile": "919800000004",
                            "directRelationship": "Wife",
                            "relationshipToViewer": "Wife",
                            "isRegisteredUser": true,
                            "children": [],
                            "spouses": [],
                            "parents": [],
                            "siblings": []
                        }
                    ],
                    "parents": []
                }
            ],
            "spouses": [
                {
                    "id": "a385358f-c358-4ac0-88b2-cec8ad027b22",
                    "title": "Smt",
                    "fullName": "Kamla Sharma",
                    "gender": "Female",
                    "dob": "1954-07-22T00:00:00.000Z",
                    "isDeceased": false,
                    "isMinor": false,
                    "photoUrl": null,
                    "qrImageUrl": null,
                    "linkedMobile": "919800000002",
                    "directRelationship": "Wife",
                    "relationshipToViewer": "Wife",
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
            "id": "a385358f-c358-4ac0-88b2-cec8ad027b22",
            "title": "Smt",
            "fullName": "Kamla Sharma",
            "gender": "Female",
            "dob": "1954-07-22T00:00:00.000Z",
            "isDeceased": false,
            "isMinor": false,
            "photoUrl": null,
            "qrImageUrl": null,
            "linkedMobile": "919800000002",
            "directRelationship": "Mother",
            "relationshipToViewer": "Mother",
            "isRegisteredUser": true,
            "children": [],
            "spouses": [],
            "parents": [],
            "siblings": []
        }
    ],
    "spouses": [],
    "siblings": [
        {
            "id": "4903c93a-195b-4e63-b969-986784f26bf2",
            "title": "Shri",
            "fullName": "Dinesh Sharma",
            "gender": "Male",
            "dob": "1974-11-05T00:00:00.000Z",
            "isDeceased": false,
            "isMinor": false,
            "photoUrl": null,
            "qrImageUrl": null,
            "linkedMobile": "919800000003",
            "directRelationship": "Brother",
            "relationshipToViewer": "Brother",
            "isRegisteredUser": true,
            "children": [],
            "spouses": []
        }
    ],
    "children": []
}
''';

  testWidgets(
    'FamilyTreeCanvas displays entire extended Sharma family across 4 generations (parents, brother, bhabhi, nephews, niece, grandnephew)',
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
                focusUserId: '2e9819be-d5f9-4e20-b507-b4f19c31dc9a',
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // 1. Tier +1: Parents
      expect(find.text('Raghunath Sharma'), findsOneWidget);
      expect(find.text('Kamla Sharma'), findsOneWidget);
      expect(find.text('Father'), findsOneWidget);
      expect(find.text('Mother'), findsOneWidget);

      // 2. Tier 0: Focus User & Sibling couple
      expect(find.text('Suresh Sharma'), findsOneWidget);
      expect(find.text('Dinesh Sharma'), findsOneWidget);
      expect(find.text('Sunita Sharma'), findsOneWidget);
      expect(find.text('Brother'), findsOneWidget);
      expect(find.text('Sister-in-law (Bhabhi)'), findsOneWidget);

      // 3. Tier -1: Nephews & Niece
      expect(find.text('Rohit Sharma'), findsOneWidget);
      expect(find.text('Priya Sharma'), findsOneWidget);
      expect(find.text('Karan Sharma'), findsOneWidget);
      expect(find.text('Nephew (Bhatija)'), findsNWidgets(2)); // Rohit and Karan
      expect(find.text('Niece (Bhatiji)'), findsOneWidget); // Priya

      // 4. Tier -2: Grandnephew
      expect(find.text('Arjun Sharma'), findsOneWidget);
      expect(find.text('Grandnephew'), findsOneWidget);
    },
  );
}
