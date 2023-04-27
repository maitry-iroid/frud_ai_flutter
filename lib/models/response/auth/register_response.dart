import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class UserResponse {
  RxString? name = ''.obs;
  RxString? nickname = ''.obs;
  RxString? email = ''.obs;
  RxString? countryCode = ''.obs;
  RxInt? contact = 0.obs;
  RxInt? age = 0.obs;
  RxInt? genderId = 0.obs;
  RxString? gender = ''.obs;
  RxString? profile = ''.obs;

  RxString? profileType = ''.obs;
  RxString? document = ''.obs;
  RxString? profession = ''.obs;
  RxBool? verify = false.obs;
  RxBool? isSocial = false.obs;
  RxString? providerType = ''.obs;
  RxString? providerId = ''.obs;
  RxString? latitude = ''.obs;
  RxString? longitude = ''.obs;
  RxString? aboutYou = ''.obs;
  RxString? hometown = ''.obs;
  RxString? schoolName = ''.obs;
  RxInt? graduate = 0.obs;
  RxString? fromYear = ''.obs;
  RxString? toYear = ''.obs;
  RxBool? privacy = false.obs;
  RxList<Photos>? photos = <Photos>[].obs;
  RxList<Photos>? featureList = <Photos>[].obs;
  RxList<Photos>? imageLinkList = <Photos>[].obs;
  RxList<Prompts>? prompts = <Prompts>[].obs;
  Auth? auth;
  UserResponse({
    this.name,
    this.nickname,
    this.email,
    this.countryCode,
    this.contact,
    this.age,
    this.genderId,
    this.gender,
    this.profile,
    this.profileType,
    this.document,
    this.profession,
    this.verify,
    this.isSocial,
    this.providerType,
    this.providerId,
    this.latitude,
    this.longitude,
    this.aboutYou,
    this.hometown,
    this.schoolName,
    this.graduate,
    this.fromYear,
    this.toYear,
    this.privacy,
    this.photos,
    this.prompts,
    this.auth,
  });

  UserResponse.fromJson(Map<String, dynamic> json) {
    name?.value = json['name'] ?? '';
    nickname?.value = json['nickname'] ?? '';
    email?.value = json['email'] ?? '';
    countryCode?.value = json['country_code'] ?? '';
    contact?.value = json['contact'] ?? '';
    age?.value = json['age'] ?? 0;
    genderId?.value = json['gender_id'] ?? 0;
    gender?.value = json['gender'] ?? '';
    profile?.value = json['profile'] ?? '';
    profileType?.value = json['profile_type'] ?? '';
    document?.value = json['document'] ?? '';
    profession?.value = json['profession'] ?? '';
    verify?.value = json['verify'] ?? false;
    isSocial?.value = json['is_social'] ?? false;
    providerType?.value = json['provider_type'] ?? '';
    providerId?.value = json['provider_id'] ?? '';
    latitude?.value = json['latitude'] ?? '';
    longitude?.value = json['longitude'] ?? '';
    aboutYou?.value = json['about_you'] ?? '';
    hometown?.value = json['hometown'] ?? '';
    schoolName?.value = json['school_name'] ?? '';
    graduate?.value = json['graduate'] ?? 0;
    fromYear?.value = json['from_year'] ?? '';
    toYear?.value = json['to_year'] ?? '';
    privacy?.value = json['privacy'] ?? false;
    auth = json['auth'] != null ? Auth.fromJson(json['auth']) : null;
    if (json['photos'] != null) {
      photos?.value = <Photos>[];
      json['photos'].forEach((v) {
        photos!.add(Photos.fromJson(v));
      });
    }
    if (json['prompts'] != null) {
      prompts?.value = <Prompts>[];
      json['prompts'].forEach((v) {
        prompts!.add(Prompts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name?.value;
    data['nickname'] = nickname?.value;
    data['email'] = email?.value;
    data['country_code'] = countryCode?.value;
    data['contact'] = contact?.value;
    data['age'] = age?.value;
    data['gender_id'] = genderId?.value;
    data['gender'] = gender?.value;
    data['profile'] = profile?.value;
    data['profile_type'] = profileType?.value;
    data['document'] = document?.value;
    data['profession'] = profession?.value;
    data['verify'] = verify?.value;
    data['is_social'] = isSocial?.value;
    data['provider_type'] = providerType?.value;
    data['provider_id'] = providerId?.value;
    data['latitude'] = latitude?.value;
    data['longitude'] = longitude?.value;
    data['about_you'] = aboutYou?.value;
    data['hometown'] = hometown?.value;
    data['school_name'] = schoolName?.value;
    data['graduate'] = graduate?.value;
    data['from_year'] = fromYear?.value;
    data['to_year'] = toYear?.value;
    data['privacy'] = privacy?.value;
    if (auth != null) {
      data['auth'] = auth!.toJson();
    }
    if (photos != null) {
      data['photos'] = photos!.map((v) => v.toJson()).toList();
    }
    if (prompts != null) {
      data['prompts'] = prompts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Photos {
  int? photoId;
  RxString? image = ''.obs;
  RxString? type = ''.obs;

  Photos({this.photoId, this.image, this.type});

  Photos.fromJson(Map<String, dynamic> json) {
    photoId = json['photo_id'];
    image?.value = json['image'] ?? '';
    type?.value = json['type'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['photo_id'] = photoId;
    data['image'] = image?.value;
    data['type'] = type?.value;
    return data;
  }
}

class Prompts {
  int? questionId;
  RxString? question = ''.obs;
  RxString? answer = ''.obs;
  TextEditingController answerController = TextEditingController();
  var selected = true.obs;
  Prompts({this.questionId, this.question, this.answer});

  Prompts.fromJson(Map<String, dynamic> json) {
    questionId = json['question_id'];
    question?.value = json['question'] ?? '';
    answer?.value = json['answer'] ?? '';
    selected.value = json['answer'] != null ? true : false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question_id'] = questionId;
    data['question'] = question?.value;
    data['answer'] = answer?.value;
    return data;
  }
}

class Auth {
  String? tokenType;
  int? expiresIn;
  String? accessToken;
  String? refreshToken;

  Auth({this.tokenType, this.expiresIn, this.accessToken, this.refreshToken});

  Auth.fromJson(Map<String, dynamic> json) {
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token_type'] = tokenType;
    data['expires_in'] = expiresIn;
    data['access_token'] = accessToken;
    data['refresh_token'] = refreshToken;
    return data;
  }
}
