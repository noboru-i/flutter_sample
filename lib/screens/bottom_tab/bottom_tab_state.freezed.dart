// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'bottom_tab_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$BottomTabStateTearOff {
  const _$BottomTabStateTearOff();

// ignore: unused_element
  _BottomTabState call({int dummy}) {
    return _BottomTabState(
      dummy: dummy,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $BottomTabState = _$BottomTabStateTearOff();

/// @nodoc
mixin _$BottomTabState {
// TODO something value (e.g. count of notification)
  int get dummy;

  $BottomTabStateCopyWith<BottomTabState> get copyWith;
}

/// @nodoc
abstract class $BottomTabStateCopyWith<$Res> {
  factory $BottomTabStateCopyWith(
          BottomTabState value, $Res Function(BottomTabState) then) =
      _$BottomTabStateCopyWithImpl<$Res>;
  $Res call({int dummy});
}

/// @nodoc
class _$BottomTabStateCopyWithImpl<$Res>
    implements $BottomTabStateCopyWith<$Res> {
  _$BottomTabStateCopyWithImpl(this._value, this._then);

  final BottomTabState _value;
  // ignore: unused_field
  final $Res Function(BottomTabState) _then;

  @override
  $Res call({
    Object dummy = freezed,
  }) {
    return _then(_value.copyWith(
      dummy: dummy == freezed ? _value.dummy : dummy as int,
    ));
  }
}

/// @nodoc
abstract class _$BottomTabStateCopyWith<$Res>
    implements $BottomTabStateCopyWith<$Res> {
  factory _$BottomTabStateCopyWith(
          _BottomTabState value, $Res Function(_BottomTabState) then) =
      __$BottomTabStateCopyWithImpl<$Res>;
  @override
  $Res call({int dummy});
}

/// @nodoc
class __$BottomTabStateCopyWithImpl<$Res>
    extends _$BottomTabStateCopyWithImpl<$Res>
    implements _$BottomTabStateCopyWith<$Res> {
  __$BottomTabStateCopyWithImpl(
      _BottomTabState _value, $Res Function(_BottomTabState) _then)
      : super(_value, (v) => _then(v as _BottomTabState));

  @override
  _BottomTabState get _value => super._value as _BottomTabState;

  @override
  $Res call({
    Object dummy = freezed,
  }) {
    return _then(_BottomTabState(
      dummy: dummy == freezed ? _value.dummy : dummy as int,
    ));
  }
}

/// @nodoc
class _$_BottomTabState
    with DiagnosticableTreeMixin
    implements _BottomTabState {
  const _$_BottomTabState({this.dummy});

  @override // TODO something value (e.g. count of notification)
  final int dummy;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BottomTabState(dummy: $dummy)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BottomTabState'))
      ..add(DiagnosticsProperty('dummy', dummy));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _BottomTabState &&
            (identical(other.dummy, dummy) ||
                const DeepCollectionEquality().equals(other.dummy, dummy)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(dummy);

  @override
  _$BottomTabStateCopyWith<_BottomTabState> get copyWith =>
      __$BottomTabStateCopyWithImpl<_BottomTabState>(this, _$identity);
}

abstract class _BottomTabState implements BottomTabState {
  const factory _BottomTabState({int dummy}) = _$_BottomTabState;

  @override // TODO something value (e.g. count of notification)
  int get dummy;
  @override
  _$BottomTabStateCopyWith<_BottomTabState> get copyWith;
}
