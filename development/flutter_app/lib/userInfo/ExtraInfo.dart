

class ExtraInfo{

  String infoType = '';
  String info = '';

  ExtraInfo(this.infoType,  this.info);

  ExtraInfo.fromExtraInfo(ExtraInfo otherExtraInfo){
    this.infoType = otherExtraInfo.infoType;
    this.info = otherExtraInfo.info ;
  }
}