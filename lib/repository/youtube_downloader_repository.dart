import 'package:dio/dio.dart';
import 'package:youtube_downloader/constants/url_constants.dart';
import 'package:youtube_downloader/util/Injector.dart';

import '../models/response/youtube_downloader_response.dart';

class YoutubeDownloaderRepository {
  final Dio dio = locator<Dio>();

  Future<YoutubeDownloaderResponseModel> getDataMp3(String url) async {
    try {
      dio.options.headers["accept"] = "application/json";
      dio.options.headers["User-Agent"] =
          "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36";
      Response response = await dio.get(UrlConstants.urlMp3 + url);

      var fetchedResponse = YoutubeDownloaderResponseModel.fromJson(
        response.data,
      );

      return fetchedResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<YoutubeDownloaderResponseModel> getDataMp4(String url) async {
    try {
      dio.options.headers["accept"] = "application/json";
      dio.options.headers["User-Agent"] =
          "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36";
      Response response = await dio.get(UrlConstants.urlMp4 + url);

      var fetchedResponse = YoutubeDownloaderResponseModel.fromJson(
        response.data,
      );

      return fetchedResponse;
    } catch (e) {
      rethrow;
    }
  }
}
