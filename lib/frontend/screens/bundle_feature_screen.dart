import 'package:flutter/material.dart';
import 'package:loavi_project/frontend/app_theme.dart';

class BundleFeatureScreen extends StatefulWidget {
  final int id;
  final String name;
  final List<String> features;

  const BundleFeatureScreen({
    Key? key,
    required this.id,
    required this.name,
    required this.features,
  }) : super(key: key);

  @override
  State<BundleFeatureScreen> createState() => _BundleFeatureScreenState();
}

class _BundleFeatureScreenState extends State<BundleFeatureScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: widget.features.length,
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
                margin: const EdgeInsets.only(left: 30, right: 30, top: 20),
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppTheme.accent7)),
                child: Text(
                  widget.features[index],
                  textAlign: TextAlign.center,
                ));
          }),
    );
  }
}
