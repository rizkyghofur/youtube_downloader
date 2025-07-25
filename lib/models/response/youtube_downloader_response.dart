class YoutubeDownloaderResponseModel {
  String? title;
  String? author;
  String? authorUrl;
  int? lengthSeconds;
  int? views;
  String? uploadDate;
  String? thumbnail;
  String? description;
  String? videoUrl;
  String? url;
  String? quality;

  YoutubeDownloaderResponseModel({
    this.title,
    this.author,
    this.authorUrl,
    this.lengthSeconds,
    this.views,
    this.uploadDate,
    this.thumbnail,
    this.description,
    this.videoUrl,
    this.url,
    this.quality,
  });

  YoutubeDownloaderResponseModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    author = json['author'];
    authorUrl = json['authorUrl'];
    lengthSeconds = json['lengthSeconds'];
    views = json['views'];
    uploadDate = json['uploadDate'];
    thumbnail = json['thumbnail'];
    description = json['description'];
    videoUrl = json['videoUrl'];
    url = json['url'];
    quality = json['quality'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['author'] = this.author;
    data['authorUrl'] = this.authorUrl;
    data['lengthSeconds'] = this.lengthSeconds;
    data['views'] = this.views;
    data['uploadDate'] = this.uploadDate;
    data['thumbnail'] = this.thumbnail;
    data['description'] = this.description;
    data['videoUrl'] = this.videoUrl;
    data['url'] = this.url;
    data['quality'] = this.quality;
    return data;
  }
}
