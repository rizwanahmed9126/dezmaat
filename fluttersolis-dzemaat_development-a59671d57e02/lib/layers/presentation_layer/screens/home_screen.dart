import 'package:dzemaat/layers/presentation_layer/screens/aamal_main_screen.dart';
import 'package:dzemaat/layers/presentation_layer/screens/book_main_screen.dart';
import 'package:dzemaat/layers/presentation_layer/constants/my_decoration.dart';
import 'package:dzemaat/layers/presentation_layer/constants/my_textstyle.dart';
import 'package:dzemaat/layers/presentation_layer/screens/dua_main_screen.dart';
import 'package:dzemaat/layers/data_layer/models/user_model.dart';
import 'package:dzemaat/layers/presentation_layer/screens/prayer_calendar.dart';
import 'package:dzemaat/layers/presentation_layer/screens/prayertime_screen.dart';
import 'package:dzemaat/layers/presentation_layer/screens/profile_main.dart';
import 'package:dzemaat/layers/presentation_layer/screens/quran_main_screen.dart';
import 'package:dzemaat/layers/presentation_layer/screens/chat_scholar_main.dart';
import 'package:dzemaat/layers/presentation_layer/screens/login_screen.dart';
import 'package:dzemaat/layers/presentation_layer/screens/scholars_list.dart';
import 'package:dzemaat/layers/presentation_layer/widgets/toptitle.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static double widthStep, heightStep;

  bool loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData().then((value){
      if(value!=null)
      setState(() {
        userData = value;
        loading = false;
      });
    });
  }

  void drawerGotoPages({BuildContext context, Widget widget}) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => widget));
  }

  Widget _buildMyAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.white),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: widthStep * 15),
          child: Image(
            height: heightStep * 80,
            width: widthStep * 80,
            image: AssetImage(
              "images/ic_language.png",
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSingleButton({Function onPressed, String image, String name}) {
    return RaisedButton(
      color: Colors.black54,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onPressed: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            height: heightStep * 60,
            image: AssetImage("images/$image.png"),
          ),
          SizedBox(
            height: heightStep * 15,
          ),
          Text(
            name,
            style: TextStyle(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSingleDrawerTab({Function onTap, String name, String image}) {
    return ListTile(
      onTap: onTap,
      leading: Image(
        height: heightStep * 80,
        width: widthStep * 80,
        image: AssetImage(
          "images/$image.png",
        ),
      ),
      title: Text(
        name,
        style: myTextStyle,
      ),
    );
  }

  Widget _buildMainPartDrawer(context) {
    print(heightStep);
    return Container(
      child: ListView(
        children: [
          _buildSingleDrawerTab(
            image: "ic_home",
            name: "View Profile",
            onTap: () => drawerGotoPages(
              context: context,
              widget: ProfileMainScreen(),
            ),
          ),
          _buildSingleDrawerTab(
            image: "ic_qurans",
            name: "Quran",
            onTap: () => drawerGotoPages(
              context: context,
              widget: QuranMainScreen(),
            ),
          ),
          _buildSingleDrawerTab(
            image: "ic_books",
            onTap: () => drawerGotoPages(
              context: context,
              widget: BookMainScreen(),
            ),
            name: "Book",
          ),
          _buildSingleDrawerTab(
            onTap: () => drawerGotoPages(
              context: context,
              widget: ScholarMainScreen(),
            ),
            image: "ic_chat_scholar",
            name: "Chat Scholar",
          ),
          _buildSingleDrawerTab(
            image: "ic_video",
            onTap: () {},
            name: "Video",
          ),
          _buildSingleDrawerTab(
            image: "ic_scholars",
            onTap: () => drawerGotoPages(
              context: context,
              widget: ScholarList(),
            ),
            name: "Scholar",
          ),
          _buildSingleDrawerTab(
            image: "ic_duas",
            onTap: () => drawerGotoPages(
              context: context,
              widget: DuaMainScreen(),
            ),
            name: "Duas",
          ),
          _buildSingleDrawerTab(
            image: "ic_amaals",
            name: "Aamals",
            onTap: () => drawerGotoPages(
              context: context,
              widget: AammalMainScreen(),
            ),
          ),
          _buildSingleDrawerTab(
            image: "ic_prayertime",
            name: "Prayer Time",
            onTap: () => drawerGotoPages(
              context: context,
              widget: PrayerTimeScreen(),
            ),
          ),
          _buildSingleDrawerTab(
            image: "ic_calender",
            name: "Calendar",
            onTap: () => drawerGotoPages(
              context: context,
              widget: PrayerCalendar(),
            ),
          ),
          _buildSingleDrawerTab(
            image: "ic_feedback",
            onTap: () {},
            name: "Feedback",
          ),
          _buildSingleDrawerTab(
            image: "ic_logout",
            onTap: () => drawerGotoPages(
              context: context,
              widget: LoginScreen(),
            ),
            name: "Log Out",
          ),
        ],
      ),
    );
  }

  Widget _buildMorePartDrawer() {
    return Container(
      child: ListView(
        children: [
          _buildSingleDrawerTab(
            image: "ic_setting",
            name: "Settings",
          ),
          _buildSingleDrawerTab(
            image: "ic_menu_rate_us",
            name: "Rating",
          ),
          _buildSingleDrawerTab(
            image: "ic_menu_share_app",
            name: "Share",
          ),
          _buildSingleDrawerTab(
            image: "ic_menu_facebok_menu",
            name: "Like us on Facebook",
          ),
          _buildSingleDrawerTab(
            image: "ic_menu_web",
            name: "Visit Website",
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerTabbar() {
    return Container(
      height: 40,
      color: Colors.transparent,
      child: TabBar(
        labelColor: Colors.white,
        indicatorWeight: widthStep * 7,
        labelStyle: TextStyle(
          fontSize: widthStep * 50,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: widthStep * 40,
          fontWeight: FontWeight.bold,
        ),
        indicatorColor: Colors.green,
        unselectedLabelColor: Colors.black,
        tabs: [
          Tab(
            text: "Main",
          ),
          Tab(
            text: "More",
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader(context) {
    return DrawerHeader(
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //     fit: BoxFit.cover,
      //     colorFilter: ColorFilter.mode(Colors.black12, BlendMode.colorBurn),
      //     image: NetworkImage(userData.userImage),
      //   ),
      // ),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: ListTile(
                leading: CircleAvatar(
                  maxRadius: 30,
                  //backgroundImage: NetworkImage(userData.userImage),
                ),
                // title: Text(
                //  // userData.userName,
                //   style: myTextStyle,
                // ),
                subtitle: GestureDetector(
                  onTap: () => drawerGotoPages(
                    context: context,
                    widget: ProfileMainScreen(),
                  ),
                  child: Text(
                    "View Profile",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: widthStep * 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          _buildDrawerTabbar(),
        ],
      ),
    );
  }

  Widget _buildDrawer(context) {
    return SafeArea(
      child: Drawer(
        child: DefaultTabController(
          length: 2,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: myDecorationMenu,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                _buildDrawerHeader(context),
                Expanded(
                  child: Container(
                    child: TabBarView(
                      children: [
                        _buildMainPartDrawer(context),
                        _buildMorePartDrawer(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomPart({context}) {
    return Expanded(
      child: GridView.count(
        childAspectRatio: heightStep * 1.6,
        crossAxisSpacing: widthStep * 10,
        mainAxisSpacing: heightStep * 20,
        children: [
          _buildSingleButton(
              onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (ctx) => QuranMainScreen(),
                    ),
                  ),
              image: "ic_qurans",
              name: "Quran"),
          _buildSingleButton(
              onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (ctx) => BookMainScreen(),
                    ),
                  ),
              image: "ic_books",
              name: "Books"),
          _buildSingleButton(
              onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (ctx) => ScholarMainScreen(),
                    ),
                  ),
              image: "ic_chat_scholar",
              name: "Chat Scholar"),
          _buildSingleButton(
              onPressed: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => ScholarList(),
                ),
              ),
              image: "ic_scholars", name: "Scholar"),
          _buildSingleButton(
              onPressed: () {}, image: "ic_video", name: "Video"),
          _buildSingleButton(
              onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (ctx) => PrayerCalendar(),
                    ),
                  ),
              image: "ic_calender",
              name: "Calendar"),
          _buildSingleButton(
              onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (ctx) => PrayerTimeScreen(),
                    ),
                  ),
              image: "ic_prayertime",
              name: "PrayerTime"),
          _buildSingleButton(
              onPressed: () => drawerGotoPages(
                    context: context,
                    widget: DuaMainScreen(),
                  ),
              image: "ic_duas",
              name: "Dua"),
          _buildSingleButton(
              onPressed: () => drawerGotoPages(
                    context: context,
                    widget: AammalMainScreen(),
                  ),
              image: "ic_amaals",
              name: "Aamal"),
        ],
        crossAxisCount: 3,
      ),
    );
  }

  Widget _buildMainBody(context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: myDecoration,
      padding: EdgeInsets.symmetric(
        horizontal: widthStep * 20,
      ),
      child: Column(
        children: [
          TopTitle(
            onlyTopText: true,
            heightStep: heightStep,
            widthStep: widthStep,
          ),
          _buildBottomPart(context: context),
        ],
      ),
    );
  }

  bool isUserDrawer = false;
  @override
  Widget build(BuildContext context) {
    widthStep = MediaQuery.of(context).size.width / 1000;
    heightStep = MediaQuery.of(context).size.height / 1000;
    getFontSize(getTextFontSize: widthStep * 50);
    return //loading?Center(child: CircularProgressIndicator(),):
      Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: _buildMyAppBar(),
      drawer: _buildDrawer(context),

      body:
      _buildMainBody(context),
    );
  }
}
