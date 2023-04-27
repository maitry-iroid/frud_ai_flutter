class OnlineUserResponse {
  String? placeId;
  int? online;

  OnlineUserResponse({this.placeId, this.online});

  OnlineUserResponse.fromJson(Map<String, dynamic> json) {
    placeId = json['place_id'];
    online = json['online'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['place_id'] = placeId;
    data['online'] = online;
    return data;
  }
}
