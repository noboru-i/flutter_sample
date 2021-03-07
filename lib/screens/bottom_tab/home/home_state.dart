import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    bool isLoading,
    @Default(<String>[]) List<String> list,
  }) = _HomeState;
}
