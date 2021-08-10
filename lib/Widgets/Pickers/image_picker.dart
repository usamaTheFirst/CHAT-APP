import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickDPWidget extends StatefulWidget {
  final void Function(File pickedImage) imagePickFn;

  const PickDPWidget({Key key, this.imagePickFn}) : super(key: key);

  @override
  _PickDPWidgetState createState() => _PickDPWidgetState();
}

class _PickDPWidgetState extends State<PickDPWidget> {
  File _pickedImage;

  _pickImage() async {
    final pickedImageFile = await ImagePicker.platform.pickImage(
        source: ImageSource.gallery, imageQuality: 50, maxWidth: 150);
    if (pickedImageFile == null) return;
    setState(() {
      _pickedImage = File(pickedImageFile.path);
    });
    widget.imagePickFn(_pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 45,
          backgroundColor: Colors.grey,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage) : null,
        ),
        FlatButton.icon(
          textColor: Theme.of(context).primaryColor,
          onPressed: _pickImage,
          icon: Icon(Icons.image),
          label: Text("Add Image"),
        ),
      ],
    );
  }
}
