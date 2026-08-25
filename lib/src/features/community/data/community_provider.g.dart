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

@ProviderFor(communityAnnouncements)
final communityAnnouncementsProvider = CommunityAnnouncementsFamily._();

final class CommunityAnnouncementsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Announcement>>,
          List<Announcement>,
          FutureOr<List<Announcement>>
        >
    with
        $FutureModifier<List<Announcement>>,
        $FutureProvider<List<Announcement>> {
  CommunityAnnouncementsProvider._({
    required CommunityAnnouncementsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'communityAnnouncementsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$communityAnnouncementsHash();

  @override
  String toString() {
    return r'communityAnnouncementsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Announcement>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Announcement>> create(Ref ref) {
    final argument = this.argument as String;
    return communityAnnouncements(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CommunityAnnouncementsProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$communityAnnouncementsHash() =>
    r'8e3162167745a869cc99ebf576eda4764ab2b5f5';

final class CommunityAnnouncementsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Announcement>>, String> {
  CommunityAnnouncementsFamily._()
    : super(
        retry: null,
        name: r'communityAnnouncementsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CommunityAnnouncementsProvider call(String communityId) =>
      CommunityAnnouncementsProvider._(argument: communityId, from: this);

  @override
  String toString() => r'communityAnnouncementsProvider';
}

@ProviderFor(communityEvents)
final communityEventsProvider = CommunityEventsFamily._();

final class CommunityEventsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Event>>,
          List<Event>,
          FutureOr<List<Event>>
        >
    with $FutureModifier<List<Event>>, $FutureProvider<List<Event>> {
  CommunityEventsProvider._({
    required CommunityEventsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'communityEventsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$communityEventsHash();

  @override
  String toString() {
    return r'communityEventsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Event>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Event>> create(Ref ref) {
    final argument = this.argument as String;
    return communityEvents(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CommunityEventsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$communityEventsHash() => r'7ec143ef3abf292f6ce4a6ee9ce836cc2edb6093';

final class CommunityEventsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Event>>, String> {
  CommunityEventsFamily._()
    : super(
        retry: null,
        name: r'communityEventsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CommunityEventsProvider call(String communityId) =>
      CommunityEventsProvider._(argument: communityId, from: this);

  @override
  String toString() => r'communityEventsProvider';
}
