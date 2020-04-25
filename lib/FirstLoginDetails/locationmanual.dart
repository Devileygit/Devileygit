import 'dart:async';
import 'package:deviley_production/FirstLoginDetails/aboutme.dart';
import 'package:deviley_production/services/customdropdown.dart' as custom;
import 'package:flutter/material.dart';

class LocationManualDetails extends StatefulWidget {
  final String name;
  final String age;
  final String gender;
  final String marital;
  final String orientation;
  final List<String> addictionList;

  const LocationManualDetails({Key key,
    this.name,
    this.age,
    this.gender,
    this.marital,
    this.orientation,
    this.addictionList})
      : super(key: key);

  @override
  _LocationManualDetailsState createState() => _LocationManualDetailsState();
}

class _LocationManualDetailsState extends State<LocationManualDetails> {
  final GlobalKey dropdownKey = GlobalKey();
  final GlobalKey dropdownKey2 = GlobalKey();

  List<Countries> _countries = Countries.getCountries();
  List<Cities> _cities = Cities.getCities();
  List<custom.DropdownMenuItem<Cities>> _dropdownMenuItemsCity;
  List<custom.DropdownMenuItem<Countries>> _dropdownMenuItemsCountry;
  Countries _selectedCountry;
  Cities _selectedCities;

  String countryName;
  String cityName;
  double cityLatitude;
  double cityLongitude;

  String cityCountry;

  List<custom.DropdownMenuItem<Countries>> buildDropdownMenuItemsCountry(
      List countries) {
    List<custom.DropdownMenuItem<Countries>> items = List();
    for (Countries countries in countries) {
      items.add(
        custom.DropdownMenuItem(
          value: countries,
          child: Text(countries.country),
        ),
      );
    }
    return items;
  }

  List<custom.DropdownMenuItem<Cities>> buildDropdownMenuItemsCity(
      List cities) {
    List<custom.DropdownMenuItem<Cities>> items = List();
    for (Cities cities in cities) {
      items.add(custom.DropdownMenuItem(
        value: cities,
        child: Text(cities.city),
      ));
    }
    return items;
  }

  onChangedDropdownItemCountry(Countries _selected) {
    setState(() {
      _selectedCountry = _selected;
      countryName = _selected.country;
      simulateClick();
    });
  }

  onChangedDropdownItemCity(Cities _selected) {
    setState(() {
      _selectedCities = _selected;
      cityName = _selected.city;
      cityLatitude = _selected.latitude;
      cityLongitude = _selected.longitude;
      cityCountry=_selected.city+ ", " + countryName;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dropdownMenuItemsCountry = buildDropdownMenuItemsCountry(_countries);
    _dropdownMenuItemsCity = buildDropdownMenuItemsCity(_cities);
  }

  void simulateClick() {
    Timer(Duration(milliseconds: 200), () {
      custom.CustomDropdownButtonState state = dropdownKey.currentState;
      state.callTap();
    });
  }

  void simulateClick2() {
    Timer(Duration(milliseconds: 100), () {
      custom.CustomDropdownButtonState state = dropdownKey2.currentState;
      state.callTap();
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
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.purple, width: 2),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: cityName == null
                        ? (custom.CustomDropdownButtonHideUnderline(
                      child: _selectedCountry == null
                          ? custom.CustomDropdownButton(
                        hint: Text("Select Location"),
                        key: dropdownKey2,
                        value: _selectedCountry,
                        items: _dropdownMenuItemsCountry,
                        onChanged: onChangedDropdownItemCountry,
                      )
                          : custom.CustomDropdownButton(
                        hint: Text("Select Location"),
                        key: dropdownKey,
                        value: _selectedCities,
                        items: _dropdownMenuItemsCity,
                        onChanged: onChangedDropdownItemCity,
                      ),
                    ))
                        : InkWell(
                      onTap: () {
                        setState(() {
                          cityName = null;
                          _selectedCountry = null;
                          _selectedCities = null;
                          simulateClick2();
                          print('tapped');
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Center(
                            child: Text(
                              cityCountry,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.grey[700],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Builder(
                      builder:(context)=> FlatButton(
                        onPressed: () {
                          if(cityName!=null) {
                            Navigator.pop(context, MaterialPageRoute(
                                builder: (context) => LocationManualDetails()));
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) =>
                                    AboutDetails(name: widget.name,
                                      age: widget.age,
                                      gender: widget.gender,
                                      marital: widget.marital,
                                      orientation: widget.orientation,
                                      addictionList: widget.addictionList,
                                      cityName: cityName,
                                      countryName: countryName,
                                      cityLatitude: cityLatitude,
                                      cityLongitude: cityLongitude,)));
                          }
                          else{
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text('Select a location.'),
                              backgroundColor: Colors.purple[600],
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

class Countries {
  String country;

  Countries(this.country);

  static List<Countries> getCountries() {
    return <Countries>[
      Countries('India'),
    ];
  }
}

class Cities {
  String city;
  double latitude;
  double longitude;

  Cities(this.city, this.latitude, this.longitude);

  static List<Cities> getCities() {
    return <Cities>[
      Cities('Agartala', 23.8315, 91.2868),
      Cities('Agra', 27.1767, 78.0081),
      Cities('Ahmedabad', 23.0225, 72.5714),
      Cities('Aizawl', 23.7307, 92.7173),
      Cities('Aligarh', 27.8974, 78.0880),
      Cities('Amaravati', 16.5131, 80.5165),
      Cities('Amritsar', 31.6340, 74.8723),
      Cities('Asansol', 23.6889, 86.9661),
      Cities('Bareilly', 28.3670, 79.4304),
      Cities('Bengaluru', 12.9716, 77.5946),
      Cities('Bhilai', 21.1938, 81.3509),
      Cities('Bhopal', 23.2599, 77.4126),
      Cities('Bhubaneswar', 20.2961, 85.8245),
      Cities('Chandigarh', 30.7333, 76.7794),
      Cities('Chennai', 13.0827, 80.2707),
      Cities('Cherrapunji', 25.2702, 91.7323),
      Cities('Coimbatore', 11.0168, 76.9558),
      Cities('Cuttack', 20.4625, 85.8830),
      Cities('Daman', 20.3974, 72.8328),
      Cities('Dehradun', 30.3165, 78.0322),
      Cities('Dhanbad', 23.7957, 86.4304),
      Cities('Dharamshala', 32.2190, 76.3234),
      Cities('Dimapur', 25.9091, 93.7266),
      Cities('Dispur', 26.1433, 91.7898),
      Cities('Durgapur', 23.5204, 87.3119),
      Cities('Faridabad', 28.4089, 77.3178),
      Cities('Gandhinagar', 23.2156, 72.6369),
      Cities('Gangtok', 27.3314, 88.6138),
      Cities('Gaya', 24.7914, 85.0002),
      Cities('Ghaziabad', 28.6692, 77.4538),
      Cities('Gurugram', 28.4595, 77.0266),
      Cities('Guwahati', 26.1445, 91.7362),
      Cities('Gwalior', 26.2183, 78.1828),
      Cities('Haridwar', 29.9457, 78.1642),
      Cities('Hyderabad', 17.3850, 78.4867),
      Cities('Imphal', 24.8170, 93.9368),
      Cities('Indore', 22.7196, 75.8577),
      Cities('Itanagar', 27.0844, 93.6053),
      Cities('Jabalpur', 23.1815, 79.9864),
      Cities('Jaipur', 26.9124, 75.7873),
      Cities('Jalandhar', 31.3260, 75.5762),
      Cities('Jammu', 32.7266, 74.8570),
      Cities('Jamshedpur', 22.8046, 86.2029),
      Cities('Jhansi', 25.4484, 78.5685),
      Cities('Jodhpur', 26.2389, 73.0243),
      Cities('Kanpur', 26.4499, 80.3319),
      Cities('Kargil', 34.5539, 76.1349),
      Cities('Kavaratti', 10.5593, 72.6358),
      Cities('Kochi', 9.9312, 76.2673),
      Cities('Kohima', 25.6751, 94.1086),
      Cities('Kolkata', 22.5726, 88.3639),
      Cities('Kota', 25.2138, 75.8648),
      Cities('Kozhikode', 11.2588, 75.7804),
      Cities('Kullu', 31.9592, 77.1089),
      Cities('Leh', 34.1526, 77.5771),
      Cities('Lucknow', 26.84671, 80.9462),
      Cities('Ludhiana', 30.9010, 75.8573),
      Cities('Lunglei', 22.8671, 92.7655),
      Cities('Madurai', 9.9252, 78.1198),
      Cities('Mangaluru', 12.9141, 74.8560),
      Cities('Meerut', 28.9845, 77.7064),
      Cities('Mormugao', 15.3889, 73.8166),
      Cities('Mumbai', 19.0760, 72.8777),
      Cities('Muzaffarpur', 26.1197, 85.3910),
      Cities('Mysuru', 12.2958, 76.6394),
      Cities('Nagpur', 21.1458, 79.0882),
      Cities('Namchi', 21.1458, 79.0882),
      Cities('New Delhi', 28.6139, 77.2090),
      Cities('Panaji', 15.4909, 73.8278),
      Cities('Patna', 25.5941, 85.1376),
      Cities('Puducherry', 11.9416, 79.8083),
      Cities('Port Blair', 11.6234, 92.7265),
      Cities('Prayagraj', 25.4358, 81.8463),
      Cities('Pune', 18.5204, 73.8567),
      Cities('Raipur', 21.2514, 81.6296),
      Cities('Ranchi', 23.3441, 85.3096),
      Cities('Roorkee', 29.8543, 77.8880),
      Cities('Rourkela', 22.2604, 84.8536),
      Cities('Shillong', 25.5788, 91.8933),
      Cities('Shimla', 31.1048, 77.1734),
      Cities('Silchar', 24.8333, 92.7789),
      Cities('Siliguri', 26.7271, 88.3953),
      Cities('Srinagar', 34.0837, 74.7973),
      Cities('Surat', 21.1702, 72.8311),
      Cities('Thiruvananthapuram', 8.5241, 76.9366),
      Cities('Tiruchirappalli', 10.7905, 78.7047),
      Cities('Varanasi', 25.3176, 82.9739),
      Cities('Vijayawada', 16.5062, 80.6480),
      Cities('Visakhapatnam', 17.6868, 83.2185),
      Cities('Warangal', 17.9689, 79.5941),
    ];
  }
}