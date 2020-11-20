import 'dart:core';

import 'package:flutter/material.dart';
import 'package:untitled/stateDataModel.dart';
import 'nationalSummaryModel.dart';
import 'services.dart';
import 'stateDropdownItems.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nigerian Covid19 Statistics',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Nigerian Covid19 Statistics'),
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  String _userInputValue;
  Future<NationalSummaryModel> _nationalSummary;
  Future<StateDataModel> _nationalDetails;
  List<StateModel> _allStateData;
  StateModel _selectedState;

  @override
  void initState() {
    super.initState();
    _nationalSummary = fetchNationalSummaryData();
    _nationalDetails = fetchNationalDetailsData();
  }

  @override
  Widget build(BuildContext context) {

    var _goButton = Expanded(
      flex: 1,
      child: ElevatedButton(
        onPressed: (){
          for (StateModel state in _allStateData) {
            if (state.name == _userInputValue) {
              setState(() {
                _selectedState = state;
              });
            }
          }
        },
        child: Text('Go'),
      ),
    );

    var emptyText = Container(
        child: Text(''),
      );

    var _singleStateStatisticsResult = Expanded(
        child: _selectedState == null ? emptyText : ListView(
          padding: const EdgeInsets.all(1.0),
          children: [
            Container(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text('State'),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      '${_selectedState.name}',
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text('Confirmed Cases'),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      '${_selectedState.confirmedCases}',
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text('Cases On Admission'),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      '${_selectedState.casesOnAdmission}',
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text('Discharged'),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      '${_selectedState.discharged}',
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text('Death'),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      '${_selectedState.death}',
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            )
          ],
        )
    );

    var _stateDropDownList = Expanded(
      flex: 5,
      child: DropdownButton<String>(
        items: createStateDropdownItems(),
        hint: Text(
            "select a state",
        ),
        onChanged: (value){
          setState(() {
            _userInputValue = value;
          });
        },
        value: _userInputValue,
        isExpanded: true,
      ),
    );
    
    var _newCasesList = FutureBuilder<StateDataModel>(
      future: _nationalDetails,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            padding: const EdgeInsets.all(1.0),
            itemCount: snapshot.data.states.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(_allStateData[index].name),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "${_allStateData[index].confirmedCases}", // TODO: replace with newcases
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Expanded(
            child: Center(
              child: Text("Unable to fetch data"),
            ),
          );
        }
        return Expanded(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );

    var _newCasesSection = SizedBox.expand(
      child: Card(
        elevation: 2.0,
        margin: const EdgeInsets.all(5.0),
        child: Container(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                    "New Cases",
                    style: Theme.of(context).textTheme.headline5
                ),
              ),

              Expanded(
                child: _newCasesList,
              ),
            ],
          ),
        ),
      ),
    );

    var _highestMortalityList = FutureBuilder<StateDataModel>(
      future: _nationalDetails,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var states = snapshot.data.states;
          // populate the _allStateData variable above
          _allStateData = states;

          List<String> generateMortalityList() {
            List<String> result = [];
            for (var nigerianState in states) {
              result.add("${nigerianState.death} ${nigerianState.name}");
            }
            return result;
          }

          var mortalityList = generateMortalityList();
          mortalityList.sort((a,b) => int.parse(a.split(' ').first).compareTo(int.parse(b.split(' ').first)));

          return Expanded(
              child: ListView(
                padding: const EdgeInsets.all(1.0),
                children: [
                  Container(
                    height: 50,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(mortalityList[36].split(' ').last),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            mortalityList[36].split(' ').first,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    height: 50,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(mortalityList[35].split(' ').last),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            mortalityList[35].split(' ').first,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    height: 50,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(mortalityList[34].split(' ').last),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            mortalityList[34].split(' ').first,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
          );
        } else if (snapshot.hasError) {
          return Expanded(
            child: Center(
              child: Text("Unable to fetch data"),
            ),
          );
        }
        return Expanded(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );

    var _highestMortalitySection = Expanded(
      flex: 2,
      child: SizedBox.expand(
        child: Card(
          elevation: 2.0,
          margin: const EdgeInsets.all(5.0),
          child: Container(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                    "Highest Mortality",
                    style: Theme.of(context).textTheme.headline5
                ),
                _highestMortalityList,
              ],
            ),
          ),
        ),
      )
    );

    var _nationalSummarySection = Expanded(
      flex: 1,
      child: SizedBox.expand(
        child: Card(
          elevation: 2.0,
          margin: const EdgeInsets.all(5.0),
          child: Container(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                      "National Summary",
                      style: Theme.of(context).textTheme.headline5
                  ),
                ),

                Expanded(
                  child: FutureBuilder<NationalSummaryModel>(
                    future: _nationalSummary,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Expanded(
                          child: ListView(
                            children: [
                              Container(
                                height: 50,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text('Total Samples Tested'),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        snapshot.data.totalSamplesTested, //.toString(),
                                        textAlign: TextAlign.end,
                                      )
                                    ),
                                  ],
                                ),
                              ),

                              Container(
                                height: 50,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text('Total Confirmed Cases'),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        snapshot.data.totalConfirmedCases.toString(),
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Container(
                                height: 50,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text('Total Active Cases'),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        snapshot.data.totalActiveCases.toString(),
                                        textAlign: TextAlign.end,
                                      )
                                    )
                                  ],
                                ),
                              ),

                              Container(
                                height: 50,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text('Discharged'),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        snapshot.data.discharged.toString(),
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Container(
                                height: 50,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text('Death'),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        snapshot.data.death.toString(),
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Expanded(
                          child: Center(
                            child: Text(
                                "Unable to fetch data",
                            ),
                          ),
                        );
                      }
                      return Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );

    var _confirmedCasesList = FutureBuilder<StateDataModel>(
      future: _nationalDetails,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            padding: const EdgeInsets.all(1.0),
            itemCount: 37,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(snapshot.data.states.elementAt(index).name),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        snapshot.data.states.elementAt(index).confirmedCases.toString(),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Expanded(
            child: Center(
              child: Text("Unable to fetch data"),
            ),
          );
        }
        return Expanded(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );

    var _confirmedCasesSection = Expanded(
      flex: 1,
      child: SizedBox.expand(
        child: Card(
          elevation: 2.0,
          margin: const EdgeInsets.all(5.0),
          child: Container(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                Text(
                    "Confirmed Cases",
                    style: Theme.of(context).textTheme.headline5
                ),
                Expanded(
                  child: _confirmedCasesList,
                )
              ],
            ),
          )
        ),
      )
    );

    var _statisticsByStateSection = Expanded(
      flex: 3,
      child: SizedBox.expand(
        child: Card(
          elevation: 2.0,
          margin: const EdgeInsets.all(5.0),
          child: Container(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: <Widget>[
                Text(
                    "Statistics By State",
                    style: Theme.of(context).textTheme.headline5
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: <Widget>[
                      _stateDropDownList,
                      _goButton,
                    ],
                  ),
                ),

                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _singleStateStatisticsResult,
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _nationalSummarySection,
                      _confirmedCasesSection,
                    ],
                  )
              ),

              Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _statisticsByStateSection,
                      _highestMortalitySection,
                    ],
                  )
              ),

              Expanded(
                flex: 2,
                child: _newCasesSection,
              )
            ],
          ),
        ),
    );
  }
}
