import 'package:shared_preferences/shared_preferences.dart';

Future<String> getUserToken() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getString('USER_TOKEN') ?? '';
}

Future<String> getUserId() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getString('USER_ID') ?? '';
}
// Future<String> getUserId() async {
//   SharedPreferences preferences = await SharedPreferences.getInstance();
//   return preferences.getString('USER_ID') ?? '';
// }
// Future<String> getUserName() async {
//   SharedPreferences preferences = await SharedPreferences.getInstance();
//   return preferences.getString('USER_NAME') ?? 'Guest';
// }
