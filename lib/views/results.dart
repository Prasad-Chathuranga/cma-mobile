import 'dart:convert';

import 'package:cma_mobile/constants.dart';
import 'package:cma_mobile/helpers/connection_helper.dart';
import 'package:cma_mobile/helpers/data_helper.dart';
import 'package:cma_mobile/widgets/common/loader.dart';
import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:provider/provider.dart';

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

  Map<String, dynamic>? results;
  List<AccordionSection> children = [];

  bool? resultsLoaded = false;
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getResults();
  }

  Future<void> getResults() async {
    // var sc = ScaffoldMessenger.of(context);
    setState(() {
      resultsLoaded = false;
      loading = true;
    });
    var provider = Provider.of<DataHelper>(context, listen: false);

    var value = await ConnectionHelper(context)
        .createRequest<ConnectionHelper>('get', 'results',
            queryParams: {"student_id": provider.getStudentId()})
        .withToken()
        .sendAndMap();

    if (value!.responseCode == 200) {
      // print(value.data!['data']);
      results = value.data!['data'];

      results?.forEach((key, res) {
        List<DataRow> dataRows = [];

        res?.forEach((r) {
          dataRows.add(DataRow(cells: [
            DataCell(
                Text(r[0], style: _contentStyle, textAlign: TextAlign.right)),
            DataCell(Text(r[1], style: _contentStyle)),
            DataCell(
                Text(r[2], style: _contentStyle, textAlign: TextAlign.right))
          ]));
        });

        children.add(AccordionSection(
          isOpen: false,
          leftIcon: const Icon(Icons.insights_rounded, color: Colors.white),
          headerBackgroundColor: loginBlue,
          headerBackgroundColorOpened: resultsHeader,
          header: Text(key, style: _headerStyle),
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
            rows: dataRows,
          ),
          contentHorizontalPadding: 20,
          contentBorderWidth: 1,
          // onOpenSection: () => print('onOpenSection ...'),
          // onCloseSection: () => print('onCloseSection ...'),
        ));
      });

      setState(() {
        resultsLoaded = true;
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryBlue,
        appBar: AppBar(
          title: const Text('Results'),
        ),
        body: Stack(children: [
          Accordion(
              maxOpenSections: 2,
              headerBackgroundColorOpened: Colors.black54,
              scaleWhenAnimating: true,
              openAndCloseAnimation: true,
              headerPadding:
                  const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
              sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
              sectionClosingHapticFeedback: SectionHapticFeedback.light,
              children: children),
          if (loading) const Loader()
        ]));
  }
}
