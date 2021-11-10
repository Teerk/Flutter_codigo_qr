import 'package:flutter/material.dart';
import 'package:qrreader/providers/db_provider.dart';


class ScanListProvider extends ChangeNotifier{

  List<ScanModel> scans = [];

  String tipoSeleccionado = 'http';


  Future<ScanModel> nuevoScan(String valor) async{
    final nuevoScan = new ScanModel(valor: valor);
    final id = await DBProvider.db.nuevoScan(nuevoScan);
    //asignar el id de la bd al modelo
    nuevoScan.id = id;

    if(this.tipoSeleccionado == nuevoScan.tipo){
      this.scans.add(nuevoScan);
      notifyListeners();
    }
    return nuevoScan;
  }

  cargarScan() async{
    final scans = await DBProvider.db.getScans();
    this.scans = [...scans];
    notifyListeners();
  }

  cargarScanPorTipo(String tipo) async{
    final scans = await DBProvider.db.getScansPorTipo(tipo);
    this.tipoSeleccionado = tipo;
    this.scans = [...scans];
    notifyListeners();

  }

  borrarTodos() async{
    await DBProvider.db.deleteAllScan();
    this.scans = [];
    notifyListeners();
  }

  borrarScanPorId(int id) async {
    await DBProvider.db.deleteScan(id);
    // cargarScanPorTipo(this.tipoSeleccionado);
  }










}