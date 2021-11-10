import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qrreader/providers/scan_list_provider.dart';
import 'package:qrreader/utils/utils.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async{ 
        
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#3D8BEF', 'Cancelar lectura', true, ScanMode.QR);
        //  final barcodeScanRes = 'geo:45.280089,-75.922405';

         if(barcodeScanRes == '-1'){
           return;
         }

        final scanListProvider = Provider.of<ScanListProvider>(context, listen:false);

        final nuevoScan = await scanListProvider.nuevoScan(barcodeScanRes);

        launchURL(context, nuevoScan);


       },
      child: Icon(Icons.filter_center_focus),

    );
  }
}