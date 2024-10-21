import 'package:dio/dio.dart';
import 'package:youtube_downloader/util/Injector.dart';

import '../constants/Constants.dart';
import '../models/response/youtube_downloader_response.dart';

class YoutubeDownloaderRepository {
  final Dio dio = locator<Dio>();

  Future<YoutubeDownloaderResponse> getData(String url) async {
    try {
      Response response = await dio.get(Constants.url + url);

      dio.options.headers["User-Agent"] =
          "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36";
      var map = Map<String, dynamic>.from(response.data);
      var fetchedResponse = YoutubeDownloaderResponse.fromJson(map);

      return fetchedResponse;
    } catch (e) {
      rethrow;
    }
  }
}
