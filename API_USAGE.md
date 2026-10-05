# Community Connect API Usage Document

This document summarizes the API calls used by the app, including which endpoints are called, what parameters are sent, what each API is used for, and how the response is parsed.

## 1. API Base Configuration

Central client and auth handling live in:
- [lib/src/core/network/api_client.dart](lib/src/core/network/api_client.dart)
- [lib/src/utils/api_endpoints.dart](lib/src/utils/api_endpoints.dart)

Base URL:
- `http://168.144.216.118/api/v1`

Common behavior:
- All requests use Dio.
- Authorization header is added automatically when an access token is available.
- If a request gets `401 Unauthorized`, the client tries to refresh the token using `/auth/refresh` and retries the original request.
- Most responses follow the pattern `response.data['data']`.

## 2. Endpoints Used in the App

### Authentication
- `POST /auth/login`
- `POST /auth/verify-otp`
- `POST /auth/refresh`
- `POST /auth/logout`
- `DELETE /auth/account`

### Profiles
- `GET /profiles`
- `GET /profiles/public/{id}`
- `GET /profiles/states`
- `GET /profiles/cities`
- `GET /profiles/business-categories`
- `POST /profiles`
- `POST /profiles/photo`
- `POST /profiles/job`
- `POST /profiles/business`
- `POST /profiles/privacy`
- `DELETE /profiles/job`
- `DELETE /profiles/business`
- `DELETE /profiles/photo`

### Search
- `GET /search`
- `GET /search/find-match`
- `GET /search/link-members`

### Family / Family Tree
- `GET /family`
- `GET /family/hierarchy`
- `POST /family`
- `PUT /family/{id}`
- `DELETE /family/{id}`

### Communities
- `POST /communities`
- `POST /communities/join`
- `GET /communities/my-memberships`
- `GET /communities/{communityId}/members`
- `POST /communities/{communityId}/approve`
- `POST /communities/{communityId}/reject`
- `GET /admin/{communityId}/announcements`
- `GET /admin/{communityId}/events`

### Notifications
- `GET /notifications`
- `POST /notifications/{id}/read` or `PATCH /notifications/{id}/read`

### Exports
- `POST /exports/pdf`
- `POST /exports/qr`

## 3. API Usage by Feature

### 3.1 Authentication
Source: [lib/src/features/authentication/data/auth_repository.dart](lib/src/features/authentication/data/auth_repository.dart)

#### `requestOtp(mobileNumber, purpose = 'Login')`
- Purpose: Request OTP for login.
- Request type: `POST`
- Endpoint: `/auth/login`
- Body:
  ```json
  {
    "mobileNumber": "<string>",
    "purpose": "Login"
  }
  ```
- Parsing: `AuthResponse.fromJson(response.data)`

#### `verifyOtp(mobileNumber, code, purpose = 'Login')`
- Purpose: Verify OTP and complete login.
- Request type: `POST`
- Endpoint: `/auth/verify-otp`
- Body:
  ```json
  {
    "mobileNumber": "<string>",
    "code": "<string>",
    "purpose": "Login"
  }
  ```
- Parsing: `AuthResponse.fromJson(response.data)`

#### `refreshToken(refreshToken)`
- Purpose: Refresh expired access token.
- Request type: `POST`
- Endpoint: `/auth/refresh`
- Body:
  ```json
  {
    "refreshToken": "<string>"
  }
  ```
- Parsing: `AuthResponse.fromJson(response.data)`

#### `logout(refreshToken)`
- Purpose: Log out the user and invalidate refresh token.
- Request type: `POST`
- Endpoint: `/auth/logout`
- Body:
  ```json
  {
    "refreshToken": "<string>"
  }
  ```
- Parsing: no model; result is ignored (`void`)

#### `deleteAccount()`
- Purpose: Delete the current user account.
- Request type: `DELETE`
- Endpoint: `/auth/account`
- Body: none
- Parsing: none

---

### 3.2 Profile APIs
Source: [lib/src/features/profile/data/profile_repository.dart](lib/src/features/profile/data/profile_repository.dart)

#### `getStates({search})`
- Purpose: Load applicable Indian states for dropdowns.
- Request type: `GET`
- Endpoint: `/profiles/states`
- Query params:
  - optional `search`
- Parsing:
  - Supports multiple backend response shapes:
    - `data.stateNames`
    - `data.states`
    - direct list
  - Returns `List<String>`
- Fallback: if the API fails, a static list of Indian states is used.

#### `getCities(state, {search})`
- Purpose: Load cities for a selected state.
- Request type: `GET`
- Endpoint: `/profiles/cities`
- Query params:
  - `state` (trimmed)
  - optional `search`
- Parsing:
  - Supports `data.cityNames`, `data.cities`, or direct list
  - Returns `List<String>`
- Fallback: if the API fails, state-specific city lists are used.

#### `getBusinessCategories()`
- Purpose: Load business category dropdown values.
- Request type: `GET`
- Endpoint: `/profiles/business-categories`
- Query params: none
- Parsing:
  - Supports `data.categoryNames`, `data.categories`, or direct list
  - Returns `List<String>`
- Fallback: static category list used if API fails.

#### `getOwnProfile()`
- Purpose: Get current logged-in user's profile.
- Request type: `GET`
- Endpoint: `/profiles`
- Parsing: `UserProfile.fromJson(response.data['data'])`

#### `getMemberProfile(String id)`
- Purpose: Get profile of another member.
- Request type: `GET`
- Endpoint: `/profiles/public/{id}`
- Parsing: `UserProfile.fromJson(response.data['data'])`

#### `updateCoreProfile(Map<String, dynamic> data)`
- Purpose: Save/update core profile fields.
- Request type: `POST`
- Endpoint: `/profiles`
- Body: raw map `data`
- Parsing: `UserProfile.fromJson(response.data['data'])`

#### `updateJobDetails(Map<String, dynamic> data)`
- Purpose: Update work/job details.
- Request type: `POST`
- Endpoint: `/profiles/job`
- Body: raw map `data`
- Parsing: `UserProfile.fromJson(response.data['data'])`

#### `updateBusinessDetails(Map<String, dynamic> data)`
- Purpose: Update business details.
- Request type: `POST`
- Endpoint: `/profiles/business`
- Body: raw map `data`
- Parsing: `UserProfile.fromJson(response.data['data'])`

#### `updatePrivacySettings(Map<String, dynamic> data)`
- Purpose: Change user privacy preferences.
- Request type: `POST`
- Endpoint: `/profiles/privacy`
- Body: raw map `data`
- Parsing: none

#### `uploadProfilePhoto(String filePath)`
- Purpose: Upload user profile photo.
- Request type: `POST`
- Endpoint: `/profiles/photo`
- Body: multipart form data with key `photo`
- Example payload:
  ```dart
  FormData.fromMap({
    'photo': await MultipartFile.fromFile(filePath),
  });
  ```
- Authorization: token is read manually from secure storage and attached to the request to avoid multipart interceptor issues.

#### `deleteProfilePhoto()`
- Purpose: Remove current profile photo.
- Request type: `DELETE`
- Endpoint: `/profiles/photo`
- Parsing: none

#### `deleteJobDetails()`
- Purpose: Remove job details.
- Request type: `DELETE`
- Endpoint: `/profiles/job`
- Parsing: none

#### `deleteBusinessDetails()`
- Purpose: Remove business details.
- Request type: `DELETE`
- Endpoint: `/profiles/business`
- Parsing: none

---

### 3.3 Search APIs
Source: [lib/src/features/search/data/search_repository.dart](lib/src/features/search/data/search_repository.dart)

#### `searchMembers(...)`
- Purpose: Search members with advanced filters.
- Request type: `GET`
- Endpoint: `/search`
- Query params:
  - `fullName` or derived from `query`
  - `limit`
  - `page`
  - optional: `state`, `city`, `gender`, `gotra`, `surname`, `businessCategory`, `occupation`
  - optional: `ageMin`, `ageMax`
- Parsing:
  - `SearchResponse.fromJson(response.data)`
  - Returns only approved results: `membershipStatus == 'approved'` or `isApproved == true`

#### `findMatchMembers(...)`
- Purpose: Find matching members based on profile criteria.
- Request type: `GET`
- Endpoint: `/search/find-match`
- Query params: similar to `searchMembers` but without `businessCategory`
- Parsing:
  - `SearchResponse.fromJson(response.data)`
  - Filters to approved entries only

#### `searchLinkableMembers(...)`
- Purpose: Search members that can be linked.
- Request type: `GET`
- Endpoint: `/search/link-members`
- Query params:
  - `fullName`/`query`
  - `mobileNumber`
  - `city`
  - `gender`
  - `gotra`
  - `surname`
  - `limit`
  - `page`
- Parsing: `SearchResponse.fromJson(response.data)` and returns raw `data` array

---

### 3.4 Family / Family Tree APIs
Source: [lib/src/features/family_tree/data/family_repository.dart](lib/src/features/family_tree/data/family_repository.dart)

#### `getFamilyMembers()`
- Purpose: Load family member list.
- Request type: `GET`
- Endpoint: `/family`
- Parsing: `(response.data['data'] as List).map((e) => FamilyMember.fromJson(e)).toList();`

#### `getFamilyHierarchy({focusUserId})`
- Purpose: Fetch family tree hierarchy.
- Request type: `GET`
- Endpoint: `/family/hierarchy`
- Query params:
  - `depth=5`
  - optional `focusUserId`
- Parsing: `FamilyTreeNode.fromJson(response.data['data']['tree'])`

#### `addFamilyMember(Map<String, dynamic> data)`
- Purpose: Add a new family member.
- Request type: `POST`
- Endpoint: `/family`
- Body: raw `data`
- Parsing: `FamilyMember.fromJson(response.data['data'])`

#### `updateFamilyMember(String id, Map<String, dynamic> data)`
- Purpose: Update a family member.
- Request type: `PUT`
- Endpoint: `/family/{id}`
- Body: raw `data`
- Parsing: none

#### `deleteFamilyMember(String id)`
- Purpose: Delete a family member.
- Request type: `DELETE`
- Endpoint: `/family/{id}`
- Parsing: none

---

### 3.5 Community APIs
Source: [lib/src/features/community/data/community_repository.dart](lib/src/features/community/data/community_repository.dart)

#### `createCommunity(Map<String, dynamic> data)`
- Purpose: Create a community.
- Request type: `POST`
- Endpoint: `/communities`
- Body: raw `data`
- Parsing: `Community.fromJson(response.data['data'])`

#### `joinCommunity(String inviteCode)`
- Purpose: Join a community using an invite code.
- Request type: `POST`
- Endpoint: `/communities/join`
- Body:
  ```json
  {
    "inviteCode": "<string>"
  }
  ```
- Parsing: none

#### `getMyMemberships()`
- Purpose: Get communities the current user belongs to.
- Request type: `GET`
- Endpoint: `/communities/my-memberships`
- Parsing:
  - Reads `response.data['data']`
  - Each item may contain `community` and `status`
  - Normalizes `membershipStatus` and then calls `Community.fromJson(...)`

#### `getCommunityMembers(String communityId, {page = 1, limit = 10})`
- Purpose: Fetch members of a community.
- Request type: `GET`
- Endpoint: `/communities/{communityId}/members`
- Query params:
  - `page`
  - `limit`
- Parsing: maps to `CommunityMember.fromJson`

#### `approveJoinRequest(String communityId, String membershipId)`
- Purpose: Approve a join request.
- Request type: `POST`
- Endpoint: `/communities/{communityId}/approve`
- Body:
  ```json
  {
    "membershipId": "<string>"
  }
  ```

#### `rejectJoinRequest(String communityId, String membershipId)`
- Purpose: Reject a join request.
- Request type: `POST`
- Endpoint: `/communities/{communityId}/reject`
- Body:
  ```json
  {
    "membershipId": "<string>"
  }
  ```

#### `getAnnouncements(String communityId, {page = 1, limit = 10})`
- Purpose: Fetch announcements for a community.
- Request type: `GET`
- Endpoint: `/admin/{communityId}/announcements`
- Query params:
  - `page`
  - `limit`
  - `source=ALL`
- Parsing: list mapped to `Announcement.fromJson`

#### `getEvents(String communityId, {page = 1, limit = 10})`
- Purpose: Fetch events for a community.
- Request type: `GET`
- Endpoint: `/admin/{communityId}/events`
- Query params:
  - `page`
  - `limit`
  - `source=ALL`
- Parsing: list mapped to `Event.fromJson`

#### `getNotifications({source = 'ALL'})`
- Purpose: Load notifications.
- Request type: `GET`
- Endpoint: `/notifications`
- Query params:
  - `source`
- Parsing: list mapped to `AppNotification.fromJson`

#### `markNotificationAsRead(String id)`
- Purpose: Mark a notification as read.
- Request type: `POST` with fallback `PATCH`
- Endpoint: `/notifications/{id}/read`
- Behavior:
  - Try `POST` first.
  - If `405 Method Not Allowed`, retry with `PATCH`.

---

### 3.6 Export APIs
Source: [lib/src/features/exports/data/export_repository.dart](lib/src/features/exports/data/export_repository.dart)

#### `exportPdfBiodata(String targetUserId)`
- Purpose: Export biodata PDF for a user.
- Request type: `POST`
- Endpoint: `/exports/pdf`
- Body:
  ```json
  {
    "targetUserId": "<string>"
  }
  ```
- Parsing: `response.data['data']['pdfUrl']`

#### `generateProfileQrCode([String? targetUserId])`
- Purpose: Generate QR profile image.
- Request type: `POST`
- Endpoint: `/exports/qr`
- Body:
  ```json
  {
    "targetUserId": "<string>"
  }
  ```
  or `null` for own profile
- Parsing:
  - tries `response.data['data']['qrImageUrl']`
  - falls back to `response.data['data']['qrCode']`

---

## 4. Parameter Parsing and Response Parsing Pattern

Most repository methods follow one of these patterns:

### Pattern A: Object response
```dart
final response = await _dio.get(ApiEndpoints.profiles);
return UserProfile.fromJson(response.data['data']);
```

### Pattern B: List response
```dart
final response = await _dio.get(ApiEndpoints.familyMember);
return (response.data['data'] as List)
    .map((e) => FamilyMember.fromJson(e))
    .toList();
```

### Pattern C: Nested data object
```dart
final response = await _dio.get(ApiEndpoints.familyHierarchy);
return FamilyTreeNode.fromJson(response.data['data']['tree']);
```

### Pattern D: Multiple possible backend wrappers
The profile APIs are defensive and inspect more than one possible field shape:
- `stateNames`, `states`
- `cityNames`, `cities`
- `categoryNames`, `categories`

This is used to handle inconsistent backend response schemas.

## 5. Important Implementation Notes

### Token handling
- See [lib/src/core/network/api_client.dart](lib/src/core/network/api_client.dart)
- The API client automatically injects `Authorization` on requests when token exists.
- Token refresh is done automatically on `401` responses.

### Multipart upload
- See [lib/src/features/profile/data/profile_repository.dart](lib/src/features/profile/data/profile_repository.dart)
- Profile photo upload uses `FormData` and a manual `Authorization` header to avoid multipart request issues.

### Local notifications
- Not an API call; real notifications are displayed locally using Flutter local notifications.
- See [lib/src/core/notifications/local_notification_service.dart](lib/src/core/notifications/local_notification_service.dart)

### Translation feature
- Not a backend API; uses Google MLKit on-device translation and downloads language models locally.
- See [lib/src/features/translation/application/translation_service.dart](lib/src/features/translation/application/translation_service.dart)

## 6. Summary

The app primarily uses a single backend API base URL and communicates through a centralized Dio client. The most active features are:
- authentication
- profile management
- search and matching
- family hierarchy
- community memberships and moderation
- export generation
- notification tracking

The app follows a consistent pattern of:
1. Build request body or query params
2. Call Dio endpoint
3. Read `response.data['data']`
4. Convert to model using `*.fromJson(...)`

This document is based on the current code in the repository and can be used as a backend integration reference or handoff summary.
