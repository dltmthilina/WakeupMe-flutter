import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final double latitude;
  final double longitude;

  MapScreen({Key? key, required this.latitude, required this.longitude})
      : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  
  late GoogleMapController mapController;
  late LatLng location;
  late LatLng location2;
  List<Polyline> _polylines = [];

  @override
  void initState() {
    super.initState();
    location = LatLng(widget.latitude, widget.longitude);
    location2 = LatLng(6.8511, 79.9212);
  }

  Set<Circle> _circles = {};

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
        child: SizedBox(
              width: 500,
              height: 500,
            child: InteractiveViewer(
              child: GoogleMap(
                onTap: (argument) => print(argument),
                initialCameraPosition: CameraPosition(
                  target: location,
                  zoom: 10,
                ),
                onMapCreated: (controller) {
                  setState(() {
                    mapController = controller;
                    _drawPolylines();
                    _drawCircle();
                  });
                   
                },
                markers: Set<Marker>.of([
                  Marker(
                    markerId: MarkerId('place_marker'),
                    position: location,
                    infoWindow: InfoWindow(
                      title: 'Selected Place',
                    ),
                  ),
                  Marker(
                    markerId: MarkerId('place_marker'),
                    position: location2,
                    infoWindow: InfoWindow(
                      title: 'Selected Place',
                    ),
                  ),
                ]),
                polylines: Set<Polyline>.of(_polylines),
                circles: _circles,
              ),
            ),
         
        ),
      ),
    );
  }

  void _drawPolylines() {
    setState(() {
      _polylines.add(
        Polyline(
          polylineId: PolylineId('route'),
          color: Colors.blue,
          width: 5,
          points: [
            location,
            location2,
          ],
        ),
      );
    });
  }

   void _drawCircle() {
    setState(() {
      _circles.add(
        Circle(
          circleId: CircleId('destination_circle'),
          center: location ,
          radius: 2000,
          strokeWidth: 2,
          strokeColor: Colors.blue,
          fillColor: Colors.blue.withOpacity(0.1),
        ),
      );
    });
  }
}


