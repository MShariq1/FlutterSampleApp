class Login {
  final String id;
  final String emailAddress;
  final String firstName;
  final String lastName;
  final String slug;
  final String code;
  final String number;
  final String imageUrl;
  final String baseUrl;
  final List<dynamic> interestId;
  final String accessToken;
  final String refreshToken;

  const Login({
    required this.id,
    required this.emailAddress,
    required this.firstName,
    required this.lastName,
    required this.slug,
    required this.code,
    required this.number,
    required this.imageUrl,
    required this.baseUrl,
    required this.interestId,
    required this.accessToken,
    required this.refreshToken});


  factory Login.fromJson(Map<String, dynamic> map) {
    return Login(
      id: map['id'] as String,
      emailAddress: map['emailAddress'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      slug: map['slug'] as String,
      code: map['code'] as String,
      number: map['number'] as String,
      imageUrl: map['imageUrl'] as String,
      baseUrl: map['baseUrl'] as String,
      interestId: map['interestId'].map((id) => id).toList(),
      accessToken: map['accessToken'] as String,
      refreshToken: map['refreshToken'] as String,
    );
  }

  @override
  String toString() {
    return 'Login{id: $id, emailAddress: $emailAddress, firstName: $firstName, lastName: $lastName, slug: $slug, code: $code, number: $number, imageUrl: $imageUrl, baseUrl: $baseUrl, interestId: $interestId, accessToken: $accessToken, refreshToken: $refreshToken}';
  }
}