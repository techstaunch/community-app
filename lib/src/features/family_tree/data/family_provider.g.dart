// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FamilyController)
final familyControllerProvider = FamilyControllerProvider._();

final class FamilyControllerProvider
    extends $AsyncNotifierProvider<FamilyController, FamilyTreeNode?> {
  FamilyControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'familyControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$familyControllerHash();

  @$internal
  @override
  FamilyController create() => FamilyController();
}

String _$familyControllerHash() => r'53d9495f8a2a6cfa5c6d28730b4e67072d482a09';

abstract class _$FamilyController extends $AsyncNotifier<FamilyTreeNode?> {
  FutureOr<FamilyTreeNode?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<FamilyTreeNode?>, FamilyTreeNode?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<FamilyTreeNode?>, FamilyTreeNode?>,
              AsyncValue<FamilyTreeNode?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
