import 'package:deviley_production/FirstLoginDetails/aboutme.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationAutoDetails extends StatefulWidget {
  final String name;
  final String age;
  final String gender;
  final String marital;
  final String orientation;
  final List<String> addictionList;

  const LocationAutoDetails(
      {Key key,
      this.name,
      this.age,
      this.gender,
      this.marital,
      this.orientation,
      this.addictionList})
      : super(key: key);

  @override
  _LocationAutoDetailsState createState() => _LocationAutoDetailsState();
}

class _LocationAutoDetailsState extends State<LocationAutoDetails> {
  Geolocator geolocator = Geolocator();
  List<Placemark> fetchedLocation;
  Position fetchedLatitudeLongitude;

  Future<List> _getLocationName() async {
    var currentLocation;
    List<Placemark> placeMark;

    try {
      currentLocation = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      placeMark = await Geolocator().placemarkFromCoordinates(
          currentLocation.latitude, currentLocation.longitude);
    } catch (e) {
      currentLocation = null;
      placeMark = null;
    }
    return [placeMark, currentLocation];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getLocationName().then((name) {
      setState(() {
        fetchedLocation = name[0];
        fetchedLatitudeLongitude = name[1];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.pink[600]),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.pink[50],
      body: Container(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Center(
                  child: Text(
                    'My Location',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.purple, width: 2),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: fetchedLocation == null
                            ? Text(
                                'Fetching Location',
                                style: TextStyle(fontSize: 16),
                              )
                            : Text(
                                fetchedLocation[0].locality +
                                    ", " +
                                    fetchedLocation[0].country,
                                style: TextStyle(fontSize: 16),
                              ),
                      ),
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Builder(
                      builder: (context) => FlatButton(
                        onPressed: () {
                          if (fetchedLocation != null) {
                            Navigator.pop(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        LocationAutoDetails()));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AboutDetails(
                                          name: widget.name,
                                          age: widget.age,
                                          gender: widget.gender,
                                          marital: widget.marital,
                                          orientation: widget.orientation,
                                          addictionList: widget.addictionList,
                                          cityName: fetchedLocation[0].locality,
                                          countryName:
                                              fetchedLocation[0].country,
                                          cityLatitude:
                                              fetchedLatitudeLongitude.latitude,
                                          cityLongitude:
                                              fetchedLatitudeLongitude
                                                  .longitude,
                                        )));
                          } else {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'Location Couldn\'t fetched automatically.'),
                              duration: Duration(seconds: 3),
                            ));
                          }
                        },
                        child: Text('Next'),
                        splashColor: Colors.transparent,
                        color: Colors.pink[600],
                        highlightColor: Colors.pinkAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        padding: EdgeInsets.fromLTRB(50, 15, 50, 15),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
