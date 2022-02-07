import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_context/one_context.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rapid_response/Model/Maps/direction_respository.dart';
import 'package:rapid_response/Model/Maps/directtion_model.dart';
import 'package:rapid_response/Views/Constants/colors.dart';
import 'package:rapid_response/Views/Rapid_Response/Components/rappid_response_dialog.dart';
import 'package:rapid_response/Views/Widgets/my_button.dart';
import 'package:rapid_response/Views/Widgets/response_widget.dart';
import 'package:rapid_response/Views/Widgets/smart_button_indicator.dart';

// class ResponseScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Google Maps',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primaryColor: Colors.white,
//       ),
//       home: MapScreen(),
//     );
//   }
// }

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(37.773972, -122.431297),
    zoom: 11.5,
  );

  GoogleMapController _googleMapController;
  Marker _origin;
  Marker _destination;
  Directions _info;
  @override
  void initState() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(12, 12)),
            'assets/images/pin.png')
        .then((d) {
      pinSource = d;
    });
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(12, 12)),
            'assets/images/pin_dest.png')
        .then((d) {
      pinDest = d;
    });
    super.initState();
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  BitmapDescriptor pinSource;
  BitmapDescriptor pinDest;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          left: 0,
          right: 0,
        ),
        child: GestureDetector(
          onTap: () {
            OneContext().showDialog(builder: (BuildContext context) {
              return const RapidResponseDialog(blur: false);
            });
          },
          child: ResponseWidget(),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        // leading: BackButton(color: JssColors.judul),
        leading: Container(
          margin: const EdgeInsets.only(left: 16.0),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: MyColors.bg_button_back,
          ),
          alignment: Alignment.center,
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: MyColors.grey_3,
              size: 20.0,
            ),
            onPressed: () {
              //  OneContext().pop();
              Get.back();
            },
          ),
        ),
        title: const Text(
          "Responding",
          style: TextStyle(color: MyColors.grey_3, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        color: MyColors.grey_2,
        child: Container(
          margin: const EdgeInsets.only(top: 2),
          color: MyColors.white,
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: AlignmentDirectional.topCenter,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    height: MediaQuery.of(context).size.height / 3,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                      ),
                      child: GoogleMap(
                        myLocationButtonEnabled: false,
                        zoomControlsEnabled: false,
                        initialCameraPosition: _initialCameraPosition,
                        onMapCreated: (controller) {
                          _googleMapController = controller;
                          var sourceLatLng =
                              const LatLng(-7.8079182, 110.3887332);
                          var destLatLng =
                              const LatLng(-7.8050712, 110.3902453);
                          _addMarker(sourceLatLng);
                          _addMarker(destLatLng);
                          LatLngBounds bound = LatLngBounds(
                              southwest: sourceLatLng, northeast: destLatLng);
                          CameraUpdate u2 =
                              CameraUpdate.newLatLngBounds(bound, 50);
                          _googleMapController.animateCamera(u2).then((void v) {
                            check(u2, this._googleMapController);
                          });
                        },
                        markers: {
                          if (_origin != null) _origin,
                          if (_destination != null) _destination
                        },
                        polylines: {
                          if (_info != null)
                            Polyline(
                              polylineId: const PolylineId('overview_polyline'),
                              color: Colors.red,
                              width: 5,
                              points: _info.polylinePoints
                                  .map((e) => LatLng(e.latitude, e.longitude))
                                  .toList(),
                            ),
                        },
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Column(
                        children: [
                          const Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text('Medical Emergency',
                                style: TextStyle(
                                    color: MyColors.black,
                                    fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            child: Row(
                              children: const [
                                Text('Alexander:',
                                    style: TextStyle(color: MyColors.grey)),
                                Text('avaliable',
                                    style: TextStyle(color: MyColors.primary)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text('2.5 km',
                                style: TextStyle(color: MyColors.grey)),
                          ),
                        ],
                      )),
                      Container(
                          padding: const EdgeInsets.only(
                              left: 8, top: 4, right: 8, bottom: 4),
                          decoration: BoxDecoration(
                            color: MyColors.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'Incident',
                            style: TextStyle(color: MyColors.white),
                          ))
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  autofocus: false,
                  minLines: 6,
                  keyboardType: TextInputType.text,
                  maxLines: null,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 0.4),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 0.4),
                    ),
                    labelText: 'Description',
                    hintText: "I'm on way",
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  ),
                  onChanged: (value) {},
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: ProgressButton(
                    color: MyColors.primary,
                    defaultWidget: Container(
                      child: const Text(
                        "Send",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    progressWidget: const SmartButtonIndicatorWidget(),
                    borderRadius: 12,
                    type: ProgressButtonType.Flat,
                    height: 56,
                    onPressed: () async {
                      // FocusScope.of(context).unfocus();
                      // if (_loginStore.userEmail.isNotEmpty &&
                      //     _loginStore.password.isNotEmpty) {
                      //   int score = await Future.delayed(
                      //       const Duration(milliseconds: 1000), () => 42);
                      //   return () {
                      //     _loginStore.login();
                      //   };
                      // } else {
                      //   FocusScope.of(context).unfocus();
                      //   warning("Username dan password tidak boleh kosong");
                      // }
                    },
                  ),
                ),
                if (_info != null)
                  Positioned(
                    top: 20.0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6.0,
                        horizontal: 12.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.yellowAccent,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 2),
                            blurRadius: 6.0,
                          )
                        ],
                      ),
                      child: Text(
                        '${_info.totalDistance}, ${_info.totalDuration}',
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void check(CameraUpdate u, GoogleMapController c) async {
    c.animateCamera(u);
    _googleMapController.animateCamera(u);
    LatLngBounds l1 = await c.getVisibleRegion();
    LatLngBounds l2 = await c.getVisibleRegion();
    print(l1.toString());
    print(l2.toString());
    if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90)
      check(u, c);
  }

  void _addMarker(LatLng pos) async {
    if (_origin == null || (_origin != null && _destination != null)) {
      // Origin is not set OR Origin/Destination are both set
      // Set origin
      setState(() {
        _origin = Marker(
          markerId: const MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon: pinSource,
          position: pos,
        );
        // Reset destination
        _destination = null;

        // Reset info
        _info = null;
      });
    } else {
      // Origin is already set
      // Set destination
      setState(() {
        _destination = Marker(
          markerId: const MarkerId('destination'),
          infoWindow: const InfoWindow(title: 'Destination'),
          icon: pinDest,
          position: pos,
        );
      });

      //Get directions
      final directions = await DirectionsRepository(dio: Dio())
          .getDirections(origin: _origin.position, destination: pos);
      setState(() => _info = directions);
    }
  }
}
