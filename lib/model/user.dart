import 'dart:developer' as developer;

class User {
  int id;
  String username;
  String email;
  int kindnessScore;
  int region;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.kindnessScore,
    required this.region,
  });

  getUsername(){
    return username;
  }

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      kindnessScore: json['kindness_score'],
      region: json['region_id']
    );
  }
}