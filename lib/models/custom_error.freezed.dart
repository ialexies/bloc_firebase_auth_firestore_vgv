// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'custom_error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CustomError {
  String get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String get plugin => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CustomErrorCopyWith<CustomError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomErrorCopyWith<$Res> {
  factory $CustomErrorCopyWith(
          CustomError value, $Res Function(CustomError) then) =
      _$CustomErrorCopyWithImpl<$Res>;
  $Res call({String code, String message, String plugin});
}

/// @nodoc
class _$CustomErrorCopyWithImpl<$Res> implements $CustomErrorCopyWith<$Res> {
  _$CustomErrorCopyWithImpl(this._value, this._then);

  final CustomError _value;
  // ignore: unused_field
  final $Res Function(CustomError) _then;

  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? plugin = freezed,
  }) {
    return _then(_value.copyWith(
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      plugin: plugin == freezed
          ? _value.plugin
          : plugin // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_CustomErrorCopyWith<$Res>
    implements $CustomErrorCopyWith<$Res> {
  factory _$$_CustomErrorCopyWith(
          _$_CustomError value, $Res Function(_$_CustomError) then) =
      __$$_CustomErrorCopyWithImpl<$Res>;
  @override
  $Res call({String code, String message, String plugin});
}

/// @nodoc
class __$$_CustomErrorCopyWithImpl<$Res> extends _$CustomErrorCopyWithImpl<$Res>
    implements _$$_CustomErrorCopyWith<$Res> {
  __$$_CustomErrorCopyWithImpl(
      _$_CustomError _value, $Res Function(_$_CustomError) _then)
      : super(_value, (v) => _then(v as _$_CustomError));

  @override
  _$_CustomError get _value => super._value as _$_CustomError;

  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? plugin = freezed,
  }) {
    return _then(_$_CustomError(
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      plugin: plugin == freezed
          ? _value.plugin
          : plugin // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_CustomError implements _CustomError {
  const _$_CustomError({this.code = '', this.message = '', this.plugin = ''});

  @override
  @JsonKey()
  final String code;
  @override
  @JsonKey()
  final String message;
  @override
  @JsonKey()
  final String plugin;

  @override
  String toString() {
    return 'CustomError(code: $code, message: $message, plugin: $plugin)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CustomError &&
            const DeepCollectionEquality().equals(other.code, code) &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality().equals(other.plugin, plugin));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(code),
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(plugin));

  @JsonKey(ignore: true)
  @override
  _$$_CustomErrorCopyWith<_$_CustomError> get copyWith =>
      __$$_CustomErrorCopyWithImpl<_$_CustomError>(this, _$identity);
}

abstract class _CustomError implements CustomError {
  const factory _CustomError(
      {final String code,
      final String message,
      final String plugin}) = _$_CustomError;

  @override
  String get code;
  @override
  String get message;
  @override
  String get plugin;
  @override
  @JsonKey(ignore: true)
  _$$_CustomErrorCopyWith<_$_CustomError> get copyWith =>
      throw _privateConstructorUsedError;
}
