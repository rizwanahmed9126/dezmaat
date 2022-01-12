
class ChatModel{
  String senderId;
  String senderName;
  String senderStatus; //scholar or common
  String message;
  String time;
  String timeShort;
  int timeEpoch;

  ChatModel({this.timeShort, this.time, this.timeEpoch, this.message,
    this.senderId, this.senderName, this.senderStatus});

}

ChatModel chatModel = ChatModel();