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
  YoutubeDownloaderResponseModel youtubeDownloaderResponse =
      YoutubeDownloaderResponseModel();
  String thumbb = "",
      title = "",
      resultInMp3 = "",
      resultInMp4 = "",
      qualityInMp3 = "",
      qualityInMp4 = "",
      progress = "";
  bool isLoadingMp3 = false,
      isLoadingMp4 = false,
      isErrorMp3 = false,
      isErrorMp4 = false,
      isDownloadingMp3 = false,
      isDownloadingMp4 = false;

  void searchData(String url) async {
    setState(() {
      isLoadingMp3 = true;
      isLoadingMp4 = true;
      isErrorMp3 = false;
      isErrorMp4 = false;
      title = "";
      resultInMp3 = "";
      resultInMp4 = "";
      qualityInMp3 = "";
      qualityInMp4 = "";
      thumbb = "";
    });

    // getDataMp3
    repository
        .getDataMp3(url)
        .then((response) {
          setState(() {
            title = response.title ?? "";
            resultInMp3 = response.url ?? "";
            qualityInMp3 = response.quality ?? "";
            thumbb = response.thumbnail ?? "";
            isLoadingMp3 = false;
          });
        })
        .onError((error, stackTrace) {
          setState(() {
            isLoadingMp3 = false;
            isErrorMp3 = true;
          });
        });

    // getDataMp4
    repository
        .getDataMp4(url)
        .then((response) {
          setState(() {
            // Only update title/thumb if not already set by mp3
            if (title.isEmpty) title = response.title ?? "";
            if (thumbb.isEmpty) thumbb = response.thumbnail ?? "";
            resultInMp4 = response.url ?? "";
            qualityInMp4 = response.quality ?? "";
            isLoadingMp4 = false;
          });
        })
        .onError((error, stackTrace) {
          setState(() {
            isLoadingMp4 = false;
            isErrorMp4 = true;
          });
        });
  }

  Future<void> downloadVideo(
    String trackURL,
    String trackName,
    String format,
  ) async {
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
      await dio.download(
        trackURL,
        "${directory!.path}/" +
            trackName.replaceAll(RegExp(r'[^\w\s]+'), '').split(" ").join("") +
            format,
        onReceiveProgress: (rec, total) {
          setState(() {
            progress = ((rec / total) * 100).toStringAsFixed(0) + "%";
          });
        },
      );

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
      appBar: AppBar(title: Text('Youtube Downloader')),
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

            // Show thumbnail and title if available
            Padding(
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
                          placeholder: 'assets/images/placeholder.png',
                          image: thumbb,
                          height: 150,
                          width: 350,
                        ),
                  SizedBox(height: 10),
                  Text(
                    title == "" ? 'Nothing\'s here' : 'Title: $title',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),

            // MP3 Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Column(
                children: [
                  if (isLoadingMp3)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(width: 10),
                          Text('Loading MP3...'),
                        ],
                      ),
                    )
                  else if (isErrorMp3)
                    Text(
                      'Failed to load MP3 info.',
                      style: TextStyle(color: Colors.red),
                    )
                  else if (resultInMp3.isNotEmpty)
                    TextButton(
                      child: Text(
                        isDownloadingMp3
                            ? 'Downloading...'
                            : "Download MP3".toUpperCase(),
                        style: TextStyle(fontSize: 14),
                      ),
                      style: ButtonStyle(
                        padding: WidgetStateProperty.all<EdgeInsets>(
                          EdgeInsets.all(15),
                        ),
                        foregroundColor: WidgetStateProperty.all<Color>(
                          Colors.red,
                        ),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                      onPressed: isDownloadingMp3 || isDownloadingMp4
                          ? null
                          : () {
                              downloadVideo(resultInMp3, title, '.mp3');
                            },
                    ),
                ],
              ),
            ),

            // MP4 Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Column(
                children: [
                  if (isLoadingMp4)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(width: 10),
                          Text('Loading MP4...'),
                        ],
                      ),
                    )
                  else if (isErrorMp4)
                    Text(
                      'Failed to load MP4 info.',
                      style: TextStyle(color: Colors.red),
                    )
                  else if (resultInMp4.isNotEmpty)
                    TextButton(
                      child: Text(
                        isDownloadingMp4
                            ? 'Downloading...'
                            : "Download MP4".toUpperCase(),
                        style: TextStyle(fontSize: 14),
                      ),
                      style: ButtonStyle(
                        padding: WidgetStateProperty.all<EdgeInsets>(
                          EdgeInsets.all(15),
                        ),
                        foregroundColor: WidgetStateProperty.all<Color>(
                          Colors.red,
                        ),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                      onPressed: isDownloadingMp3 || isDownloadingMp4
                          ? null
                          : () {
                              downloadVideo(resultInMp4, title, '.mp4');
                            },
                    ),
                ],
              ),
            ),
            SizedBox(height: 10),
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
    );
  }
}
