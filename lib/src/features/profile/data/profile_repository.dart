import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../utils/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'profile_models.dart';

part 'profile_repository.g.dart';

@riverpod
ProfileRepository profileRepository(Ref ref) {
  return ProfileRepository(ref.watch(apiClientProvider));
}

class ProfileRepository {
  final Dio _dio;

  ProfileRepository(this._dio);

  Future<List<String>> getStates({String? search}) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.profileStates,
        queryParameters: {
          if (search != null && search.isNotEmpty) 'search': search,
        },
      );
      final data = response.data['data'];
      if (data is Map<String, dynamic>) {
        if (data['stateNames'] is List) {
          return (data['stateNames'] as List).map((e) => e.toString()).toList();
        }
        if (data['states'] is List) {
          return (data['states'] as List).map((e) => e is Map ? e['name'].toString() : e.toString()).toList();
        }
      } else if (data is List) {
        return data.map((e) => e is Map ? e['name'].toString() : e.toString()).toList();
      }
    } catch (_) {}
    return const [
      'Andaman and Nicobar Islands',
      'Andhra Pradesh',
      'Arunachal Pradesh',
      'Assam',
      'Bihar',
      'Chandigarh',
      'Chhattisgarh',
      'Dadra and Nagar Haveli and Daman and Diu',
      'Delhi',
      'Goa',
      'Gujarat',
      'Haryana',
      'Himachal Pradesh',
      'Jammu and Kashmir',
      'Jharkhand',
      'Karnataka',
      'Kerala',
      'Ladakh',
      'Lakshadweep',
      'Madhya Pradesh',
      'Maharashtra',
      'Manipur',
      'Meghalaya',
      'Mizoram',
      'Nagaland',
      'Odisha',
      'Puducherry',
      'Punjab',
      'Rajasthan',
      'Sikkim',
      'Tamil Nadu',
      'Telangana',
      'Tripura',
      'Uttar Pradesh',
      'Uttarakhand',
      'West Bengal',
    ];
  }

  Future<List<String>> getCities(String state, {String? search}) async {
    final trimmedState = state.trim();
    if (trimmedState.isEmpty) {
      return const [];
    }
    try {
      final response = await _dio.get(
        ApiEndpoints.profileCities,
        queryParameters: {
          'state': trimmedState,
          if (search != null && search.trim().isNotEmpty) 'search': search.trim(),
        },
      );
      final data = response.data['data'];
      if (data is Map<String, dynamic>) {
        if (data['cityNames'] is List) {
          final list = (data['cityNames'] as List).map((e) => e.toString()).toList();
          if (list.isNotEmpty) return list;
        }
        if (data['cities'] is List) {
          final list = (data['cities'] as List).map((e) => e is Map ? e['name'].toString() : e.toString()).toList();
          if (list.isNotEmpty) return list;
        }
      } else if (data is List) {
        final list = data.map((e) => e is Map ? e['name'].toString() : e.toString()).toList();
        if (list.isNotEmpty) return list;
      }
    } catch (_) {}
    return fallbackCities(trimmedState);
  }

  static List<String> fallbackCities(String state) {
    final lower = state.toLowerCase().trim();
    if (lower.isEmpty) {
      return const [];
    }
    if (lower.contains('gujarat') || lower == 'gj') {
      return const [
        'Ahmedabad', 'Surat', 'Vadodara', 'Rajkot', 'Bhavnagar', 'Jamnagar',
        'Gandhinagar', 'Junagadh', 'Anand', 'Navsari', 'Morbi', 'Nadiad',
        'Surendranagar', 'Bharuch', 'Mehsana', 'Bhuj', 'Porbandar', 'Palanpur',
        'Valsad', 'Vapi', 'Gondal', 'Veraval', 'Godhra', 'Patan', 'Dahod',
        'Botad', 'Amreli', 'Deesa', 'Jetpur',
      ];
    } else if (lower.contains('maharashtra') || lower == 'mh') {
      return const [
        'Mumbai', 'Pune', 'Nagpur', 'Thane', 'Nashik', 'Kalyan-Dombivli',
        'Vasai-Virar', 'Aurangabad', 'Navi Mumbai', 'Solapur', 'Mira-Bhayandar',
        'Bhiwandi', 'Amravati', 'Nanded', 'Kolhapur', 'Ulhasnagar', 'Sangli',
        'Malegaon', 'Jalgaon', 'Akola', 'Latur', 'Dhule', 'Ahmednagar',
        'Chandrapur', 'Parbhani', 'Ichalkaranji', 'Jalna', 'Panvel', 'Satara',
      ];
    } else if (lower.contains('rajasthan') || lower == 'rj') {
      return const [
        'Jaipur', 'Jodhpur', 'Kota', 'Bikaner', 'Ajmer', 'Udaipur',
        'Bhilwara', 'Alwar', 'Bharatpur', 'Sikar', 'Pali', 'Sri Ganganagar',
        'Chittorgarh', 'Beawar', 'Tonk', 'Kishangarh', 'Hanumangarh',
      ];
    } else if (lower.contains('delhi') || lower == 'dl') {
      return const [
        'New Delhi', 'North Delhi', 'South Delhi', 'East Delhi', 'West Delhi',
        'Central Delhi', 'North East Delhi', 'North West Delhi', 'South East Delhi',
        'South West Delhi', 'Shahdara',
      ];
    } else if (lower.contains('madhya pradesh') || lower == 'mp') {
      return const [
        'Indore', 'Bhopal', 'Jabalpur', 'Gwalior', 'Ujjain', 'Sagar',
        'Dewas', 'Satna', 'Ratlam', 'Rewa', 'Murwara', 'Singrauli',
        'Burhanpur', 'Khandwa', 'Morena', 'Bhind', 'Chhindwara', 'Guna',
      ];
    } else if (lower.contains('uttar pradesh') || lower == 'up') {
      return const [
        'Lucknow', 'Kanpur', 'Ghaziabad', 'Agra', 'Meerut', 'Varanasi',
        'Prayagraj (Allahabad)', 'Bareilly', 'Aligarh', 'Moradabad',
        'Saharanpur', 'Gorakhpur', 'Noida', 'Firozabad', 'Jhansi', 'Muzaffarnagar',
      ];
    }
    return const [];
  }

  Future<List<String>> getBusinessCategories() async {
    try {
      final response = await _dio.get(ApiEndpoints.profileBusinessCategories);
      final data = response.data['data'];
      if (data is Map<String, dynamic>) {
        if (data['categoryNames'] is List) {
          return (data['categoryNames'] as List).map((e) => e.toString()).toList();
        }
        if (data['categories'] is List) {
          return (data['categories'] as List).map((e) => e is Map ? e['name'].toString() : e.toString()).toList();
        }
      } else if (data is List) {
        return data.map((e) => e is Map ? e['name'].toString() : e.toString()).toList();
      }
    } catch (_) {}
    return const [
      'Agriculture & Farming',
      'Automobile & Auto Components',
      'Banking, Financial Services & Insurance (BFSI)',
      'Building, Construction & Real Estate',
      'Chemicals, Petrochemicals & Plastics',
      'Textiles, Apparel & Fashion',
      'Education, Training & Coaching',
      'Electricals, Electronics & Energy',
      'Food, Beverages & Restaurants (FMCG)',
      'Gems, Diamonds & Jewellery',
      'Healthcare, Hospitals & Pharmaceuticals',
      'Hospitality, Travel & Tourism',
      'Information Technology (IT) & Software',
      'Logistics, Transport & Warehousing',
      'Manufacturing & Heavy Engineering',
      'Media, Advertising & Events',
      'Personal Care, Beauty & Fitness',
      'Professional, Legal & Business Services',
      'Retail & Wholesale Trading',
      'Handicrafts, Art & Culture',
      'Other / Specialized Services',
    ];
  }

  Future<UserProfile> getOwnProfile() async {
    final response = await _dio.get(ApiEndpoints.profiles);
    return UserProfile.fromJson(response.data['data']);
  }

  Future<UserProfile> getMemberProfile(String id) async {
    final response = await _dio.get(ApiEndpoints.profilePublic(id));
    return UserProfile.fromJson(response.data['data']);
  }

  Future<void> deleteAccount() async {
    await _dio.delete(ApiEndpoints.profileDeleteAccount);
  }

  Future<UserProfile> updateCoreProfile(Map<String, dynamic> data) async {
    final response = await _dio.post(ApiEndpoints.profiles, data: data);
    return UserProfile.fromJson(response.data['data']);
  }

  Future<UserProfile> updateJobDetails(Map<String, dynamic> data) async {
    final response = await _dio.post(ApiEndpoints.profileJob, data: data);
    return UserProfile.fromJson(response.data['data']);
  }

  Future<UserProfile> updateBusinessDetails(Map<String, dynamic> data) async {
    final response = await _dio.post(ApiEndpoints.profileBusiness, data: data);
    return UserProfile.fromJson(response.data['data']);
  }

  Future<void> updatePrivacySettings(Map<String, dynamic> data) async {
    await _dio.post(ApiEndpoints.profilePrivacy, data: data);
  }

  Future<void> deleteJobDetails() async {
    await _dio.delete(ApiEndpoints.profileJob);
  }

  Future<void> deleteBusinessDetails() async {
    await _dio.delete(ApiEndpoints.profileBusiness);
  }

  Future<void> blockUser(String userId, {String? reason}) async {
    await _dio.post(ApiEndpoints.profileBlock(userId), data: {
      if (reason != null && reason.isNotEmpty) 'reason': reason,
    });
  }

  Future<void> unblockUser(String userId) async {
    await _dio.delete(ApiEndpoints.profileUnblock(userId));
  }

  Future<bool> checkBlockStatus(String userId) async {
    try {
      final response = await _dio.get(ApiEndpoints.profileBlockStatus(userId));
      final resData = response.data;
      dynamic data = resData;
      if (resData is Map) {
        data = resData['data'] ?? resData;
      }
      if (data is bool) return data;
      if (data is Map) {
        return data['isBlocked'] == true ||
            data['blocked'] == true ||
            data['isUserBlocked'] == true ||
            data['status'] == 'blocked';
      }
      return false;
    } catch (e) {
      if (e is DioException && e.response?.data != null) {
        final d = e.response!.data;
        if (d is Map) {
          if (d['data'] is Map &&
              (d['data']['isBlocked'] == true || d['data']['blocked'] == true)) {
            return true;
          }
          final msg = (d['message'] ?? d['error'] ?? '').toString().toLowerCase();
          if (msg.contains('block')) return true;
        }
      }
      return false;
    }
  }

  UserProfile _parseBlockedUser(dynamic item) {
    if (item is! Map) return const UserProfile();
    final map = Map<String, dynamic>.from(item);

    // If it's wrapped in blockedUser, user, or targetUser:
    Map<String, dynamic>? userMap;
    if (map['blockedUser'] is Map) {
      userMap = Map<String, dynamic>.from(map['blockedUser'] as Map);
    } else if (map['user'] is Map) {
      userMap = Map<String, dynamic>.from(map['user'] as Map);
    } else if (map['targetUser'] is Map) {
      userMap = Map<String, dynamic>.from(map['targetUser'] as Map);
    }

    if (userMap != null) {
      final effectiveId = userMap['id'] ??
          userMap['_id'] ??
          userMap['userId'] ??
          map['blockedUserId'] ??
          map['userId'] ??
          map['id'];
      if (effectiveId != null && userMap['id'] == null) {
        userMap['id'] = effectiveId.toString();
      }
      return UserProfile.fromJson(userMap);
    }

    final effectiveId = map['id'] ?? map['_id'] ?? map['userId'] ?? map['blockedUserId'];
    if (effectiveId != null && map['id'] == null) {
      map['id'] = effectiveId.toString();
    }
    return UserProfile.fromJson(map);
  }

  Future<List<UserProfile>> getBlockedUsers({int page = 1, int limit = 10}) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.profileBlockedList,
        queryParameters: {
          'page': page,
          'limit': limit,
        },
      );
      final resData = response.data;
      dynamic listData = resData;
      if (resData is Map) {
        final d = resData['data'];
        if (d is List) {
          listData = d;
        } else if (d is Map) {
          listData = d['items'] ??
              d['data'] ??
              d['users'] ??
              d['blockedUsers'] ??
              d['results'] ??
              [];
        } else {
          listData = resData['items'] ??
              resData['users'] ??
              resData['blockedUsers'] ??
              resData['results'] ??
              [];
        }
      }
      if (listData is List) {
        return listData.map((e) => _parseBlockedUser(e)).toList();
      }
      return [];
    } catch (_) {
      return [];
    }
  }

  Future<void> uploadProfilePhoto(String filePath, {String? userId}) async {
    final formData = FormData.fromMap({
      'photo': await MultipartFile.fromFile(filePath),
    });
    
    // Explicitly grab token to bypass any interceptor issues with FormData
    final storage = const FlutterSecureStorage();
    final token = await storage.read(key: ApiEndpoints.accessTokenKey);
    
    final endpoint = userId != null ? '${ApiEndpoints.profilePhoto}/$userId' : ApiEndpoints.profilePhoto;
    
    await _dio.post(
      endpoint, 
      data: formData,
      options: Options(
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
        }
      )
    );
  }

  Future<void> deleteProfilePhoto() async {
    await _dio.delete(ApiEndpoints.profilePhoto);
  }
}
