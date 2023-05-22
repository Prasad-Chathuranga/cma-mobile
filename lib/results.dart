import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';

class Results extends StatefulWidget {
  const Results({super.key});

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  final _headerStyle = const TextStyle(
      color: Color(0xffffffff), fontSize: 15, fontWeight: FontWeight.bold);
  final _contentStyleHeader = const TextStyle(
      color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.w700);
  final _contentStyle = const TextStyle(
      color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.normal);
  final _loremIpsum =
      '''Lorem ipsum is typically a corrupted version of 'De finibus bonorum et malorum', a 1st century BC text by the Roman statesman and philosopher Cicero, with words altered, added, and removed to make it nonsensical and improper Latin.''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[100],
        appBar: AppBar(
          title: const Text('Results'),
        ),
        body: Accordion(
            maxOpenSections: 2,
            headerBackgroundColorOpened: Colors.black54,
            scaleWhenAnimating: true,
            openAndCloseAnimation: true,
            headerPadding:
                const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
            sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
            sectionClosingHapticFeedback: SectionHapticFeedback.light,
            children: [
              AccordionSection(
                isOpen: true,
                leftIcon:
                    const Icon(Icons.insights_rounded, color: Colors.white),
                headerBackgroundColor: Colors.black,
                headerBackgroundColorOpened: Colors.red,
                header: Text('Introduction', style: _headerStyle),
                content: Text(_loremIpsum, style: _contentStyle),
                contentHorizontalPadding: 20,
                contentBorderWidth: 1,
                // onOpenSection: () => print('onOpenSection ...'),
                // onCloseSection: () => print('onCloseSection ...'),
              ),
              AccordionSection(
                isOpen: true,
                leftIcon:
                    const Icon(Icons.compare_rounded, color: Colors.white),
                header: Text('Nested Accordion', style: _headerStyle),
                contentBorderColor: const Color(0xffffffff),
                headerBackgroundColorOpened: Colors.amber,
                content: Accordion(
                  maxOpenSections: 1,
                  headerBackgroundColorOpened: Colors.black54,
                  headerPadding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                  children: [
                    AccordionSection(
                      isOpen: false,
                      leftIcon:
                          const Icon(Icons.food_bank, color: Colors.white),
                      header: Text('Company Info', style: _headerStyle),
                      content: DataTable(
                        sortAscending: true,
                        sortColumnIndex: 1,
                        dataRowHeight: 40,
                        showBottomBorder: false,
                        columns: [
                          DataColumn(
                              label: Text('ID', style: _contentStyleHeader),
                              numeric: true),
                          DataColumn(
                              label: Text('Description',
                                  style: _contentStyleHeader)),
                          DataColumn(
                              label: Text('Price', style: _contentStyleHeader),
                              numeric: true),
                        ],
                        rows: [
                          DataRow(
                            cells: [
                              DataCell(Text('1',
                                  style: _contentStyle,
                                  textAlign: TextAlign.right)),
                              DataCell(
                                  Text('Fancy Product', style: _contentStyle)),
                              DataCell(Text(r'$ 199.99',
                                  style: _contentStyle,
                                  textAlign: TextAlign.right))
                            ],
                          ),
                          DataRow(
                            cells: [
                              DataCell(Text('2',
                                  style: _contentStyle,
                                  textAlign: TextAlign.right)),
                              DataCell(Text('Another Product',
                                  style: _contentStyle)),
                              DataCell(Text(r'$ 79.00',
                                  style: _contentStyle,
                                  textAlign: TextAlign.right))
                            ],
                          ),
                          DataRow(
                            cells: [
                              DataCell(Text('3',
                                  style: _contentStyle,
                                  textAlign: TextAlign.right)),
                              DataCell(Text('Really Cool Stuff',
                                  style: _contentStyle)),
                              DataCell(Text(r'$ 9.99',
                                  style: _contentStyle,
                                  textAlign: TextAlign.right))
                            ],
                          ),
                          DataRow(
                            cells: [
                              DataCell(Text('4',
                                  style: _contentStyle,
                                  textAlign: TextAlign.right)),
                              DataCell(Text('Last Product goes here',
                                  style: _contentStyle)),
                              DataCell(Text(r'$ 19.99',
                                  style: _contentStyle,
                                  textAlign: TextAlign.right))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]));
  }
}
