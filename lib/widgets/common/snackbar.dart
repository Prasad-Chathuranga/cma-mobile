import 'package:cma_mobile/constants.dart';
import 'package:cma_mobile/helpers/connection_helper.dart';
import 'package:flutter/material.dart';

enum SnackBarType { info, error, success }

class CMASnackBar {
  final String message;
  final SnackBarType type;

  const CMASnackBar(this.message, {this.type = SnackBarType.error});

  static String _getMessage(CMAResponse res) {
    String msg = res.message == null || res.message!.isEmpty
        ? 'Unable to perform the request'
        : res.message!;

    if (res.data!.containsKey('errors')) {
      var errorList = res.data!['errors'] as Map<String, List<String>>;

      msg += (errorList[errorList.keys.first]?.first == null
          ? ""
          : "\n${errorList[errorList.keys.first]!.first}");
    }

    return msg;
  }

  /// Shows snackbar
  /// returns _true_ after successful results
  static bool fromResult(CMAResponse? res, ScaffoldMessengerState? scaffoldMsg,
      {String? message, bool showSuccess = true}) {
    if (scaffoldMsg == null) {
      return false;
    }

    if (res == null || res.isOk == false) {
      scaffoldMsg.showSnackBar(
          CMASnackBar(message ?? 'Connection error').snackBar());

      return false;
    }

    if (res.responseCode != 200) {
      scaffoldMsg.showSnackBar(CMASnackBar(_getMessage(res)).snackBar());
      return false;
    }

    if (showSuccess) {
      scaffoldMsg.showSnackBar(
          CMASnackBar(res.message ?? 'Success', type: SnackBarType.success)
              .snackBar());
    }

    return true;
  }

  /// Returns the snackbar
  SnackBar snackBar() {
    switch (type) {
      case SnackBarType.success:
        return SnackBar(
          content: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: primaryBlue,
          closeIconColor: primaryOrange,
          showCloseIcon: true,
          elevation: 3,
        );

      case SnackBarType.error:
        return SnackBar(
          content: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: primaryOrange,
          closeIconColor: primaryBlue,
          showCloseIcon: true,
          elevation: 3,
        );

      default:
        return SnackBar(
          content: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: primaryBlue,
          closeIconColor: primaryOrange,
          showCloseIcon: true,
          elevation: 3,
        );
    }
  }
}
