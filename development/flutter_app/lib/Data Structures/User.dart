import 'ExtraInfo.dart';

class User {
  String username;
  String phoneNumber;
  String email;
  List<ExtraInfo> extraInfo=[];

  User(){
    this.username = "";
    this.phoneNumber = "";
    this.email = "";
  }

  setUsername(username) {
    this.username = username;
  }

  setPhoneNumber(phoneNumber) {
    this.phoneNumber = phoneNumber;
  }

  setEmail(email) {
    this.email = email;
  }

  setExtraInfo(extraInfo) {
    this.extraInfo = extraInfo;
  }
}