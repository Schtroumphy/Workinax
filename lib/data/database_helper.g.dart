// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_helper.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getAllHash() => r'bb24e271aab0880afec5f1d74f31537a8335b655';

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
String _$databaseHelperHash() => r'1addb003037cb23cb7ee99f7adb419f25369d354';

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
