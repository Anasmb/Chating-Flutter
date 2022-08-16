import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserImagePicker extends StatefulWidget {
  final void Function(
    File pickedImage,
  ) imagePickFun;

  UserImagePicker(this.imagePickFun);

  @override
  State<UserImagePicker> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<UserImagePicker> {
  File _pickedImageFile;
  var pickedImage = null;
  void _pickImage() async {
    final picker = ImagePicker();
    pickedImage = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 35,
    );
    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });
    widget.imagePickFun(_pickedImageFile);
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      backgroundImage: pickedImage != null ? FileImage(_pickedImageFile) : null,
      child: IconButton(
        onPressed: _pickImage,
        icon: Icon(Icons.add),
        iconSize: 35,
      ),
    );
  }
}
