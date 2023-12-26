// route_service.dart
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteService {
  final PolylinePoints _polylinePoints = PolylinePoints();

  Future<List<LatLng>> getRouteCoordinates(LatLng origin, LatLng destination) async {
    List<LatLng> polylineCoordinates = [];
    PolylineResult result = await _polylinePoints.getRouteBetweenCoordinates(
      'YOUR_API_KEY',
      PointLatLng(origin.latitude, origin.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );
    
    if (result.status == 'OK') {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    
    return polylineCoordinates;
  }
}
