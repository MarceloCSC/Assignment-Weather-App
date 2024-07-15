class AuthTokens {
  String token;
  String refreshToken;

  AuthTokens({required this.token, required this.refreshToken});

  factory AuthTokens.fromJson(Map<String, dynamic> json) =>
      AuthTokens(token: json['token'], refreshToken: json['refreshToken']);

  Map<String, dynamic> toJson() => {
        'token': token,
        'refreshToken': refreshToken,
      };
}
