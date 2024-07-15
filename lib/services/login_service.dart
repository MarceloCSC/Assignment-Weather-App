import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_weather_app/models/login_request.dart';
import 'package:my_weather_app/models/auth_tokens.dart';

class LoginService {
  static Future<bool> login(LoginRequest request) async {
    final Uri uri = Uri.parse('https://dummyjson.com/auth/login');

    final http.Response response = await http.post(
      uri,
      headers: <String, String>{'Content-Type': 'application/json'},
      body: json
          .encode({'username': request.username, 'password': request.password}),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final AuthTokens tokens = AuthTokens.fromJson(json);

      // NOT IMPLEMENTED: Here we would handle encryption and safe storage of tokens

      return true;
    }

    // Maybe we don't want too much information why login has failed.
    // We return false instead and show some default error message in the frontend.
    return false;
  }
}
