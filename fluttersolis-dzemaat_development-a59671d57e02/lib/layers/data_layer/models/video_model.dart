
class VideoModel{
  String videoName;
  String videoSize;
  String videoId;
  String videoDuration;
  String videoLink;
  String videoTitle;
  String videoDescription;
  String videoInfo;

  VideoModel({this.videoDescription, this.videoDuration, this.videoId,
  this.videoInfo, this.videoLink, this.videoName, this.videoSize,
    this.videoTitle});
}

VideoModel videoModel = VideoModel();