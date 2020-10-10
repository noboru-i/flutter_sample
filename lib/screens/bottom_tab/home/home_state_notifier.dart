import 'dart:math' as math;

import 'package:flutter_sample/screens/bottom_tab/home/home_state.dart';
import 'package:state_notifier/state_notifier.dart';

class HomeStateNotifier extends StateNotifier<HomeState> {
  HomeStateNotifier() : super(HomeState()) {
    refresh();
  }

  Future<void> refresh() async {
    state = state.copyWith(
      isLoading: true,
    );

    // API call here
    await Future.delayed(Duration(seconds: 2));

    final random = math.Random();
    final list =
        List.generate(20, (index) => random.nextInt(9999).toString()).toList();

    state = state.copyWith(
      isLoading: false,
      list: list,
    );
  }
}
