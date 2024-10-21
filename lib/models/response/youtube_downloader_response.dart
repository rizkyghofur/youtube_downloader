class YoutubeDownloaderResponse {
  String? type;
  Download? download;

  YoutubeDownloaderResponse({this.type, this.download});

  YoutubeDownloaderResponse.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    download = json['download'] != null
        ? new Download.fromJson(json['download'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.download != null) {
      data['download'] = this.download!.toJson();
    }
    return data;
  }
}

class Download {
  String? title;
  String? description;
  String? url;
  String? videoId;
  int? seconds;
  String? timestamp;
  int? views;
  String? genre;
  String? uploadDate;
  String? ago;
  String? image;
  String? thumbnail;
  Author? author;
  Dl? dl;

  Download(
      {this.title,
      this.description,
      this.url,
      this.videoId,
      this.seconds,
      this.timestamp,
      this.views,
      this.genre,
      this.uploadDate,
      this.ago,
      this.image,
      this.thumbnail,
      this.author,
      this.dl});

  Download.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    url = json['url'];
    videoId = json['videoId'];
    seconds = json['seconds'];
    timestamp = json['timestamp'];
    views = json['views'];
    genre = json['genre'];
    uploadDate = json['uploadDate'];
    ago = json['ago'];
    image = json['image'];
    thumbnail = json['thumbnail'];
    author =
        json['author'] != null ? new Author.fromJson(json['author']) : null;
    dl = json['dl'] != null ? new Dl.fromJson(json['dl']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['url'] = this.url;
    data['videoId'] = this.videoId;
    data['seconds'] = this.seconds;
    data['timestamp'] = this.timestamp;
    data['views'] = this.views;
    data['genre'] = this.genre;
    data['uploadDate'] = this.uploadDate;
    data['ago'] = this.ago;
    data['image'] = this.image;
    data['thumbnail'] = this.thumbnail;
    if (this.author != null) {
      data['author'] = this.author!.toJson();
    }
    if (this.dl != null) {
      data['dl'] = this.dl!.toJson();
    }
    return data;
  }
}

class Author {
  String? name;
  String? url;

  Author({this.name, this.url});

  Author.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}

class Dl {
  Smp4? smp4;
  Smp3? smp3;

  Dl({this.smp4, this.smp3});

  Dl.fromJson(Map<String, dynamic> json) {
    smp4 = json['mp4'] != null ? new Smp4.fromJson(json['mp4']) : null;
    smp3 = json['mp3'] != null ? new Smp3.fromJson(json['mp3']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.smp4 != null) {
      data['mp4'] = this.smp4!.toJson();
    }
    if (this.smp3 != null) {
      data['mp3'] = this.smp3!.toJson();
    }
    return data;
  }
}

class Smp4 {
  S360p? s360p;
  S360p? s720p;
  S360p? auto;

  Smp4({this.s360p, this.s720p, this.auto});

  Smp4.fromJson(Map<String, dynamic> json) {
    s360p = json['360p'] != null ? new S360p.fromJson(json['360p']) : null;
    s720p = json['720p'] != null ? new S360p.fromJson(json['720p']) : null;
    auto = json['auto'] != null ? new S360p.fromJson(json['auto']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.s360p != null) {
      data['360p'] = this.s360p!.toJson();
    }
    if (this.s720p != null) {
      data['720p'] = this.s720p!.toJson();
    }
    if (this.auto != null) {
      data['auto'] = this.auto!.toJson();
    }
    return data;
  }
}

class S360p {
  String? size;
  String? format;
  String? url;

  S360p({this.size, this.format, this.url});

  S360p.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    format = json['format'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['size'] = this.size;
    data['format'] = this.format;
    data['url'] = this.url;
    return data;
  }
}

class Smp3 {
  S360p? sM4a;
  S360p? s128kbps;

  Smp3({this.sM4a, this.s128kbps});

  Smp3.fromJson(Map<String, dynamic> json) {
    sM4a = json['.m4a'] != null ? new S360p.fromJson(json['.m4a']) : null;
    s128kbps =
        json['128kbps'] != null ? new S360p.fromJson(json['128kbps']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sM4a != null) {
      data['.m4a'] = this.sM4a!.toJson();
    }
    if (this.s128kbps != null) {
      data['128kbps'] = this.s128kbps!.toJson();
    }
    return data;
  }
}
