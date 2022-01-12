
import 'package:dzemaat/layers/data_layer/data_providers/contants.dart';
import 'package:dzemaat/layers/data_layer/data_providers/user_authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserData {
  String userName;
  String userId;
  String userEmail;
  String userImage;
  String userStatus; //scholar or user
  String subscriptionStatus;

  UserData({
    this.userEmail,
    this.userId,
    this.userName,
    this.userImage,
    this.userStatus,
    this.subscriptionStatus,
  });
}

UserData userData = UserData();

Future<UserData> getUserData() async{
  final userValue = await db.collection('users').doc(FirebaseAuth.instance.currentUser.uid).get();
  UserData userData = UserData(
    userEmail: userValue.data()['email'],
    userId: userValue.data()['userId'],
    userStatus: userValue.data()['userStatus'],
    userName: userValue.data()['userName'],
    userImage: userValue.data()['userImage'],
    subscriptionStatus: userValue.data()['subscriptionStatus'],
  );
  return userData;
}
