import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';

import 'package:phone_state_background/phone_state_background.dart';

import 'dialog.dart';

/// Be sure to annotate @pragma('vm:entry-point') your callback function to avoid issues in release mode on Flutter >= 3.3.0
@pragma('vm:entry-point')

/// Defines a callback that will handle all background incoming events
Future<void> phoneStateBackgroundCallbackHandler(
    PhoneStateBackgroundEvent event,
    String number,
    int duration,
    ) async {
  switch (event) {
    case PhoneStateBackgroundEvent.incomingstart:
   print(">>>>>>>>>incoming call");


   Fluttertoast.showToast(
       msg: 'Incoming call start, number: $number',
       toastLength: Toast.LENGTH_LONG,
       gravity: ToastGravity.CENTER,
       timeInSecForIosWeb: 110,
       textColor: Colors.white70,
       fontSize: 16.0
   );
      log('Incoming call start, number: $number, duration: $duration s');


      break;
    case PhoneStateBackgroundEvent.incomingmissed:
      Fluttertoast.showToast(
          msg: 'Incoming call missed, number: $number',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 4,
          textColor: Colors.white70,
          fontSize: 16.0
      );
      log('Incoming call missed, number: $number, duration: $duration s');

      break;
    case PhoneStateBackgroundEvent.incomingreceived:

        Fluttertoast.showToast(
            msg: 'Incoming call received, number: $number, duration: $duration s',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 4,
            textColor: Colors.white70,
            fontSize: 16.0
        );
        print("call recived.....");

      log('Incoming call received, number: $number, duration: $duration s');

       EasyLoading.showToast("call reci sucessfully");

      print("call recived...>>>");


      break;
    case PhoneStateBackgroundEvent.incomingend:

      Fluttertoast.showToast(
          msg: 'Incoming call ended, number: $number, duration: $duration s',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 100,
          textColor: Colors.red,
          fontSize: 16.0
      );

      log('Incoming call ended, number: $number, duration $duration s');
      Text("call end ");
      break;
    case PhoneStateBackgroundEvent.outgoingstart:

      Fluttertoast.showToast(
          msg: 'Outgoing call start, number: $number, duration: $duration s',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 100,
          textColor: Colors.green,
          fontSize: 16.0
      );

      log('Outgoing call start, number: $number, duration: $duration s');
      break;
    case PhoneStateBackgroundEvent.outgoingend:
      Fluttertoast.showToast(
          msg: 'Outgoing call ended, number: $number, duration: $duration s',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 100,
          textColor: Colors.red,
          fontSize: 16.0
      );
      log('Outgoing call ended, number: $number, duration: $duration s');
      break;
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Phone State Background',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(title: 'Phone State Background'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  bool hasPermission = false;

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      await _hasPermission();
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _hasPermission();
    _requestPermission();
    _init();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _hasPermission() async {
    final permission = await PhoneStateBackground.checkPermission();
    if (mounted) {
      setState(() => hasPermission = permission);
    }
  }

  Future<void> _requestPermission() async {
    await PhoneStateBackground.requestPermissions();
  }

  Future<void> _stop() async {
    await PhoneStateBackground.stopPhoneStateBackground();
  }

  Future<void> _init() async {
    if (hasPermission != true) return;
    await PhoneStateBackground.initialize(phoneStateBackgroundCallbackHandler);
  }



  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Dialog Box'),
          content: Text('This is a dialog box.'),
          actions: [
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Has Permission: $hasPermission',
              style: TextStyle(
                fontSize: 16,
                color: hasPermission ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 180,
              child: ElevatedButton(
                onPressed: () => _requestPermission(),
                child: const Text('Check Permission'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SizedBox(
                width: 180,
                child: ElevatedButton(
                  onPressed: () => _init(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Background color
                  ),
                  child: const Text('Start Listener'),
                ),
              ),
            ),
            SizedBox(
              width: 180,
              child: ElevatedButton(
                onPressed: () => _stop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Background color
                ),
                child: const Text('Stop Listener'),
              ),
            ),
            ElevatedButton(onPressed: (){
              _showDialog(context);
            }, child: Text("Dilogbox")
            )


          ],
        ),
      ),
    );
  }


}