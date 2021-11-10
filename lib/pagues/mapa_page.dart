
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qrreader/providers/db_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaPage extends StatefulWidget {


  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {

  Completer<GoogleMapController> _controller = Completer();

  MapType tipoMapa =  MapType.normal;
  
  

  
  @override
  Widget build(BuildContext context) {

    final ScanModel scan = ModalRoute.of(context)!.settings.arguments as ScanModel;

    final CameraPosition puntoInicial = CameraPosition(
    target: scan.getLatLng(),
    zoom: 17.5,
    tilt: 50
    );

    final Set<Marker> marcadores = new Set<Marker>();

    marcadores.add(new Marker(
      markerId: MarkerId('geo-location'),
      position: scan.getLatLng()
    ));


    return Scaffold(
      appBar: AppBar(
        title: Text('Visualizador de ubicación'),
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location_sharp),
            tooltip: 'Regresa a tu ubicacion',
            onPressed: () async{
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(
                CameraUpdate.newCameraPosition(puntoInicial)
                );
            },
          ),
        ],
      ),
      body: GoogleMap(

        markers: marcadores,
        
        mapType: tipoMapa,
        initialCameraPosition: puntoInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
      child:Icon(Icons.layers) ,
      onPressed: (){

        if(tipoMapa == MapType.normal){
          tipoMapa =MapType.satellite;
        }else{
          tipoMapa =MapType.normal;
        }

        setState(() {
          
        });

      }),

    );
  }
}