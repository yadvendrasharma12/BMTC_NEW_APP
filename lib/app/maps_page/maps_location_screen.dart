// // import 'package:flutter/material.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:google_places_flutter/google_places_flutter.dart';
// // import 'package:geocoding/geocoding.dart';
// // import 'package:bmtc_app/app/core/app_colors.dart';
// // import 'package:bmtc_app/app/core/text_style.dart';
// //
// // class MapsLocationScreen extends StatefulWidget {
// //   const MapsLocationScreen({super.key});
// //
// //   @override
// //   State<MapsLocationScreen> createState() => _MapsLocationScreenState();
// // }
// //
// // class _MapsLocationScreenState extends State<MapsLocationScreen> {
// //   LatLng selectedLatLng = LatLng(28.6139, 77.2090); // Default: Delhi
// //   GoogleMapController? mapController;
// //
// //   final TextEditingController placeSearchController = TextEditingController();
// //   final Set<Marker> markers = {};
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _setMarker(selectedLatLng);
// //   }
// //
// //   void _setMarker(LatLng position) {
// //     markers.clear();
// //     markers.add(
// //       Marker(
// //         markerId: const MarkerId("selected"),
// //         position: position,
// //         draggable: true,
// //         onDragEnd: (newPos) {
// //           _updateLocation(newPos);
// //         },
// //       ),
// //     );
// //     selectedLatLng = position;
// //     setState(() {}); // Update map and marker
// //   }
// //
// //   Future<void> _updateLocation(LatLng position) async {
// //     _setMarker(position);
// //
// //     // Move camera
// //     mapController?.animateCamera(
// //       CameraUpdate.newLatLngZoom(position, 16),
// //     );
// //
// //     try {
// //       final placemarks = await placemarkFromCoordinates(
// //         position.latitude,
// //         position.longitude,
// //       );
// //       if (placemarks.isNotEmpty) {
// //         final place = placemarks.first;
// //         placeSearchController.text =
// //         "${place.name ?? ''}, ${place.locality ?? ''}";
// //       }
// //     } catch (e) {
// //       debugPrint("Error getting placemark: $e");
// //     }
// //   }
// //
// //   @override
// //   void dispose() {
// //     placeSearchController.dispose();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text("Select Location")),
// //       body: Column(
// //         children: [
// //           // 🔍 Search Bar
// //           Padding(
// //             padding: const EdgeInsets.all(12),
// //             child: Material(
// //               elevation: 4,
// //               borderRadius: BorderRadius.circular(12),
// //               child: GooglePlaceAutoCompleteTextField(
// //                 textEditingController: placeSearchController,
// //                 googleAPIKey:"AIzaSyAaEUKGNSlJ3VaQhi8xt8GOiSe1IfpkKpw",
// //                 debounceTime: 800,
// //                 countries: const ["in"],
// //                 isLatLngRequired: true,
// //                 inputDecoration: InputDecoration(
// //                   hintText: "Search location",
// //                   prefixIcon: const Icon(Icons.search),
// //                   filled: true,
// //                   fillColor: Colors.white,
// //                   border: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(12),
// //                     borderSide: BorderSide.none,
// //                   ),
// //                 ),
// //                 getPlaceDetailWithLatLng: (prediction) {
// //                   if (prediction.lat == null || prediction.lng == null) return;
// //                   final lat = double.tryParse(prediction.lat!) ?? 0;
// //                   final lng = double.tryParse(prediction.lng!) ?? 0;
// //                   _updateLocation(LatLng(lat, lng));
// //                 },
// //                 itemClick: (prediction) {
// //                   placeSearchController.text = prediction.description ?? "";
// //                   FocusScope.of(context).unfocus();
// //                 },
// //                 itemBuilder: (context, index, prediction) {
// //                   return ListTile(
// //                     leading: const Icon(Icons.location_on, color: Colors.red),
// //                     title: Text(prediction.description ?? ""),
// //                   );
// //                 },
// //                 seperatedBuilder: const Divider(),
// //                 isCrossBtnShown: true,
// //               ),
// //             ),
// //           ),
// //
// //           // 🗺 Map
// //           Expanded(
// //             child: GoogleMap(
// //               initialCameraPosition: CameraPosition(
// //                 target: selectedLatLng,
// //                 zoom: 15,
// //               ),
// //               onMapCreated: (controller) => mapController = controller,
// //               markers: markers,
// //               onTap: _updateLocation,
// //               myLocationButtonEnabled: true,
// //               myLocationEnabled: true,
// //             ),
// //           ),
// //
// //           // ✅ Select Button
// //           Padding(
// //             padding: const EdgeInsets.only(bottom: 20, left: 16, right: 16),
// //             child: SizedBox(
// //               width: double.infinity,
// //               child: ElevatedButton(
// //                 style: ElevatedButton.styleFrom(
// //                   padding: const EdgeInsets.all(16),
// //                   backgroundColor: AppColors.primaryColor,
// //                 ),
// //                 onPressed: () => Navigator.pop(context, selectedLatLng),
// //                 child: Text(
// //                   "Select Location",
// //                   style: AppTextStyles.button,
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
//
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_places_flutter/google_places_flutter.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:bmtc_app/app/core/app_colors.dart';
// import 'package:bmtc_app/app/core/text_style.dart';
//
// class MapsLocationScreen extends StatefulWidget {
//   final double? initialLat;
//   final double? initialLng;
//   final bool isViewOnly; // VIEW mode
//
//   const MapsLocationScreen({
//     super.key,
//     this.initialLat,
//     this.initialLng,
//     this.isViewOnly = false,
//   });
//
//   @override
//   State<MapsLocationScreen> createState() => _MapsLocationScreenState();
// }
//
// class _MapsLocationScreenState extends State<MapsLocationScreen> {
//   late LatLng selectedLatLng;
//   GoogleMapController? mapController;
//
//   final TextEditingController placeSearchController = TextEditingController();
//   final Set<Marker> markers = {};
//
//   @override
//   void initState() {
//     super.initState();
//
//     // ✅ Initial LatLng
//     if (widget.initialLat != null && widget.initialLng != null) {
//       selectedLatLng = LatLng(widget.initialLat!, widget.initialLng!);
//     } else {
//       selectedLatLng = const LatLng(28.6139, 77.2090); // Default: Delhi
//     }
//
//     _setMarker(selectedLatLng);
//   }
//
//   void _setMarker(LatLng position) {
//     markers.clear();
//     markers.add(
//       Marker(
//         markerId: const MarkerId("selected"),
//         position: position,
//         draggable: widget.isViewOnly ? false : true,
//         onDragEnd: (newPos) {
//           if (!widget.isViewOnly) _updateLocation(newPos);
//         },
//       ),
//     );
//     selectedLatLng = position;
//     setState(() {});
//   }
//
//   Future<void> _updateLocation(LatLng position) async {
//     if (widget.isViewOnly) return; // VIEW mode me update nahi karenge
//
//     _setMarker(position);
//
//     // Move camera
//     mapController?.animateCamera(
//       CameraUpdate.newLatLngZoom(position, 16),
//     );
//
//     try {
//       final placemarks = await placemarkFromCoordinates(
//         position.latitude,
//         position.longitude,
//       );
//       if (placemarks.isNotEmpty) {
//         final place = placemarks.first;
//         placeSearchController.text =
//         "${place.name ?? ''}, ${place.locality ?? ''}";
//       }
//     } catch (e) {
//       debugPrint("Error getting placemark: $e");
//     }
//   }
//
//   @override
//   void dispose() {
//     placeSearchController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Select Location")),
//       body: Column(
//         children: [
//           // 🔍 Search Bar (only if not view mode)
//           if (!widget.isViewOnly)
//             Padding(
//               padding: const EdgeInsets.all(12),
//               child: Material(
//                 elevation: 4,
//                 borderRadius: BorderRadius.circular(12),
//                 child: GooglePlaceAutoCompleteTextField(
//                   textEditingController: placeSearchController,
//                   googleAPIKey:
//                   "AIzaSyAaEUKGNSlJ3VaQhi8xt8GOiSe1IfpkKpw",
//                   debounceTime: 800,
//                   countries: const ["in"],
//                   isLatLngRequired: true,
//                   inputDecoration: InputDecoration(
//                     hintText: "Search location",
//                     prefixIcon: const Icon(Icons.search),
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                   getPlaceDetailWithLatLng: (prediction) {
//                     if (prediction.lat == null || prediction.lng == null) return;
//                     final lat = double.tryParse(prediction.lat!) ?? 0;
//                     final lng = double.tryParse(prediction.lng!) ?? 0;
//                     _updateLocation(LatLng(lat, lng));
//                   },
//                   itemClick: (prediction) {
//                     placeSearchController.text = prediction.description ?? "";
//                     FocusScope.of(context).unfocus();
//                   },
//                   itemBuilder: (context, index, prediction) {
//                     return ListTile(
//                       leading: const Icon(Icons.location_on, color: Colors.red),
//                       title: Text(prediction.description ?? ""),
//                     );
//                   },
//                   seperatedBuilder: const Divider(),
//                   isCrossBtnShown: true,
//                 ),
//               ),
//             ),
//
//           // 🗺 Map
//           Expanded(
//             child: GoogleMap(
//               initialCameraPosition: CameraPosition(
//                 target: selectedLatLng,
//                 zoom: 15,
//               ),
//               onMapCreated: (controller) => mapController = controller,
//               markers: markers,
//               onTap: widget.isViewOnly ? null : _updateLocation,
//               myLocationButtonEnabled: !widget.isViewOnly,
//               myLocationEnabled: !widget.isViewOnly,
//             ),
//           ),
//
//           // ✅ Select Button (only for new user)
//           if (!widget.isViewOnly)
//             Padding(
//               padding: const EdgeInsets.only(bottom: 20, left: 16, right: 16),
//               child: SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.all(16),
//                     backgroundColor: AppColors.primaryColor,
//                   ),
//                   onPressed: () => Navigator.pop(context, selectedLatLng),
//                   child: Text(
//                     "Select Location",
//                     style: AppTextStyles.button,
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_places_flutter/google_places_flutter.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:bmtc_app/app/core/app_colors.dart';
// import 'package:bmtc_app/app/core/text_style.dart';
//
// class MapsLocationScreen extends StatefulWidget {
//   final double? initialLat;
//   final double? initialLng;
//   final bool isViewOnly;
//
//   const MapsLocationScreen({
//     super.key,
//     this.initialLat,
//     this.initialLng,
//     this.isViewOnly = false,
//   });
//
//   @override
//   State<MapsLocationScreen> createState() => _MapsLocationScreenState();
// }
//
// class _MapsLocationScreenState extends State<MapsLocationScreen> {
//   late LatLng selectedLatLng;
//   GoogleMapController? mapController;
//   final TextEditingController placeSearchController = TextEditingController();
//   final FocusNode searchFocus = FocusNode();
//   final Set<Marker> markers = {};
//
//   @override
//   void initState() {
//     super.initState();
//     selectedLatLng = (widget.initialLat != null && widget.initialLng != null)
//         ? LatLng(widget.initialLat!, widget.initialLng!)
//         : const LatLng(28.6139, 77.2090);
//
//     _setMarker(selectedLatLng);
//   }
//
//   void _setMarker(LatLng position) {
//     markers.clear();
//     markers.add(
//       Marker(
//         markerId: const MarkerId("selected"),
//         position: position,
//         draggable: !widget.isViewOnly,
//         onDragEnd: (newPos) {
//           if (!widget.isViewOnly) _updateLocation(newPos);
//         },
//       ),
//     );
//     selectedLatLng = position;
//     setState(() {});
//   }
//
//   Future<void> _updateLocation(LatLng position) async {
//     if (widget.isViewOnly) return;
//
//     _setMarker(position);
//     mapController?.animateCamera(CameraUpdate.newLatLngZoom(position, 16));
//
//     try {
//       final placemarks =
//       await placemarkFromCoordinates(position.latitude, position.longitude);
//       if (placemarks.isNotEmpty) {
//         final place = placemarks.first;
//         placeSearchController.text =
//         "${place.name ?? ''}, ${place.locality ?? ''}";
//       }
//     } catch (e) {
//       debugPrint("Error getting placemark: $e");
//     }
//   }
//
//   @override
//   void dispose() {
//     placeSearchController.dispose();
//     searchFocus.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title:  Text("Select Location",style: AppTextStyles.dashBordButton3,),),
//       body: SafeArea(
//         child: Column(
//           children: [
//
//             if (!widget.isViewOnly)
//               Padding(
//                 padding: const EdgeInsets.all(12),
//                 child: Material(
//
//                   elevation: 4,
//                   borderRadius: BorderRadius.circular(12),
//                   child: GooglePlaceAutoCompleteTextField(
//
//                     textEditingController: placeSearchController,
//                     focusNode: searchFocus, // ✅ Proper focus
//                     googleAPIKey:
//                     "AIzaSyAaEUKGNSlJ3VaQhi8xt8GOiSe1IfpkKpw",
//                     debounceTime: 300,
//                     countries: const ["in"],
//                     isLatLngRequired: true,
//                     inputDecoration: InputDecoration(
//                       hintText: "Search location",
//                       prefixIcon: Icon(CupertinoIcons.search),
//
//                       filled: true,
//                       fillColor: Colors.white,
//                       border: OutlineInputBorder(
//
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide.none,
//                       ),
//                     ),
//                     getPlaceDetailWithLatLng: (prediction) {
//                       if (prediction.lat == null || prediction.lng == null) return;
//                       final lat = double.tryParse(prediction.lat!) ?? 0;
//                       final lng = double.tryParse(prediction.lng!) ?? 0;
//                       _updateLocation(LatLng(lat, lng));
//                     },
//                     itemClick: (prediction) {
//                       placeSearchController.text = prediction.description ?? "";
//                       FocusScope.of(context).unfocus();
//                     },
//                     itemBuilder: (context, index, prediction) {
//                       return ListTile(
//                         leading: const Icon(Icons.location_on, color: Colors.red),
//                         title: Text(prediction.description ?? ""),
//                       );
//                     },
//                     seperatedBuilder: const Divider(),
//                     isCrossBtnShown: true,
//                   ),
//                 ),
//               ),
//
//             // 🗺 Map
//             Expanded(
//               child: GoogleMap(
//                 initialCameraPosition: CameraPosition(
//                   target: selectedLatLng,
//                   zoom: 15,
//                 ),
//                 onMapCreated: (controller) => mapController = controller,
//                 markers: markers,
//                 onTap: widget.isViewOnly ? null : _updateLocation,
//                 myLocationButtonEnabled: !widget.isViewOnly,
//                 myLocationEnabled: !widget.isViewOnly,
//               ),
//             ),
//
//             // ✅ Select Button
//             if (!widget.isViewOnly)
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 20, left: 16, right: 16),
//                 child: SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.all(16),
//                       backgroundColor: AppColors.primaryColor,
//                     ),
//                     onPressed: () => Navigator.pop(context, selectedLatLng),
//                     child: Text(
//                       "Select Location",
//                       style: AppTextStyles.button,
//                     ),
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:bmtc_app/app/core/app_colors.dart';
import 'package:bmtc_app/app/core/text_style.dart';

class MapsLocationScreen extends StatefulWidget {
  final double? initialLat;
  final double? initialLng;
  final bool isViewOnly;

  const MapsLocationScreen({
    super.key,
    this.initialLat,
    this.initialLng,
    this.isViewOnly = false,
  });

  @override
  State<MapsLocationScreen> createState() => _MapsLocationScreenState();
}

class _MapsLocationScreenState extends State<MapsLocationScreen> {
  late LatLng selectedLatLng;
  GoogleMapController? mapController;

  final TextEditingController placeSearchController = TextEditingController();
  final FocusNode searchFocus = FocusNode();
  final Set<Marker> markers = {};

  String placeName = "";

  @override
  void initState() {
    super.initState();

    selectedLatLng = (widget.initialLat != null && widget.initialLng != null)
        ? LatLng(widget.initialLat!, widget.initialLng!)
        : const LatLng(28.6139, 77.2090); // Delhi default

    _setMarker(selectedLatLng);
    _fetchPlaceName(selectedLatLng);
  }

  void _setMarker(LatLng position) {
    markers.clear();
    markers.add(
      Marker(
        markerId: const MarkerId("selected"),
        position: position,
        draggable: !widget.isViewOnly,
        onDragEnd: (newPos) {
          if (!widget.isViewOnly) _updateLocation(newPos);
        },
        onTap: _showLocationPreview,
      ),
    );

    selectedLatLng = position;
    setState(() {});
  }

  Future<void> _fetchPlaceName(LatLng position) async {
    try {
      final placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        placeName =
        "${p.name ?? ''}, ${p.locality ?? ''}, ${p.administrativeArea ?? ''}";
        placeSearchController.text = placeName;
        setState(() {});
      }
    } catch (_) {}
  }

  Future<void> _updateLocation(LatLng position) async {
    if (widget.isViewOnly) return;

    _setMarker(position);
    mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(position, 16),
    );

    await _fetchPlaceName(position);
  }

  void _showLocationPreview() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                placeName.isNotEmpty ? placeName : "Selected Location",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // const SizedBox(height: 12),
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(12),
              //   child: Image.network(
              //     "https://maps.googleapis.com/maps/api/staticmap",
              //     fit: BoxFit.cover,
              //     errorBuilder: (context, error, stackTrace) {
              //       return Container(
              //         height: 200,
              //         color: Colors.grey.shade300,
              //         child: const Center(
              //           child: Text("Map image not available"),
              //         ),
              //       );
              //     },
              //   )
              // ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    placeSearchController.dispose();
    searchFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Select Location",
          style: AppTextStyles.dashBordButton3,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (!widget.isViewOnly)
              Padding(
                padding: const EdgeInsets.all(12),
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(12),
                  child: GooglePlaceAutoCompleteTextField(
                    textEditingController: placeSearchController,
                    focusNode: searchFocus,
                    googleAPIKey:
                    "AIzaSyAaEUKGNSlJ3VaQhi8xt8GOiSe1IfpkKpw",
                    debounceTime: 300,
                    countries: const ["in"],
                    isLatLngRequired: true,
                    inputDecoration: InputDecoration(
                      hintText: "Search location",
                      prefixIcon: const Icon(CupertinoIcons.search),
                      suffixIcon: placeSearchController.text.isNotEmpty
                          ? IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          placeSearchController.clear();
                          setState(() {});
                        },
                      )
                          : null,
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

                      final lat =
                          double.tryParse(prediction.lat!) ?? 0;
                      final lng =
                          double.tryParse(prediction.lng!) ?? 0;

                      _updateLocation(LatLng(lat, lng));
                    },
                    itemClick: (prediction) {
                      placeSearchController.text =
                          prediction.description ?? "";
                      FocusScope.of(context).unfocus();
                    },
                    itemBuilder: (context, index, prediction) {
                      return ListTile(
                        leading: const Icon(Icons.location_on,
                            color: Colors.red),
                        title:
                        Text(prediction.description ?? ""),
                      );
                    },
                    seperatedBuilder: const Divider(),
                    isCrossBtnShown: false,
                  ),
                ),
              ),

            Expanded(
              child: GoogleMap(

                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: selectedLatLng,
                  zoom: 15,
                ),
                onMapCreated: (controller) =>
                mapController = controller,
                markers: markers,
                onTap: widget.isViewOnly ? null : _updateLocation,
                myLocationButtonEnabled: !widget.isViewOnly,
                myLocationEnabled: !widget.isViewOnly,
              ),
            ),

            if (!widget.isViewOnly)
              Padding(
                padding:
                const EdgeInsets.fromLTRB(16, 8, 16, 20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      backgroundColor:
                      AppColors.primaryColor,
                    ),
                    onPressed: () =>
                        Navigator.pop(context, selectedLatLng),
                    child: Text(
                      "Select Location",
                      style: AppTextStyles.button,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
