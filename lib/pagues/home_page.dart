import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrreader/pagues/direcciones_page.dart';
import 'package:qrreader/pagues/mapas_page.dart';
import 'package:qrreader/providers/db_provider.dart';
import 'package:qrreader/providers/iu_provider.dart';
import 'package:qrreader/providers/scan_list_provider.dart';
import 'package:qrreader/widgets/custom_navigatorbar.dart';
import 'package:qrreader/widgets/scan_boton.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Historial'),
        actions: [
          IconButton(
            onPressed: (){
              final scansListProvider = Provider.of<ScanListProvider>(context,listen:false);
              scansListProvider.borrarTodos();
            }, 
            icon: Icon(Icons.delete)
            )
        ],
      ),

      body: _HomePageBody(),

      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    //Obtener el current de selected menu opt

    final uiProvider =  Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.selectMenuOpt;

//TODO:Temporal leer base de datos
    // final tempScan = new ScanModel(valor: 'http://google.com');
    // // final inttemp = DBProvider.db.nuevoScan(tempScan);
    // DBProvider.db.getScanById(16).then((scan) => print(scan.valor));
    // DBProvider.db.getScans().then((scan) => print(scan));

    final scansListProvider = Provider.of<ScanListProvider>(context,listen:false);


    switch(currentIndex){

        case 0:
        scansListProvider.cargarScanPorTipo('geo');
        return MapasPage();

        case 1:
        scansListProvider.cargarScanPorTipo('http');
        return DireccionesPage();

        default:
        return MapasPage();

    }

  }
}