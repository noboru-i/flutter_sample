import 'dart:math' as math;

import 'package:flutter_sample/screens/bottom_tab/bottom_tab_state_notifier.dart';
import 'package:flutter_sample/screens/bottom_tab/home/home_state.dart';
import 'package:state_notifier/state_notifier.dart';

class HomeStateNotifier extends StateNotifier<HomeState> with LocatorMixin {
  HomeStateNotifier() : super(const HomeState()) {
    refresh();
  }

  @override
  void initState() {
    read<BottomTabStateNotifier>().addRefreshListener(
      TabItem.home,
      refresh,
    );
  }

  @override
  void dispose() {
    read<BottomTabStateNotifier>().removeRefreshListener(TabItem.home);
    super.dispose();
  }

  Future<void> refresh() async {
    state = state.copyWith(
      isLoading: true,
    );

    final list = await _callApi();

    state = state.copyWith(
      isLoading: false,
      list: list,
    );
  }

  Future<List<String>> _callApi() async {
    // API call here
    await Future<void>.delayed(const Duration(seconds: 2));

    final random = math.Random();
    return List.generate(20, (index) => random.nextInt(9999).toString())
        .toList();
  }
}
