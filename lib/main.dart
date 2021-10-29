import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Léa',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: 'DayRoman',
      ),
      home: const MyHomePage(title: 'Cookies Game Léa'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  // ignore: prefer_final_fields
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<int> _counter;

  Future<void> _incrementCounter() async {
    final SharedPreferences prefs = await _prefs;
    final int counter = (prefs.getInt('counter') ?? 0) + 1;

    setState(() {
      _counter = prefs.setInt("counter", counter).then((bool success) {
        return counter;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _counter = _prefs.then((SharedPreferences prefs) {
      return (prefs.getInt('counter') ?? 0);
    });
  }


  @override
  Widget build(BuildContext context) {
    var largeurEcran = MediaQuery.of(context).size.width;
    var hauteurEcran = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: largeurEcran,
        height: hauteurEcran,
        decoration: BoxDecoration(
          color:  const Color(0xff7c94b6),
          image: DecorationImage(
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.dstATop),
            image: const ExactAssetImage("assets/images/fondEcran.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 100,),
            FutureBuilder<int>(
              future: _counter,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const CircularProgressIndicator();
                  default:
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return Text(
                        '🥛 ${snapshot.data} 🍪',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                          color: Colors.black
                        ),
                      );
                    }
                }
              }
            ),
            const SizedBox(height: 100,),
            SizedBox(
              width: 200,
              height: 200,
              child: FloatingActionButton(
                backgroundColor: Colors.transparent,
                onPressed: _incrementCounter,
                tooltip: 'Increment',
                child: Image.asset('assets/images/cookie.png'),
              ),
            ),
            const SizedBox(height: 100,),
            Center( child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 100,
                  width: 100,
                  child: FloatingActionButton.extended(
                    backgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                    onPressed: _Clicker1,
                    icon: Image.asset('assets/images/curseur.png', width: 20, height: 20,),
                    label: Text(
                      "+ 2/s \n\n 12 🍪",
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                ),
                SizedBox(width: 70,),
                SizedBox(
                  height: 100,
                  width: 100,
                  child: FloatingActionButton.extended(
                    backgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                    onPressed: _Clicker2,
                    icon: Image.asset('assets/images/hand.png', width: 20, height: 20,),
                    label: Text(
                      " x1 \n\n 12 🍪",
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                ),
              ],
            ),),
          ],
        ),
      ),
    );
  }

  Future<void> _Clicker1() async {
    int clickParSeconde = 0,
    _incrementCounter;
  }

  Future<void> _Clicker2() async {
    _incrementCounter;
  }
  
}

