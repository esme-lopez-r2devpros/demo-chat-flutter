class Session {
  String userId;
  List<Resident> residents;
  Resident selectedResident;
  String token;

  Session({this.userId, this.residents, this.selectedResident, this.token});
}

class Resident {
  String userId;
  String nickName;
  String imageUrl;

  Resident({
    this.userId,
    this.nickName,
    this.imageUrl,
  });
}
