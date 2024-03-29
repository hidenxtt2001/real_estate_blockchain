// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ImageResponse _$ImageResponseFromJson(Map<String, dynamic> json) {
  return _ImageResponse.fromJson(json);
}

/// @nodoc
mixin _$ImageResponse {
  int? get id => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  int? get width => throw _privateConstructorUsedError;
  int? get height => throw _privateConstructorUsedError;
  int? get omitempty => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ImageResponseCopyWith<ImageResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageResponseCopyWith<$Res> {
  factory $ImageResponseCopyWith(
          ImageResponse value, $Res Function(ImageResponse) then) =
      _$ImageResponseCopyWithImpl<$Res, ImageResponse>;
  @useResult
  $Res call({int? id, String? url, int? width, int? height, int? omitempty});
}

/// @nodoc
class _$ImageResponseCopyWithImpl<$Res, $Val extends ImageResponse>
    implements $ImageResponseCopyWith<$Res> {
  _$ImageResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? url = freezed,
    Object? width = freezed,
    Object? height = freezed,
    Object? omitempty = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      width: freezed == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int?,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int?,
      omitempty: freezed == omitempty
          ? _value.omitempty
          : omitempty // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ImageResponseCopyWith<$Res>
    implements $ImageResponseCopyWith<$Res> {
  factory _$$_ImageResponseCopyWith(
          _$_ImageResponse value, $Res Function(_$_ImageResponse) then) =
      __$$_ImageResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? url, int? width, int? height, int? omitempty});
}

/// @nodoc
class __$$_ImageResponseCopyWithImpl<$Res>
    extends _$ImageResponseCopyWithImpl<$Res, _$_ImageResponse>
    implements _$$_ImageResponseCopyWith<$Res> {
  __$$_ImageResponseCopyWithImpl(
      _$_ImageResponse _value, $Res Function(_$_ImageResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? url = freezed,
    Object? width = freezed,
    Object? height = freezed,
    Object? omitempty = freezed,
  }) {
    return _then(_$_ImageResponse(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      width: freezed == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int?,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int?,
      omitempty: freezed == omitempty
          ? _value.omitempty
          : omitempty // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable(createToJson: false)
class _$_ImageResponse implements _ImageResponse {
  _$_ImageResponse(
      {this.id, this.url, this.width, this.height, this.omitempty});

  factory _$_ImageResponse.fromJson(Map<String, dynamic> json) =>
      _$$_ImageResponseFromJson(json);

  @override
  final int? id;
  @override
  final String? url;
  @override
  final int? width;
  @override
  final int? height;
  @override
  final int? omitempty;

  @override
  String toString() {
    return 'ImageResponse(id: $id, url: $url, width: $width, height: $height, omitempty: $omitempty)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ImageResponse &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.omitempty, omitempty) ||
                other.omitempty == omitempty));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, url, width, height, omitempty);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ImageResponseCopyWith<_$_ImageResponse> get copyWith =>
      __$$_ImageResponseCopyWithImpl<_$_ImageResponse>(this, _$identity);
}

abstract class _ImageResponse implements ImageResponse {
  factory _ImageResponse(
      {final int? id,
      final String? url,
      final int? width,
      final int? height,
      final int? omitempty}) = _$_ImageResponse;

  factory _ImageResponse.fromJson(Map<String, dynamic> json) =
      _$_ImageResponse.fromJson;

  @override
  int? get id;
  @override
  String? get url;
  @override
  int? get width;
  @override
  int? get height;
  @override
  int? get omitempty;
  @override
  @JsonKey(ignore: true)
  _$$_ImageResponseCopyWith<_$_ImageResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
