import 'user_model.dart';

class VideoModel {
  String? title;
  String? category;
  String? location;
  UserModel? user;
  String? date;
  String? videoUrl;
  VideoModel.fromMap({required Map<String, dynamic> json}) {
    title = json["title"];
    category = json["category"];
    location = json["location"];
    videoUrl = json["videoUrl"];
    date =
        "${DateTime.parse(json["date"]).difference(DateTime.now()).inDays.toString()} days ago";
    user = UserModel.fromMap(json: json["user"]);
  }
  VideoModel({
    required this.title,
    required this.category,
    required this.location,
    required this.user,
    required this.date,
    required this.videoUrl,
  });
}
