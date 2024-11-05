// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_helper.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getAllHash() => r'275610a84d4be6d0483fb732edab4fcc413ba56f';

/// See also [getAll].
@ProviderFor(getAll)
final getAllProvider = AutoDisposeFutureProvider<List<WorkClock>>.internal(
  getAll,
  name: r'getAllProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getAllHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetAllRef = AutoDisposeFutureProviderRef<List<WorkClock>>;
String _$getTodayWorkClockHash() => r'9382a9b536d6e479b2a90b661db83369368368f1';

/// See also [getTodayWorkClock].
@ProviderFor(getTodayWorkClock)
final getTodayWorkClockProvider =
    AutoDisposeFutureProvider<WorkClock?>.internal(
  getTodayWorkClock,
  name: r'getTodayWorkClockProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getTodayWorkClockHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetTodayWorkClockRef = AutoDisposeFutureProviderRef<WorkClock?>;
String _$workClockServiceHash() => r'5353e940cd6a0c1e85d531d1178318fe16015c0f';

/// See also [workClockService].
@ProviderFor(workClockService)
final workClockServiceProvider = Provider<WorkClockService>.internal(
  workClockService,
  name: r'workClockServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$workClockServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WorkClockServiceRef = ProviderRef<WorkClockService>;
String _$databaseHelperHash() => r'ec128c0afb2f7df671b6078939a8687bd2a7ad5d';

/// See also [DatabaseHelper].
@ProviderFor(DatabaseHelper)
final databaseHelperProvider =
    AutoDisposeAsyncNotifierProvider<DatabaseHelper, Database>.internal(
  DatabaseHelper.new,
  name: r'databaseHelperProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$databaseHelperHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DatabaseHelper = AutoDisposeAsyncNotifier<Database>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
