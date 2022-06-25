import 'dart:convert';
List<ReviewResponseModel> reviewResponseModelJson(str) {
  List jsonResponse = json.decode(str);
  return jsonResponse
      .map((data) => ReviewResponseModel.fromJson(data))
      .toList();
}

class ReviewResponseModel {
  ReviewResponseModel({
    this.id,
    this.userId,
    this.rating,
    this.like,
    this.comment,
    this.cafeId,
    this.createdAt,
    this.updatedAt,
  });
  int? id;
  String? userId;
  String? rating;
  String? like;
  String? comment;
  int? cafeId;
  String? createdAt;
  String? updatedAt;

  ReviewResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    rating = json['rating'];
    like = json['like'];
    comment = json['comment'];
    cafeId = json['cafe_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['user_id'] = userId;
    _data['rating'] = rating;
    _data['like'] = like;
    _data['comment'] = comment;
    _data['cafe_id'] = cafeId;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}