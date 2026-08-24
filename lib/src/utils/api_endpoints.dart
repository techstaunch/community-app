class ApiEndpoints {
  // Base URLs
  // TODO: Switch to production URL before release
  static const String baseUrl =
      'http://168.144.216.118/api/v1'; // Using production as default so it works on devices without local setup

  // Auth Endpoints
  static const String authLogin = '/auth/login';
  static const String authVerifyOtp = '/auth/verify-otp';
  static const String authRefresh = '/auth/refresh';
  static const String authLogout = '/auth/logout';

  // Profile Endpoints
  static const String profiles = '/profiles';
  static const String profilePhoto = '/profiles/photo';
  static const String profileJob = '/profiles/job';
  static const String profileBusiness = '/profiles/business';
  static const String profilePrivacy = '/profiles/privacy';

  // Search Endpoints
  static const String search = '/search';

  // Family Endpoints
  static const String family = '/family/hierarchy?depth=3';

  // Communities Endpoints
  static const String communities = '/communities';
  static const String communitiesJoin = '/communities/join';
  static const String communitiesMyMemberships = '/communities/my-memberships';

  // Exports Endpoints
  static const String exportsPdf = '/exports/pdf';
  static const String exportsQr = '/exports/qr';

  // Notifications Endpoints
  static const String notifications = '/notifications';

  // Storage Keys
  static const String accessTokenKey = 'accessToken';
  static const String refreshTokenKey = 'refreshToken';
}
