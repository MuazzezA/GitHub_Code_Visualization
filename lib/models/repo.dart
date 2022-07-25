class Repo {
  // bir repoya karşılık
  String? name; //repo name
  String? html_url;
  String? description;

  Repo({
    this.name,
    this.html_url,
    this.description,
  });

  factory Repo.fromJson(Map<String, dynamic> json) {
    return Repo(
      name: json['name'],
      html_url: json['html_url'],
      //stargazerCount: json['stargazerCount'],
      description: json['description'],
    );
  }
}
