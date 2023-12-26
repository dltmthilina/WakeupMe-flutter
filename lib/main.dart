// main.dart
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wakeup/map_screen.dart';
import 'package:wakeup/place_search.dart';
import 'location_service.dart';
import 'route_service.dart';
import 'proximity_alert.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Location App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  LocationService _locationService = LocationService();
  RouteService _routeService = RouteService();
  ProximityAlert _proximityAlert = ProximityAlert();

  List<Polyline> _polylines = [];
  String? _selectedRoute;


  TextEditingController currentLocationController = TextEditingController();
  TextEditingController destinationLocationController = TextEditingController();
  TextEditingController doubleInputController = TextEditingController();
  

  Future<void> _setProximityAlert() async {
 
    double distance = 0.0; 

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WakeupMe'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20,),
                buildLocationInput(
                   label: 'Current Location',
                   controller: currentLocationController,
                 ),
                  const SizedBox(height: 10,),
                 buildLocationInput(
                   label: 'Destination Location',
                   controller: destinationLocationController,
                 ),
                  const SizedBox(height: 10,),
                 buildDoubleInput(
                   label: 'Double Input',
                   controller: doubleInputController,
                 ),
                  MapScreen(latitude: 6.9271, longitude: 79.8612),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

   Widget buildLocationInput({required String label, required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Row(
          children: [
            Expanded(
              child: PlaceSearchWidget(controller: controller,),
            ),
             IconButton(
              icon: const Icon(Icons.map),
              onPressed: () {
                //openMapToChooseLocation(controller);
              },
            ),
          ],
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }

    Widget buildDoubleInput({required String label, required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
