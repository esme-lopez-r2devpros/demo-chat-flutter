class  Sesion{
  Sesion({
    this.userId,
    this.FirstName,
    this.LastName,
    this.Residents,
    this.SelectedResident
});

  String userId;
  String FirstName;
  String LastName;
  List<Resident> Residents;
  Resident SelectedResident;
}

class Resident{
  String UserId;
  String NickName;

  Resident({
    this.UserId,
    this.NickName
  });


}