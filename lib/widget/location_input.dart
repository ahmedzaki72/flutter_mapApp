import 'package:flutter/material.dart';
import 'package:flutter_chat_app/helpers/location_helper.dart';
import 'package:flutter_chat_app/screens/map_screen.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;
  LocationInput(this.onSelectPlace);
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String previewImageUrl;

  void _showPreview (double lat , double log) {
    final staticMapImageUrl = LocationHeper.generateLocationPreviewImage(
        latitude: lat, longitude: log);
    setState(() {
      previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _getCurrentLocation() async {
    try{
      Location location = Location();
      final locationData = await location.getLocation();
      _showPreview(locationData.latitude, locationData.longitude);
      widget.onSelectPlace(locationData.latitude, locationData.longitude);
    }catch(error) {
      return;
    }

  }

  Future<void> isSelectOnMap() async {
   final selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MapScreen(
          isSelecting: true,
        ),
      ),
    );
   if(selectedLocation == null) {
     return;
   }
   _showPreview(selectedLocation.latitude, selectedLocation.longitude);
   widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
          ),
          child: previewImageUrl == null
              ? Text(
                  'No Location Chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(
              onPressed: _getCurrentLocation,
              icon: Icon(Icons.location_on),
              label: Text('Current Location'),
              textColor: Theme.of(context).primaryColor,
            ),
            FlatButton.icon(
              onPressed: isSelectOnMap,
              icon: Icon(Icons.map),
              label: Text('Select on Map'),
              textColor: Theme.of(context).primaryColor,
            ),
          ],
        )
      ],
    );
  }
}
