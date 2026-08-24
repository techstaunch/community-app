import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../utils/api_endpoints.dart';
import '../../../core/network/api_client.dart';

part 'export_repository.g.dart';

@riverpod
ExportRepository exportRepository(Ref ref) {
  return ExportRepository(ref.watch(apiClientProvider));
}

class ExportRepository {
  final Dio _dio;

  ExportRepository(this._dio);

  Future<String> exportPdfBiodata(String targetUserId) async {
    final response = await _dio.post(
      ApiEndpoints.exportsPdf,
      data: {'targetUserId': targetUserId},
    );
    return response.data['data']['pdfUrl'];
  }

  Future<String> generateProfileQrCode() async {
    final response = await _dio.post(ApiEndpoints.exportsQr);
    return response.data['data']['qrCode'];
  }
}
