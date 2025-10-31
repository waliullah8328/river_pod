import 'dart:convert';

GetMyProfileModel getMyProfileModelFromJson(String str) => GetMyProfileModel.fromJson(json.decode(str));

String getMyProfileModelToJson(GetMyProfileModel data) => json.encode(data.toJson());

class GetMyProfileModel {
  bool? success;
  String? message;
  Data? data;

  GetMyProfileModel({
    this.success,
    this.message,
    this.data,
  });

  factory GetMyProfileModel.fromJson(Map<String, dynamic> json) => GetMyProfileModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  String? id;
  String? email;
  String? name;
  String? role;
  String? status;
  dynamic fcmToken;
  dynamic image;
  List<dynamic>? tradeImage;
  dynamic availability;
  List<dynamic>? profession;
  double? latitude;
  double? longitude;
  String? location;
  String? about;
  String? customerId;
  dynamic connectAccountId;
  List<dynamic>? portfolio;
  bool? isVerified;
  dynamic subscriptionPlan;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic averageRating;
  int? ratingCount;
  int? completedServices;

  Data({
    this.id,
    this.email,
    this.name,
    this.role,
    this.status,
    this.fcmToken,
    this.image,
    this.tradeImage,
    this.availability,
    this.profession,
    this.latitude,
    this.longitude,
    this.location,
    this.about,
    this.customerId,
    this.connectAccountId,
    this.portfolio,
    this.isVerified,
    this.subscriptionPlan,
    this.createdAt,
    this.updatedAt,
    this.averageRating,
    this.ratingCount,
    this.completedServices,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    email: json["email"],
    name: json["name"],
    role: json["role"],
    status: json["status"],
    fcmToken: json["fcmToken"],
    image: json["image"],
    tradeImage: json["tradeImage"] == null ? [] : List<dynamic>.from(json["tradeImage"]!.map((x) => x)),
    availability: json["availability"],
    profession: json["profession"] == null ? [] : List<dynamic>.from(json["profession"]!.map((x) => x)),
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    location: json["location"],
    about: json["about"],
    customerId: json["customerId"],
    connectAccountId: json["connectAccountId"],
    portfolio: json["portfolio"] == null ? [] : List<dynamic>.from(json["portfolio"]!.map((x) => x)),
    isVerified: json["isVerified"],
    subscriptionPlan: json["subscriptionPlan"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    averageRating: json["averageRating"],
    ratingCount: json["ratingCount"],
    completedServices: json["completedServices"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "name": name,
    "role": role,
    "status": status,
    "fcmToken": fcmToken,
    "image": image,
    "tradeImage": tradeImage == null ? [] : List<dynamic>.from(tradeImage!.map((x) => x)),
    "availability": availability,
    "profession": profession == null ? [] : List<dynamic>.from(profession!.map((x) => x)),
    "latitude": latitude,
    "longitude": longitude,
    "location": location,
    "about": about,
    "customerId": customerId,
    "connectAccountId": connectAccountId,
    "portfolio": portfolio == null ? [] : List<dynamic>.from(portfolio!.map((x) => x)),
    "isVerified": isVerified,
    "subscriptionPlan": subscriptionPlan,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "averageRating": averageRating,
    "ratingCount": ratingCount,
    "completedServices": completedServices,
  };
}
