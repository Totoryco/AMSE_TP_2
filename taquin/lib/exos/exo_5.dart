import 'package:flutter/material.dart';
import 'package:taquin/exos/exo_4.dart';

class Exo5a extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('GridView Example'),
        centerTitle: true,
      ),
      body: new GridView.count(
        crossAxisCount: 3,
        children: new List<Widget>.generate(9, (index) {
          return new GridTile(
            child: new Card(
                color: Colors.blue[100 * index],
                child: new Center(
                  child: new Text('Tile ' + (index + 1).toString()),
                )),
          );
        }),
      ),
    );
  }
}

class Exo5b extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Taquin Board'),
        centerTitle: true,
      ),
      body: new GridView.count(
        crossAxisCount: 3,
        children: new List<Widget>.generate(9, (index) {
          return new GridTile(
              child: new Card(
            child: this.createTileWidgetFrom(new Tile(
                imageURL: 'https://picsum.photos/512',
                alignment: Alignment(-1+2*(index % 3)/2,
                    -1 + (2 / 3) * (index ~/ 3)))),
          ));
        }),
      ),
    );
  }

  Widget createTileWidgetFrom(Tile tile) {
    return InkWell(
      child: tile.croppedImageTile(),
      onTap: () {
        print("tapped on tile");
      },
    );
  }
}

class Exo5c extends StatefulWidget {
  @override
  _Exo5cState createState() => _Exo5cState();
}

class _Exo5cState extends State<Exo5c> {
  double _currentSliderValue = 3;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Taquin Board'),
          centerTitle: true,
        ),
        body: Column(children: <Widget>[
          Expanded(
              child: new GridView.count(
            crossAxisCount: _currentSliderValue.toInt(),
            children: new List<Widget>.generate(
                (_currentSliderValue * _currentSliderValue).toInt(), (index) {
              return new GridTile(
                  child: new Container(
                margin: EdgeInsets.all(1.0),
                child: this.createTileWidgetFrom(new Tile(
                    imageURL: 'https://picsum.photos/512',
                    alignment: Alignment(coordinatesL(index), coordinatesC(index))
              ))));
            }),
          )),
          Row(
            children: <Widget>[
              Text(
                "Size :",
                textAlign: TextAlign.left,
              ),
              Expanded(
                  child: Slider(
                value: _currentSliderValue,
                min: 3,
                max: 8,
                divisions: 5,
                label: _currentSliderValue.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _currentSliderValue = value;
                  });
                },
              ))
            ],
          ),
        ]));
  }

  Widget createTileWidgetFrom(Tile tile) {
    return InkWell(
      child: tile.croppedImageTilev(_currentSliderValue.toInt()),
      onTap: () {
        print("tapped on tile");
      },
    );
  }

    double coordinatesL(int i){
    var l = -1+2*(i%_currentSliderValue.toInt())/(_currentSliderValue.toInt()-1);
    return l;
  }

  double coordinatesC(int i){
    var c = 0.0;
    for (var j = 0; j < _currentSliderValue.toInt(); j++) {
        if ((j*_currentSliderValue.toInt() <= i) && (i < (j+1)*_currentSliderValue.toInt())){
          c = -1+2*(j%_currentSliderValue.toInt())/(_currentSliderValue.toInt()-1);
        }
    }
      return c;
  }
}