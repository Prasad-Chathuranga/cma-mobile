import 'package:cma_mobile/constants.dart';
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
                isOpen: false,
                leftIcon:
                    const Icon(Icons.insights_rounded, color: Colors.white),
                headerBackgroundColor: primaryBlue,
                headerBackgroundColorOpened: Colors.red,
                header: Text('Foundation Level', style: _headerStyle),
                content: DataTable(
                  sortAscending: true,
                  sortColumnIndex: 1,
                  dataRowMaxHeight: 100.0,
                  showBottomBorder: false,
                  columns: [
                    DataColumn(
                      label: Text('Code', style: _contentStyleHeader),
                    ),
                    DataColumn(label: Text('Name', style: _contentStyleHeader)),
                    DataColumn(
                      label: Text('Result', style: _contentStyleHeader),
                    ),
                  ],
                  rows: [
                    DataRow(
                      cells: [
                        DataCell(Text('MAF',
                            style: _contentStyle, textAlign: TextAlign.right)),
                        DataCell(Text('Management Accounting Fundamentals',
                            style: _contentStyle)),
                        DataCell(Text('EX',
                            style: _contentStyle, textAlign: TextAlign.right))
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(Text('MAF',
                            style: _contentStyle, textAlign: TextAlign.right)),
                        DataCell(Text('Management Accounting Fundamentals',
                            style: _contentStyle)),
                        DataCell(Text('EX',
                            style: _contentStyle, textAlign: TextAlign.right))
                      ],
                    ),
                  ],
                ),
                contentHorizontalPadding: 20,
                contentBorderWidth: 1,
                // onOpenSection: () => print('onOpenSection ...'),
                // onCloseSection: () => print('onCloseSection ...'),
              ),
              AccordionSection(
                isOpen: false,
                leftIcon:
                    const Icon(Icons.insights_rounded, color: Colors.white),
                headerBackgroundColor: primaryBlue,
                headerBackgroundColorOpened: Colors.red,
                header: Text('Operational Level', style: _headerStyle),
                content: DataTable(
                  sortAscending: true,
                  sortColumnIndex: 1,
                  dataRowMaxHeight: 100.0,
                  showBottomBorder: false,
                  columns: [
                    DataColumn(
                      label: Text('Code', style: _contentStyleHeader),
                    ),
                    DataColumn(label: Text('Name', style: _contentStyleHeader)),
                    DataColumn(
                      label: Text('Result', style: _contentStyleHeader),
                    ),
                  ],
                  rows: [
                    DataRow(
                      cells: [
                        DataCell(Text('MAF',
                            style: _contentStyle, textAlign: TextAlign.right)),
                        DataCell(Text('Management Accounting Fundamentals',
                            style: _contentStyle)),
                        DataCell(Text('EX',
                            style: _contentStyle, textAlign: TextAlign.right))
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(Text('MAF',
                            style: _contentStyle, textAlign: TextAlign.right)),
                        DataCell(Text('Management Accounting Fundamentals',
                            style: _contentStyle)),
                        DataCell(Text('EX',
                            style: _contentStyle, textAlign: TextAlign.right))
                      ],
                    ),
                  ],
                ),
                contentHorizontalPadding: 20,
                contentBorderWidth: 1,
                // onOpenSection: () => print('onOpenSection ...'),
                // onCloseSection: () => print('onCloseSection ...'),
              ),
              AccordionSection(
                isOpen: true,
                leftIcon:
                    const Icon(Icons.insights_rounded, color: Colors.white),
                headerBackgroundColor: primaryBlue,
                headerBackgroundColorOpened: Colors.red,
                header: Text('Managerial Level', style: _headerStyle),
                content: DataTable(
                  sortAscending: true,
                  sortColumnIndex: 1,
                  dataRowMaxHeight: 100.0,
                  showBottomBorder: false,
                  columns: [
                    DataColumn(
                      label: Text('Code', style: _contentStyleHeader),
                    ),
                    DataColumn(label: Text('Name', style: _contentStyleHeader)),
                    DataColumn(
                      label: Text('Result', style: _contentStyleHeader),
                    ),
                  ],
                  rows: [
                    DataRow(
                      cells: [
                        DataCell(Text('MAF',
                            style: _contentStyle, textAlign: TextAlign.right)),
                        DataCell(Text('Management Accounting Fundamentals',
                            style: _contentStyle)),
                        DataCell(Text('EX',
                            style: _contentStyle, textAlign: TextAlign.right))
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(Text('MAF',
                            style: _contentStyle, textAlign: TextAlign.right)),
                        DataCell(Text('Management Accounting Fundamentals',
                            style: _contentStyle)),
                        DataCell(Text('EX',
                            style: _contentStyle, textAlign: TextAlign.right))
                      ],
                    ),
                  ],
                ),
                contentHorizontalPadding: 20,
                contentBorderWidth: 1,
                // onOpenSection: () => print('onOpenSection ...'),
                // onCloseSection: () => print('onCloseSection ...'),
              ),
            ]));
  }
}
