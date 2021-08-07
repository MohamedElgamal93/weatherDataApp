import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../app_constants.dart';
class LocationPage extends StatefulWidget {
       const LocationPage(
      {Key key,
      @required this.lat, @required this.long, @required this.cityName
})
      : super(key: key);
  final double lat;
  final double long;
  final String cityName;

    
  @override
  _LocationPage createState() => _LocationPage();
}

class _LocationPage extends State<LocationPage>  {
  List blogThumList = [];
  Completer<GoogleMapController> _controoller = Completer();

  String searchAddr;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;


    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Container(
              margin: const EdgeInsets.only(right: 15.0),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    Container(
                        padding: EdgeInsets.only(top: 11, left: 11),
                        child: Text(
                          Location,
                          style: TextStyle(
                              fontFamily: BOLD_FONT,
                              fontSize: 20,
                              color: Colors.white),
                        ))
                  ],
                ),
              ))),
      body:
          CustomScrollView(physics: ClampingScrollPhysics(), slivers: <Widget>[
        _locationmap(screenHeight,screenWidth),
      ]),
      // resizeToAvoidBottomPadding: false,
    );
  }

  SliverToBoxAdapter _locationmap(screenHeight,screenWidth) {
    return SliverToBoxAdapter(
        child: 
                  
  Container(
    height: screenHeight/1.5,
    width: screenWidth,
                               
                                      padding: EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
                                      color: Colors.transparent,
                                 child: GoogleMap(
                                             mapType: MapType.normal,
                                             myLocationEnabled: true,
                                             initialCameraPosition:  CameraPosition(target: LatLng(widget.lat, widget.long), zoom: 12),
                                             onMapCreated: (GoogleMapController controller) {
                                               _controoller.complete(controller);
                                             },
                                             compassEnabled: true,
                                            
                                             markers: {
                                               Marker(
  markerId: MarkerId(widget.cityName),
  position: LatLng(widget.lat  ,widget.long ),
  infoWindow: InfoWindow(title: widget.cityName),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
)
                                             },
                                           ),
                                        
                                        ),            
                 
             
            );
  }

  


 




 





}