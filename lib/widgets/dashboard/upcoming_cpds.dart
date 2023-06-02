import 'package:cma_mobile/helpers/connection_helper.dart';
import 'package:cma_mobile/helpers/data_helper.dart';
import 'package:cma_mobile/widgets/common/loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpcomingCpds extends StatefulWidget {
  const UpcomingCpds({super.key});

  @override
  State<UpcomingCpds> createState() => _UpcomingCpdsState();
}

class _UpcomingCpdsState extends State<UpcomingCpds> {
  List<dynamic>? cpdList;
  List<Widget> children = [];
  bool? cpdLoaded = false;
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCPDs();
  }

  Future<void> getCPDs() async {
    // var sc = ScaffoldMessenger.of(context);
    setState(() {
      cpdLoaded = false;
      loading = true;
    });
    var provider = Provider.of<DataHelper>(context, listen: false);

    var value = await ConnectionHelper(context)
        .createRequest<ConnectionHelper>('get', 'cpd', queryParams: {
          "customer_id": provider.getCustomerId(),
          "category_id": provider.getCategoryId()
        })
        .withToken()
        .sendAndMap();

    if (value!.responseCode == 200) {
      cpdList = value.data!['data'];

      if (cpdList!.isNotEmpty) {
        cpdList?.forEach(
          (value) {
            children.add(
               Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(10.0),
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
                      padding: EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: 
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Padding(padding: EdgeInsets.only(top: 5.0)),
                              Row(children: [
                                // Flexible(child: child)
                                Expanded(
                                  child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                                    children: [ Text(
                                    value['instance'],
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 5, 25, 50),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold),
                                        softWrap: true,
                                        textAlign: TextAlign.left,
                                  ),
                              ]),
                                ),
                              ]),
                              Row(mainAxisSize: MainAxisSize.max, children: [
                                Wrap(
                                    direction: Axis.horizontal,
                                    spacing: 5.0,
                                    children: [
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Padding(
                                                padding:
                                                    EdgeInsets.only(top: 2.0)),
                                            Text(
                                              value['date'],
                                              style: TextStyle(
                                                color: Colors.red.shade400,
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              '${value['credits']} credits',
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 194, 106, 106),
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                          ]),
                                    ]),
                              ])
                            ],
                          ),
                      )],
                      ),
                    ),
                  ),
                ),
              
            
            );

            children.add(const SizedBox(height: 15.0));
          },
        );
      } else {
        children.add(
          const Padding(
              padding: EdgeInsets.only(left: 25.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("No Upcoming CPD Events !",
                              textAlign: TextAlign.left)
                        ])
                  ])),
        );
      }

      setState(() {
        cpdLoaded = true;
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25.0),
      child: Column(children: children)
      );

    // return Expanded(child:  Column(children: children));
    // return Container(
    //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.stretch,
    //     children: [
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: children,
    //       ),
    //       SizedBox(height: 15.0)
    //     ]
    //   ),
    //   );

    // Expanded(child: Container(
    //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
    //   child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.stretch,
    //       children: [
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: children,
    //         ),
    //         SizedBox(height: 15.0),
    //       ]),
    // )
    // );
    // if (loading) const Loader()
  }
}
