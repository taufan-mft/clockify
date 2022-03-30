import 'package:clockify/models/ActivityModel.dart';
import 'package:clockify/provider/ActivityJson.dart';
import 'package:clockify/provider/ActivityState.dart';
import 'package:flutter/material.dart';
import 'package:clockify/constants.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/database.dart';

class DetailActivity extends StatefulWidget {
  final ActivityJson activity;
  const DetailActivity({Key? key, required this.activity}) : super(key: key);

  @override
  _DetailActivityState createState() => _DetailActivityState();
}

class _DetailActivityState extends State<DetailActivity> {
  NumberFormat f = NumberFormat("00");
  final TextEditingController _controller = TextEditingController();

  _saveData() async {
    widget.activity.setAct = _controller.text;
    context.read<ActivityState>().updateActivity(widget.activity);
    Navigator.pop(context);
  }

  _deleteData() async {
    context.read<ActivityState>().deleteActivity(widget.activity.id!);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _controller.text = widget.activity.activity!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: const Text('Detail'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          Text(widget.activity.start?.substring(0,10) ?? '',
              style: const TextStyle(color: textColor, fontSize: 16)),
          Expanded(child: Container(),),
          Text(
            '${f.format(widget.activity.hour)} : ${f.format(widget.activity.minute)} : ${f.format(widget.activity.second)}',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 40),
          ),
          Expanded(child: Container(),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 24,
              ),
              Column(
                children: [
                  const Text(
                    'Start Time',
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    widget.activity.start?.substring(10,18) ?? '',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    widget.activity.start?.substring(0,10) ?? '',
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
              Expanded(
                child: Container(),
              ),
              Column(
                children: [
                  const Text(
                    'End Time',
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    widget.activity.end?.substring(10,18) ?? '',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    widget.activity.end?.substring(0, 10) ?? '',
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(
                width: 24,
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 8),
            child: Container(
              decoration: BoxDecoration(
                  color: locationButton,
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.location_pin, size: 28, color: Colors.red),
                    Text(
                      widget.activity.latitude.toString(),
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 8),
            child: TextField(
              controller: _controller,
              maxLines: 4,
              decoration: InputDecoration(
                  hintText: ("Write your activity here ..."),
                  hintStyle: const TextStyle(color: lineColor, fontSize: 14),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  fillColor: Colors.white,
                  filled: true),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _saveData,
                  child: const Text(
                    "SAVE",
                    // child: Text("STOP",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.black,
                    primary: buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
                ElevatedButton(
                    onPressed: _deleteData,
                    child: const Text(
                      'DELETE',
                      style: TextStyle(
                          color: lineColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.black,
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ))
              ],
            ),
          ),
          const SizedBox(height: 20,)
        ],
      ),
    );
  }
}
