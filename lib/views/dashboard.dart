import 'package:cma_mobile/constants.dart';
import 'package:cma_mobile/views/results.dart';
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
      backgroundColor: primaryBlue,
      appBar: AppBar(title: const Text('Dashboard')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: primaryBlue,
              ),
              child: Container(
                child: Row(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                            width: 135,
                            height: 135,
                            child: Image.asset('assets/images/logo.png')),
                      ],
                    )
                  ],
                ),
              ),
            ),
            ListTile(
              title: const Text('Results'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const Results()));
                // Update the state of the app
                // ...
                // Then close the drawer
                // Navigator.pop(context);
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
      body: SingleChildScrollView(
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
            Container(
              width: double.infinity,
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - 200.0,
              ),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                // color: Color.fromRGBO(240, 235, 220, 1),
              ),
              child: Column(
                children: [
                  // Padding(
                  //   padding: EdgeInsets.only(top: 30.0),
                  // ),
                  RenewedCard(),
                  CPDCreditsCard(),
                  CPDCreditsCard()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
