import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:winch_app/services/Maps_Assistants/maps_services.dart';

class RideRequest extends StatefulWidget {
  @override
  _RideRequestState createState() => _RideRequestState();
}

class _RideRequestState extends State<RideRequest> {

  @override
  Widget build(BuildContext context) {

    double customerLat = 31.20684069999999;
    double customerLng = 29.9237711;
    LatLng customerPosition = LatLng(customerLat, customerLng);

    double destinationLat = 31.2181232;
    double destinationLng = 29.9570564;
    LatLng destinationPosition = LatLng(destinationLat, destinationLng);

    getAddressNames() async
    {
      String customerAddress = await MapsApiService.searchCoordinateAddress(
          customerPosition, context);
      String destinationAddress = await MapsApiService.searchCoordinateAddress(
          destinationPosition, context);
    }

    return Container(


    );
  }
}
