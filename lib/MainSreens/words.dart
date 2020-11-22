class Words {
  final String currentName;
  final List<dynamic> wordsList;

  Words(this.currentName, this.wordsList);

  Words.fromMappedJson(Map<String, dynamic> json)
      : currentName = json['currentName'] ?? 'NAME',
        wordsList = json['words'] ?? 'FILE';

  Map<String, dynamic> toJson() => {
        'name': currentName,
        'words': wordsList,
      };
}
