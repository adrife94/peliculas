import 'package:flutter/material.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';



class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Peliculas en cines"),
        backgroundColor: Colors.indigoAccent,
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {

          },
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            _swiperTarjetas()
          ],
        ),
      ),
    );
  }

  Widget _swiperTarjetas() {
    return CardSwiperWidget(
        peliculas: [1,2,3,4,5,6,7,8]
    );
  }
}
