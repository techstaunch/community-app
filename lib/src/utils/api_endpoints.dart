class ApiEndpoints {
  // Base URLs
  // TODO: Switch to production URL before release
  static const String baseUrl =
      'https://api-communityapp.techstaunch.in/api/v1'; // Using production as default so it works on devices without local setup

  // Web & Policy URLs
  static const String termsOfServiceUrl =
      'https://communityapp-admin.techstaunch.in/terms-of-service';
  static const String privacyPolicyUrl =
      'https://communityapp-admin.techstaunch.in/privacy-policy';

  // Auth Endpoints
  static const String authLogin = '/auth/login';
  static const String authVerifyOtp = '/auth/verify-otp';
  static const String authRefresh = '/auth/refresh';
  static const String authLogout = '/auth/logout';
  static const String authDeleteAccount = '/auth/account';

  // Profiles Endpoints
  static const String profiles = '/profiles';
  static String profilePublic(String id) => '/profiles/public/$id';
  static const String profileStates = '/profiles/states';
  static const String profileCities = '/profiles/cities';
  static const String profileBusinessCategories = '/profiles/business-categories';
  static const String profilePhoto = '/profiles/photo';
  static const String profileJob = '/profiles/job';
  static const String profileBusiness = '/profiles/business';
  static const String profilePrivacy = '/profiles/privacy';
  static const String profileDeleteAccount = '/profiles/account';
  static String profileBlock(String id) => '/profiles/block/$id';
  static String profileUnblock(String id) => '/profiles/unblock/$id';
  static const String profileBlockedList = '/profiles/blocked';
  static String profileBlockStatus(String id) => '/profiles/block-status/$id';

  // Search Endpoints
  static const String search = '/search';
  static const String searchFindMatch = '/search/find-match';
  static const String searchMembers = '/search';
  static String searchMember(String id) => '/search/$id';
  static const String searchLinkMembers = '/search/link-members';
  static String searchLinkMember(String id) => '/search/link-members/$id';

  // Family Endpoints
  static const String familyHierarchy = '/family/hierarchy';
  static const String familyMember = '/family';
  static String familyMemberId(String id) => '/family/$id';

  // Communities Endpoints
  static const String communities = '/communities';
  static const String communitiesJoin = '/communities/join';
  static const String communitiesMyMemberships = '/communities/my-memberships';
  static const String communitiesDefaultNode = '/communities/default-node';
  static String community(String id) => '/communities/$id';

  // Exports Endpoints
  static const String exportsPdf = '/exports/pdf';
  static const String exportsQr = '/exports/qr';

  // Notifications Endpoints
  static const String notifications = '/notifications';
  static String notificationRead(String id) => '/notifications/$id/read';

  // Storage Keys
  static const String accessTokenKey = 'accessToken';
  static const String refreshTokenKey = 'refreshToken';
}
