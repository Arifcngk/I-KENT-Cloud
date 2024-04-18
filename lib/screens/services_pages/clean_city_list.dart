import 'package:flutter/material.dart';

class CollectedInformationScreen extends StatelessWidget {
  final List<Map<String, String>> collectedInformation;

  const CollectedInformationScreen(
      {Key? key, required this.collectedInformation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Collected Information'),
      ),
      body: ListView.builder(
        itemCount: collectedInformation.length,
        itemBuilder: (context, index) {
          final Map<String, String> item = collectedInformation[index];
          return ListTile(
            title: Text(item.keys.first),
            subtitle: Text(item.values.first),
          );
        },
      ),
    );
  }
}
