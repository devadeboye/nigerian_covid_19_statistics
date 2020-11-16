class NationalSummaryData {
  final String totalSamplesTested;
  final int totalConfirmedCases;
  final int totalActiveCases;
  final int discharged;
  final int death;

  NationalSummaryData(this.totalSamplesTested, this.totalConfirmedCases, this.totalActiveCases, this.discharged, this.death);

  NationalSummaryData.fromJson(Map<String, dynamic> json)
    : totalSamplesTested = json['totalSamplesTested'],
      totalConfirmedCases = json['totalConfirmedCases'],
      totalActiveCases = json['totalActiveCases'],
      discharged = json['discharged'],
      death = json['death'];
}


class StateData {
  final String state;
  final int confirmedCases;
  final int casesOnAdmission;
  final int discharged;
  final int death;

  StateData(this.state, this.confirmedCases, this.casesOnAdmission, this.discharged, this.death);

  StateData.fromJson(Map<String, dynamic> json)
      : state = json['state'],
        confirmedCases = json['confirmedCases'],
        casesOnAdmission = json['casesOnAdmission'],
        discharged = json['discharged'],
        death = json['death'];
}