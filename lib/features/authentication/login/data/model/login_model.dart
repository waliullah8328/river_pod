
class LoginModel {
  bool? success;
  String? message;
  Data? data;

  LoginModel({
    this.success,
    this.message,
    this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
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
  String? accessToken;
  String? email;
  String? name;
  String? id;
  dynamic image;
  String? role;
  String? status;
  dynamic fcmToken;

  Data({
    this.accessToken,
    this.email,
    this.name,
    this.id,
    this.image,
    this.role,
    this.status,
    this.fcmToken,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    accessToken: json["accessToken"],
    email: json["email"],
    name: json["name"],
    id: json["id"],
    image: json["image"],
    role: json["role"],
    status: json["status"],
    fcmToken: json["fcmToken"],
  );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "email": email,
    "name": name,
    "id": id,
    "image": image,
    "role": role,
    "status": status,
    "fcmToken": fcmToken,
  };
}
