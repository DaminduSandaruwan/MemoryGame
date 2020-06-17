import 'package:flutter/material.dart';
import 'package:memory_game/data/data.dart';
import 'package:memory_game/model/tile_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
        
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pairs = getPairs();
    pairs.shuffle();

    visiblePairs = pairs;
    selected = true;
    Future.delayed(const Duration(seconds: 5),(){
      setState(() {
        visiblePairs = getQuestions();
        selected = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 50,horizontal: 20),
        child: Column(
          children: <Widget>[
            SizedBox(height: 40,),
            Text(
              "$points/800",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text("Points"),
            SizedBox(height: 20,),
            GridView(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                mainAxisSpacing: 0.0,
                maxCrossAxisExtent: 100,
              ),
              children: List.generate(visiblePairs.length, (index){
                return Tile(
                  imageAssetPath: visiblePairs[index].getImageAssetPath(),
                  // selected: visiblePairs[index].getIsSelected(),
                  parent: this,  
                  tileIndex: index,
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}

class Tile extends StatefulWidget {
  String imageAssetPath;

  int tileIndex;

  _HomePageState parent;
  Tile({this.imageAssetPath,this.parent, this.tileIndex});
  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(!selected){
          if(selectedImageAssetPath != ""){
            if(selectedImageAssetPath==pairs[widget.tileIndex].getImageAssetPath()){
              //Correct
              print("correct");
              Future.delayed(const Duration(seconds: 2),(){
                points+=100;
                
                setState(() {
                  
                });

                widget.parent.setState(() {
                  pairs[widget.tileIndex].setImageAssetPath ("");
                  pairs[selectedTileIndex].setImageAssetPath("");

                });
                selectedImageAssetPath="";
              });

            }
            
              
            
            else{
              //incorrect choice
              print("incorrect");
              Future.delayed(const Duration(seconds:2),(){
                widget.parent.setState(() {
                  pairs[widget.tileIndex].setIsSelected(false);
                  pairs[selectedTileIndex].setIsSelected(false);
                });
                selectedImageAssetPath="";
              });
            }
          }
          else{
            selectedTileIndex = widget.tileIndex;
            selectedImageAssetPath=pairs[widget.tileIndex].getImageAssetPath();
          }
          
          setState(() {
            pairs[widget.tileIndex].setIsSelected(true);
          });
          print("You Clicked");
        }
      },
      child: Container(
        margin: EdgeInsets.all(5),
        child: pairs[widget.tileIndex].getImageAssetPath() !="" ?  Image.asset(pairs[widget.tileIndex].getIsSelected() ? pairs[widget.tileIndex].getImageAssetPath() : widget.imageAssetPath) : Image.asset("assets/correct.png"),
      ),
    );
  }
}