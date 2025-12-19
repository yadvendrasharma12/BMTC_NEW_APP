import 'package:bmtc_app/app/core/app_colors.dart';
import 'package:bmtc_app/app/core/text_style.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:geocoding/geocoding.dart';

class MapsLocationScreen extends StatefulWidget {
  const MapsLocationScreen({super.key});

  @override
  State<MapsLocationScreen> createState() => _MapsLocationScreenState();
}

class _MapsLocationScreenState extends State<MapsLocationScreen> {
  LatLng selectedLatLng =  LatLng(28.6139, 77.2090);
  GoogleMapController? mapController;

  final TextEditingController placeSearchController = TextEditingController();
  final Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    _setMarker(selectedLatLng);
  }

  void _setMarker(LatLng position) {
    markers.clear();
    markers.add(
      Marker(
        markerId:  MarkerId("selected"),
        position: position,
        draggable: true,
        onDragEnd: (newPos) {
          _updateLocation(newPos);
        },
      ),
    );

    setState(() {
      selectedLatLng = position;
    });
  }

  Future<void> _updateLocation(LatLng position) async {
    _setMarker(position);

    mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(position, 16),
    );

    try {
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        placeSearchController.text =
        "${placemarks.first.name}, ${placemarks.first.locality}";
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Location")),
      body: Column(
        children: [
          /// 🔍 SEARCH BAR
          Padding(
            padding: const EdgeInsets.all(12),
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(12),
              child: GooglePlaceAutoCompleteTextField(
                textEditingController: placeSearchController,
                googleAPIKey: "AIzaSyDhzH8bgVZJs5LFUlpAvIjYHU4w8fdOmE0",
                debounceTime: 800,
                countries: const ["in"],
                isLatLngRequired: true,

                inputDecoration: InputDecoration(
                  hintText: "Search location",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),

                getPlaceDetailWithLatLng: (prediction) {
                  if (prediction.lat == null ||
                      prediction.lng == null) return;

                  final lat = double.parse(prediction.lat!);
                  final lng = double.parse(prediction.lng!);

                  _updateLocation(LatLng(lat, lng));
                },

                itemClick: (prediction) {
                  placeSearchController.text =
                      prediction.description ?? "";
                  FocusScope.of(context).unfocus();
                },

                itemBuilder: (context, index, prediction) {
                  return ListTile(
                    leading:
                    const Icon(Icons.location_on, color: Colors.red),
                    title: Text(prediction.description ?? ""),
                  );
                },

                seperatedBuilder: const Divider(),
                isCrossBtnShown: true,
              ),
            ),
          ),

          /// 🗺 MAP
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: selectedLatLng,
                zoom: 15,
              ),
              onMapCreated: (controller) {
                mapController = controller;
              },
              markers: markers,
              onTap: _updateLocation,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
            ),
          ),


          Padding(padding: const EdgeInsets.only(bottom: 20,left: 16,right: 16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(16),
                backgroundColor: AppColors.primaryColor,
                ),
                onPressed: () {
                  Navigator.pop(context, selectedLatLng);
                },
                child:  Text("Select Location",style: AppTextStyles.button,),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
