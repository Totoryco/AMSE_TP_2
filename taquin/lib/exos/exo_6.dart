import 'package:flutter/material.dart';
import 'dart:math' as math;

math.Random random = new math.Random();

class Tile {
  Color color;

  Tile(this.color);
  Tile.randomColor() {
    this.color = Color.fromARGB(
        255, random.nextInt(255), random.nextInt(255), random.nextInt(255));
  }
}

class TileWidget extends StatelessWidget {
  final Tile tile;

  TileWidget(this.tile);

  @override
  Widget build(BuildContext context) {
    return this.coloredBox();
  }

  Widget coloredBox() {
    return Container(
        color: tile.color,
        child: Padding(
          padding: EdgeInsets.all(70.0),
        ));
  }
}

class Exo6a extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Exo6aState();
}

class Exo6aState extends State<Exo6a> {
  List<Widget> tiles =
      List<Widget>.generate(2, (index) => TileWidget(Tile.randomColor()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black, 
        title: Center(child: Text("Exo 6")),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ), 
      ),
      body: Row(children: tiles),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.sentiment_very_satisfied), onPressed: swapTiles),
    );
  }

  swapTiles() {
    setState(() {
      tiles.insert(1, tiles.removeAt(0));
    });
  }
}

class Exo6b extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Exo6bState();
}

class Exo6bState extends State<Exo6b> {
  List<Widget> tiles = <Widget>[];
  int _emptyTile = 1;
  List<String> text = [
    "Tile 1",
    "Empty",
    "Tile 3",
    "Tile 4",
    "Tile 5",
    "Tile 6",
    "Tile 7",
    "Tile 8",
    "Tile 9"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Swapable Grid'),
        centerTitle: true,
      ),
      body: new GridView.builder(
        itemCount: 9,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (BuildContext context, int index) {
          return new GridTile(
              child: new InkResponse(
            enableFeedback: true,
            child: new Card(
                color:
                    (index == _emptyTile) ? Colors.blue[0] : Colors.blue[500],
                child: new Center(
                  child: new Text(text[index]),
                )),
            onTap: () => setState(() {
              _onTileClicked(index, _emptyTile);
            }),
          ));
        },
      ),
    );
  }

  void _onTileClicked(int index, int empty) {
    if (index == empty + 1 ||
        index == empty - 1 ||
        index == empty + 3 ||
        index == empty - 3) {
      String temp = text[index];
      text[index] = text[empty];
      text[empty] = temp;
      _emptyTile = index;
    }
  }
}