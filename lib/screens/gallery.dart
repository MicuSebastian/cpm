import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../storage_service.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({Key? key}) : super(key: key);

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

String _currentImage = "";

class _GalleryScreenState extends State<GalleryScreen> {
  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade200,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () async {
                final results = await FilePicker.platform.pickFiles(
                  allowMultiple: false,
                  type: FileType.custom,
                  allowedExtensions: ['png', 'jpg'],
                );

                if (results == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'No file selected',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );

                  return null;
                }

                final path = results.files.single.path;
                final fileName = results.files.single.name;

                storage
                    .uploadFile(path.toString(), fileName)
                    .then((value) => print('Done'));

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Transfer completed',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
              child: const Text('Upload images'),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          FutureBuilder(
            future: storage.listFiles(),
            builder: (BuildContext context,
                AsyncSnapshot<firebase_storage.ListResult> snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: 50,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _currentImage =
                                    snapshot.data!.items[index].name;
                              });
                            },
                            child: Text(snapshot.data!.items[index].name),
                          ),
                        );
                      }),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting ||
                  !snapshot.hasData) {
                return CircularProgressIndicator();
              }

              return Container();
            },
          ),
          const SizedBox(
            height: 30,
          ),
          FutureBuilder(
            future: storage.downloadURL(_currentImage),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return SizedBox(
                  width: 260,
                  height: 310,
                  child: Image.network(
                    snapshot.data!,
                    fit: BoxFit.fitHeight,
                  ),
                );
              }

              if ((snapshot.connectionState == ConnectionState.waiting ||
                      !snapshot.hasData) &&
                  _currentImage != "") {
                return const CircularProgressIndicator();
              }

              return Container();
            },
          ),
        ],
      ),
    );
  }
}
