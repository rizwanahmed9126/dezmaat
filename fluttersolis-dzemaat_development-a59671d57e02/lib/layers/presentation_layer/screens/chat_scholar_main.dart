import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dzemaat/layers/data_layer/data_providers/contants.dart';
import 'package:dzemaat/layers/presentation_layer/constants/my_decoration.dart';
import 'package:dzemaat/layers/presentation_layer/constants/my_textstyle.dart';
import 'package:dzemaat/layers/presentation_layer/screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'chat_room.dart';

class ScholarMainScreen extends StatelessWidget {
  static double heightStep, widthStep;
  Widget _buildMyAppBar(context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      bottom: TabBar(
        labelColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorWeight: widthStep * 10,
        labelStyle: TextStyle(
          fontSize: widthStep * 50,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: widthStep * 40,
          fontWeight: FontWeight.bold,
        ),
        indicatorColor: Theme.of(context).primaryColor,
        unselectedLabelColor: Colors.black,
        tabs: [
          Text("Chats"),
          Text("Scholars"),
        ],
      ),
      iconTheme: IconThemeData(color: Colors.white),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (ctx) => HomeScreen(),
            ),
          );
        },
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      ],
      title: Text(
        "Chat With Scholars",
        style: myTextStyle,
      ),
    );
  }

  Widget _buildSingleMenChat({
    context,
    String name,
    String image,
  }) {
    return Container(
      height: heightStep * 100,
      width: double.infinity,
      color: Colors.white24,
      child: Center(
        child: ListTile(
          leading: CircleAvatar(
            maxRadius: heightStep * 35,
            backgroundImage: AssetImage(
              "images/$image.jpg",
            ),
          ),
          title: Text(
            name,
            style: myTextStyle,
          ),
        ),
      ),
    );
  }

  Widget _buildSingleMessage({
    context,
    String name,
    String message,
    String image,
    String messageCount,
    bool isMessageCount,
  }) {
    return Container(
      height: heightStep * 100,
      width: double.infinity,
      color: Colors.white24,
      child: Center(
        child: ListTile(
          leading: CircleAvatar(
            maxRadius: heightStep * 35,
            backgroundImage: AssetImage(
              "images/$image.jpg",
            ),
          ),
          title: Text(
            name,
            style: myTextStyle,
          ),
          subtitle: Text(
            message,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: isMessageCount == false
              ? CircleAvatar(
                  maxRadius: heightStep * 15,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Text(
                    messageCount,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : Text(""),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    widthStep = MediaQuery.of(context).size.width / 1000;
    heightStep = MediaQuery.of(context).size.height / 1000;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: _buildMyAppBar(context),
        body: Container(
          height: double.infinity,
          decoration: myDecoration,
          width: double.infinity,
          child: SafeArea(
            child: TabBarView(
              children: [
                Container(
                  height: double.infinity,
                  padding: EdgeInsets.only(
                    top: heightStep * 20,
                  ),
                  width: double.infinity,
                  child: StreamBuilder<QuerySnapshot>(
                    //refine this to users chats
                      stream: db.collection('scholars').snapshots(),
                      builder: (context, snapshot) {
                        return snapshot.hasData?ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: (){
                                //navigate to chat screen with this scholar ID
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ctx) => ChatRoomPage(snapshot.data.docs[index].id),
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  _buildSingleMessage(
                                    name: "Khasrow Bagheri",
                                    messageCount: "2",
                                    message: "That's Good My Son!",
                                    isMessageCount: false,
                                    image: "muslammen",
                                    context: context,
                                  ),
                                  SizedBox(
                                    height: heightStep * 15,
                                  ),
                                ],
                              ),
                            );
                          },
                        ):Container();
                      }
                  )
                ),
                Container(
                  height: double.infinity,
                  padding: EdgeInsets.only(
                    top: heightStep * 20,
                  ),
                  width: double.infinity,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: db.collection('scholars').snapshots(),
                    builder: (context, snapshot) {
                      return snapshot.hasData?ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: (){
                              //navigate to chat screen with this scholar ID
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => ChatRoomPage(snapshot.data.docs[index].id),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                _buildSingleMenChat(
                                  context: context,
                                  image: 'men',
                                  name: snapshot.data.docs[index].data()['scholarName'],
                                ),
                                SizedBox(
                                  height: heightStep * 15,
                                ),
                              ],
                            ),
                          );
                        },
                      ):Container();
                    }
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
