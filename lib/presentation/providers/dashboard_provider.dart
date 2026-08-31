import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/service_locator.dart';
import '../../core/utils/either.dart';
import '../../data/models/dashboard_stats_model.dart';
import '../../data/repositories/dashboard_repository.dart';

class DashboardNotifier extends AsyncNotifier<DashboardStatsModel> {
  @override
  Future<DashboardStatsModel> build() => _fetch();

  Future<DashboardStatsModel> _fetch() async {
    final result = await sl<DashboardRepository>().getStats();
    if (result is Right<String, DashboardStatsModel>) return result.value;
    throw Exception((result as Left<String, DashboardStatsModel>).value);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_fetch);
  }
}

final dashboardProvider =
    AsyncNotifierProvider<DashboardNotifier, DashboardStatsModel>(
  DashboardNotifier.new,
);
