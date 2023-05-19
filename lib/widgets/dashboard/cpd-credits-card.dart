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
        color: Color.fromARGB(106, 160, 156, 156),
        child: Container(
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
          child: const SizedBox(
            width: 350,
            height: 110,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(children: [
                        Text(
                          'CPD Credits',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                          ),
                        ),
                      ]),
                      Text(
                        '15',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.menu_book,
                        size: 70.0,
                        color: Colors.white,
                      )
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
