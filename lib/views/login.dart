import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cma_mobile/constants.dart';
import 'package:cma_mobile/widgets/common/loader.dart';
import 'package:flutter/material.dart';
import 'package:cma_mobile/helpers/connection_helper.dart';
import 'package:cma_mobile/helpers/data_helper.dart';
import 'package:cma_mobile/widgets/common/snackbar.dart';

import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  bool userInfoLoaded = false;
  bool loading = false;
  String? code, password;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider = Provider.of<DataHelper>(context, listen: false);
      provider.addListener(_providerListener);
    });
  }

  void _providerListener() {
    try {
      getCurrentUser();
    } catch (_) {}
  }

  ///Load user from stored token
  Future<void> getCurrentUser() async {
    if (context.mounted == false) {
      return;
    }

    var sc = ScaffoldMessenger.of(context);

    var provider = Provider.of<DataHelper>(context, listen: false);

    provider.removeListener(_providerListener);

    if (provider.getToken().isNotEmpty) {
      setState(() {
        loading = true;
      });

      var value = await ConnectionHelper(context)
          .createRequest<ConnectionHelper>('get', '/')
          .withToken()
          .sendAndMap();

      if (value == null) {
        sc.showSnackBar(const CMASnackBar(
          'Unable to contact the server!',
        ).snackBar());
      }

      if (value!.responseCode == 200) {
        //Valid status code

        provider.setUserData(value.data!['data']);
        // provider.setCPDCourseData(value.data!['data']['cpd_events']);

        if (context.mounted) {
          context.go('/');
        }
        return;
      }
      //Invalid status code
      else {
        sc.showSnackBar(CMASnackBar(
          value.message ?? 'Error',
        ).snackBar());

        setState(() {
          loading = false;
          userInfoLoaded = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: loginBlue,
      appBar: null,
      body: SafeArea(
        child: Stack(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 100.0),
                    child: Center(
                      child: SizedBox(
                          width: 180,
                          height: 180,
                          child: Image.asset('assets/images/logo.png')),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                    child: const Text(
                      'Login to your account',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white38),
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Username',
                          labelStyle: TextStyle(color: Colors.white70),
                          hintText: 'Enter your CMA Code',
                          hintStyle: TextStyle(color: Colors.white38)),
                      validator: (String? value) {
                        if (value == null || value == '') {
                          return "CMA Code is required";
                        }
                        return null;
                      },
                      onChanged: (value) => code = value,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15, bottom: 0),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: const TextStyle(color: Colors.white38),
                      obscureText: true,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.white70),
                          hintText: 'Enter your password',
                          hintStyle: TextStyle(color: Colors.white38)),
                      validator: (String? value) {
                        if (value == null || value == '') {
                          return "Password is required";
                        }
                        // if (value.trim().length < 6) {
                        //   return "Password must be at least 6 letters long";
                        // }
                        return null;
                      },
                      onChanged: (value) => password = value,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(left: 15.0, top: 20.0),
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.indigo.shade900,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: TextButton(
                        onPressed: () {
                          _loginButtonClicked();
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (_) => const Dashboard()));
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      ),
                    ),
                  ),
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: Container(
                  //     margin: const EdgeInsets.only(top: 30.0),
                  //     child: TextButton(
                  //       onPressed: () {},
                  //       child: const Text(
                  //         'Retrive Password',
                  //         style: TextStyle(color: Colors.blue, fontSize: 16),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            if (loading) const Loader()
          ],
        ),
      ),
    );
  }

  void _loginButtonClicked() {
    if (_formKey.currentState?.validate() == true) {
      setState(() {
        loading = true;
      });

      loginUser();
    }
  }

  void loginUser() async {
    var formData = <String, String>{};

    var provider = Provider.of<DataHelper>(context, listen: false);

    formData['code'] = code ?? '';
    formData['password'] = password ?? '';

    var sc = ScaffoldMessenger.of(context);

    var response = await MultipartConnectionHelper(context)
        .createRequest<MultipartConnectionHelper>('post', 'login')
        .addField('code', formData['code'] ?? '')
        .addField('password', formData['password'] ?? '')
        .sendAndMap();

    setState(() {
      loading = false;
      userInfoLoaded = true;
    });

    if (response == null) {
      sc.showSnackBar(const CMASnackBar(
        'Unable to contact the server!',
      ).snackBar());
    }

    if (response!.responseCode == 200) {
      provider.writeToken(response.data!['data']['token']);

      response.data!['data'].remove('token');

      provider.setUserData(response.data!['data']);
   
      if (context.mounted) context.go('/');
    } else if (response.responseCode == 500) {
      sc.showSnackBar(CMASnackBar(
        'Unable to contact the server!',
      ).snackBar());
    } else if (context.mounted) {
      sc.showSnackBar(CMASnackBar(
        response.message ?? 'Error',
      ).snackBar());
    }

    setState(() {
      loading = false;
      userInfoLoaded = true;
    });
  }
}
