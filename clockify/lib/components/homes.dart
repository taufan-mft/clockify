import 'dart:async';

import 'package:clockify/components/bghome.dart';
import 'package:clockify/components/savedItem.dart';
import 'package:clockify/constants.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class homes extends StatefulWidget {
  homes({Key? key}) : super(key: key);

  @override
  _homesState createState() => _homesState();
}

class _homesState extends State<homes> {

  bool _isVisible = true;
  var _click = true;
  
  //stopwatch
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  int seconds = 0, minutes = 0, hours = 0;
  String digitSec = "00", digitMin = "00", digitHou = "00";
  Timer? timer;
  bool started = false;
  bool stopped = false;
  bool saved = false;

  //date
  String date = "-";
  String datee = "-";

  //time
  String time = "-";
  String timee = "-";

  //location
  String latitudeData = "";


  //dropdown
  final items = [ "Latest Date", "Nearby"];
  String? value;

  //stop
  void stop(){
    stopped = true;
    saved = true;
    timer!.cancel();
    setState(() {
      started = false;
      getdatee();
      gettimee();
    });
  }
  
  //reset
  void reset(){
    timer!.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;

      digitSec = "00";
      digitMin = "00";
      digitHou = "00";

      started = false;
      date = "-";
      datee = "-";
      time = "-";
      timee = "-";

      _isVisible = !_isVisible;
    });
    if(_isVisible){
      _click = true;
    }
  }

  //delete
  void delete(){
    timer!.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;

      digitSec = "00";
      digitMin = "00";
      digitHou = "00";

      started = false;
      date = "-";
      datee = "-";
      time = "-";
      timee = "-";

      _isVisible = !_isVisible;
    });
    if(_isVisible){
      _click = true;
    }
  }

  //save
  void save(){
    saved = true;

    setState(() {
   
      
    });

  }

  //start
  void start(){
    started = true;
    stopped = false;
    saved = false;
    timer = Timer.periodic(Duration(seconds: 1), (timer){
      int localSec = seconds + 1;
      int localMin = minutes;
      int localHou = hours;

      if(localSec > 59){
        if(localMin > 59){
          localHou++;
          localMin = 0;
        } else {
          localMin++;
          localSec = 0;
        }
      }
      setState(() {
        seconds = localSec;
        minutes = localMin;
        hours = localHou;

        digitSec = (seconds >= 10) ? "$seconds" : "0$seconds";
        digitMin = (minutes >= 10) ? "$minutes" : "0$minutes";
        digitHou = (hours >= 10) ? "$hours" : "0$hours";
      });
    });
    getdate();
    gettime();
  }

  void hide(){
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  //getdate
  void getdate(){
    date = DateFormat('d MMM y').format(DateTime.now());
  }
  void getdatee(){
    datee = DateFormat('d MMM y').format(DateTime.now());
  }

  //gettime
  void gettime(){
    time = DateFormat('Hms').format(DateTime.now());
  }
  void gettimee(){
    timee = DateFormat('Hms').format(DateTime.now());
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _stopWatchTimer.dispose(); 
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
  }
  


  getCurrentLocation () async {
    LocationPermission permission = await Geolocator.requestPermission();
    final position = await Geolocator
    .getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

      setState(() {
        latitudeData = "${position.latitude}"; 
      });
  }
  

  @override
  Widget build(BuildContext context) {
    return bghome(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 130),
          ),
          _tabSection(context),
        ],
      ),
    );
  }

  Widget _tabSection(BuildContext context) {
    return DefaultTabController(
      length: 2, 
      child: Column(
        children: <Widget>[
          Container(
            child: TabBar(
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  color: textColor,
                  width: 2
                  ),
                insets: EdgeInsets.symmetric(horizontal: 90),
              ),
              indicatorColor: textColor,
              tabs: [
                Tab(
                  child : Text(
                    "TIMER",
                    style: TextStyle(
                      color: textColor, 
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                      ),
                    )
                  ),
                Tab(
                  child : Text(
                    "ACTIVITY",
                    style: TextStyle(
                      color: textColor, 
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                      ),
                    )
                  ),
              ]),
          ),

          Container(
            // alignment: Alignment.center,
            height: 700,
            child: TabBarView(
              children: [ 
                Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(bottom: 450),
                      child: Text("$digitHou   :  $digitMin  :  $digitSec",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 250, left: 75),
                      child: Text("Start Time",
                      style: TextStyle(color: Colors.white,
                      fontSize: 14),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 290, left: 70),
                      child: Text(
                        "$time",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 330, left: 72),
                      child: Text(
                        "$date",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 250, left: 295),
                      child: Text("End Time",
                      style: TextStyle(color: Colors.white,
                      fontSize: 14),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 290, left: 280),
                      child: Text(
                        "$timee",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 330, left: 282),
                      child: Text(
                        "$datee",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),

                    Container(
                      width: 300,
                      height: 48,
                      margin: EdgeInsets.only(top: 400, left: 65),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: locationButton
                      ),
                      child: Stack(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 32, top: 12),
                            child : Image.asset(
                            "assets/icons/nav.png",
                            height: 24,
                            width: 16,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 17, left: 120),
                            child: Text(
                            latitudeData,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ), 
                          ),
                        ],
                      ),
                    ),
   
                    Container(
                      width: 370,
                      margin: EdgeInsets.only(top: 473, left: 30),
                      child: TextField(
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: ("Write your activity here ..."),
                          hintStyle: TextStyle(
                            color: lineColor, 
                            fontSize: 14
                            ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)
                          ),
                          fillColor: Colors.white,
                          filled: true
                        ),
                      ),
                    ),
                    
                    Stack(
                      children: [
                        Container(
                          width: 175,
                          height: 48,
                          margin: EdgeInsets.only(top: 635, left: 225),
                          child: ElevatedButton(
                            onPressed: (){
                              (!stopped)? reset() : delete();
                              // reset();
                            },
                              child: Text((!stopped) ? "RESET" : "DELETE", 
                              // child: Text("RESET",
                              style: TextStyle(
                                color: lineColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                              shadowColor: Colors.black,
                              primary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        
                        Container(
                          width: 175,
                          height: 48,
                          margin: EdgeInsets.only(top: 635, left: 30),
                          child: ElevatedButton(
                            onPressed: () {
                                if(_click){
                                  _click = false;
                                  stop();
                                }
                                (!stopped)? stop() : save();
                              },
                              child: Text((!stopped) ? "STOP" : "SAVE", 
                            // child: Text("STOP",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              shadowColor: Colors.black,
                              primary: buttonColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),

                        Container(
                          width: 370,
                          height: 48,
                          margin: EdgeInsets.only(left: 30, top: 635),
                          child: Visibility(
                            visible: _isVisible,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _isVisible = !_isVisible;
                                });
                                start();
                                // (!started) ? start() : stop();
                                // (!started) ? getdatee() : getdate();
                                // (!started) ? gettimee() : gettime();
                              }, 
                              // child: Text((!started) ? "START" : "STOP",
                              child: Text("START",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                shadowColor: Colors.black,
                                primary: buttonColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],                                
                    ),                
                  ],
                ),

                Stack(
                  children: [
                    Container(
                      width: 220,
                      height: 40,
                      margin: EdgeInsets.only(left: 30, top: 30),
                      child: TextField(
                        decoration: InputDecoration(
                          suffixIcon: Image.asset("assets/icons/search.png"),
                          contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: ("Search Activity"),
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: lineColor,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)
                          ),
                        ),                       
                      ),
                    ),
                    Container(
                      width: 130,
                      height: 40,
                      margin: EdgeInsets.only(left: 260, top: 30),
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: locationButton,
                        borderRadius: BorderRadius.circular(12)
                      ),
                      child: DropdownButton<String>(
                        value: value,
                        isExpanded: true,
                        dropdownColor: locationButton,
                        underline: SizedBox(),
                        borderRadius: BorderRadius.circular(12),
                        icon: Image.asset('assets/icons/down.png'),
                        items: items.map(menuItem).toList(),
                        onChanged: (value) => setState(() => this.value = value),
                        ), 
                    ),
                    Column(
                      children: [
                        savedItem()
                      ],
                    ),
                  ],
                ),     
                
              ]
            ),
          ),   
        ],
      )
    );
  }
  DropdownMenuItem<String> menuItem(String item) => DropdownMenuItem(
    value: item,
    child: Text(
      item,
      style: TextStyle(
        color: Colors.white,
        fontSize: 14
      ),
    ),
  );
}

 
