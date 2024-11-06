// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$timerNotifierHash() => r'5563da303aaedf282344279f52f38de210cc4747';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$TimerNotifier extends BuildlessAutoDisposeNotifier<Duration> {
  late final DateTime startTime;

  Duration build(
    DateTime startTime,
  );
}

/// See also [TimerNotifier].
@ProviderFor(TimerNotifier)
const timerNotifierProvider = TimerNotifierFamily();

/// See also [TimerNotifier].
class TimerNotifierFamily extends Family<Duration> {
  /// See also [TimerNotifier].
  const TimerNotifierFamily();

  /// See also [TimerNotifier].
  TimerNotifierProvider call(
    DateTime startTime,
  ) {
    return TimerNotifierProvider(
      startTime,
    );
  }

  @override
  TimerNotifierProvider getProviderOverride(
    covariant TimerNotifierProvider provider,
  ) {
    return call(
      provider.startTime,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'timerNotifierProvider';
}

/// See also [TimerNotifier].
class TimerNotifierProvider
    extends AutoDisposeNotifierProviderImpl<TimerNotifier, Duration> {
  /// See also [TimerNotifier].
  TimerNotifierProvider(
    DateTime startTime,
  ) : this._internal(
          () => TimerNotifier()..startTime = startTime,
          from: timerNotifierProvider,
          name: r'timerNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$timerNotifierHash,
          dependencies: TimerNotifierFamily._dependencies,
          allTransitiveDependencies:
              TimerNotifierFamily._allTransitiveDependencies,
          startTime: startTime,
        );

  TimerNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.startTime,
  }) : super.internal();

  final DateTime startTime;

  @override
  Duration runNotifierBuild(
    covariant TimerNotifier notifier,
  ) {
    return notifier.build(
      startTime,
    );
  }

  @override
  Override overrideWith(TimerNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: TimerNotifierProvider._internal(
        () => create()..startTime = startTime,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        startTime: startTime,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<TimerNotifier, Duration> createElement() {
    return _TimerNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TimerNotifierProvider && other.startTime == startTime;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, startTime.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TimerNotifierRef on AutoDisposeNotifierProviderRef<Duration> {
  /// The parameter `startTime` of this provider.
  DateTime get startTime;
}

class _TimerNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<TimerNotifier, Duration>
    with TimerNotifierRef {
  _TimerNotifierProviderElement(super.provider);

  @override
  DateTime get startTime => (origin as TimerNotifierProvider).startTime;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
