class Messages {
  String? userName;
  String? userImage;
  String? message;
  dynamic record;
  dynamic image;
  String? date;

  Messages(
      {this.userName,
      this.userImage,
      this.message,
      this.record,
      this.image,
      this.date});

  Messages.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    userImage = json['user_image'];
    message = json['message'];
    record = json['record'];
    image = json['image'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_name'] = this.userName;
    data['user_image'] = this.userImage;
    data['message'] = this.message;
    data['record'] = this.record;
    data['image'] = this.image;
    data['date'] = this.date;
    return data;
  }
}
