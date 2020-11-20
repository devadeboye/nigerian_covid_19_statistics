class NationalSummaryModel {
  final String totalSamplesTested;
  final int totalConfirmedCases;
  final int totalActiveCases;
  final int discharged;
  final int death;

  NationalSummaryModel({this.totalSamplesTested, this.totalConfirmedCases, this.totalActiveCases, this.discharged, this.death});

  factory NationalSummaryModel.fromJson(Map<String, dynamic> json) {
    return NationalSummaryModel(
        totalSamplesTested: json['totalSamplesTested'],
        totalConfirmedCases: json['totalConfirmedCases'],
        totalActiveCases: json['totalActiveCases'],
        discharged : json['discharged'],
        death: json['death'],
    );
  }
}