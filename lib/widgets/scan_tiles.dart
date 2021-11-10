import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrreader/providers/scan_list_provider.dart';
import 'package:qrreader/utils/utils.dart';

class ScanTiles extends StatelessWidget {

  final String tipo;

  const ScanTiles({ required this.tipo});
  

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context, listen:true);
    final scans = scanListProvider.scans;
    
    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: UniqueKey(),
          background: Container(
            color: Colors.red,
          ),
          onDismissed: (DismissDirection direction){
            
            Provider.of<ScanListProvider>(context,listen:false)
            .borrarScanPorId(scans[index].id!);
            
          },
          child: ListTile(
            leading: Icon(
              this.tipo == 'http'
              ?Icons.wb_iridescent_rounded
              :Icons.map
              ),
            title: Text(scans[index].valor),
            subtitle: Text(scans[index].id.toString()),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: (){
              launchURL(context, scans[index]);
            },
          ),
        );
      },
    );
  }
}