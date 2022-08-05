import 'package:http/http.dart' as http;
import 'package:pagination_prac/models/user_data_model/user_data_model.dart';

class UserDataRepo {
  static Future<UserDataModel?> userData(int pageNum) async {
    var baseurl = "https://dummyjson.com/users?page=$pageNum&limit=10";
    final response = await http.get(Uri.parse(baseurl));
    if (response.statusCode == 200) {
      return userDataModelFromJson(response.body);
    }
    return null;
  }
}
