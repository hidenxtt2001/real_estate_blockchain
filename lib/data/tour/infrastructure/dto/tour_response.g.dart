// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tour_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TourResponse _$$_TourResponseFromJson(Map<String, dynamic> json) =>
    _$_TourResponse(
      id: json['id'] as int,
      date: const DateTimeOrNull().fromJson(json['date'] as String?),
      type: json['type'] as String,
      extraData: json['extra_data'] as String?,
      staff: json['staff'] == null
          ? null
          : UserDto.fromJson(json['staff'] as Map<String, dynamic>),
      status: json['status'] as int,
      user: UserDto.fromJson(json['user'] as Map<String, dynamic>),
      realEstate: RealEstateResponse.fromJson(
          json['real_estate'] as Map<String, dynamic>),
    );
