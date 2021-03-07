import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bottom_tab_state.freezed.dart';

@freezed
abstract class BottomTabState with _$BottomTabState {
  const factory BottomTabState({
    // TODO(anyone): something value (e.g. count of notification)
    int dummy,
  }) = _BottomTabState;
}
