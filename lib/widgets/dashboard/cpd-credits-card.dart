import 'package:cma_mobile/helpers/connection_helper.dart';
import 'package:cma_mobile/helpers/data_helper.dart';
import 'package:cma_mobile/widgets/common/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CPDCreditsCard extends StatelessWidget {
  const CPDCreditsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CPDCredits(),
            ],
          ),
          SizedBox(height: 15.0),
          // ListView.separated(
          //   shrinkWrap: true,
          //   physics: NeverScrollableScrollPhysics(),
          //   itemBuilder: (BuildContext context, int index) {
          //     return CoinCard(
          //       coin: StaticData.otherCoins[index],
          //     );
          //   },
          //   separatorBuilder: (BuildContext context, int index) {
          //     return SizedBox(
          //       height: 15.0,
          //     );
          //   },
          //   itemCount: StaticData.otherCoins.length,
          // )
        ],
      ),
    );
  }
}

class CPDCredits extends StatefulWidget {
  const CPDCredits({super.key});

  @override
  State<CPDCredits> createState() => _CPDCredits();
}

class _CPDCredits extends State<CPDCredits> {
  Map? _cpd;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _providerListener() {
    try {
      getCPDCreditsStats();
    } catch (_) {}
  }

  Future<void> getCPDCreditsStats() async {
    // var sc = ScaffoldMessenger.of(context);

    var provider = Provider.of<DataHelper>(context, listen: false);

    var value = await ConnectionHelper(context)
        .createRequest<ConnectionHelper>('get', 'cpd-credits',
            queryParams: {"customer_id": provider.getCustomerId()})
        .withToken()
        .sendAndMap();

    // provider.setCPDCreditsData(value!.data!['data']);

    DateTime nowDate = DateTime.now();
    int currYear = nowDate.year;

    //  print(provider.getCPDCreditsByYear((currYear-2).toString()));

    // for (var i = currYear; i >= currYear - 2; i--) {
    //   print(i);
    //   print(value!.data!['data'][i.toString()][0]);
    // }

// print(currYear.toString());

    // if (value == null) {
    //   sc.showSnackBar(const FlairSnackBar(
    //     'Unable to contact the server!',
    //   ).snackBar());
    // }

    // provider.setUserData(value.data!['data']);
  }

  @override
  Widget build(BuildContext context) {

    var provider = Provider.of<DataHelper>(context, listen: false);

    DateTime nowDate = DateTime.now();
    int currYear = nowDate.year;

    return Expanded(child: Container(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${provider.getCPDByYear(
                                              currYear.toString())}/20',
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        '${provider.getCPDByYear(
                                                (currYear - 1).toString())}/20',
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${provider.getCPDByYear(
                                              (currYear - 2).toString())}/20',
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
  }
}
