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
    r'1086cb0d6395c8066142b2912766060ff97aaf46';

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
