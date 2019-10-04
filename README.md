# Flutter Great Place

- Uses Flutter
- Google Maps
- Native Device features

## How to run locally

```
git clone
```

```
create a location_helper.dart file in helpers folder
```

```
Get your Google Cloud API Key
```

```
Add this to the location_helper.dart file

Add your api key to the variable

import 'package:http/http.dart' as http;
import 'dart:convert';
const GOOGLE_API_KEY = 'YOUR API KEY';

class LocationHelper {
  static String generateLocationPreviewImage({
    double latitude, double longitude,}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:S%7C40.702147,-74.015794&markers=color:green%7Clabel:G%7C40.711614,-74.012318&markers=color:red%7Clabel:C%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }

  static Future<String> getPlaceAddress( double lat, double lng) async{
    final url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY';
    final response = await http.get(url);
    return json.decode(response.body)['results'][0]['formatted_address'];

  }
}
```
