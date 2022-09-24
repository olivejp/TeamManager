import 'package:team_manager/openapi/api.dart';

class UserConnectedService {
  TeammateDto? user;

  setUser(TeammateDto? user) {
    this.user = user;
  }

  TeammateDto? getUser() {
    return user;
  }
}
