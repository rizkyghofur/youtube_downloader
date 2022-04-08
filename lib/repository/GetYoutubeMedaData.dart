import 'package:dio/dio.dart';
import 'package:youtube_downloader/constants/Constants.dart';
import 'package:youtube_downloader/model/response/GetDataYoutubeByDataType.dart';
import 'package:youtube_downloader/util/Injector.dart';

class GetYoutubeMedaData {
  final Dio dio = locator<Dio>();

  Future<GetDataYoutubeByDataType> getData(String url) async {
    try {
      Response response = await dio.get(Constants.url + url);

      var map = Map<String, dynamic>.from(response.data);
      var fetchedResponse = GetDataYoutubeByDataType.fromJson(map);

      return fetchedResponse;
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}
