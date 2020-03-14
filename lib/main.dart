import 'package:flutter/material.dart';
import 'package:movie_search_app/view/main_page.dart';

void main(){
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage(),
    )
  );
}

