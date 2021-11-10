import 'package:flutter/material.dart';
import 'package:qrreader/models/scan_model.dart';

import 'package:url_launcher/url_launcher.dart';


void launchURL(BuildContext context, ScanModel scan) async {
  
  final  _url = scan.valor;

  if (scan.tipo == 'http') {
    if (await launch(_url)) {
      await launch(_url);
    } else {
      throw 'Could not launch $_url';
    }
  }else{
    Navigator.pushNamed(context, 'mapa', arguments: scan);
  }
  // await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
}
    