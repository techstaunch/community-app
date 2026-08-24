// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TargetLanguage)
final targetLanguageProvider = TargetLanguageProvider._();

final class TargetLanguageProvider
    extends $NotifierProvider<TargetLanguage, TranslateLanguage> {
  TargetLanguageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'targetLanguageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$targetLanguageHash();

  @$internal
  @override
  TargetLanguage create() => TargetLanguage();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TranslateLanguage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TranslateLanguage>(value),
    );
  }
}

String _$targetLanguageHash() => r'7ceb21db1211d0ada1b3fdb3c76e178f7cabfbfc';

abstract class _$TargetLanguage extends $Notifier<TranslateLanguage> {
  TranslateLanguage build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<TranslateLanguage, TranslateLanguage>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TranslateLanguage, TranslateLanguage>,
              TranslateLanguage,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
