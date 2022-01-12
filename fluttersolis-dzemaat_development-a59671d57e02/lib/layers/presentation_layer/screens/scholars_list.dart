import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dzemaat/layers/data_layer/data_providers/contants.dart';
import 'package:dzemaat/layers/presentation_layer/constants/my_decoration.dart';
import 'package:dzemaat/layers/presentation_layer/constants/my_textstyle.dart';
import 'package:dzemaat/layers/presentation_layer/screens/home_screen.dart';
import 'package:flutter/material.dart';

class ScholarList extends StatelessWidget {
  static double heightStep, widthStep;
  Widget _buildMyAppBar(context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
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
        "Scholars",
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
            child: Container(
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
                            //navigate to scholar profile

                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (ctx) => ,
                            //   ),
                            // );
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
            )
          ),
        ),
      ),
    );
  }
}
