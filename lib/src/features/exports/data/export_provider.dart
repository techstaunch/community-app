import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../profile/data/profile_provider.dart';
import 'export_repository.dart';

part 'export_provider.g.dart';

@Riverpod(keepAlive: true)
class ExportController extends _$ExportController {
  final Map<String, String> _pdfCache = {};
  final Map<String, String> _qrCache = {};

  @override
  FutureOr<void> build() {}

  /// Returns a cached PDF URL if available either in the in-memory cache
  /// or already loaded in the profile model from the API.
  String? getCachedPdfUrl(String targetUserId) {
    if (_pdfCache.containsKey(targetUserId) && _pdfCache[targetUserId]!.isNotEmpty) {
      return _pdfCache[targetUserId];
    }

    final ownProfile = ref.read(profileControllerProvider).value;
    if (ownProfile != null && (ownProfile.id == targetUserId || targetUserId.isEmpty || targetUserId == 'self')) {
      if (ownProfile.pdfUrl != null && ownProfile.pdfUrl!.isNotEmpty) {
        _pdfCache[targetUserId] = ownProfile.pdfUrl!;
        return ownProfile.pdfUrl!;
      }
      if (ownProfile.profile?.biodataUrl != null && ownProfile.profile!.biodataUrl!.isNotEmpty) {
        _pdfCache[targetUserId] = ownProfile.profile!.biodataUrl!;
        return ownProfile.profile!.biodataUrl!;
      }
    }

    if (targetUserId != 'self' && targetUserId.isNotEmpty && (ownProfile == null || ownProfile.id != targetUserId)) {
      final memberProfile = ref.read(memberProfileProvider(targetUserId)).value;
      if (memberProfile?.pdfUrl != null && memberProfile!.pdfUrl!.isNotEmpty) {
        _pdfCache[targetUserId] = memberProfile.pdfUrl!;
        return memberProfile.pdfUrl!;
      }
      if (memberProfile?.profile?.biodataUrl != null && memberProfile!.profile!.biodataUrl!.isNotEmpty) {
        _pdfCache[targetUserId] = memberProfile.profile!.biodataUrl!;
        return memberProfile.profile!.biodataUrl!;
      }
    }

    return null;
  }

  /// Returns a cached QR URL/code if available in cache or in the profile model from the API.
  String? getCachedQrCode([String? targetUserId]) {
    final cacheKey = targetUserId ?? 'self';
    if (_qrCache.containsKey(cacheKey) && _qrCache[cacheKey]!.isNotEmpty) {
      return _qrCache[cacheKey];
    }

    final ownProfile = ref.read(profileControllerProvider).value;
    if (targetUserId == null || targetUserId == 'self' || (ownProfile != null && ownProfile.id == targetUserId)) {
      final qr = ownProfile?.qrCode?.qrImageUrl ?? ownProfile?.qrCode?.code;
      if (qr != null && qr.isNotEmpty) {
        _qrCache[cacheKey] = qr;
        return qr;
      }
    }

    if (targetUserId != null && targetUserId.isNotEmpty && targetUserId != 'self' && (ownProfile == null || ownProfile.id != targetUserId)) {
      final memberProfile = ref.read(memberProfileProvider(targetUserId)).value;
      final qr = memberProfile?.qrCode?.qrImageUrl ?? memberProfile?.qrCode?.code;
      if (qr != null && qr.isNotEmpty) {
        _qrCache[cacheKey] = qr;
        return qr;
      }
    }

    return null;
  }

  /// Sets or updates the cached PDF URL for a target user.
  void setCachedPdfUrl(String targetUserId, String url) {
    if (url.isNotEmpty) {
      _pdfCache[targetUserId] = url;
    }
  }

  /// Sets or updates the cached QR code URL/data for a target user.
  void setCachedQrCode(String? targetUserId, String qr) {
    if (qr.isNotEmpty) {
      _qrCache[targetUserId ?? 'self'] = qr;
    }
  }

  /// Exports or retrieves the PDF biodata URL.
  /// Reuses cached link from API if available to avoid generating a new one every time.
  Future<String?> exportPdfBiodata(String targetUserId, {bool forceRefresh = false}) async {
    if (!forceRefresh) {
      final cached = getCachedPdfUrl(targetUserId);
      if (cached != null && cached.isNotEmpty) {
        return cached;
      }
    }

    state = const AsyncLoading();
    try {
      final repo = ref.read(exportRepositoryProvider);
      final pdfUrl = await repo.exportPdfBiodata(targetUserId);
      if (pdfUrl.isNotEmpty) {
        _pdfCache[targetUserId] = pdfUrl;
      }
      state = const AsyncData(null);
      return pdfUrl;
    } catch (e, stack) {
      state = AsyncError(e, stack);
      return null;
    }
  }

  /// Generates or retrieves the QR code.
  /// Reuses cached link/code from API if available to avoid generating a new one every time.
  Future<String?> generateProfileQrCode([String? targetUserId, bool forceRefresh = false]) async {
    final cacheKey = targetUserId ?? 'self';
    if (!forceRefresh) {
      final cached = getCachedQrCode(targetUserId);
      if (cached != null && cached.isNotEmpty) {
        return cached;
      }
    }

    state = const AsyncLoading();
    try {
      final repo = ref.read(exportRepositoryProvider);
      final qrCode = await repo.generateProfileQrCode(targetUserId);
      if (qrCode.isNotEmpty) {
        _qrCache[cacheKey] = qrCode;
      }
      state = const AsyncData(null);
      return qrCode;
    } catch (e, stack) {
      state = AsyncError(e, stack);
      return null;
    }
  }
}
