import 'dart:convert';

class Resident {
  String residentId;
  String nickName;
  String imageUrl;
  String token;

  Resident({
    this.residentId, this.nickName, this.imageUrl, this.token
  });

  //From Map to Object
  Resident.fromJsonMap(Map<String, dynamic> json) {
    residentId = json["userId"] ?? "";
    nickName = json["nickName"] ?? "";
    imageUrl = json["imageUrl"] ?? "";
    token = json["token"] ?? "";
  }

  //From Object to Map
  static Map<String, dynamic> toMap(Resident resident) => {
    "userId": resident.residentId,
    "nickName": resident.nickName,
    "imageUrl": resident.imageUrl,
    "token": resident.token,
  };

  //From List<Object> to String
  static String encodeResidents(List<Resident> residents) => json.encode(
    residents
        .map<Map<String, dynamic>>((resident) => Resident.toMap(resident))
        .toList(),
  );

  //From String to List<Object>
  static List<Resident> decodeResidents(String residents) =>
      (json.decode(residents) as List<dynamic>)
          .map<Resident>((item) => Resident.fromJsonMap(item))
          .toList();
}