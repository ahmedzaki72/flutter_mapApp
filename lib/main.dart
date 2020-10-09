import 'package:flutter/material.dart';
import 'package:flutter_chat_app/providers/great_place.dart';
import 'package:flutter_chat_app/screens/add_place_screen.dart';
import 'package:flutter_chat_app/screens/place_detail_screen.dart';
import 'package:provider/provider.dart';
import './screens/place_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GreatPlace(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        ),
        home: PlaceListScreen(),
        routes: {
          AddPlaceScreen.routeName : (ctx) => AddPlaceScreen(),
          PlaceDetailScreen.routeName : (ctx) => PlaceListScreen(),
        },
      ),
    );
  }
}
