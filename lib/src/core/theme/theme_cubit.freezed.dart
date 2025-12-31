// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'theme_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ThemeState {
  TimePeriod get timePeriod => throw _privateConstructorUsedError;
  bool get isRamadan => throw _privateConstructorUsedError;
  ThemeData get theme => throw _privateConstructorUsedError;

  /// Create a copy of ThemeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ThemeStateCopyWith<ThemeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThemeStateCopyWith<$Res> {
  factory $ThemeStateCopyWith(
    ThemeState value,
    $Res Function(ThemeState) then,
  ) = _$ThemeStateCopyWithImpl<$Res, ThemeState>;
  @useResult
  $Res call({TimePeriod timePeriod, bool isRamadan, ThemeData theme});
}

/// @nodoc
class _$ThemeStateCopyWithImpl<$Res, $Val extends ThemeState>
    implements $ThemeStateCopyWith<$Res> {
  _$ThemeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ThemeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timePeriod = null,
    Object? isRamadan = null,
    Object? theme = null,
  }) {
    return _then(
      _value.copyWith(
            timePeriod: null == timePeriod
                ? _value.timePeriod
                : timePeriod // ignore: cast_nullable_to_non_nullable
                      as TimePeriod,
            isRamadan: null == isRamadan
                ? _value.isRamadan
                : isRamadan // ignore: cast_nullable_to_non_nullable
                      as bool,
            theme: null == theme
                ? _value.theme
                : theme // ignore: cast_nullable_to_non_nullable
                      as ThemeData,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ThemeStateImplCopyWith<$Res>
    implements $ThemeStateCopyWith<$Res> {
  factory _$$ThemeStateImplCopyWith(
    _$ThemeStateImpl value,
    $Res Function(_$ThemeStateImpl) then,
  ) = __$$ThemeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({TimePeriod timePeriod, bool isRamadan, ThemeData theme});
}

/// @nodoc
class __$$ThemeStateImplCopyWithImpl<$Res>
    extends _$ThemeStateCopyWithImpl<$Res, _$ThemeStateImpl>
    implements _$$ThemeStateImplCopyWith<$Res> {
  __$$ThemeStateImplCopyWithImpl(
    _$ThemeStateImpl _value,
    $Res Function(_$ThemeStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ThemeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timePeriod = null,
    Object? isRamadan = null,
    Object? theme = null,
  }) {
    return _then(
      _$ThemeStateImpl(
        timePeriod: null == timePeriod
            ? _value.timePeriod
            : timePeriod // ignore: cast_nullable_to_non_nullable
                  as TimePeriod,
        isRamadan: null == isRamadan
            ? _value.isRamadan
            : isRamadan // ignore: cast_nullable_to_non_nullable
                  as bool,
        theme: null == theme
            ? _value.theme
            : theme // ignore: cast_nullable_to_non_nullable
                  as ThemeData,
      ),
    );
  }
}

/// @nodoc

class _$ThemeStateImpl extends _ThemeState {
  const _$ThemeStateImpl({
    required this.timePeriod,
    required this.isRamadan,
    required this.theme,
  }) : super._();

  @override
  final TimePeriod timePeriod;
  @override
  final bool isRamadan;
  @override
  final ThemeData theme;

  @override
  String toString() {
    return 'ThemeState(timePeriod: $timePeriod, isRamadan: $isRamadan, theme: $theme)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ThemeStateImpl &&
            (identical(other.timePeriod, timePeriod) ||
                other.timePeriod == timePeriod) &&
            (identical(other.isRamadan, isRamadan) ||
                other.isRamadan == isRamadan) &&
            (identical(other.theme, theme) || other.theme == theme));
  }

  @override
  int get hashCode => Object.hash(runtimeType, timePeriod, isRamadan, theme);

  /// Create a copy of ThemeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ThemeStateImplCopyWith<_$ThemeStateImpl> get copyWith =>
      __$$ThemeStateImplCopyWithImpl<_$ThemeStateImpl>(this, _$identity);
}

abstract class _ThemeState extends ThemeState {
  const factory _ThemeState({
    required final TimePeriod timePeriod,
    required final bool isRamadan,
    required final ThemeData theme,
  }) = _$ThemeStateImpl;
  const _ThemeState._() : super._();

  @override
  TimePeriod get timePeriod;
  @override
  bool get isRamadan;
  @override
  ThemeData get theme;

  /// Create a copy of ThemeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ThemeStateImplCopyWith<_$ThemeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
