class Profil {
  String? id;
  String? location;
  String? description;
  String? name;
  String? email;
  String? password;
  String? type;
  String? language;
  String? token;

  Profil(
      {this.id,
      this.location,
      this.description,
      this.name,
      this.email,
      this.password,
      this.type,
      this.language,
      this.token});

  Profil.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    location = json['location'];
    description = json['description'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    type = json['type'];
    language = json['language'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['location'] = this.location;
    data['description'] = this.description;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['type'] = this.type;
    data['language'] = this.language;
    data['token'] = this.token;
    return data;
  }
}
