
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dzemaat/layers/data_layer/data_providers/contants.dart';
import 'package:dzemaat/layers/data_layer/models/chat_model.dart';
import 'package:dzemaat/layers/data_layer/models/user_model.dart';
import 'package:dzemaat/layers/presentation_layer/widgets/ReusableWidgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class ChatRoomPage extends StatefulWidget {
  String chatRoomId;
  @override
  _ChatRoomPageState createState() => _ChatRoomPageState();
  ChatRoomPage(this.chatRoomId);
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  //change later
  TextEditingController chatController = TextEditingController();
  CollectionReference chatsPath;

  String readTimeStampDateTime (int timestamp){
    var format = DateFormat('dd MMM yyyy, h:mm a');

    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return format.format(date);
  }

  String readTimeStampDateTimeShort (int timestamp){
    var format = DateFormat('h:mm a');

    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return format.format(date);
  }

  String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var format = DateFormat('dd MMM yyyy, h:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes > 0 && diff.inHours == 0 || diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' DAY AGO';
      } else {
        time = diff.inDays.toString() + ' DAYS AGO';
      }
    } else if (diff.inDays >= 7 && diff.inDays < 30){
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
      } else {

        time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
      }
    } else if (diff.inDays >= 30 && diff.inDays < 365){
      if (diff.inDays == 30) {
        time = (diff.inDays / 30).floor().toString() + ' MONTH AGO';
      } else {

        time = (diff.inDays / 30).floor().toString() + ' MONTHS AGO';
      }
    } else {
      if (diff.inDays == 365) {
        time = (diff.inDays / 365).floor().toString() + ' YEAR AGO';
      } else {

        time = (diff.inDays / 365).floor().toString() + ' YEARS AGO';
      }
    }

    return time;
  }


  bool loading = false;

  void initializer(){
    chatsPath = db.collection('messages').doc(widget.chatRoomId).collection('chats');

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializer();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void backButtonPressed(){
  }


  Stream<QuerySnapshot> chatStream(){
    return chatsPath.orderBy('timeEpoch', descending: true).limit(50).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    widthStep = MediaQuery.of(context).size.width / 1000;
    heightStep = MediaQuery.of(context).size.height / 1000;
    return Scaffold(

      body: loading?Center(child: CircularProgressIndicator(),):GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          width: widthStep*1000,
          height: heightStep*1000,
          child: Stack(
            children: <Widget>[
              Container(
                width: widthStep*1000,
                height: heightStep*1000,
                color: Colors.white,
              ),
              //Chats
              Positioned(
                width: widthStep*1000,
                height: heightStep*850,
                bottom: heightStep*100,
                child: Scrollbar(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: widthStep*50,
                    ),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: chatStream(),
                      builder: (context, snapshot) {
                        return snapshot.hasData?ListView.builder(
                          reverse: true,
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            chatData(snapshot, index);
                            return Column(
                              children: <Widget>[
                                PaddingBox(heightValue: 20,),
                                chatModel.senderId == userData.userId?
                                Dismissible(
                                  key: Key(snapshot.data.docs[index].reference.id),
                                  background: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.red.shade800,
                                          borderRadius: BorderRadius.circular(widthStep*50)
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: widthStep*100),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Icon(Icons.delete_sweep, color: Colors.white,),
                                          Icon(Icons.delete_forever, color: Colors.white,),
                                          Icon(Icons.delete_sweep, color: Colors.white,),
                                        ],
                                      )
                                  ),
                                  onDismissed: (direction){
                                    dismissDeleteReference(snapshot,index);
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(),
                                          Container(
                                            width: widthStep*750,
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Material(
                                                color: Color(0xff43494f),
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(widthStep*30),
                                                    topRight: Radius.circular(widthStep*30),
                                                    bottomLeft: Radius.circular(widthStep*30),
                                                    bottomRight: Radius.zero
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: widthStep*30,
                                                    vertical: heightStep*20,
                                                  ),
                                                  child: Text(chatModel.message,
                                                    style: TextStyle(
                                                      fontSize: widthStep * 35,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.white70,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      PaddingBox(heightValue: 5,),

                                      Text(
                                        snapshot.data.docs.length > 1
                                            && index < snapshot.data.docs.length-1
                                            && chatModel.senderId == snapshot.data.docs[index+1].data()['senderId']?
                                        chatModel.timeShort: chatModel.time,
                                        style: TextStyle(
                                          fontSize: widthStep * 25,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                    :
                                snapshot.data.docs.length > 1
                                    && index < snapshot.data.docs.length-1
                                    && chatModel.senderId == snapshot.data.docs[index+1].data()['senderId']?
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          width: widthStep*650,
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Material(
                                              color: Color(0xffF0F0F0),
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.zero,
                                                  topRight: Radius.circular(widthStep*60),
                                                  bottomLeft: Radius.circular(widthStep*30),
                                                  bottomRight: Radius.circular(widthStep*60)
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(vertical: heightStep*20, horizontal: widthStep*30),
                                                child: Text(chatModel.message,
                                                  style: TextStyle(
                                                    fontSize: widthStep * 35,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black54,
                                                  ),),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(chatModel.time,
                                          style: TextStyle(
                                            fontSize: widthStep * 25,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black38,
                                          ),),
                                      ],
                                    ),

                                  ],
                                ):
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[

                                    Container(
                                      color: Colors.transparent,
                                      child: Row(
                                        children: <Widget>[

                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(chatModel.senderName,
                                                style: TextStyle(
                                                  fontSize: widthStep * 35,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black87,
                                                ),),
                                              PaddingBox(heightValue: 5,),
                                              Text(chatModel.time,
                                                style: TextStyle(
                                                  fontSize: widthStep * 25,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black38,
                                                ),),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: widthStep*750,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Material(
                                          color: Color(0xffF0F0F0),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.zero,
                                            topRight: Radius.circular(widthStep*60),
                                            bottomLeft: Radius.circular(widthStep*30),
                                            bottomRight: Radius.circular(widthStep*60)
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(vertical: heightStep*20, horizontal: widthStep*30),
                                            child: Text(chatModel.message,
                                              style: TextStyle(
                                                fontSize: widthStep * 35,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black54,
                                              ),),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                PaddingBox(heightValue: 5,),
                              ],
                            );
                        },

                        )
                            :Container();
                      }
                    ),
                  ),
                ),
              ),

              //Chat field and button
              Positioned(
                bottom: 0,
                child: Material(
                  elevation: 5,
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: widthStep*800,
                        height: heightStep*100,
                        child: TextFormField(
                          controller: chatController,
                          cursorColor: Colors.black,
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.center,
                          autocorrect: false,
                          expands: true,
                          minLines: null,
                          maxLines: null,
                          style: TextStyle(
                            fontSize: widthStep * 40,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                          decoration: InputDecoration(
                            contentPadding:
                            EdgeInsets.symmetric(
                              horizontal: widthStep*30
                            ),
                            border: InputBorder.none,
                            hintText: 'Type something to send...',
                            hintStyle: TextStyle(
                              fontSize: widthStep * 40,
                              fontWeight: FontWeight.w400,
                              color: Colors.black26,                                ),
                          ),
                        ),
                      ),
                      Container(
                        width: widthStep*200,
                        height: heightStep*100,
                        color: Colors.black,
                        child: FlatButton(
                          splashColor: Colors.white24,
                          onPressed: (){
                            sendChatMessage();
                          },
                          child: Container(
                            width: widthStep*90,
                            height: heightStep*60,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('images/chat.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void chatData(AsyncSnapshot<QuerySnapshot> snapshot, int index) {
    chatModel.message = snapshot.data.docs[index].data()['message'];
    chatModel.senderId = snapshot.data.docs[index].data()['senderId'];
    chatModel.time = readTimeStampDateTime(snapshot.data.docs[index].data()['timeEpoch']);
    chatModel.timeShort = readTimeStampDateTimeShort(snapshot.data.docs[index].data()['timeEpoch']);
    chatModel.senderName = snapshot.data.docs[index].data()['senderName'];
    chatModel.senderStatus = snapshot.data.docs[index].data()['senderStatus'];
  }

  void sendChatMessage() {
    chatController.text = chatController.text.trim();
    if(chatController.text.isNotEmpty){
      chatsPath.add({
        'message': chatController.text,
        'senderName': userData.userName,
        'senderId': userData.userId,
        'timeEpoch': DateTime.now().millisecondsSinceEpoch,
        'senderStatus': userData.userStatus
      });

      chatController.text = '';
    }
  }

  void dismissDeleteReference(AsyncSnapshot<QuerySnapshot> snapshot, int index) {
    snapshot.data.docs[index].reference.delete();
  }
}
