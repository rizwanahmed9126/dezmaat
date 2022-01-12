import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dzemaat/layers/presentation_layer/constants/my_decoration.dart';
import 'package:dzemaat/layers/presentation_layer/constants/my_textstyle.dart';
import 'package:dzemaat/layers/presentation_layer/constants/media_query.dart';
import 'package:dzemaat/layers/data_layer/models/user_model.dart';
import 'package:dzemaat/layers/presentation_layer/screens/home_screen.dart';
import 'package:dzemaat/layers/presentation_layer/widgets/mybutton.dart';
import 'package:dzemaat/layers/presentation_layer/widgets/mytextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileMainScreen extends StatefulWidget {
  @override
  _ProfileMainScreenState createState() => _ProfileMainScreenState();
}

class _ProfileMainScreenState extends State<ProfileMainScreen> {
  static String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  File pickedImage;

  PickedFile _image;
  Future<void> getImage({ImageSource source}) async {
    _image = await ImagePicker().getImage(source: source);
    if (_image != null) {
      setState(() {
        pickedImage = File(_image.path);
      });
    }
  }

  User user;

  Future<String> _uploadImage({File image}) async {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child("UserImage/${user.uid}");
    StorageUploadTask uploadTask = storageReference.putFile(image);
    StorageTaskSnapshot snapshot = await uploadTask.onComplete;
    String imageUrl = await snapshot.ref.getDownloadURL();
    return imageUrl;
  }

  bool isEdit = false;
  void userDetailUpdate() async {
    setState(() {
      isEdit = true;
    });
    String imageUrl = pickedImage == null
        ? await _uploadImage(image: pickedImage)
        : userData.userName;

    FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).update({
      'userName': userName.text,
      'email': email.text,
      'userImage': imageUrl,
    });

    setState(() {
      isEdit = false;
    });
  }

  RegExp regExp = new RegExp(p);
  final TextEditingController email = TextEditingController();
  final TextEditingController userName = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> myDialogBox(context) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  ListTile(
                    leading: Icon(Icons.camera_alt),
                    title: Text("Pick Form Camera"),
                    onTap: () {
                      getImage(source: ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text("Pick Form Gallery"),
                    onTap: () {
                      getImage(source: ImageSource.gallery);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void vaildation() async {
    if (email.text.isEmpty && userName.text.isEmpty) {
      FirebaseAuth.instance.signOut();
      scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Both Flied Are Empty"),
        ),
      );
    } else if (userName.text.isEmpty) {
      scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Password Is Empty"),
        ),
      );
    } else if (email.text.isEmpty) {
      scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Email Is Empty"),
        ),
      );
    } else if (!regExp.hasMatch(email.text)) {
      scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Please Try Vaild Email"),
        ),
      );
    } else if (userName.text.isEmpty) {
      scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Password Is Empty"),
        ),
      );
    } else {
      userDetailUpdate();
    }
  }

  Widget _buildMyAppBar(context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
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
      iconTheme: IconThemeData(color: Colors.white),
      title: Text(
        "Back",
        style: myTextStyle,
      ),
    );
  }

  Widget _buildBottomPart() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                MyTextField(
                  iconData: Icons.person,
                  textName: userData.userName,
                  controller: userName,
                ),
                SizedBox(
                  height: MediaQuerys.heightStep * 15,
                ),
                MyTextField(
                  iconData: Icons.email,
                  controller: email,
                  textName: userData.userEmail,
                ),
                SizedBox(
                  height: MediaQuerys.heightStep * 15,
                ),
              ],
            ),
          ),
          MyButton(
            buttonName: "Update Profile",
            containerHeight: MediaQuerys.heightStep * 65,
            onPressed: () {
              vaildation();
            },
            textFontSize: MediaQuerys.widthStep * 40,
          ),
        ],
      ),
    );
  }

  Widget _buildTopPart() {
    return Container(
      color: Colors.white30,
      width: double.infinity,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuerys.heightStep * 25,
            ),
            CircleAvatar(
              //backgroundImage: NetworkImage(userData.userImage,),
              maxRadius: MediaQuerys.heightStep * 90,
            ),
            SizedBox(
              height: MediaQuerys.heightStep * 15,
            ),
            GestureDetector(
              onTap: () => myDialogBox(context),
              child: Text(
                "Change Profile Photo",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: MediaQuerys.widthStep * 40,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuerys.heightStep * 25,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    user = FirebaseAuth.instance.currentUser;
    MediaQuerys().init(context);
    return Scaffold(
      key:scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: _buildMyAppBar(context),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: myDecoration,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: SafeArea(
            child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection("User").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var myDoc = snapshot.data.docs;
                    myDoc.forEach((checkDocs) {
                      if (checkDocs.data()["UserId"] == user.uid) {
                        userData = UserData(
                          userEmail: checkDocs.data()['email'],
                          userImage: checkDocs.data()['userImage'],
                          userName: checkDocs.data()['userName'],
                        );
                      }
                    });
                    return Container(
                      height: 600,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildTopPart(),
                          _buildBottomPart(),
                        ],
                      ),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
