import 'package:flutter/material.dart';
import 'package:taquin/main.dart';
import 'dart:math';

List<Widget> grid;
_GameboardState gameState;
int emptyTile = 0;
List<String> movesDone = [];


class Tile extends StatelessWidget{
  final int value;
  final bool empty;

  Widget build(BuildContext context) {
  return empty ?
  FittedBox(
          fit: BoxFit.fill,
            child: ClipRect(
              child: Container(
                child: Align(
                  alignment: Alignment(coordinatesL(value), coordinatesC(value)),
                    widthFactor: 1/sizeLen,
                    heightFactor: 1/sizeLen,
                    child: Container(color: Colors.black)
                  ),
                ),
              ),
            ):
    FittedBox(
          fit: BoxFit.fill,
            child: ClipRect(
              child: Stack(
                alignment: (indtabBar == 2)? 
                Alignment.topLeft :
                Alignment.center,
                children: [
                  Align(
                    alignment : Alignment(coordinatesL(value), coordinatesC(value)),
                    widthFactor: 1/sizeLen,
                    heightFactor: 1/sizeLen, 
                    child: !(indtabBar == 0) ? 
                        Image.network('https://picsum.photos/512'): 
                        Container(
                          color: (sizeLen%2 == 0)?
                          (colorEven(value))? Colors.blue:Colors.blue[200]:
                          (value%2 == 1)? Colors.blue:Colors.blue[200],
                          height: 512,
                          width: 512,
                        ),
                  ),
                  Visibility(
                      visible: !(indtabBar == 1),
                      child: Text('$value', style: TextStyle(
                        fontSize: (indtabBar == 2)? 
                        1/(3*sizeLen) * MediaQuery.of(context).size.width : 
                        2/(3*sizeLen) * MediaQuery.of(context).size.width,
                        color: Colors.yellowAccent,
                          )
                        )
                  ),
            ])
        ),
    );
  }
  bool colorEven(int i){
    var blackColored = true;
    if (((i~/sizeLen)%2 == 0) && (i%2 == 0)){
      blackColored = false;
    }
    else if (((i~/sizeLen)%2 == 1) && (i%2 == 1)){
      blackColored = false;
    }
    return blackColored;
  }

  double coordinatesL(int i){
    var l = -1+2*(i%sizeLen)/(sizeLen-1);
    return l;
  }

  double coordinatesC(int i){
    var c = 0.0;
    for (var j = 0; j < sizeLen; j++) {
        if ((j*sizeLen <= i) && (i < (j+1)*sizeLen)){
          c = -1+2*(j%sizeLen)/(sizeLen-1);
        }
    }
      return c;
  }

  Tile({this.value, this.empty});
}


class Gameboard extends StatefulWidget {
  const Gameboard({ Key key }) : super(key: key);

  @override
  _GameboardState createState() {
    gameState = _GameboardState();
    return gameState;
  }
}


class _GameboardState extends State<Gameboard> {

  int movedTile;

  List<Widget> gridCreation(){
    grid = [for(var value in grid_value)
            new Tile(value: value, empty: value == 0)];
    return grid;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          child: SizedBox(
            height: MediaQuery.of(context).size.width,
            child: GridView.count(
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisCount: sizeLen,
              children: gridCreation()
            )
          ),
          onVerticalDragEnd: (details) {
            if ((details.velocity.pixelsPerSecond.dy < 0) && canSwipeUp()){
              setState(() {
                swapTilesUp();
                  print("up");
              });
            }
            else if ((details.velocity.pixelsPerSecond.dy > 0) && canSwipeDown()){
              setState(() {
                swapTilesDown();
                print("down");
              });
            }
          },
          onHorizontalDragEnd: (details) {
            if ((details.velocity.pixelsPerSecond.dx < 0) && canSwipeLeft()){
              setState(() {
                swapTilesLeft();
                print("left");
              });
            }
            else if ((details.velocity.pixelsPerSecond.dx > 0) && canSwipeRight()){
              setState(() {
                swapTilesRight();
                print("right");
              });
            }
          },
        ),
        SizedBox(
            height: 48,
            width: double.infinity,
            child: Container(
              margin: EdgeInsets.only(left: 8, right: 8),
              decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.2)),
              borderRadius: BorderRadius.circular(8)
              ),
            child: MaterialButton(
              child: !gameStarted ? Text('Start'): Text('Restart'),
                color: Colors.grey.withOpacity(0.2),
                onPressed: (){
                  homeState.setState(() {});
                  setState(() {melange();});
                }
              )
            )
        ),
        Visibility(
          visible: gameStarted,
          child : Padding(padding: EdgeInsets.only(bottom: 8.0),
            child: Row(children: [
              Text('   Number of moves :  ${movesDone.length}'), 
              Padding(child: Text('Go back:'), padding: EdgeInsets.only(left: 70)),
              IconButton(
                icon: Icon(Icons.settings_backup_restore),  
                onPressed: (){
                  setState(() {});
                  if (movesDone.length != 0){
                    var lastMove = movesDone.removeLast();
                    if (lastMove == "Left"){
                      swapTilesRight();
                      print("right");
                    }
                    if (lastMove == "Right"){
                      swapTilesLeft();
                      print("left");
                    }
                    if (lastMove == "Up"){
                      swapTilesDown();
                      print("down");
                    }
                    if (lastMove == "Down"){
                      swapTilesUp();
                      print("up");
                    }
                    movesDone.removeLast();
                  }
                  else {
                    print("You didn't even started the game...");
                  }
                }
              )
            ],)
          )
        )
    ],);
  }

  bool canSwipeRight() => (emptyTile % sizeLen != 0);
  bool canSwipeLeft() => (emptyTile % sizeLen != sizeLen-1);
  bool canSwipeUp() => (emptyTile < (sizeLen-1)*sizeLen);
  bool canSwipeDown() => (emptyTile >= sizeLen);

  swapTiles(){
    var tempo = grid_value[emptyTile];
    grid_value[emptyTile] = grid_value[movedTile];
    grid_value[movedTile] = tempo;

    var temp = emptyTile;
    emptyTile = movedTile;
    movedTile = temp;

    var win = true;
    var comp = List.generate(sizeLen*sizeLen, (i) => i++);
    for(var i in comp){
      if (grid_value[i] != i){
        win = false;
      }
    }

    if(gameStarted && win){
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('You win !!'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Congratulations, you won this game in ${movesDone.length} moves!'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Replay'),
                onPressed: () {
                  Navigator.of(context).pop();
                  gameStarted = false;
                  homeState.setState(() {});
                  setState(() {melange();});
                },
              ),
              TextButton(
                child: Text('Menu'),
                onPressed: () {
                  Navigator.of(context).pop();
                  emptyTile = 0;
                  gameStarted = false;
                  grid_value = List.generate(sizeLen*sizeLen, (i) => i++);
                  homeState.setState(() {});
                  setState(() {});
                },
              ),
            ],
          );   
        }
      );       
    }
  }

  swapTilesUp(){
    movedTile = emptyTile + sizeLen;
    movesDone.add("Up");
    swapTiles();
  }
  swapTilesDown(){
    movedTile = emptyTile - sizeLen;
    movesDone.add("Down");
    swapTiles();
  }
  swapTilesLeft(){
    movedTile = emptyTile + 1;
    movesDone.add("Left");
    swapTiles();
  }
  swapTilesRight(){
    movedTile = emptyTile -1;
    movesDone.add("Right");
    swapTiles();
  }

  void melange(){
    final random = new Random();
    int r = random.nextInt(4);
    for(var i = 0; i<sizeLen*difficulty; i++){
      if ((r == 0) && (canSwipeUp())) {swapTilesUp();}
      if ((r == 1) && (canSwipeDown())) {swapTilesDown();}
      if ((r == 2) && (canSwipeRight())) {swapTilesRight();}
      if ((r == 3) && (canSwipeLeft())) {swapTilesLeft();}
      r = random.nextInt(4);
    }
    gameStarted = true;
    movesDone = [];
  }
}
