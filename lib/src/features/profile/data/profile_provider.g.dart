// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(memberProfile)
final memberProfileProvider = MemberProfileFamily._();

final class MemberProfileProvider
    extends
        $FunctionalProvider<
          AsyncValue<UserProfile>,
          UserProfile,
          FutureOr<UserProfile>
        >
    with $FutureModifier<UserProfile>, $FutureProvider<UserProfile> {
  MemberProfileProvider._({
    required MemberProfileFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'memberProfileProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$memberProfileHash();

  @override
  String toString() {
    return r'memberProfileProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<UserProfile> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<UserProfile> create(Ref ref) {
    final argument = this.argument as String;
    return memberProfile(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is MemberProfileProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$memberProfileHash() => r'ef397a2fb5b5a8827ad2360b1dcacd2a173d01a6';

final class MemberProfileFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<UserProfile>, String> {
  MemberProfileFamily._()
    : super(
        retry: null,
        name: r'memberProfileProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MemberProfileProvider call(String id) =>
      MemberProfileProvider._(argument: id, from: this);

  @override
  String toString() => r'memberProfileProvider';
}

@ProviderFor(statesList)
final statesListProvider = StatesListProvider._();

final class StatesListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<String>>,
          List<String>,
          FutureOr<List<String>>
        >
    with $FutureModifier<List<String>>, $FutureProvider<List<String>> {
  StatesListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'statesListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$statesListHash();

  @$internal
  @override
  $FutureProviderElement<List<String>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<String>> create(Ref ref) {
    return statesList(ref);
  }
}

String _$statesListHash() => r'7ef8f7aa5a4aca9036adf992127b3bdbf611b5dd';

@ProviderFor(citiesList)
final citiesListProvider = CitiesListFamily._();

final class CitiesListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<String>>,
          List<String>,
          FutureOr<List<String>>
        >
    with $FutureModifier<List<String>>, $FutureProvider<List<String>> {
  CitiesListProvider._({
    required CitiesListFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'citiesListProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$citiesListHash();

  @override
  String toString() {
    return r'citiesListProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<String>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<String>> create(Ref ref) {
    final argument = this.argument as String;
    return citiesList(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CitiesListProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$citiesListHash() => r'f740abf4feb6cb5505cd2860fb18faecde41cc8b';

final class CitiesListFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<String>>, String> {
  CitiesListFamily._()
    : super(
        retry: null,
        name: r'citiesListProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CitiesListProvider call(String state) =>
      CitiesListProvider._(argument: state, from: this);

  @override
  String toString() => r'citiesListProvider';
}

@ProviderFor(businessCategoriesList)
final businessCategoriesListProvider = BusinessCategoriesListProvider._();

final class BusinessCategoriesListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<String>>,
          List<String>,
          FutureOr<List<String>>
        >
    with $FutureModifier<List<String>>, $FutureProvider<List<String>> {
  BusinessCategoriesListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'businessCategoriesListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$businessCategoriesListHash();

  @$internal
  @override
  $FutureProviderElement<List<String>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<String>> create(Ref ref) {
    return businessCategoriesList(ref);
  }
}

String _$businessCategoriesListHash() =>
    r'85ec6890dac03658223ec48d07844d36b9124954';

@ProviderFor(blockedUsers)
final blockedUsersProvider = BlockedUsersProvider._();

final class BlockedUsersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<UserProfile>>,
          List<UserProfile>,
          FutureOr<List<UserProfile>>
        >
    with
        $FutureModifier<List<UserProfile>>,
        $FutureProvider<List<UserProfile>> {
  BlockedUsersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'blockedUsersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$blockedUsersHash();

  @$internal
  @override
  $FutureProviderElement<List<UserProfile>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<UserProfile>> create(Ref ref) {
    return blockedUsers(ref);
  }
}

String _$blockedUsersHash() => r'43d7dcbcb461dbdf2c5d6e84a3f58c661ff5a74d';

@ProviderFor(blockStatus)
final blockStatusProvider = BlockStatusFamily._();

final class BlockStatusProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  BlockStatusProvider._({
    required BlockStatusFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'blockStatusProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$blockStatusHash();

  @override
  String toString() {
    return r'blockStatusProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    final argument = this.argument as String;
    return blockStatus(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is BlockStatusProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$blockStatusHash() => r'be73137dbc2ffe9895852266731a1c3fc81d5809';

final class BlockStatusFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<bool>, String> {
  BlockStatusFamily._()
    : super(
        retry: null,
        name: r'blockStatusProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  BlockStatusProvider call(String userId) =>
      BlockStatusProvider._(argument: userId, from: this);

  @override
  String toString() => r'blockStatusProvider';
}

@ProviderFor(ProfileController)
final profileControllerProvider = ProfileControllerProvider._();

final class ProfileControllerProvider
    extends $AsyncNotifierProvider<ProfileController, UserProfile?> {
  ProfileControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileControllerHash();

  @$internal
  @override
  ProfileController create() => ProfileController();
}

String _$profileControllerHash() => r'd3835ac10e9b679517bf1c40157c3dc84b9a5dba';

abstract class _$ProfileController extends $AsyncNotifier<UserProfile?> {
  FutureOr<UserProfile?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<UserProfile?>, UserProfile?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<UserProfile?>, UserProfile?>,
              AsyncValue<UserProfile?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
