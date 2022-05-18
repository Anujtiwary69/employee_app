import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:jobtrackeremployee/screens/job_detail_screen.dart';
import 'package:provider/provider.dart';

import '../constants/app_colors.dart';
import '../constants/app_dimens.dart';
import '../providers/job_provider.dart';
import '../widgets/app_text_field_widget.dart';

class JobFinder extends StatefulWidget {
  const JobFinder({Key? key}) : super(key: key);

  @override
  State<JobFinder> createState() => _JobFinderState();
}

class _JobFinderState extends State<JobFinder> {
  late GoogleMapController mapController; //contrller for Google map
  final Set<Marker> markers = new Set(); //markers for google map
  static const LatLng showLocation = const LatLng(27.7089427, 85.3086209);
  //location to show in map
  getjobData(JobProvider provider) async {
    setState(() {
      isLoading = true;
    });
    await provider.getJobListNew(context);
    setState(() {
      isLoading = false;
    });
  }

  bool isFirst = false;
  bool isLoading = false;
  bool isLoadingFirst = false;
  String googleApikey = "AIzaSyCCn8zUfCj8hBImHLHqK_tZdfpMmUBPbzE";
  String location = "Search Location";

  @override
  Widget build(BuildContext context) {
    var providerData = Provider.of<JobProvider>(context);
    if (isFirst == false) {
      getjobData(providerData);

      isFirst = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Job Finder",
          textAlign: TextAlign.center,
        ),
        backgroundColor: AppColors.appColor,
      ),
      body: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: true,
            //Map widget from google_maps_flutter package
            zoomGesturesEnabled: true, //enable Zoom in, out on map
            initialCameraPosition: CameraPosition(
              //innital position in map
              target: showLocation, //initial position
              zoom: 15.0, //initial zoom level
            ),
            markers: getmarkers(providerData), //markers to show on map
            mapType: MapType.normal, //map type
            onMapCreated: (controller) {
              //method called when map is created
              setState(() {
                mapController = controller;
              });
            },
          ),
          //search autoconplete input
          Positioned(  //search input bar
              top:10,
              child: InkWell(
                  onTap: () async {
                    var place = await PlacesAutocomplete.show(
                        context: context,
                        apiKey: googleApikey,
                        mode: Mode.overlay,
                        types: [],
                        strictbounds: false,
                        components: [Component(Component.country, 'au')],
                        //google_map_webservice package
                        onError: (err){
                          print(err);
                        }
                    );

                    if(place != null){
                      setState(() {
                        location = place.description.toString();
                      });

                      //form google_maps_webservice package
                      final plist = GoogleMapsPlaces(apiKey:googleApikey,
                        apiHeaders: await GoogleApiHeaders().getHeaders(),
                        //from google_api_headers package
                      );
                      String placeid = place.placeId ?? "0";
                      final detail = await plist.kgetDetailsByPlaceId(placeid);
                      final geometry = detail.result.geometry!;
                      final lat = geometry.location.lat;
                      final lang = geometry.location.lng;
                      var newlatlang = LatLng(lat, lang);


                      //move map camera to selected place with animation
                      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: newlatlang, zoom: 17)));
                    }
                  },
                  child:Padding(
                    padding: EdgeInsets.all(15),
                    child: Card(
                      child: Container(
                          padding: EdgeInsets.all(0),
                          width: MediaQuery.of(context).size.width - 40,
                          child: ListTile(
                            title:Text(location, style: TextStyle(fontSize: 18),),
                            trailing: Icon(Icons.search),
                            dense: true,
                          )
                      ),
                    ),
                  )
              )
          )
        ],
      ),
    );
  }

  Set<Marker> getmarkers(JobProvider providerData) {
    //markers to place on map
    print("ANUJ COunt");
    print(providerData.jobList1?.length);
    print("Count ends here");

    providerData.jobList1?.forEach((element) {
      setState(() {
        LatLng showLocation1 = LatLng(double.parse(element.lat.toString()),double.parse(element.lan.toString()));
        markers.add(Marker(
            //add first marker

            markerId: MarkerId(showLocation1.toString()),
            position: LatLng(double.parse(element.lat.toString()),
                double.parse(element.lan.toString())), //position of marker
            infoWindow: InfoWindow(
              //popup info
              title: element.title,
              snippet: element.address,
            ),
            icon: BitmapDescriptor.defaultMarker, //Icon for Marker
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context){
              //   JobDetailScreen(id:element.id.toString());
              //
              // }));
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          JobDetailScreen(id: element.id.toString(),apply: true,)));
            }));
        isLoadingFirst = true;
      });
    });
    // if (isLoadingFirst == false) {
    //   providerData.getJobList(context).then((value) {
    //     value.employeeJobs?.forEach((element) {
    //
    //     });
    //   });
    // }
    return markers;
  }
}
