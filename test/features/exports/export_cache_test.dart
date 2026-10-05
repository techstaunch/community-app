import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:community_connect/src/features/exports/data/export_provider.dart';
import 'package:community_connect/src/features/exports/data/export_repository.dart';
import 'package:community_connect/src/features/profile/data/profile_models.dart';
import 'package:community_connect/src/features/profile/data/profile_provider.dart';
import 'package:community_connect/src/features/profile/presentation/my_qr_code_screen.dart';

class FakeProfileController extends ProfileController {
  final UserProfile? initialProfile;
  FakeProfileController([this.initialProfile]);

  @override
  FutureOr<UserProfile?> build() {
    return initialProfile ?? const UserProfile(id: 'self-user');
  }
}

class FakeExportRepository implements ExportRepository {
  int exportPdfCallCount = 0;
  int generateQrCallCount = 0;

  @override
  Future<String> exportPdfBiodata(String targetUserId) async {
    exportPdfCallCount++;
    return 'https://api.example.com/generated_$targetUserId.pdf';
  }

  @override
  Future<String> generateProfileQrCode([
    String? targetUserId,
    bool forceRefresh = false,
  ]) async {
    generateQrCallCount++;
    return 'https://api.example.com/generated_${targetUserId ?? "self"}.png';
  }
}

void main() {
  group('ExportController caching tests', () {
    late FakeExportRepository fakeRepo;

    setUp(() {
      fakeRepo = FakeExportRepository();
    });

    test(
      're-uses PDF URL already present in memberProfileProvider without API call',
      () async {
        final container = ProviderContainer(
          overrides: [
            exportRepositoryProvider.overrideWithValue(fakeRepo),
            profileControllerProvider.overrideWith(FakeProfileController.new),
            memberProfileProvider('member-1').overrideWith(
              (ref) async => const UserProfile(
                id: 'member-1',
                pdfUrl: 'https://cdn.example.com/existing_biodata.pdf',
              ),
            ),
          ],
        );
        addTearDown(container.dispose);

        // Trigger profile load
        await container.read(memberProfileProvider('member-1').future);

        final controller = container.read(exportControllerProvider.notifier);
        final pdfUrl = await controller.exportPdfBiodata('member-1');

        expect(pdfUrl, 'https://cdn.example.com/existing_biodata.pdf');
        expect(
          fakeRepo.exportPdfCallCount,
          0,
          reason: 'Must not call repository when URL is cached',
        );
      },
    );

    test(
      're-uses QR code already present in memberProfileProvider without API call',
      () async {
        final container = ProviderContainer(
          overrides: [
            exportRepositoryProvider.overrideWithValue(fakeRepo),
            profileControllerProvider.overrideWith(FakeProfileController.new),
            memberProfileProvider('member-1').overrideWith(
              (ref) async => const UserProfile(
                id: 'member-1',
                qrCode: QrCodeDetails(
                  qrImageUrl: 'https://cdn.example.com/existing_qr.png',
                ),
              ),
            ),
          ],
        );
        addTearDown(container.dispose);

        // Trigger profile load
        await container.read(memberProfileProvider('member-1').future);

        final controller = container.read(exportControllerProvider.notifier);
        final qrUrl = await controller.generateProfileQrCode('member-1');

        expect(qrUrl, 'https://cdn.example.com/existing_qr.png');
        expect(
          fakeRepo.generateQrCallCount,
          0,
          reason: 'Must not call repository when QR is cached',
        );
      },
    );

    test('re-uses self profile QR and PDF without API call', () async {
      final container = ProviderContainer(
        overrides: [
          exportRepositoryProvider.overrideWithValue(fakeRepo),
          profileControllerProvider.overrideWith(
            () => FakeProfileController(
              const UserProfile(
                id: 'self-1',
                pdfUrl: 'https://cdn.example.com/self_biodata.pdf',
                qrCode: QrCodeDetails(
                  qrImageUrl: 'https://cdn.example.com/self_qr.png',
                ),
              ),
            ),
          ),
        ],
      );
      addTearDown(container.dispose);

      await container.read(profileControllerProvider.future);
      final controller = container.read(exportControllerProvider.notifier);

      final pdfUrl = await controller.exportPdfBiodata('self-1');
      expect(pdfUrl, 'https://cdn.example.com/self_biodata.pdf');
      expect(fakeRepo.exportPdfCallCount, 0);

      final qrUrl = await controller.generateProfileQrCode();
      expect(qrUrl, 'https://cdn.example.com/self_qr.png');
      expect(fakeRepo.generateQrCallCount, 0);
    });

    test(
      'caches newly generated PDF URL and does not re-fetch on subsequent calls',
      () async {
        final container = ProviderContainer(
          overrides: [
            exportRepositoryProvider.overrideWithValue(fakeRepo),
            profileControllerProvider.overrideWith(FakeProfileController.new),
            memberProfileProvider(
              'member-2',
            ).overrideWith((ref) async => const UserProfile(id: 'member-2')),
          ],
        );
        addTearDown(container.dispose);

        await container.read(memberProfileProvider('member-2').future);
        final controller = container.read(exportControllerProvider.notifier);

        // First call: generates via API
        final firstUrl = await controller.exportPdfBiodata('member-2');
        expect(firstUrl, 'https://api.example.com/generated_member-2.pdf');
        expect(fakeRepo.exportPdfCallCount, 1);

        // Second call: re-uses cached URL
        final secondUrl = await controller.exportPdfBiodata('member-2');
        expect(secondUrl, 'https://api.example.com/generated_member-2.pdf');
        expect(
          fakeRepo.exportPdfCallCount,
          1,
          reason: 'Must not call repository on second call',
        );
      },
    );

    test('force refresh always requests a new PDF from the API', () async {
      final container = ProviderContainer(
        overrides: [
          exportRepositoryProvider.overrideWithValue(fakeRepo),
          profileControllerProvider.overrideWith(FakeProfileController.new),
          memberProfileProvider('member-3').overrideWith(
            (ref) async => const UserProfile(
              id: 'member-3',
              pdfUrl: 'https://cdn.example.com/old_biodata.pdf',
            ),
          ),
        ],
      );
      addTearDown(container.dispose);

      await container.read(memberProfileProvider('member-3').future);
      final controller = container.read(exportControllerProvider.notifier);

      final pdfUrl = await controller.exportPdfBiodata(
        'member-3',
        forceRefresh: true,
      );

      expect(pdfUrl, 'https://api.example.com/generated_member-3.pdf');
      expect(fakeRepo.exportPdfCallCount, 1);
    });

    test(
      'caches newly generated QR code and does not re-fetch on subsequent calls',
      () async {
        final container = ProviderContainer(
          overrides: [
            exportRepositoryProvider.overrideWithValue(fakeRepo),
            profileControllerProvider.overrideWith(FakeProfileController.new),
            memberProfileProvider(
              'member-2',
            ).overrideWith((ref) async => const UserProfile(id: 'member-2')),
          ],
        );
        addTearDown(container.dispose);

        await container.read(memberProfileProvider('member-2').future);
        final controller = container.read(exportControllerProvider.notifier);

        // First call: generates via API
        final firstQr = await controller.generateProfileQrCode('member-2');
        expect(firstQr, 'https://api.example.com/generated_member-2.png');
        expect(fakeRepo.generateQrCallCount, 1);

        // Second call: re-uses cached QR
        final secondQr = await controller.generateProfileQrCode('member-2');
        expect(secondQr, 'https://api.example.com/generated_member-2.png');
        expect(
          fakeRepo.generateQrCallCount,
          1,
          reason: 'Must not call repository on second call',
        );
      },
    );
  });

  group('MyQrCodeScreen widget tests', () {
    testWidgets(
      'renders instantly when qrImageUrl is provided without calling repo',
      (tester) async {
        final fakeRepo = FakeExportRepository();

        await tester.pumpWidget(
          ProviderScope(
            overrides: [exportRepositoryProvider.overrideWithValue(fakeRepo)],
            child: const MaterialApp(
              home: MyQrCodeScreen(
                userId: 'member-101',
                userName: 'Ananya Agarwal',
                qrImageUrl: 'https://cdn.example.com/instant_qr.png',
              ),
            ),
          ),
        );

        // Since initialData is available, no spinner should be shown
        expect(find.byType(CircularProgressIndicator), findsNothing);
        expect(
          fakeRepo.generateQrCallCount,
          0,
          reason: 'Must not call API when qrImageUrl is provided',
        );
      },
    );
  });
}
