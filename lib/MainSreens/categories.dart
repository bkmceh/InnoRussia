class Categories {
  final int id;
  final String name;
  final String file;

  Categories(this.id, this.name, this.file);

  Categories.fromMappedJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        name = json['name'] ?? 'NAME',
        file = json['file'] ?? 'FILE';


  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'name': name,
        'file': file,
      };
}


class CategoriesList {
  List<Categories> categories;

  CategoriesList(this.categories);

  CategoriesList.fromMappedJson(List<dynamic> json) {

    categories = json.map((category) => Categories.fromMappedJson(category)).toList();
  }
}
