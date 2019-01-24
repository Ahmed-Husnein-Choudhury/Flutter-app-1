class CheckInVerificationCodeModel{
  String verificationCode;

  CheckInVerificationCodeModel({this.verificationCode});

  factory CheckInVerificationCodeModel.fromJson(Map<String,dynamic> jsonData){
    return CheckInVerificationCodeModel(
      verificationCode:jsonData["code"]
    );
  }
}