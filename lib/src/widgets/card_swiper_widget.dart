import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/pages/models/pelicula_modelo.dart';

class CardSwiperWidget extends StatelessWidget {

  final List<Pelicula> peliculas;

  CardSwiperWidget({@required this.peliculas}) ;

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size; //Esto nes para obtener las dimensiones del dispositivo


    return Container(
      padding: EdgeInsets.only(top: 20),

      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.5,
        itemHeight: _screenSize.height * 0.5,
        itemBuilder: (BuildContext context,int index){

          peliculas[index].uniqueId = '${peliculas[index].id}-cine';

          return Hero(
            tag: peliculas[index].uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "detalle", arguments: peliculas[index]);
                },
                child: FadeInImage(
                  image: NetworkImage(peliculas[index].getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                ),
              )
            ),
          );

        },
        itemCount: peliculas.length,
      //  pagination: SwiperPagination(),
       // control: SwiperControl(),
      ),
    );
  }
}


