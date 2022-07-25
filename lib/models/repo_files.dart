class RepoTree {
  String sha;
  String url;
  List<RepoInside> tree;
  bool truncated;

  RepoTree({
    required this.sha,
    required this.url,
    required this.tree,
    required this.truncated,
  });

  factory RepoTree.fromJson(Map<String, dynamic> json) {
    var list = json['tree'] as List;

    List<RepoInside> treeList =
        list.map((i) => RepoInside.fromJson(i)).toList();

    return RepoTree(
      sha: json["sha"] as String,
      url: json["url"] as String,
      tree: treeList,
      truncated: json["truncated"],
    );
  }

  Map<String, dynamic> toJson() => {
        "sha": sha,
        "url": url,
        "tree": List<RepoInside>.from(tree.map((x) => x.toJson())),
        "truncated": truncated,
      };
}

class RepoInside {
  String? path;
  Type? type;
  int? size;

  RepoInside({
    this.path,
    this.type,
    this.size,
  });

  @override
  toString() => 'RepoInside: \npath: $path\ntype: $type\nsize: $size\n\n';

  RepoInside.withoutParameter();

  factory RepoInside.fromJson(Map<String, dynamic> json) {
    return RepoInside(
      path: json["path"],
      type: typeValues.map[json["type"]]!,
      size: json["size"] ?? 0,
    );
  }
  //

  Map<String, dynamic> toJson() => {
        "path": path,
        "type": typeValues.reverse[type],
        "size": size,
      };
}

enum Type { blob, tree }

final typeValues = EnumValues({"blob": Type.blob, "tree": Type.tree});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap = {};

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => MapEntry(v, k));
    }
    return reverseMap;
  }
}
