import 'package:chat_stream/utils/resident.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Session {
  static String userId;
  static String nickname;
  static String token;
  static List<Resident> residents;
  static Resident selectedResident;

  static Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userId', userId);
    prefs.setString('nickname', nickname);
    prefs.setString('token', token);

    if (residents == null || residents.isEmpty) {
      prefs.remove('residents');
    } else {
      prefs.setString('residents', Resident.encodeResidents(residents));
    }

    if (selectedResident == null) {
      prefs.remove('selectedResident');
    } else {
      List<Resident> list = List();
      list.add(selectedResident);
      prefs.setString('selectedResident', Resident.encodeResidents(list));
    }
  }

  static Future<bool> restoreData() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId') ?? "";
    nickname = prefs.getString('nickname') ?? "";
    token = prefs.getString('token') ?? "";
    residents = prefs.getString('residents') != null
        ? Resident.decodeResidents(prefs.getString('residents'))
        : null;

    if (prefs.getString('selectedResident') != null) {
      String sResident = prefs.getString('selectedResident');
      final decodedResident = Resident.decodeResidents(sResident);
      selectedResident = decodedResident.first;
    }

    return (token.isNotEmpty);
  }

  static Future<void> endSession() async {
    userId = "";
    nickname = "";
    token = "";
    residents = List();
    selectedResident = null;
    saveData();
  }

}
