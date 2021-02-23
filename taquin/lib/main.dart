import 'package:flutter/material.dart';
import 'package:taquin/tiles.dart';

void main() => runApp(MyApp());

int sizeLen = 4;
List<Widget> choices;
List<int> grid_value = List.generate(sizeLen*sizeLen, (i) => i++);
String _title = "Jeu de Taquin";
bool gameStarted = false;
_HomeScreenState homeState;
int indtabBar = 0;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/home',
      routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/home': (context) => HomeScreen(),
      // When navigating to the "/second" route, build the SecondScreen widget.
      '/game': (context) => Game(),
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
      indicatorColor: Colors.red,
      labelColor: Colors.red,
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
                  title: Center(child: Text(_title))
                ),
                body: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        Gameboard(),
                        Visibility(
                          visible: !gameStarted,
                          child :Column(children: [
                            Text('Slide to choose your size. Current Size : $_currentSliderValue'),
                            Padding( padding: EdgeInsets.only(bottom: 8),
                              child: Slider(
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
                              height: 64,
                              width: double.infinity,
                              child: Container(
                                margin: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                border: Border.all(color: Colors.white.withOpacity(0.2)),
                                borderRadius: BorderRadius.circular(8)
                                ),
                              child: MaterialButton(
                                child: Text('Return to main menu'),
                                  color: Colors.grey.withOpacity(0.2),
                                  onPressed: (){
                                    emptyTile = 0;
                                    gameStarted = false;
                                    grid_value = List.generate(sizeLen*sizeLen, (i) => i++);
                                    gameState.setState(() {});
                                    setState(() {});
                                  }
                                )
                              )
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

class Game extends StatefulWidget {
  const Game({ Key key }) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {

  @override
    void initState() {
        super.initState();
    }

  @override
  Widget build(BuildContext context) {

        return MaterialApp(
            title: _title,
            theme: ThemeData.dark(),
            home: Scaffold(
                appBar: AppBar(title: Center(child: Text(_title))),
                body: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        MaterialButton(
                          child: Text('start'),
                            color: Colors.grey.withOpacity(0.2),
                            onPressed: (){
                          }
                        ),
                        Gameboard(),
                    ]
                ),
            )
        );
    }
}
