import 'package:cma_mobile/helpers/data_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RenewedCard extends StatelessWidget {
  const RenewedCard({super.key});

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
              Renewed(),
            ],
          ),
          SizedBox(height: 15.0)
        ],
      ),
    );
  }
}

class Renewed extends StatelessWidget {
  const Renewed({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<DataHelper>(context, listen: false);

    return Expanded(
        child: Container(
      child: Card(
        // color: Color.fromARGB(106, 160, 156, 156),
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
                          'Renewed Upto',
                          style: TextStyle(
                              color: Color.fromARGB(255, 5, 25, 50),
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ]),
                      Row(children: [
                        Text(
                          provider.getMemberUpto(),
                          style: TextStyle(
                            color: Colors.red.shade400,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ]),
                      Row(children: [
                        Text(
                          provider.getPath(),
                          style: const TextStyle(
                            color: Color.fromARGB(255, 5, 25, 50),
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ])
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: Image.asset('assets/images/renew.png'),
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
    )
    );
  }
}
