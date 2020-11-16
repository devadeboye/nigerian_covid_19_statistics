import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {

    var _goButton = Expanded(
      flex: 1,
      child: ElevatedButton(
        onPressed: (){},
        child: Text('Go'),
      ),
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
      itemCount: 36,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 50,
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text('State Name'),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  index.toString(),
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
                )
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
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text('Total number of cases'),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                'value',
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text('Total number of cases'),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                'value',
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text('Total number of cases'),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                'value',
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text('Total number of cases'),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                'value',
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
      itemCount: 36,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 50,
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text('State Name'),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  index.toString(),
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
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(''), //TODO: replace with the result of the query above
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
