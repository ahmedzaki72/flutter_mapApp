import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class ImageInput extends StatefulWidget {
  final Function selectedImage;

  ImageInput(this.selectedImage);
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> takePicture () async{
    final imageFile = await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);
    if(imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = imageFile;
    });
    final appDire = await getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final saveImage = await imageFile.copy('${appDire.path}/$fileName}');
    widget.selectedImage(saveImage);
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
        ),
        SizedBox(
          width: 10,
        ),
        FlatButton.icon(
          onPressed: takePicture,
          icon: Icon(
            Icons.camera,
          ),
          label: Text('Take picture'),
          textColor: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}
