import 'package:dzemaat/layers/presentation_layer/screens/book_sub_list_screen.dart';
import 'package:dzemaat/layers/presentation_layer/constants/my_decoration.dart';
import 'package:dzemaat/layers/presentation_layer/constants/my_textstyle.dart';
import 'package:dzemaat/layers/presentation_layer/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookMainScreen extends StatelessWidget {
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
        onPressed: () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => HomeScreen(),
          ),
        ),
      ),
      title: Text(
        "Book",
        style: myTextStyle,
      ),
    );
  }

  Widget _buildSingleBookContainer({String bookImage, bookName}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            height: heightStep * 200,
            width: widthStep * 250,
            image: AssetImage("images/$bookImage"),
          ),
          SizedBox(
            height: heightStep * 12,
          ),
          Text(
            bookName,
            style: TextStyle(color: Colors.white, fontSize: 18),
          )
        ],
      ),
    );
  }

  void goToBookSubListScreen(
      {String image, String name, String about, BuildContext context}) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => BookSublistScreen(
          name: name,
          image: image,
          about: about,
        ),
      ),
    );
  }

  static double heightStep, widthStep;

  @override
  Widget build(BuildContext context) {
    widthStep = MediaQuery.of(context).size.width / 1000;
    heightStep = MediaQuery.of(context).size.height / 1000;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildMyAppBar(context),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: myDecoration,
        padding: EdgeInsets.symmetric(
            horizontal: widthStep * 20, vertical: heightStep * 20),
        child: SafeArea(
          child: GridView.count(
            mainAxisSpacing: widthStep * 20,
            childAspectRatio: 0.8,
            crossAxisSpacing: heightStep * 10,
            crossAxisCount: 2,
            children: [
              GestureDetector(
                onTap: () => goToBookSubListScreen(
                  context: context,
                  image: "meembook.jpg",
                  name: "Meem is for Mercy",
                  about: "this is book one",

                ),
                child: _buildSingleBookContainer(
                  bookImage: "meembook.jpg",
                  bookName: "Meem is for Mercy",
                ),
              ),
              GestureDetector(
                onTap: () => goToBookSubListScreen(
                  context: context,
                  image: "missionbook.jpg",
                  name: "Misssion Nizamuddin",
                    about: "this is book two"
                ),
                child: _buildSingleBookContainer(
                  bookImage: "missionbook.jpg",
                  bookName: "Misssion Nizamuddin",

                ),
              ),
              GestureDetector(
                onTap: () => goToBookSubListScreen(
                  context: context,
                  image: "alchemy.png",
                  name: "The Alchemy of Affinity",
                    about: "this is book three"


                ),
                child: _buildSingleBookContainer(
                  bookImage: "alchemy.png",
                  bookName: "The Alchemy of Affinity",

                ),
              ),
              GestureDetector(
                onTap: () => goToBookSubListScreen(
                  context: context,
                  image: "meembook.jpg",
                  name: "Meem is for Mercy",
                    about: "this is book four"

                ),
                child: _buildSingleBookContainer(
                  bookImage: "meembook.jpg",
                  bookName: "Meem is for Mercy",
                ),
              ),
              GestureDetector(
                onTap: () => goToBookSubListScreen(
                  context: context,
                  image: "missionbook.jpg",
                  name: "Misssion Nizamuddin",
                    about: "this is book five"
                ),
                child: _buildSingleBookContainer(
                  bookImage: "missionbook.jpg",
                  bookName: "Misssion Nizamuddin",
                ),
              ),
              GestureDetector(
                onTap: () => goToBookSubListScreen(
                  context: context,
                  image: "alchemy.png",
                  name: "The Alchemy of Affinity",
                    about: "this is book six"
                ),
                child: _buildSingleBookContainer(
                  bookImage: "alchemy.png",
                  bookName: "The Alchemy of Affinity",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
