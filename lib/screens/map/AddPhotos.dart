import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../constants/const.dart';
import 'package:path/path.dart' as path;

class AddPhotos extends StatefulWidget {
  static const String id = 'add_photos';
  const AddPhotos({Key? key}) : super(key: key);

  @override
  State<AddPhotos> createState() => _AddPhotosState();
}

class _AddPhotosState extends State<AddPhotos> {
  @override
  File? image;
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future pickImage() async {
    try {
      final pickedImage = await ImagePicker()
          .pickImage(source: ImageSource.gallery);
      if (pickedImage == null) return ;
      image = File(pickedImage.path);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<String> uploadImage(File file) async {
    String fileName = path.basename(file.path);
    Reference reference = _firebaseStorage.ref().child(fileName);
    UploadTask uploadTask = reference.putFile(file);
    TaskSnapshot storageTaskSnapshot = await uploadTask.whenComplete(() => null);
    return await storageTaskSnapshot.ref.getDownloadURL();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Photos"),
        ),
        body: Center(
          child: Column(
            children: [
              MaterialButton(
                  color: color2,
                  child: const Text("Pick Image from Gallery",
                      style: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.bold)),
                  onPressed: (){
                    pickImage();
                    print(image?.path);
                    print(image?.absolute);

                    print(uploadImage(image!));
                  }),
              MaterialButton(
                  color: color2,
                  child: const Text("Pick Image from Camera",
                      style: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.bold)),
                  onPressed: () {}),
            ],

          ),
        ));
  }
}
