import 'package:flutter_test/flutter_test.dart';
import 'package:community_connect/src/utils/api_endpoints.dart';

void main() {
  group('Legal & Web Policy Endpoints', () {
    test('ApiEndpoints defines valid Terms of Service URL', () {
      expect(
        ApiEndpoints.termsOfServiceUrl,
        'https://communityapp-admin.techstaunch.in/terms-of-service',
      );
      final uri = Uri.parse(ApiEndpoints.termsOfServiceUrl);
      expect(uri.isAbsolute, isTrue);
      expect(uri.scheme, 'https');
      expect(uri.host, 'communityapp-admin.techstaunch.in');
      expect(uri.path, '/terms-of-service');
    });

    test('ApiEndpoints defines valid Privacy Policy URL', () {
      expect(
        ApiEndpoints.privacyPolicyUrl,
        'https://communityapp-admin.techstaunch.in/privacy-policy',
      );
      final uri = Uri.parse(ApiEndpoints.privacyPolicyUrl);
      expect(uri.isAbsolute, isTrue);
      expect(uri.scheme, 'https');
      expect(uri.host, 'communityapp-admin.techstaunch.in');
      expect(uri.path, '/privacy-policy');
    });
  });
}
