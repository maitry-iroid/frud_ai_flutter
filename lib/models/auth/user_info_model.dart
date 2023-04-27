class UserInfoModel {
  String nickname;
  int age;
  int genderId;
  String profession;
  String profileType;
  String latitude;
  String longitude;
  String? document;

  UserInfoModel({
    required this.nickname,
    required this.age,
    required this.genderId,
    required this.profession,
    required this.profileType,
    required this.latitude,
    required this.longitude,
    required this.document,
  });

  @override
  String toString() {
    return '{nickname: $nickname, age: $age, gender_id: $genderId, profession: $profession, profile_type: $profileType, latitude: $latitude, longitude: $longitude, document: $document}';
  }
}
