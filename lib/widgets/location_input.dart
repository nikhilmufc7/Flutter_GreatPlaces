import 'package:flutter/material.dart';
import '../screens/map_screen.dart';
import 'package:location/location.dart';
import 'package:async/async.dart';
import '../helpers/location_helper.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;


  LocationInput(this.onSelectPlace);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

  void _showPreview(double lat, double lng){
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
        longitude: lat,
        latitude: lng
    );
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _getCurrentLocation()async{
    try {
      final locData = await Location().getLocation();
      _showPreview(locData.latitude, locData.longitude);
      widget.onSelectPlace(locData.latitude, locData.longitude);

    } catch(error){
      return;
    }

  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(
          isSelecting: true,
        ),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
    // ...
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            height: 170,
            alignment: Alignment.center,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(width: 1,color: Colors.grey)
            ),
            child: _previewImageUrl == null
                ? Text(
                    "No Location Chosen",
                    textAlign: TextAlign.center,
                  )
                : Image.network(
                    _previewImageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
              onPressed: _getCurrentLocation,
              icon: Icon(Icons.location_on),
              label: Text("Current Location"),
              textColor: Theme.of(context).primaryColor,
            ),
            FlatButton.icon(
              onPressed: _selectOnMap,
              icon: Icon(Icons.location_on),
              label: Text("Select on Map"),
              textColor: Theme.of(context).primaryColor,
            )
          ],
        )
      ],
    );
  }
}
