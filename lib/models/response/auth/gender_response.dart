import 'package:get/get.dart';

// class GenderResponse {
//   List<Data>? data;

//   GenderResponse({this.data});

//   GenderResponse.fromJson(Map<String, dynamic> json) {
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(Data.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

class GenderResponse {
  int? genderId;
  String? name;
  RxBool selected = false.obs;

  GenderResponse({this.genderId, this.name});

  GenderResponse.fromJson(Map<String, dynamic> json) {
    genderId = json['gender_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gender_id'] = genderId;
    data['name'] = name;
    return data;
  }

  @override
  String toString() {
    return '{gender_id: $genderId, nickname: $name}';
  }
}
