import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrreader/providers/scan_list_provider.dart';
import 'package:qrreader/widgets/scan_tiles.dart';


class MapasPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScanTiles(tipo:'map');
  }
}