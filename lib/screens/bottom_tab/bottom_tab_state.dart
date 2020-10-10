import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bottom_tab_state.freezed.dart';

@freezed
abstract class BottomTabState with _$BottomTabState {
  const factory BottomTabState({
    List<String> list,
  }) = _BottomTabState;
}
