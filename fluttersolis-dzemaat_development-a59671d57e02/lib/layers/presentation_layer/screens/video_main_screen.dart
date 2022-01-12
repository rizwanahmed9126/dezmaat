
import 'package:dzemaat/layers/presentation_layer/constants/media_query.dart';
import 'package:dzemaat/layers/presentation_layer/constants/my_decoration.dart';
import 'package:dzemaat/layers/presentation_layer/constants/my_textstyle.dart';
import 'package:dzemaat/layers/presentation_layer/screens/video_player_home.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'home_screen.dart';

class VideoMainScreen extends StatefulWidget {
  @override
  _VideoMainScreenState createState() => _VideoMainScreenState();
}

class _VideoMainScreenState extends State<VideoMainScreen> {

  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }


  Widget _buildMyAppBar(context) {
    return AppBar(
      bottom: TabBar(
        labelColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorWeight: MediaQuerys.widthStep * 10,
        labelStyle: TextStyle(
          fontSize: MediaQuerys.widthStep * 50,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: MediaQuerys.widthStep * 40,
          fontWeight: FontWeight.bold,
        ),
        indicatorColor: Colors.white,
        unselectedLabelColor: Colors.black,
        tabs: [
          Text("Movies"),
          Text("Shot Clips"),
        ],
      ),
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
      title: Text(
        "Video",
        style: myTextStyle,
      ),
    );
  }

  Widget _buildSingleVideo({context, String time, String image}) {
    return Stack(
      children: [
        Container(
          height: MediaQuerys.heightStep * 400,
          width: double.infinity,
          color: Colors.white30,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: VideoPlayer(_controller),
              ),
              Expanded(
                child: Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuerys.widthStep * 20,
                    vertical: MediaQuerys.heightStep * 20,
                  ),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Yes I am Muslim",
                            style: myTextStyle,
                          ),
                          Text(
                            time,
                            style: TextStyle(
                              color: Colors.grey[900],
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: MediaQuerys.heightStep * 50,
          right: MediaQuerys.widthStep * 15,
          child: CircleAvatar(
            maxRadius: MediaQuerys.heightStep * 40,
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(
              Icons.play_arrow,
              size: MediaQuerys.heightStep * 40,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMovieTab(context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildSingleVideo(
                context: context,
                image: 'https://www.youtube.com/watch?v=Nm_DbC9aYBU',
                time: "05:13 Hrs",
              ),
              SizedBox(
                height: MediaQuerys.heightStep * 10,
              ),
              _buildSingleVideo(
                context: context,
                image: 'https://www.youtube.com/watch?v=Nm_DbC9aYBU',
                time: "5:13 Min",
              ),
              SizedBox(
                height: MediaQuerys.heightStep * 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShotClip(context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildSingleVideo(
                context: context,
                image: '',
                time: "5:13 Min",
              ),
              SizedBox(
                height: MediaQuerys.heightStep * 10,
              ),
              _buildSingleVideo(
                context: context,
                image: '',
                time: "05:13 Hrs",
              ),
              SizedBox(
                height: MediaQuerys.heightStep * 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    MediaQuerys().init(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: myDecoration,
          child: SafeArea(
            child: TabBarView(
              children: [
                _buildMovieTab(context),
                _buildShotClip(context),
              ],
            ),
          ),
        ),
        appBar: _buildMyAppBar(context),
      ),
    );
  }
}
