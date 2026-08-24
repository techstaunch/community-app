import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'export_repository.dart';

part 'export_provider.g.dart';

@riverpod
class ExportController extends _$ExportController {
  @override
  FutureOr<void> build() {}

  Future<String?> exportPdfBiodata(String targetUserId) async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(exportRepositoryProvider);
      final pdfUrl = await repo.exportPdfBiodata(targetUserId);
      state = const AsyncData(null);
      return pdfUrl;
    } catch (e, stack) {
      state = AsyncError(e, stack);
      return null;
    }
  }

  Future<String?> generateProfileQrCode() async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(exportRepositoryProvider);
      final qrCode = await repo.generateProfileQrCode();
      state = const AsyncData(null);
      return qrCode;
    } catch (e, stack) {
      state = AsyncError(e, stack);
      return null;
    }
  }
}
