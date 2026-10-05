// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MyCommunitiesController)
final myCommunitiesControllerProvider = MyCommunitiesControllerProvider._();

final class MyCommunitiesControllerProvider
    extends $AsyncNotifierProvider<MyCommunitiesController, List<Community>> {
  MyCommunitiesControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myCommunitiesControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myCommunitiesControllerHash();

  @$internal
  @override
  MyCommunitiesController create() => MyCommunitiesController();
}

String _$myCommunitiesControllerHash() =>
    r'd95dcc75b36ad0d5f5059ae90c41baf463760e3e';

abstract class _$MyCommunitiesController
    extends $AsyncNotifier<List<Community>> {
  FutureOr<List<Community>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Community>>, List<Community>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Community>>, List<Community>>,
              AsyncValue<List<Community>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(currentUserMembershipStatus)
final currentUserMembershipStatusProvider =
    CurrentUserMembershipStatusProvider._();

final class CurrentUserMembershipStatusProvider
    extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  CurrentUserMembershipStatusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentUserMembershipStatusProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentUserMembershipStatusHash();

  @$internal
  @override
  $FutureProviderElement<String> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String> create(Ref ref) {
    return currentUserMembershipStatus(ref);
  }
}

String _$currentUserMembershipStatusHash() =>
    r'8b0c9bf96a450306759cac5aeab2435b069716ff';
