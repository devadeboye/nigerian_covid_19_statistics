import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:untitled/stateDataModel.dart';
import 'nationalSummaryModel.dart';

String summaryUrl = 'http://localhost:8080/summary'; //'https://nigerian-covid-19-api.herokuapp.com/summary';
String detailsEndpointUrl = 'http://localhost:8080/details'; //'https://nigerian-covid-19-api.herokuapp.com/details';

Future<NationalSummaryModel> fetchNationalSummaryData() async {
  final response = await http.get(summaryUrl);

  if (response.statusCode == 200) {
    return NationalSummaryModel.fromJson(jsonDecode(response.body));
  }else {
    throw Exception('Failed to get data');
  }
}

Future<StateDataModel> fetchNationalDetailsData() async {
  final response = await http.get(detailsEndpointUrl);

  if (response.statusCode == 200) {
    return StateDataModel.fromJson(jsonDecode(response.body));
  }else {
    throw Exception('Failed to get data');
  }
}