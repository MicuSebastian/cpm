import 'package:flutter/material.dart';

import 'modelPage.dart';

class ModelsScreen extends StatefulWidget {
  const ModelsScreen({Key? key}) : super(key: key);

  @override
  State<ModelsScreen> createState() => _ModelsScreenState();
}

class ModelObj {
  final String name;
  final String description;
  final String urlImage;
  final String urlModel;

  const ModelObj({
    required this.name,
    required this.description,
    required this.urlImage,
    required this.urlModel,
  });
}

class _ModelsScreenState extends State<ModelsScreen> {
  List<ModelObj> models = [
    const ModelObj(
        name: 'Amenemhat Head',
        description: '3d model',
        urlImage: 'assets/images/cpmLogo.png',
        urlModel: 'assets/amenemhathead.glb'),
    const ModelObj(
        name: 'Buddha Statue',
        description: '3d model',
        urlImage: 'assets/images/cpmLogo.png',
        urlModel: 'assets/buddhastatue.glb'),
    const ModelObj(
        name: 'Dante Statue',
        description: '3d model',
        urlImage: 'assets/images/cpmLogo.png',
        urlModel: 'assets/dantestatue.glb'),
    const ModelObj(
        name: 'Liberty Statue',
        description: '3d model',
        urlImage: 'assets/images/cpmLogo.png',
        urlModel: 'assets/libertystatue.glb'),
    const ModelObj(
        name: 'Queen Mary',
        description: '3d model',
        urlImage: 'assets/images/cpmLogo.png',
        urlModel: 'assets/queenmaria.glb'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade200,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
          itemCount: models.length,
          itemBuilder: (context, index) {
            final model = models[index];

            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  radius: 28,
                  backgroundImage: AssetImage(
                    model.urlImage,
                  ),
                ),
                title: Text(model.name),
                subtitle: Text(model.description),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ModelScreen(model: model),
                  ));
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => ModelScreen(model: model)),);
                },
              ),
            );
          }),
    );
  }
}
