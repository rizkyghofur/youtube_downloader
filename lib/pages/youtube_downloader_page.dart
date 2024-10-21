import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/response/youtube_downloader_response.dart';
import '../repository/youtube_downloader_repository.dart';
import '../util/Injector.dart';

class YoutubeDownloaderPage extends StatefulWidget {
  YoutubeDownloaderPage({Key? key}) : super(key: key);

  @override
  State<YoutubeDownloaderPage> createState() => _YoutubeDownloaderPageState();
}

class _YoutubeDownloaderPageState extends State<YoutubeDownloaderPage> {
  final Dio dio = locator<Dio>();
  TextEditingController _controller = TextEditingController();
  YoutubeDownloaderRepository repository = YoutubeDownloaderRepository();
  YoutubeDownloaderResponse youtubeDownloaderResponse =
      YoutubeDownloaderResponse();
  String thumbb = "",
      title = "",
      resultInMp3 = "",
      resultInMp4 = "",
      qualityInMp3 = "",
      qualityInMp4 = "",
      sizeInMp3 = "",
      sizeInMp4 = "",
      progress = "";
  bool isLoading = false,
      isError = false,
      isDownloadingMp3 = false,
      isDownloadingMp4 = false;

  void searchData(String url) async {
    setState(() {
      isLoading = true;
      isError = false;
    });

    await repository.getData(url).then((response) {
      setState(() {
        title = response.download!.title ?? "";
        resultInMp3 = response.download!.dl!.smp3!.s128kbps!.url ?? "";
        resultInMp4 = response.download!.dl!.smp4!.s720p!.url ?? "";
        qualityInMp3 = "128kbps";
        qualityInMp4 = "720p";
        sizeInMp3 = response.download!.dl!.smp3!.s128kbps!.size ?? "";
        sizeInMp4 = response.download!.dl!.smp4!.s720p!.size ?? "";
        thumbb = response.download!.thumbnail ?? "";
        isLoading = false;
      });
    }).onError((error, stackTrace) {
      setState(() {
        isLoading = false;
        isError = true;
      });
    });
  }

  Future<void> downloadVideo(
      String trackURL, String trackName, String format) async {
    setState(() {
      if (format.contains('mp3')) {
        isDownloadingMp3 = true;
      } else {
        isDownloadingMp4 = true;
      }
    });

    try {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      var directory = await getDownloadsDirectory();
      print("${directory!.path}/" +
          trackName
              .replaceAll(new RegExp(r'[^\w\s]+'), '')
              .split(" ")
              .join("") +
          format);
      await dio.download(trackURL, "${directory.path}/" + trackName + format,
          onReceiveProgress: (rec, total) {
        setState(() {
          progress = ((rec / total) * 100).toStringAsFixed(0) + "%";
        });
      });

      setState(() {
        if (progress.contains('100')) {
          if (format.contains('mp3')) {
            isDownloadingMp3 = false;
          } else {
            isDownloadingMp4 = false;
          }
          progress = "Download Successful";
        }
      });
    } catch (e) {
      setState(() {
        if (format.contains('mp3')) {
          isDownloadingMp3 = false;
        } else {
          isDownloadingMp4 = false;
        }
        progress = "Download Failed";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Youtube Downloader'),
      ),
      body: Container(
        child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Enter your Youtube Video link here...',
                  suffixIcon: IconButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      searchData(_controller.text);
                    },
                    icon: Icon(Icons.search),
                  ),
                ),
                onSubmitted: (url) => searchData(url),
                textInputAction: TextInputAction.search,
                style: TextStyle(fontSize: 16),
              ),
            ),
            isLoading
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ),
                  )
                : isError
                    ? Center(
                        child: Text(
                          'Something wrong...',
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            thumbb == ""
                                ? Image.asset(
                                    'assets/images/placeholder.png',
                                    height: 150,
                                    width: 350,
                                  )
                                : FadeInImage.assetNetwork(
                                    placeholder:
                                        'assets/images/placeholder.png',
                                    image: thumbb,
                                    height: 150,
                                    width: 350,
                                  ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              title == "" ? 'Nothing\'s here' : 'Title: $title',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Visibility(
                              visible: sizeInMp3 == "" ? false : true,
                              child: TextButton(
                                child: Text(
                                  isDownloadingMp3
                                      ? 'Downloading...'
                                      : "Download MP3 ($sizeInMp3)"
                                          .toUpperCase(),
                                  style: TextStyle(fontSize: 14),
                                ),
                                style: ButtonStyle(
                                  padding: WidgetStateProperty.all<EdgeInsets>(
                                    EdgeInsets.all(15),
                                  ),
                                  foregroundColor:
                                      WidgetStateProperty.all<Color>(
                                          Colors.red),
                                  shape: WidgetStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.red),
                                    ),
                                  ),
                                ),
                                onPressed: isDownloadingMp3 || isDownloadingMp4
                                    ? null
                                    : () {
                                        downloadVideo(
                                            resultInMp3, title, '.mp3');
                                      },
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Visibility(
                              visible: sizeInMp4 == "" ? false : true,
                              child: TextButton(
                                child: Text(
                                  isDownloadingMp4
                                      ? 'Downloading...'
                                      : "Download MP4 ($qualityInMp4, $sizeInMp4)"
                                          .toUpperCase(),
                                  style: TextStyle(fontSize: 14),
                                ),
                                style: ButtonStyle(
                                  padding: WidgetStateProperty.all<EdgeInsets>(
                                    EdgeInsets.all(15),
                                  ),
                                  foregroundColor:
                                      WidgetStateProperty.all<Color>(
                                          Colors.red),
                                  shape: WidgetStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.red),
                                    ),
                                  ),
                                ),
                                onPressed: isDownloadingMp3 || isDownloadingMp4
                                    ? null
                                    : () {
                                        downloadVideo(
                                            resultInMp4, title, '.mp4');
                                      },
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Visibility(
                              visible: progress == "" ? false : true,
                              child: Text(
                                'Download Progress: $progress',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
