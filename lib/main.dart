import 'package:cma_mobile/dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0x5968DE)),
        useMaterial3: true,
      ),
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 5, 25, 50),
      appBar: null,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Center(
                child: SizedBox(
                    width: 180,
                    height: 180,
                    child: Image.asset('assets/images/logo.png')),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
              child: const Text(
                'Login to your account',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white38),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                    labelStyle: TextStyle(color: Colors.white70),
                    hintText: 'Enter your CMA Code',
                    hintStyle: TextStyle(color: Colors.white38)),
              ),
            ),
            const Padding(
              padding:
                  EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                style: TextStyle(color: Colors.white38),
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.white70),
                    hintText: 'Enter your password',
                    hintStyle: TextStyle(color: Colors.white38)),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.only(left: 15.0, top: 20.0),
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.indigo.shade900,
                    borderRadius: BorderRadius.circular(10.0)),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const Dashboard()));
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: const EdgeInsets.only(top: 30.0),
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Retrive Password',
                    style: TextStyle(color: Colors.blue, fontSize: 16),
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
