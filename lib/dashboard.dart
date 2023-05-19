import 'package:cma_mobile/widgets/dashboard/cpd-credits-card.dart';
import 'package:cma_mobile/widgets/dashboard/renewed-card.dart';
import 'package:cma_mobile/widgets/dashboard/user-details.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(39, 50, 80, 1),
      appBar: AppBar(title: const Text('Dashboard')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Container(
        child: const SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 25.0,
              ),
              UserDetails(),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Divider(
                  color: Color.fromRGBO(97, 99, 119, 1),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              RenewedCard(),
              CPDCreditsCard(),
            ],
          ),
        ),
      ),
    );
  }
}
