import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiperWidget extends StatelessWidget {

  final List<dynamic> peliculas;

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
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.network("http://via.placeholder.com/350x150",fit: BoxFit.fill,)
          );

        },
        itemCount: peliculas.length,
      //  pagination: SwiperPagination(),
       // control: SwiperControl(),
      ),
    );
  }
}
