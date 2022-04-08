import 'package:json_annotation/json_annotation.dart';
import 'GetMedataDataYoutube.dart';

part 'GetDataYoutubeByDataType.g.dart';

@JsonSerializable()
class GetDataYoutubeByDataType {
  GetMedataDataYoutube mp4;
  GetMedataDataYoutube mp3;

  GetDataYoutubeByDataType({
    this.mp4,
    this.mp3,
  });

  Map<String, dynamic> toJson() => _$GetDataYoutubeByDataTypeToJson(this);

  static GetDataYoutubeByDataType fromJson(Map<String, dynamic> json) =>
      _$GetDataYoutubeByDataTypeFromJson(json);
}
