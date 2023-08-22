import 'package:cma_mobile/constants.dart';
import 'package:cma_mobile/helpers/connection_helper.dart';
import 'package:cma_mobile/helpers/data_helper.dart';
import 'package:cma_mobile/logout.dart';
import 'package:cma_mobile/views/results.dart';
import 'package:cma_mobile/widgets/common/loader.dart';
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
  bool loading = false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Future.delayed(const Duration(seconds: 5), () {
    //   setState(() {
    //     loading = true;
    //   });
    // });
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
        );
      } else {
        return null;
      }
    }

    Future<void> reloadPage() async {
      setState(() {
        loading = true;
      });
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          loading = false;
        });
      });
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
                        Center(
                          heightFactor: 1.3,
                          child: SizedBox(
                              width: 100,
                              height: 100,
                              child: Image.asset('assets/images/logo.png')),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(child: resultsState()),
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
                          title: Text('Log out'),
                          onTap: () {
                            context.go('/logout');
                          },
                        ),
                        // ListTile(
                        //     leading: Icon(Icons.help),
                        //     title: Text('Help and Feedback'))
                      ],
                    )))),
          ],
        ),
      ),
      body: RefreshIndicator.adaptive(
        key: _refreshIndicatorKey,
        color: primaryOrange,
        backgroundColor: primaryBlue,
        strokeWidth: 4.0,
        onRefresh: () async {
          // Replace this delay with the code to be executed during refresh
          // and return a Future when code finishes execution.
          // return Future<void>.delayed(const Duration(seconds: 3));
          return reloadPage();
        },
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 25.0,
                  ),
                  if (!loading) const UserDetails(),
                  const SizedBox(
                    height: 10.0,
                  ),
                  if (!loading)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Divider(
                        color: Color.fromRGBO(97, 99, 119, 1),
                      ),
                    ),
                  const SizedBox(
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
                        if (!loading) RenewedCard(),
                        if (!loading) CPDCreditsCard(),
                        SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                        ),
                        if (!loading) UpcomingCpds(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (loading) const Loader(),
          ],
        ),
      ),
    );
  }
}
