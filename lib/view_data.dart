import 'dart:convert';

import 'package:api_class/myclass.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'package:getwidget/components/rating/gf_rating.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:http/http.dart' as http;

class view_data extends StatefulWidget {
  const view_data({super.key});

  @override
  State<view_data> createState() => _view_dataState();
}

class _view_dataState extends State<view_data> {

  @override
  Widget build(BuildContext context) {
    final _ratingController = TextEditingController();
    //double _userRating = 4.5;
    myclass ma = ModalRoute.of(context)!.settings.arguments as myclass;
    Future getdata()
    async {
      var url = Uri.https('https://dummyjson.com', 'products/${ma.id}');
      var response = await http.get(url);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      Map m = jsonDecode(response.body);
      List l = m['id'];

      return m;

    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Description of data"),

      ),
      body: FutureBuilder(future: getdata(),builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.done)
          {

                  List l = ma.images!;
                  double _userRating = ma.rating;
                  return Column(children: [
                     GFCarousel(
                       items: l.map(
                             (url) {
                           return Container(
                             margin: EdgeInsets.all(8.0),
                             child: ClipRRect(
                               borderRadius: BorderRadius.all(Radius.circular(5.0)),
                               child: Image.network(
                                   url,
                                   fit: BoxFit.cover,
                                   width: 2000.0
                               ),
                             ),
                           );
                         },
                       ).toList(),
                       onPageChanged: (index) {
                        index;
                       },
                     ),
                     // Container(child: ,),

                     Text("${ma.title}"),
                     Text("${ma.description}"),
                     Text("${ma.brand}"),
                     Text("${ma.price}"),
                     Text("${ma.stock}"),
                     GFRating(
                       value: _userRating,
                       showTextForm: true,
                       controller: _ratingController, onChanged: (double rating) {

                     },
                     ),

                   ],);
          }
        else
          {
             return Center(child: CircularProgressIndicator(),);
          }
      },),
    );
  }
}
