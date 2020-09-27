import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:mime/mime.dart';
import 'package:native_pdf_view/native_pdf_view.dart';

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

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PDFScreen(file.absolute.path)),
    );
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

class PDFScreen extends StatefulWidget {
  const PDFScreen(this.path);

  final path;

  @override
  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  int _actualPageNumber = 1;
  int _allPagesCount = 0;
  PdfController _pdfController;

  @override
  void initState() {
    super.initState();
    _pdfController = PdfController(
      document: PdfDocument.openFile(widget.path),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Document"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PdfView(
                controller: _pdfController,
                onDocumentLoaded: (document) {
                  setState(() {
                    _actualPageNumber = 1;
                    _allPagesCount = document.pagesCount;
                  });
                },
                onPageChanged: (page) {
                  setState(() {
                    _actualPageNumber = page;
                  });
                },
              ),
            ),
            Text(
              '$_actualPageNumber/$_allPagesCount',
            ),
            RaisedButton(
              child: Text('some button'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
