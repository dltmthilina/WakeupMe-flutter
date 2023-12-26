import 'package:flutter/material.dart';
import 'package:google_maps_webservice_ex/places.dart';

class PlaceSearchWidget extends StatefulWidget {

  final TextEditingController controller;

  const PlaceSearchWidget({super.key, required this.controller});

  @override
  _PlaceSearchWidgetState createState() => _PlaceSearchWidgetState();
}

class _PlaceSearchWidgetState extends State<PlaceSearchWidget> {
  
  final TextEditingController _placeController = TextEditingController();
  final GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey:'AIzaSyAEg4rLHQbagoKgSp1f0hdQxrw_mb16fik');
  List<Prediction> _predictions = [];

  @override
  void dispose() {
    _placeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: widget.controller,
          onChanged: (value) {
            if (value.isNotEmpty) {
              _autocompletePlace(value);
              print(value);
            }else{
              _autocompletePlace("");
            }
          },
        ),
        if(_predictions.isNotEmpty)
        ListView.builder(
          shrinkWrap: true, 
          itemCount: _predictions.length,
          itemBuilder: (context, index) { 
            return  SingleChildScrollView(
              child: ListTile(
                title: Text(_predictions[index].description ?? ''),
                onTap: () {
                  widget.controller.text = _predictions[index].description ?? '';
                  setState(() {
                    _predictions = [];
                  });
              },
              ),
            );
           },
        ),
      ],
    );
  }

  void _autocompletePlace(String input) async {
    if (input.isEmpty) {
      setState(() {
        _predictions = [];
      });
    }

    PlacesAutocompleteResponse response = await _places.autocomplete(
      input,
      language: 'en',
    
    );

    if (response.isOkay) {
        setState(() {
        _predictions = response.predictions;
      });
    } else {
      // Handle the error
      print(response.errorMessage);
    }
  }
}
