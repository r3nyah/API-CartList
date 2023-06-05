import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;

class PreviewDownload extends StatefulWidget {
  final String imageUrl;
  const PreviewDownload({Key? key, required this.imageUrl}) : super(key: key);

  @override
  State<PreviewDownload> createState() => _PreviewDownloadState();
}

class _PreviewDownloadState extends State<PreviewDownload> {
  bool _visible = true;
  File? _displayImage;
  bool _isDownloading = false;
  late final String _downloadUrl = widget.imageUrl;

  @override
  void initState(){
    super.initState();
  }

  Future<void> _download() async{
    setState(() {
      _isDownloading = true;
    });
    final response = await http.get(Uri.parse(_downloadUrl));
    final imageName = path.basename(_downloadUrl);
    final appDir = await path_provider.getExternalStorageDirectory();
    final localPath = path.join(appDir!.path, imageName);
    final imageFile = File(localPath);

    await imageFile.writeAsBytes(response.bodyBytes);

    setState((){
      _isDownloading = false;
      _displayImage = imageFile;
      print("localpath................................$localPath");
      print("imageFile................................$imageFile");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _download,
          child: const Text(
            'Download Image',
          ),
        ),
        const SizedBox(height: 5,),
        _displayImage != null
          ? Visibility(
            visible: _visible,
            child: ElevatedButton(
              onPressed: (){
                setState(() {
                  _visible = !_visible;
                });
              },
              child: Text(
                'Done',
                style: TextStyle(
                  fontSize: 15
                ),
              ),
            ),
          ) : Center(
            child: _isDownloading
              ? const Text(
                'Downloading . . . ',
                style: TextStyle(
                  fontSize: 15
                ),
              ) : null
          )
      ],
    );
  }
}