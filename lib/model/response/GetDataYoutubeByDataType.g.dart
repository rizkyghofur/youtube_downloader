// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GetDataYoutubeByDataType.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetDataYoutubeByDataType _$GetDataYoutubeByDataTypeFromJson(
    Map<String, dynamic> json) {
  return GetDataYoutubeByDataType(
    mp4: json['mp4'] == null
        ? null
        : GetMedataDataYoutube.fromJson(json['mp4'] as Map<String, dynamic>),
    mp3: json['mp3'] == null
        ? null
        : GetMedataDataYoutube.fromJson(json['mp3'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GetDataYoutubeByDataTypeToJson(
        GetDataYoutubeByDataType instance) =>
    <String, dynamic>{
      'mp4': instance.mp4,
      'mp3': instance.mp3,
    };
