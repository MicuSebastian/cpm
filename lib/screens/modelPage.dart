import 'package:babylonjs_viewer/babylonjs_viewer.dart';
import 'package:cpm/screens/models.dart';
import 'package:flutter/material.dart';

class ModelScreen extends StatelessWidget {
  final ModelObj model;

  const ModelScreen({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue.shade400.withOpacity(0.3),
        title: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.lightBlue.shade400.withOpacity(0.3)),
          ),
          child: const Text(
            '< View other models',
            style: TextStyle(color: Colors.white70),
            textAlign: TextAlign.right,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: BabylonJSViewer(
        src: model.urlModel,
      ),
    ));
  }
}
