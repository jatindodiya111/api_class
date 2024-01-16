import 'dart:math';

import 'package:api_class/myclass.dart';
import 'package:api_class/view_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      "homepage":(context) => homepage(),
      "view":(context) => view_data(),
    },
    initialRoute: "homepage",
    // home: homepage(),
  ));
}

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  final dio = Dio();

  Future getdata() async {
    final response = await dio.get('https://dummyjson.com/products');
    print(response);
    Map m = response.data;
    return m;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("List Of Product")),
      body: FutureBuilder(
        future: getdata(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              Map p = snapshot.data;
              List l = p['products'];
              return ListView.builder(
                itemCount: l.length,
                itemBuilder: (context, index) {
                  myclass d = myclass.fromJson(l[index]);
                  return ListTile(
                    onTap: () {
                       Navigator.pushNamed(context, "view",arguments: d);
                    },
                    title: Text("${d.title}"),
                    leading: Image.network("${d.thumbnail}"),

                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
