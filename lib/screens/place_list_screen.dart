import 'package:flutter/material.dart';
import 'package:flutter_chat_app/providers/great_place.dart';
import 'package:flutter_chat_app/screens/add_place_screen.dart';
import 'package:flutter_chat_app/screens/place_detail_screen.dart';
import 'package:provider/provider.dart';

class PlaceListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future:
            Provider.of<GreatPlace>(context, listen: false).fetchAndSetPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlace>(
                child: Center(
                  child: Text(
                    'Go no places yet, starting adding some!',
                  ),
                ),
                builder: (ctx, greatPlaces, ch) => greatPlaces.items.length <= 0
                    ? ch
                    : ListView.builder(
                        itemCount: greatPlaces.items.length,
                        itemBuilder: (ctx, i) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                FileImage(greatPlaces.items[i].image),
                          ),
                          title: Text(greatPlaces.items[i].title),
                          subtitle: Text(greatPlaces.items[i].location.address),
                          onTap: () {
                            Navigator.of(context).pushNamed(PlaceDetailScreen.routeName, arguments: greatPlaces.items[i].id);
                          },
                        ),
                      ),
              ),
      ),
    );
  }
}
