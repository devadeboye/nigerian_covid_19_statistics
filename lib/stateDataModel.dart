class StateDataModel {
  final List<StateModel> states;

  StateDataModel({this.states});

  factory StateDataModel.fromJson(Map<String, dynamic> json) {
    var statesFromJson = json['states'] as List;
    List<StateModel> stateList = statesFromJson.map((i) => StateModel.fromJson(i)).toList();

    return StateDataModel(
      states: stateList,
    );
  }
}


class StateModel {
  final String id;
  final String name;
  final int confirmedCases;
  final int casesOnAdmission;
  final int discharged;
  final int death;

  StateModel({this.discharged, this.death, this.casesOnAdmission, this.name, this.id, this.confirmedCases});

  factory StateModel.fromJson(Map<String, dynamic> json) {
    return StateModel(
      discharged: json['discharged'],
      death: json['death'],
      casesOnAdmission: json['casesOnAdmission'],
      name: json['state'],
      id: json['id'],
      confirmedCases: json['confirmedCases'],
    );
  }
}