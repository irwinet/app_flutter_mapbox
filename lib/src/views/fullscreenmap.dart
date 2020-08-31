import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import 'package:http/http.dart' as http;

class FullscreenMap extends StatefulWidget {
  //const FullscreenMap({Key key}) : super(key: key);

  @override
  _FullscreenMapState createState() => _FullscreenMapState();
}

class _FullscreenMapState extends State<FullscreenMap> {
  
  MapboxMapController mapController;
  final center = LatLng(-12.174653, -76.963992);
  String selectedStyle = 'mapbox://styles/irwinet/ckedhy2zm3ay219m4vuoj6sox';
  final darkStyle = 'mapbox://styles/irwinet/ckedhy2zm3ay219m4vuoj6sox';
  final streetsStyle = 'mapbox://styles/irwinet/ckedi1o220s9p19lcnpyptr4c';

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
    _onStyleLoaded();
  }

  void _onStyleLoaded() {
    addImageFromAsset("assetImage", "assets/custom-icon.png");
    addImageFromUrl("networkImage", "https://via.placeholder.com/50");
  }

  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return mapController.addImage(name, list);
  }

  Future<void> addImageFromUrl(String name, String url) async {
    var response = await http.get(url);
    return mapController.addImage(name, response.bodyBytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: createMap(),
      floatingActionButton: buttonsFloating(),
    );
  }

  Column buttonsFloating() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[

        FloatingActionButton(
          child: Icon(Icons.sentiment_very_dissatisfied),
          onPressed: (){
            mapController.addSymbol(SymbolOptions(
              geometry: center,
              iconImage: 'networkImage',
              //iconSize: 3,
              textField: 'Home Irwin',
              //textColor: '#cccccc'
              textOffset: Offset(0,2),
            ));
          },
        ),        

        SizedBox(height: 5,),

        FloatingActionButton(
          child: Icon(Icons.zoom_in),
          onPressed: (){
            mapController.animateCamera(CameraUpdate.zoomIn());
          },
        ),        

        SizedBox(height: 5,),

        FloatingActionButton(
          child: Icon(Icons.zoom_out),
          onPressed: (){
            mapController.animateCamera(CameraUpdate.zoomOut());
          },
        ),

        SizedBox(height: 5,),

        FloatingActionButton(
          onPressed: (){
            if(selectedStyle==darkStyle){
              selectedStyle=streetsStyle;
            }
            else{
              selectedStyle=darkStyle;              
            }

            _onStyleLoaded();
            setState(() {
              
            });
          },
          child: Icon(Icons.add_to_home_screen),
        ),
      ],
    );
  }

  MapboxMap createMap() {
    return MapboxMap(
      styleString: selectedStyle,
      //accessToken: MapsDemo.ACCESS_TOKEN,
      onMapCreated: _onMapCreated,
      initialCameraPosition:
        CameraPosition(
          target: center,
          zoom: 14
        ),
    );
  }
}