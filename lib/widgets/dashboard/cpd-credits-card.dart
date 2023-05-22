import 'package:flutter/material.dart';

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

class CPDCredits extends StatelessWidget {
  const CPDCredits({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        // color: Color.fromARGB(106, 160, 156, 156),
        child: Container(
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
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
          // decoration: const BoxDecoration(
          //   borderRadius: BorderRadius.all(Radius.circular(10.0)),
          //   gradient: LinearGradient(
          //       begin: Alignment.topLeft,
          //       end: Alignment(0.8, 1),
          //       colors: <Color>[
          //         Color.fromARGB(255, 255, 171, 92),
          //         Color.fromARGB(216, 241, 27, 27),
          //       ],
          //       tileMode: TileMode.mirror),
          // ),
          child: SizedBox(
            width: 350,
            height: 150,
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.only(top: 15.0)),
                      Row(children: [
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
                                      "06/20",
                                      style: TextStyle(
                                        color: Colors.red.shade400,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '2023',
                                      style: TextStyle(
                                        color:
                                            const Color.fromARGB(255, 34, 5, 4),
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ]),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('17/20',
                                        style: TextStyle(
                                          color: Colors.red.shade400,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Text(
                                      '2022',
                                      style: TextStyle(
                                        color:
                                            const Color.fromARGB(255, 34, 5, 4),
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ]),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '16/20',
                                      style: TextStyle(
                                        color: Colors.red.shade400,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '2021',
                                      style: TextStyle(
                                        color:
                                            const Color.fromARGB(255, 34, 5, 4),
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
                      // Icon(
                      //   Icons.menu_book,
                      //   size: 70.0,
                      //   color: Colors.white,
                      // )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
