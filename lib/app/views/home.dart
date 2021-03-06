import 'package:FavYout/app/blocs/videos_bloc.dart';
import 'package:FavYout/app/delegates/data_search.dart';
import 'package:FavYout/app/widgets/video_tile.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 25,
          child: Image.asset("assets/images/youtube.png"),
        ),
        elevation: 0,
        backgroundColor: Colors.black87,
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text("0"),
          ),
          IconButton(icon: Icon(Icons.star), onPressed: () {}),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                String result =
                    await showSearch(context: context, delegate: DataSearch());
                if (result != null) {
                  BlocProvider.of<VideosBloc>(context).inSearch.add(result);
                }
              }),
        ],
      ),
      body: StreamBuilder(
        stream: BlocProvider.of<VideosBloc>(context).outvideos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("ENTROU AQUI VIDEO");
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return VideoTile(snapshot.data[index]);
                });
          } else {
            return Container();
          }
        },
      ),
      backgroundColor: Colors.black87,
    );
  }
}
