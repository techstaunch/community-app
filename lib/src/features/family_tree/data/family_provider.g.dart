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

String _$familyControllerHash() => r'896a2a7785f835fec4dcdc7e9f6375a3feee9885';

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

@ProviderFor(memberFamilyTree)
final memberFamilyTreeProvider = MemberFamilyTreeFamily._();

final class MemberFamilyTreeProvider
    extends
        $FunctionalProvider<
          AsyncValue<FamilyTreeNode?>,
          FamilyTreeNode?,
          FutureOr<FamilyTreeNode?>
        >
    with $FutureModifier<FamilyTreeNode?>, $FutureProvider<FamilyTreeNode?> {
  MemberFamilyTreeProvider._({
    required MemberFamilyTreeFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'memberFamilyTreeProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$memberFamilyTreeHash();

  @override
  String toString() {
    return r'memberFamilyTreeProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<FamilyTreeNode?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<FamilyTreeNode?> create(Ref ref) {
    final argument = this.argument as String;
    return memberFamilyTree(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is MemberFamilyTreeProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$memberFamilyTreeHash() => r'8704f1d3ffb570013fcc549ba7a54fa6421c944f';

final class MemberFamilyTreeFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<FamilyTreeNode?>, String> {
  MemberFamilyTreeFamily._()
    : super(
        retry: null,
        name: r'memberFamilyTreeProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MemberFamilyTreeProvider call(String userId) =>
      MemberFamilyTreeProvider._(argument: userId, from: this);

  @override
  String toString() => r'memberFamilyTreeProvider';
}
