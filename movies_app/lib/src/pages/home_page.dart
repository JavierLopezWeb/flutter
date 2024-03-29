import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/src/providers/peliculas_provider.dart';
import 'package:movies_app/src/widgets/card_swiper_widget.dart';
import 'package:movies_app/src/widgets/movies_horizontal.dart';



class HomePage extends StatelessWidget {

  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text('Películas en cines'),
          backgroundColor: Colors.indigoAccent,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed:(){},
            )
          ]
        ),

        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _swiperTarjetas(),
              _footer(context)
            ],
          ),
        )

    );
  }
Widget _swiperTarjetas(){

  return FutureBuilder(
    future: peliculasProvider.getEnCines(),
    builder: (BuildContext context, AsyncSnapshot<List> snapshot){

      if(snapshot.hasData){
        return CardSwiper(
          peliculas:snapshot.data
        );    
      }else{
        return Container(
          height: 400,
          child: Center(
            child: CircularProgressIndicator()
            )
          );
      }
      
    }
  );
}

Widget _footer(BuildContext context){
// final context = context;
  return Container(
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
      Container(
        padding: EdgeInsets.only(left: 20.0),
        child: Text('Populares', style: Theme.of(context).textTheme.subhead)
      ),
      SizedBox(height: 10),
      FutureBuilder(
      future: peliculasProvider.getPopulares(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.hasData){
          return MoviesHorizontal(
            peliculas:snapshot.data
          );    
        }else{
          return Center(
              child: CircularProgressIndicator()
            );

        }
      }
      )

    ],)
  );

}

}
