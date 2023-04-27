class PlaceVisitResponse {
  int? checkInId;
  String? placeId;
  String? checkInTime;
  String? checkOutTime;
  int? checkStatus;

  PlaceVisitResponse(
      {this.checkInId,
      this.placeId,
      this.checkInTime,
      this.checkOutTime,
      this.checkStatus});

  PlaceVisitResponse.fromJson(Map<String, dynamic> json) {
    checkInId = json['check_in_id'];
    placeId = json['place_id'];
    checkInTime = json['check_in_time'];
    checkOutTime = json['check_out_time'];
    checkStatus = json['check_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['check_in_id'] = checkInId;
    data['place_id'] = placeId;
    data['check_in_time'] = checkInTime;
    data['check_out_time'] = checkOutTime;
    data['check_status'] = checkStatus;
    return data;
  }
}
