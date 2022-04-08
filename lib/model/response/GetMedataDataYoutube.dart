import 'package:json_annotation/json_annotation.dart';

part 'GetMedataDataYoutube.g.dart';

@JsonSerializable()
class GetMedataDataYoutube {
  String title;
  String result;
  String quality;
  String size;
  String thumbb;

  GetMedataDataYoutube({
    this.title,
    this.result,
    this.quality,
    this.size,
    this.thumbb,
  });

  Map<String, dynamic> toJson() => _$GetMedataDataYoutubeToJson(this);

  static GetMedataDataYoutube fromJson(Map<String, dynamic> json) =>
      _$GetMedataDataYoutubeFromJson(json);
}
