import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class FullscreenMap extends StatefulWidget {
  //const FullscreenMap({Key key}) : super(key: key);

  @override
  _FullscreenMapState createState() => _FullscreenMapState();
}

class _FullscreenMapState extends State<FullscreenMap> {
  
  MapboxMapController mapController;
  final center = LatLng(-12.174585, -76.963079);
  String selectedStyle = 'mapbox://styles/irwinet/ckedhy2zm3ay219m4vuoj6sox';
  final darkStyle = 'mapbox://styles/irwinet/ckedhy2zm3ay219m4vuoj6sox';
  final streetsStyle = 'mapbox://styles/irwinet/ckedi1o220s9p19lcnpyptr4c';

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
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