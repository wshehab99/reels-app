class UserModel {
  String? phoneNumber;
  String? imgUrl;
  UserModel.fromMap({required Map<String, dynamic> json}) {
    phoneNumber = json["phoneNumber"];
    imgUrl = json["imgUrl"];
  }
  UserModel({
    required this.phoneNumber,
    required this.imgUrl,
  });
  static UserModel? currentUser;
  static void init(UserModel user) {
    currentUser = user;
  }
}
