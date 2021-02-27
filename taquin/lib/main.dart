import 'package:flutter/material.dart';
import 'package:taquin/tiles.dart';
import 'package:taquin/exos/exo_1.dart';
import 'package:taquin/exos/exo_2.dart';
import 'package:taquin/exos/exo_3.dart';
import 'package:taquin/exos/exo_4.dart';
import 'package:taquin/exos/exo_5.dart';
import 'package:taquin/exos/exo_6.dart';

void main() => runApp(MyApp());

int sizeLen = 4;
List<Widget> choices;
List<int> grid_value = List.generate(sizeLen*sizeLen, (i) => i++);
String _title = "Jeu de Taquin";
bool gameStarted = false;
_HomeScreenState homeState;
int indtabBar = 0;
int difficulty = 50;
List<bool> isSelected = [true, false, false];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jeu de Taquin',
      initialRoute: 'Exercice 3',
        routes: {
        '/home': (context) => HomeScreen(),
        'Exercice 1': (context) => Exo1(),
        'Exercice 2': (context) => Exo2(),
        'Exercice 3': (context) => SelectionScreen(),
        'Exercice 4': (context) => Exo4(),
        'Exercice 5a': (context) => Exo5a(),
        'Exercice 5b': (context) => Exo5b(),
        'Exercice 5c': (context) => Exo5c(),
        'Exercice 6a': (context) => Exo6a(),
        'Exercice 6b': (context) => Exo6b(),
        },
      );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key key }) : super(key: key);

  @override
  _HomeScreenState createState() {
    homeState = _HomeScreenState();
    return homeState;
  }
}

class _HomeScreenState extends State<HomeScreen> {
  
  static int _selectedIndexForTabBar = 0;
  static double _currentSliderValue = 4;

  @override
  Widget build(BuildContext context) {
    
    final tabBar = new TabBar(
      indicatorColor: Colors.blue,
      labelColor: Colors.blue,
      onTap: _onItemTappedForTabBar,
      tabs: <Widget>[
        new Tab(
          text: "Numbers",
        ),
        new Tab(
          text: "Image",
        ),
        new Tab(
          text: "Both",
        ),
      ],
    );

    return MaterialApp(
            title: _title,
            theme: ThemeData.dark(),
            home: DefaultTabController(
              length: 3, 
              child: new Scaffold(
                appBar: AppBar( 
                  bottom: tabBar,
                  backgroundColor: Colors.black, 
                  title: Center(child: Text(_title)),
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  )
                ),
                body: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        Gameboard(),
                        Visibility(
                          visible: !gameStarted,
                          child : Row(children: [
                            Text('   Difficulty   :'), 
                            ToggleButtons(children: [
                              SizedBox(
                                  height: 54,
                                  width: MediaQuery.of(context).size.width/4,
                                  child: Container(
                                    margin: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.grey.withOpacity(0.2)
                                    ),
                                  child: Center(child: Text('Easy')),
                                    )
                                ),
                              SizedBox(
                                  height: 54,
                                  width: MediaQuery.of(context).size.width/4,
                                  child: Container(
                                    margin: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.grey.withOpacity(0.2)
                                    ),
                                  child: Center(child: Text('Normal')),
                                    )
                                  ),
                              SizedBox(
                                  height: 54,
                                  width: MediaQuery.of(context).size.width/4,
                                  child: Container(
                                    margin: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.grey.withOpacity(0.2)
                                    ),
                                  child: Center(child: Text('Difficult')),
                                    )
                                ),
                              ],
                              renderBorder: false,
                              onPressed: (int index) {
                                setState(() {
                                  difficulty = (index+1)^2*50;
                                  for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
                                    if (buttonIndex == index) {
                                      isSelected[buttonIndex] = true;
                                    } else {
                                      isSelected[buttonIndex] = false;
                                    }
                                  }
                                });
                              },
                              isSelected: isSelected,
                            ),
                          ])
                        ),
                        Visibility(
                          visible: !gameStarted,
                          child : Row(children: [
                                Text('   Size :'), 
                                Container(width: MediaQuery.of(context).size.width - 50, child: Slider(
                                  value: _currentSliderValue,
                                  min: 3,
                                  max: 9,
                                  divisions: 6,
                                  label: _currentSliderValue.round().toString(),
                                  onChanged: (double value) {
                                    setState(() {
                                      _currentSliderValue = value;
                                      sizeSelection(_currentSliderValue);
                                    });
                                  }
                                )
                                )
                            ],)
                        ),
                        Visibility(
                          visible: gameStarted,
                          child : Padding( 
                            padding: EdgeInsets.only(bottom: 4),
                            child: SizedBox(
                              height: 44,
                              width: double.infinity,
                              child: Container(
                                margin: EdgeInsets.only(bottom: 8, left: 8, right: 8),
                                decoration: BoxDecoration(
                                border: Border.all(color: Colors.white.withOpacity(0.2)),
                                borderRadius: BorderRadius.circular(8)
                                ),
                              child: MaterialButton(
                                child: Text('Change mode'),
                                  color: Colors.grey.withOpacity(0.2),
                                  onPressed: (){
                                    emptyTile = 0;
                                    gameStarted = false;
                                    grid_value = List.generate(sizeLen*sizeLen, (i) => i++);
                                    gameState.setState(() {});
                                    setState(() {});
                                  }
                                )
                              ),
                            )
                          )
                        )
                    ])
                ),
            )
          );
  }

  void sizeSelection(double i){
    sizeLen = i.toInt();
    emptyTile = 0;
    grid_value = List.generate(sizeLen*sizeLen, (i) => i++);
    gameState.setState(() {});
  }

  void _onItemTappedForTabBar(int index) {
    setState(() {
      _selectedIndexForTabBar = index;
      indtabBar = index;
    });
  }
}
