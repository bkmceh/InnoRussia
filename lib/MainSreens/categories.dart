class Categories {
  final String currentName;
  final List<dynamic> categoriesList;

  Categories(this.currentName, this.categoriesList);

  Categories.fromMappedJson(Map<String, dynamic> json)
      : currentName = json['currentName'] ?? 'NAME',
        categoriesList = json['categories'] ?? 'FILE';

  Map<String, dynamic> toJson() => {
        'name': currentName,
        'categories': categoriesList,
      };
}
