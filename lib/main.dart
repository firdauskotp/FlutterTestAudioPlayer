import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new MaterialApp(
//      title: "Register",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: Color(0xFF37474F),
          )),
      home: new MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget{
//  MyHomePage({Key key, this.title}) : super(key: key);
  final String title = "FE7 Music App";



  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{

  List<Song> _ost;
  MusicFinder audioPlayer;

  @override
  void initState() {
    super.initState();
    // var ost = await MusicFinder.allSongs();
    // ost = new List.from(ost);

    // setState((){
    //   _ost = ost; 
    // });
    initPlayer();
  }

  void initPlayer()async{
    audioPlayer = new MusicFinder();
    var ost = await MusicFinder.allSongs();
    ost = new List.from(ost);

    setState((){
      _ost = ost; 
    });
  }

  Future _playLocal(String url) async {
    final result = await audioPlayer.play(url, isLocal: true);
    
  }

  Future pause() async {
    final result = await audioPlayer.pause();
    // if (result == 1) setState(() => playerState = PlayerState.paused);
  }

  Future stop() async {
    final result = await audioPlayer.stop();
    // if (result == 1)
    //   setState(() {
    //     playerState = PlayerState.stopped;
    //     position = new Duration();
    //   });
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: ExactAssetImage("images/wallpaper1.jpg"),
                  fit: BoxFit.cover
              )
          ),

          child: ListView.builder(
            
            itemCount: _ost.length,
            itemBuilder: (context, int index){
              return new ListTile(
                leading: new CircleAvatar(
                  child: new Text(_ost[index].title[0]),
                ),
                title: new Text(_ost[index].title),
                onTap: ()=>_playLocal(_ost[index].uri),
              );
            },
          ),
        ),
      ),
//      ),
    );
  }
}