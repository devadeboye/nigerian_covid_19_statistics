import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'getJsonResources.dart';

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
  String _nigeriaStateName;

  // TODO: remove these later
  String _nationalSummaryJson = '{"totalSamplesTested":"673183","totalConfirmedCases":63328,"totalActiveCases":2498,"discharged":59675,"death":1155}';
  String _stateDataJson = '{"state":"Zamfara","confirmedCases":79,"casesOnAdmission":1,"discharged":73,"death":5}';
  String _fullDetails = '{"Bauchi":{"discharged":708,"death":14,"casesOnAdmission":22,"state":"Bauchi","confirmedCases":744},"Kogi":{"discharged":3,"death":2,"casesOnAdmission":0,"state":"Kogi","confirmedCases":5},"Abia":{"discharged":908,"death":9,"casesOnAdmission":9,"state":"Abia","confirmedCases":926},"Lagos":{"discharged":21019,"death":220,"casesOnAdmission":1165,"state":"Lagos","confirmedCases":22404},"Anambra":{"discharged":265,"death":19,"casesOnAdmission":1,"state":"Anambra","confirmedCases":285},"Edo":{"discharged":2559,"death":112,"casesOnAdmission":14,"state":"Edo","confirmedCases":2685},"Yobe":{"discharged":68,"death":8,"casesOnAdmission":6,"state":"Yobe","confirmedCases":82},"Kano":{"discharged":1690,"death":54,"casesOnAdmission":20,"state":"Kano","confirmedCases":1764},"Bayelsa":{"discharged":382,"death":21,"casesOnAdmission":20,"state":"Bayelsa","confirmedCases":423},"Katsina":{"discharged":929,"death":24,"casesOnAdmission":12,"state":"Katsina","confirmedCases":965},"Zamfara":{"discharged":73,"death":5,"casesOnAdmission":1,"state":"Zamfara","confirmedCases":79},"Taraba":{"discharged":129,"death":6,"casesOnAdmission":20,"state":"Taraba","confirmedCases":155},"AkwaIbom":{"discharged":289,"death":9,"casesOnAdmission":21,"state":"AkwaIbom","confirmedCases":319},"Kwara":{"discharged":1028,"death":27,"casesOnAdmission":29,"state":"Kwara","confirmedCases":1084},"Plateau":{"discharged":3626,"death":33,"casesOnAdmission":60,"state":"Plateau","confirmedCases":3719},"Oyo":{"discharged":3210,"death":45,"casesOnAdmission":362,"state":"Oyo","confirmedCases":3617},"Niger":{"discharged":264,"death":12,"casesOnAdmission":10,"state":"Niger","confirmedCases":286},"Ekiti":{"discharged":326,"death":6,"casesOnAdmission":11,"state":"Ekiti","confirmedCases":343},"Imo":{"discharged":613,"death":12,"casesOnAdmission":23,"state":"Imo","confirmedCases":648},"Benue":{"discharged":460,"death":11,"casesOnAdmission":22,"state":"Benue","confirmedCases":493},"Rivers":{"discharged":2750,"death":59,"casesOnAdmission":105,"state":"Rivers","confirmedCases":2914},"Sokoto":{"discharged":148,"death":17,"casesOnAdmission":0,"state":"Sokoto","confirmedCases":165},"Ondo":{"discharged":1585,"death":39,"casesOnAdmission":96,"state":"Ondo","confirmedCases":1720},"Borno":{"discharged":705,"death":36,"casesOnAdmission":4,"state":"Borno","confirmedCases":745},"Ogun":{"discharged":1980,"death":31,"casesOnAdmission":90,"state":"Ogun","confirmedCases":2101},"Gombe":{"discharged":857,"death":25,"casesOnAdmission":56,"state":"Gombe","confirmedCases":938},"Delta":{"discharged":1737,"death":49,"casesOnAdmission":37,"state":"Delta","confirmedCases":1823},"FCT":{"discharged":5870,"death":82,"casesOnAdmission":420,"state":"FCT","confirmedCases":6372},"Osun":{"discharged":904,"death":20,"casesOnAdmission":16,"state":"Osun","confirmedCases":940},"Enugu":{"discharged":1290,"death":21,"casesOnAdmission":21,"state":"Enugu","confirmedCases":1332},"Kaduna":{"discharged":2646,"death":45,"casesOnAdmission":73,"state":"Kaduna","confirmedCases":2764},"Ebonyi":{"discharged":1019,"death":30,"casesOnAdmission":6,"state":"Ebonyi","confirmedCases":1055},"Nasarawa":{"discharged":325,"death":13,"casesOnAdmission":147,"state":"Nasarawa","confirmedCases":485},"Jigawa":{"discharged":308,"death":11,"casesOnAdmission":6,"state":"Jigawa","confirmedCases":325},"Adamawa":{"discharged":238,"death":19,"casesOnAdmission":4,"state":"Adamawa","confirmedCases":261},"Kebbi":{"discharged":84,"death":8,"casesOnAdmission":1,"state":"Kebbi","confirmedCases":93},"CrossRiver":{"discharged":78,"death":9,"casesOnAdmission":2,"state":"CrossRiver","confirmedCases":89}}';

  @override
  Widget build(BuildContext context) {
    // TODO: remove later
    Map _nationalSummaryMap = jsonDecode(_nationalSummaryJson);
    var _nationalSummary = NationalSummaryData.fromJson(_nationalSummaryMap);
    Map _stateDataMap = jsonDecode(_stateDataJson);
    var _fullDetailsMap = jsonDecode(_fullDetails);
    var _fullDetailsResultKeys = _fullDetailsMap.keys.toList();
    var _sortedFullDetailsResultKeys = new List.from(_fullDetailsResultKeys);
    _sortedFullDetailsResultKeys.sort();

    List<dynamic> generateMortalityDataString(){
      var result = [];
      for (var mortalityKey in _sortedFullDetailsResultKeys) {
        var value = _fullDetailsMap[mortalityKey]['death'];
        result.add("$value $mortalityKey");
      }
      return result;
    }

    var _mortalityListString = generateMortalityDataString();
    _mortalityListString.sort((a,b) => int.parse(a.split(' ').first).compareTo(int.parse(b.split(' ').first)));
    print(_mortalityListString);

    var _stateDataVerbose = {
      'state':'State', 'confirmedCases':'Confirmed Cases',
      'casesOnAdmission':'Cases On Admission', 'discharged':'Discharged',
      'death':'Death'
    };

    var _goButton = Expanded(
      flex: 1,
      child: ElevatedButton(
        onPressed: (){},
        child: Text('Go'),
      ),
    );

    var _singleStateStatisticsResult = Expanded(
        child: ListView.builder(
          padding: const EdgeInsets.all(1.0),
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            String resultKey = _stateDataMap.keys.elementAt(index);
            return Container(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text('${_stateDataVerbose[resultKey]}'),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      '${_stateDataMap[resultKey]}',
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            );
          },
        )
    );

    var _stateDropDownList = Expanded(
      flex: 5,
      child: DropdownButton<String>(
        items: [
          DropdownMenuItem(
            value: "Abia",
            child: Text('Abia'),
          ),
          DropdownMenuItem(
            value: "Adamawa",
            child: Text('Adamawa'),
          )
        ],
        hint: Text(
            "select a state",
        ),
        onChanged: (value){
          setState(() {
            _nigeriaStateName = value;
            //TODO: implement the result fetching logic
          });
        },
        value: _nigeriaStateName,
        isExpanded: true,
      ),
    );
    
    var _newCasesList = ListView.builder(
      padding: const EdgeInsets.all(1.0),
      itemCount: _sortedFullDetailsResultKeys.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 50,
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(_sortedFullDetailsResultKeys[index]),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  index.toString(), // TODO: add the result later
                  textAlign: TextAlign.end,
                ),
              ),
            ],
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

    var _highestMortalityList = Expanded(
      child: ListView(
        padding: const EdgeInsets.all(1.0),
        children: [
          Container(
            height: 50,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(_mortalityListString[36].split(' ').last),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    _mortalityListString[36].split(' ').first,
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
                  child: Text(_mortalityListString[35].split(' ').last),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    _mortalityListString[35].split(' ').first,
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
                  child: Text(_mortalityListString[34].split(' ').last),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    _mortalityListString[34].split(' ').first,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
        ],
      )
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
                                _nationalSummary.totalSamplesTested.toString(),
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
                              child: Text('Total Confirmed Cases'),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                _nationalSummary.totalConfirmedCases.toString(),
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
                                _nationalSummary.totalActiveCases.toString(),
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
                                _nationalSummary.discharged.toString(),
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
                                _nationalSummary.death.toString(),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );

    var _deathPerStateList = ListView.builder(
      padding: const EdgeInsets.all(1.0),
      itemCount: _sortedFullDetailsResultKeys.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 50,
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(_sortedFullDetailsResultKeys[index]),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  _fullDetailsMap[_sortedFullDetailsResultKeys[index]]['death'].toString(),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        );
      },
    );

    var _deathPerStateSection = Expanded(
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
                    "Death Per State",
                    style: Theme.of(context).textTheme.headline5
                ),
                Expanded(
                  child: _deathPerStateList,
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
                      _deathPerStateSection,
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
