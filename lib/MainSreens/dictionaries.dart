class Dictionaries {
  final int id;
  final String name;
  final String file;

  Dictionaries(this.id, this.name, this.file);

  Dictionaries.fromMappedJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        name = json['name'] ?? 'NAME',
        file = json['file'] ?? 'FILE';

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'file': file,
      };
}

class DictionariesList {
  List<Dictionaries> dictionaries;

  DictionariesList(this.dictionaries);

  DictionariesList.fromMappedJson(List<dynamic> json) {
    dictionaries = json
        .map((dictionary) => Dictionaries.fromMappedJson(dictionary))
        .toList();
  }
}
