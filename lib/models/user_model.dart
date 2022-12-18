class UserModel {
  String? phoneNumber;
  String? imgUrl;
  String? userId;
  UserModel.fromMap({required Map<String, dynamic> json}) {
    phoneNumber = json["phoneNumber"];
    imgUrl = json["userImg"];
    userId = json["userId"];
  }
  UserModel({
    required this.phoneNumber,
    required this.imgUrl,
    required this.userId,
  });
  static UserModel? currentUser;
  static void init(UserModel user) {
    currentUser = user;
  }
}
