import 'package:flutter/material.dart';
import 'package:panorama_viewer/panorama_viewer.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/org_product_entity.dart';

class PonaramaImageView extends StatefulWidget {
  const PonaramaImageView({super.key, required this.product});
  final OrgProductEntity product;

  @override
  State<PonaramaImageView> createState() => _PonaramaImageViewState();
}

class _PonaramaImageViewState extends State<PonaramaImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.product.name),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: InteractiveViewer(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: PanoramaViewer(
              animSpeed: .1,
              sensorControl: SensorControl.orientation,
              child: Image.network(widget.product.image360),
            ),
          ),
        ),
      ),
    );
  }
}
