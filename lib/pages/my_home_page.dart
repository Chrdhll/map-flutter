import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //tipe map
  MapType _mapType = MapType.normal;

  //style map
  String? _styleMap;

  //method ketika di klik
  void _onMapTypeButtonPressed() {
    setState(() {
      _mapType == MapType.normal
          ? _mapType = MapType.satellite
          : _mapType = MapType.normal;
    });
  }

  //method load file style map
  Future<void> _loadStyleMap(String path) async {
    String style = await rootBundle.loadString(path);
    setState(() {
      _styleMap = style;
    });
  }

  //standard
  void _standardStyle() => setState(() => _styleMap = null);
  //dark
  void _darkStyle() => _loadStyleMap('assets/style_map/style_dark.json');
  //retro
  void _retroStyle() => _loadStyleMap('assets/style_map/style_retro.json');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(-0.936982301171181, 100.35998313807983),
              zoom: 12.8,
            ),
            //tipe map : normal dan satellite
            mapType: _mapType,

            //style map
            style: _styleMap,
          ),
          Positioned(
            bottom: 16,
            left: 16,
            child: Column(
              children: [
                FloatingActionButton(
                  onPressed: _onMapTypeButtonPressed,
                  backgroundColor: Colors.green,
                  child:
                      _mapType == MapType.normal
                          ? Icon(Icons.map, color: Colors.white)
                          : Icon(Icons.satellite_alt, color: Colors.white),
                ),
                SizedBox(height: 10,),
                FloatingActionButton(
                  onPressed: _standardStyle,
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.sunny,color: Colors.white,
                  ),
                ),
                SizedBox(height: 10,),
                FloatingActionButton(
                  onPressed: _darkStyle,
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.dark_mode,color: Colors.black,
                  ),
                ),
                SizedBox(height: 10,),
                FloatingActionButton(
                  onPressed: _retroStyle,
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.location_city,color: Colors.yellow,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
