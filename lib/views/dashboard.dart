import 'package:cma_mobile/constants.dart';
import 'package:cma_mobile/helpers/connection_helper.dart';
import 'package:cma_mobile/helpers/data_helper.dart';
import 'package:cma_mobile/logout.dart';
import 'package:cma_mobile/views/results.dart';
import 'package:cma_mobile/widgets/common/snackbar.dart';
import 'package:cma_mobile/widgets/dashboard/cpd-credits-card.dart';
import 'package:cma_mobile/widgets/dashboard/renewed-card.dart';
import 'package:cma_mobile/widgets/dashboard/upcoming_cpds.dart';
import 'package:cma_mobile/widgets/dashboard/user-details.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<DataHelper>(context, listen: false);

    Widget? resultsState() {
      if (provider.getPath() == 'Internal') {
        return ListTile(
          leading: Icon(Icons.bookmark_added_outlined),
          title: const Text('Results'),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const Results()));
          },
        )
        ;
      } else {
        return null;
      }
    }

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
            Container(child: resultsState()),
            // ListTile(
            //   leading: Icon(Icons.bookmark_added_outlined),
            //   title: const Text('Results'),
            //   onTap: () {
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (_) => const Results()));
            //   },
            // ),
            
            Container(
                // This align moves the children to the bottom
                child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    // This container holds all the children that will be aligned
                    // on the bottom and should not scroll with the above ListView
                    child: Container(
                        child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.logout_outlined),
                          title: Text('Logout'),
                          onTap: () {
                            context.go('/logout');
                          },
                        ),
                        // ListTile(
                        //     leading: Icon(Icons.help),
                        //     title: Text('Help and Feedback'))
                      ],
                    ))))
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
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 25.0, bottom: 10.0),
                      child: Text(
                        'Upcoming CPDs',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0),
                      ),
                    ),
                  ),

                  UpcomingCpds()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
