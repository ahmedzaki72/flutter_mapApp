import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/models/place.dart';
import 'package:flutter_chat_app/providers/great_place.dart';
import 'package:flutter_chat_app/widget/image_input.dart';
import 'package:provider/provider.dart';
import '../widget/location_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add_place';
  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  TextEditingController _titleController = TextEditingController();
  File _pickedImage;
  PlaceLocation _placeLocation;

  void _selectedImages (File pickedImage) {
    _pickedImage = pickedImage;
  }
  
  void _selectPlace (double lat, double lon){
     _placeLocation = PlaceLocation(latitude: lat, longitude: lon);
  }

  void _onSavePlace () {
    if(_titleController.text.isEmpty || _pickedImage == null || _placeLocation == null ) {
      return;
    }
    Provider.of<GreatPlace>(context, listen: false).addPlace(_titleController.text, _pickedImage, _placeLocation,);
    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a New Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
         Expanded(
           child: SingleChildScrollView(
             child: Padding(
               padding: EdgeInsets.all(10.0),
               child: Column(
                 children: [
                   TextField(
                     decoration: InputDecoration(labelText: 'title'),
                     controller: _titleController,
                   ),
                   SizedBox(height: 10,),
                   ImageInput(_selectedImages),
                   SizedBox(height: 10,),
                   LocationInput(_selectPlace),
                 ],
               ),
             ),
           ),
         ),
          RaisedButton.icon(
            onPressed: _onSavePlace ,
            icon: Icon(Icons.add),
            label: Text('Add Place'),
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Theme.of(context).accentColor,
          ),
        ],
      ),
    );
  }
}
