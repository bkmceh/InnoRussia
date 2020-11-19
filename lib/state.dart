class StateData {
  int status;
  String access_token;

  // StateData(this.status, this.access_token);

  StateData() {}


  StateData.fromMappedJson(Map<String, dynamic> json) :
        status = json['status'],
        access_token = json['access_token'] ?? '';


  Map<String, dynamic> toJson() =>
      {
        'status': status,
        'access_token': access_token,
      };
}