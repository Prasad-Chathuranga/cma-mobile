import 'package:cma_mobile/constants.dart';
import 'package:cma_mobile/helpers/connection_helper.dart';
import 'package:cma_mobile/helpers/data_helper.dart';
import 'package:cma_mobile/widgets/common/loader.dart';
import 'package:cma_mobile/widgets/common/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CPDCreditsCard extends StatefulWidget {
  const CPDCreditsCard({super.key});

  @override
  State<CPDCreditsCard> createState() => _CPDCredistCardState();
}

class _CPDCredistCardState extends State<CPDCreditsCard> {
  bool loading = false;
  bool creditsLoaded = false;
  Map<String, dynamic> cpdCredits = Map();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getCPDCreditsStats();
      setState(() {});
    });
  }

  Future<void> getCPDCreditsStats() async {
    setState(() {
      loading = true;
      creditsLoaded = false;
    });

    var provider = Provider.of<DataHelper>(context, listen: false);

    var value = await ConnectionHelper(context)
        .createRequest<ConnectionHelper>('get', 'cpd-credits',
            queryParams: {"customer_id": provider.getCustomerId()})
        .withToken()
        .sendAndMap();

    if (value!.responseCode == 200) {
      // setState(() {
      //   loading = false;
      //   creditsLoaded = true;
      // });
      cpdCredits = value.data!['data'];
    }
    //  else {
    //   print(value.data);
    // }
    
    setState(() {
      loading = false;
      creditsLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime nowDate = DateTime.now();
    int currYear = nowDate.year;

    Widget getCPDCreditsCard() {
      // if (cpdCredits != null) {
      return Expanded(
        child: Container(
          child: Card(
            child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.315),
                      offset: Offset(0, 5),
                      blurRadius: 5,
                      spreadRadius: 0,
                    ),
                    BoxShadow(
                        color: Color.fromRGBO(39, 50, 80, 1),
                        offset: Offset(0, 0),
                        blurRadius: 0,
                        spreadRadius: 0)
                  ]),
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(padding: EdgeInsets.only(top: 15.0)),
                          const Row(children: [
                            Text(
                              'CPD Credits',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 5, 25, 50),
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
                          Row(mainAxisSize: MainAxisSize.max, children: [
                            Wrap(
                                direction: Axis.horizontal,
                                spacing: 10.0,
                                children: [
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${cpdCredits![currYear.toString()] ?? 0}/20',
                                          style: TextStyle(
                                            color: Colors.red.shade400,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          currYear.toString(),
                                          style: const TextStyle(
                                            color:
                                                Color.fromARGB(255, 34, 5, 4),
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                      ]),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            '${cpdCredits![(currYear - 1).toString()] ?? 0}/20',
                                            style: TextStyle(
                                              color: Colors.red.shade400,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        Text(
                                          (currYear - 1).toString(),
                                          style: const TextStyle(
                                            color:
                                                Color.fromARGB(255, 34, 5, 4),
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ]),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${cpdCredits![(currYear - 2).toString()] ?? 0}/20',
                                          style: TextStyle(
                                            color: Colors.red.shade400,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          (currYear - 2).toString(),
                                          style: const TextStyle(
                                            color:
                                                Color.fromARGB(255, 34, 5, 4),
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ]),
                                ]),
                          ])
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: Image.asset('assets/images/cpd.png'),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      // }
      // return null;
      // return null;
    }

 
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
           
          if(!loading)Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(child: getCPDCreditsCard()),
            ],
          ),
          SizedBox(height: 15.0),
          if (loading)
            Container(
              // color: loginBlue,
              child: const Center(
                child: CircularProgressIndicator(color: primaryOrange),
              ),
            ),
        ],
      ),
    );
  }
}
