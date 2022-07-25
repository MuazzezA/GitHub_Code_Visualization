class User {
  String? userName; //name- full name
  String? login; //login- user nick
  String? avatarUrl; //avatar_url
  int? publicRepoCount;

  User({
    this.userName,
    this.login,
    this.avatarUrl,
    this.publicRepoCount,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userName: json['name'],
      login: json['login'],
      avatarUrl: json['avatar_url'], //https://github.com/[USER].png
      publicRepoCount: json['public_repos'],
    );
  }
}
