import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:mime/mime.dart';

class FilePickerScreen extends StatefulWidget {
  static const routeName = '/file_picker';

  @override
  _FilePickerScreenState createState() => _FilePickerScreenState();
}

class _FilePickerScreenState extends State<FilePickerScreen> {
  Uint8List image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Picker'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              image == null ? Container() : Image(image: MemoryImage(image)),
              RaisedButton(
                child: Text('select file'),
                onPressed: () {
                  _selectFile();
                },
              ),
              RaisedButton(
                child: Text('select photo'),
                onPressed: () {
                  _selectPhoto();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectFile() async {
    FilePickerResult result =
        await FilePicker.platform.pickFiles(type: FileType.any);
    if (result == null) {
      return;
    }

    File file = File(result.files.single.path);
    print('file ${file.path}');
    final mime = lookupMimeType(file.path);
    print('mime $mime');

    final contents = await file.readAsBytes();
    print('contents ${contents.sublist(0, 100)}');
  }

  Future<void> _selectPhoto() async {
    FilePickerResult result =
        await FilePicker.platform.pickFiles(type: FileType.media);
    if (result == null) {
      return;
    }

    File file = File(result.files.single.path);
    print('file ${file.path}');
    final mime = lookupMimeType(file.path);
    print('mime $mime');

    final contents = await file.readAsBytes();
    print('contents ${contents.sublist(0, 100)}');

    final type = mime.split('/').first;
    if (type == 'image') {
      final tmpImage = await _testCompressFile(file);
      setState(() {
        this.image = tmpImage;
      });
    }
  }

  Future<Uint8List> _testCompressFile(File file) async {
    var result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minWidth: 150,
      minHeight: 150,
      quality: 94,
    );

    print('original length   ${file.lengthSync()}');
    print('compressed length ${result.length}');
    return result;
  }
}
