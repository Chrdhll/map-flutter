import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_2b/pages/custome_box_map.dart';
import 'package:map_2b/pages/detail_museum_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

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

  final List<Map<String, dynamic>> _listMuseum = [
    {
      'namaTempat': 'Benteng Jepang Gunung Panggilun',
      'gambar': 'assets/images/hotel1.jpg',
      'harga_tiket': 'Rp 15.000',
      'rating': 3.5,
      'lat': -0.9090805074497594,
      'lng': 100.36189711443076,
      'deskripsi':
          'Ullamco incididunt occaecat magna consequat magna mollit eu eiusmod nostrud enim id amet tempor. Proident aliqua et irure enim aute dolore laboris dolore exercitation eiusmod est aliquip aute aute. Nulla est mollit labore ullamco labore minim ea tempor sint. Qui laborum elit ea sunt sit nostrud cillum nulla. Mollit esse enim sint reprehenderit adipisicing commodo duis officia laboris deserunt est. Nulla non amet aute nulla elit anim. Mollit proident velit elit voluptate Lorem Ullamco incididunt occaecat magna consequat magna mollit eu eiusmod nostrud enim id amet tempor. Proident aliqua et irure enim aute dolore laboris dolore exercitation eiusmod est aliquip aute aute. Nulla est mollit labore ullamco labore minim ea tempor sint. Qui laborum elit ea sunt sit nostrud cillum nulla. Mollit esse enim sint reprehenderit adipisicing commodo duis officia laboris deserunt est. Nulla non amet aute nulla elit anim. Mollit proident velit elit voluptate Lorem.',
    },
    {
      'namaTempat': 'CRC Lolong',
      'gambar': 'assets/images/hotel2.jpg',
      'harga_tiket': 'Rp 20.000',
      'rating': 5.0,
      'lat': -0.914182302233192,
      'lng': 100.35364014261032,
      'deskripsi':
          'Ullamco incididunt occaecat magna consequat magna mollit eu eiusmod nostrud enim id amet tempor. Proident aliqua et irure enim aute dolore laboris dolore exercitation eiusmod est aliquip aute aute. Nulla est mollit labore ullamco labore minim ea tempor sint. Qui laborum elit ea sunt sit nostrud cillum nulla. Mollit esse enim sint reprehenderit adipisicing commodo duis officia laboris deserunt est. Nulla non amet aute nulla elit anim. Mollit proident velit elit voluptate Lorem.',
    },
  ];

  Set<Marker> _createMarkers() {
    Set<Marker> markers = {};
    for (var museum in _listMuseum) {
      final LatLng koordinat = LatLng(museum['lat'], museum['lng']);
      markers.add(
        Marker(
          markerId: MarkerId(museum['namaTempat']),
          position: koordinat,
          onTap: () {
            _customInfoWindowController.addInfoWindow!(
              CustomeBoxMap(
                gambar: museum['gambar'],
                namaTempat: museum['namaTempat'],
                rating: museum['rating'],
                harga: museum['harga_tiket'],
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailMuseumPage(museum: museum),
                    ),
                  );
                },
              ),
              koordinat,
            );
          },
        ),
      );
    }
    return markers;
  }

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

            //marker
            markers: _createMarkers(),
            onMapCreated: (controller) {
              _customInfoWindowController.googleMapController = controller;
            },
            onTap: (position) => _customInfoWindowController.hideInfoWindow!(),
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 240,
            width: 220,
            offset: 50,
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
                SizedBox(height: 10),
                FloatingActionButton(
                  onPressed: _standardStyle,
                  backgroundColor: Colors.green,
                  child: Icon(Icons.sunny, color: Colors.white),
                ),
                SizedBox(height: 10),
                FloatingActionButton(
                  onPressed: _darkStyle,
                  backgroundColor: Colors.green,
                  child: Icon(Icons.dark_mode, color: Colors.black),
                ),
                SizedBox(height: 10),
                FloatingActionButton(
                  onPressed: _retroStyle,
                  backgroundColor: Colors.green,
                  child: Icon(Icons.location_city, color: Colors.yellow),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

