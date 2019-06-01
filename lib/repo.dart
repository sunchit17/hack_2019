class Repo {
  final String htmlUrl;
  final int watchersCount;
  final String language;
  final String description;
  final String name;
  final String owner;
  final String avatarUrl;

  Repo(this.htmlUrl, this.watchersCount, this.language, this.description,
      this.name, this.owner, this.avatarUrl);

  static List<Repo> mapJSONStringToList(List<dynamic> jsonList) {
    return jsonList
        .map((r) => Repo(
              r['html_url'],
              r['watchers_count'],
              r['language'],
              r['description'],
              r['name'],
              r['owner']['login'],
              r['owner']['avatar_url'],
            ))
        .toList();
  }
}
