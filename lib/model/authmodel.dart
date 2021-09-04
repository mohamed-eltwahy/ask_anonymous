class User {
  String token ;
  int id ;
  String name ;
  String email ;
  String image ;
  String link ;
  int active ;

  User(
      { this.token,
       this.id,
       this.name,
       this.email,
       this.image,
       this.link,
       this.active});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
    link = json['link'];
    active = int.tryParse(json['active'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['image'] = this.image;
    data['link'] = this.link;
    data['active'] = this.active;
    return data;
  }
}
