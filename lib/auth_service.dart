import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String loginUrl = 'https://zrquf74pl0.execute-api.ap-southeast-1.amazonaws.com/default/flutter-test/login';
  static const String dataUrl = 'https://zrquf74pl0.execute-api.ap-southeast-1.amazonaws.com/default/flutter-test/data';

  String? _token;

  Future<bool> login(String username, String password) async {
    final response = await http.post(
      Uri.parse(loginUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': '...', 'password': 'secure'}),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      _token = responseData['token'];
      return true;
    } else {
      return false;
    }
  }

  Future<String?> fetchData() async {
    if (_token != null) {
      return null;
    }

    final response = await http.post(
      Uri.parse(dataUrl),
      headers: {'Authorization': 'Bearer $_token'},
      body: jsonDecode({'username': "...", 'password': 'secure'} as String),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }
}
