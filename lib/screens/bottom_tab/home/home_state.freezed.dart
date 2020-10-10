// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$HomeStateTearOff {
  const _$HomeStateTearOff();

// ignore: unused_element
  _HomeState call({bool isLoading, List<String> list = const []}) {
    return _HomeState(
      isLoading: isLoading,
      list: list,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $HomeState = _$HomeStateTearOff();

/// @nodoc
mixin _$HomeState {
  bool get isLoading;
  List<String> get list;

  $HomeStateCopyWith<HomeState> get copyWith;
}

/// @nodoc
abstract class $HomeStateCopyWith<$Res> {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) then) =
      _$HomeStateCopyWithImpl<$Res>;
  $Res call({bool isLoading, List<String> list});
}

/// @nodoc
class _$HomeStateCopyWithImpl<$Res> implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._value, this._then);

  final HomeState _value;
  // ignore: unused_field
  final $Res Function(HomeState) _then;

  @override
  $Res call({
    Object isLoading = freezed,
    Object list = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: isLoading == freezed ? _value.isLoading : isLoading as bool,
      list: list == freezed ? _value.list : list as List<String>,
    ));
  }
}

/// @nodoc
abstract class _$HomeStateCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory _$HomeStateCopyWith(
          _HomeState value, $Res Function(_HomeState) then) =
      __$HomeStateCopyWithImpl<$Res>;
  @override
  $Res call({bool isLoading, List<String> list});
}

/// @nodoc
class __$HomeStateCopyWithImpl<$Res> extends _$HomeStateCopyWithImpl<$Res>
    implements _$HomeStateCopyWith<$Res> {
  __$HomeStateCopyWithImpl(_HomeState _value, $Res Function(_HomeState) _then)
      : super(_value, (v) => _then(v as _HomeState));

  @override
  _HomeState get _value => super._value as _HomeState;

  @override
  $Res call({
    Object isLoading = freezed,
    Object list = freezed,
  }) {
    return _then(_HomeState(
      isLoading: isLoading == freezed ? _value.isLoading : isLoading as bool,
      list: list == freezed ? _value.list : list as List<String>,
    ));
  }
}

/// @nodoc
class _$_HomeState with DiagnosticableTreeMixin implements _HomeState {
  const _$_HomeState({this.isLoading, this.list = const []})
      : assert(list != null);

  @override
  final bool isLoading;
  @JsonKey(defaultValue: const [])
  @override
  final List<String> list;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'HomeState(isLoading: $isLoading, list: $list)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'HomeState'))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('list', list));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _HomeState &&
            (identical(other.isLoading, isLoading) ||
                const DeepCollectionEquality()
                    .equals(other.isLoading, isLoading)) &&
            (identical(other.list, list) ||
                const DeepCollectionEquality().equals(other.list, list)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(isLoading) ^
      const DeepCollectionEquality().hash(list);

  @override
  _$HomeStateCopyWith<_HomeState> get copyWith =>
      __$HomeStateCopyWithImpl<_HomeState>(this, _$identity);
}

abstract class _HomeState implements HomeState {
  const factory _HomeState({bool isLoading, List<String> list}) = _$_HomeState;

  @override
  bool get isLoading;
  @override
  List<String> get list;
  @override
  _$HomeStateCopyWith<_HomeState> get copyWith;
}
