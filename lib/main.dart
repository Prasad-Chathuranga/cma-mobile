import 'package:cma_mobile/constants.dart';
import 'package:cma_mobile/logout.dart';
import 'package:cma_mobile/views/dashboard.dart';
import 'package:cma_mobile/helpers/connection_helper.dart';
import 'package:cma_mobile/helpers/data_helper.dart';
import 'package:cma_mobile/views/login.dart';
import 'package:cma_mobile/widgets/common/snackbar.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';
import 'package:device_preview/device_preview.dart';


void main() {
  runApp(
    DevicePreview(builder: (context) => MyApp(), enabled: false,)
    // MyApp()
    );
}

Widget MyApp() {
  return ChangeNotifierProvider(
    create: (b) => DataHelper(),
    child: const MainRouter(),
  );
}

final GoRouter _router =
  GoRouter(initialLocation: '/login', routes: <RouteBase>[
  GoRoute(
    path: '/login',
    builder: (context, state) => const Login(),
  ),
  GoRoute(path: '/', builder: (context, state) => const Dashboard(), 
  routes: [
    GoRoute(
      path: 'logout',
      builder: (context, state) => const logout(),
    ),
    // GoRoute(
    //   path: 'calendar',
    //   builder: (context, state) => const FlairCalendar(),
    // ),
    // GoRoute(
    //   path: 'contact',
    //   builder: (context, state) => const FlairContact(),
    // )
  ]),
]);

class MainRouter extends StatelessWidget {
  const MainRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      //Device Preview
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,

      routerConfig: _router,
      // color: FlairColors.primaryBg,

      theme: ThemeData(
          fontFamily: "Open Sans",
          useMaterial3: true,
          primaryColor: primaryBlue,
          colorScheme: const ColorScheme.dark(
              // secondary: FlairColors.complementaryColor,
              // background: FlairColors.primaryBg,
              // onPrimary: FlairColors.textColor
              )),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(useMaterial3: true),
    );
  }
}
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: const Color(0x5968DE)),
//         useMaterial3: true,
//       ),
//       home: Login(),
//     );
//   }
// }

// class Login extends StatefulWidget {
//   @override
//   _LoginState createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   final _formKey = GlobalKey<FormState>();
//   bool userInfoLoaded = false;
//   bool loading = false;
//   String? code = 'ACMA1415', password = '1234';

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//     // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//     //   var provider = Provider.of<DataHelper>(context, listen: false);
//     //   provider.addListener(_providerListener);
//     // });
//   }

//   void _providerListener() {
//     try {
//       getCurrentUser();
//     } catch (_) {}
//   }

//   ///Load user from stored token
//   Future<void> getCurrentUser() async {
//     if (context.mounted == false) {
//       return;
//     }

//     var sc = ScaffoldMessenger.of(context);

//     var provider = Provider.of<DataHelper>(context, listen: false);

//     provider.removeListener(_providerListener);

//     if (provider.getToken().isNotEmpty) {
//       setState(() {
//         loading = true;
//       });

//       var value = await ConnectionHelper(context)
//           .createRequest<ConnectionHelper>('get', '/')
//           .withToken()
//           .sendAndMap();

//       if (value == null) {
//         sc.showSnackBar(const FlairSnackBar(
//           'Unable to contact the server!',
//         ).snackBar());
//       }

//       if (value!.responseCode == 200) {
//         //Valid status code

//         provider.setUserData(value.data!['data']);

//         // if (context.mounted) {
//         //   context.go('/');
//         // }
//         return;
//       }
//       //Invalid status code
//       else {
//         sc.showSnackBar(FlairSnackBar(
//           value.message ?? 'Error',
//         ).snackBar());

//         setState(() {
//           loading = false;
//           userInfoLoaded = true;
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 5, 25, 50),
//       appBar: null,
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.only(top: 100.0),
//               child: Center(
//                 child: SizedBox(
//                     width: 180,
//                     height: 180,
//                     child: Image.asset('assets/images/logo.png')),
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
//               child: const Text(
//                 'Login to your account',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                     fontSize: 22.0,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 15),
//               child: TextFormField(
//                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                 cursorColor: Colors.white,
//                 style: TextStyle(color: Colors.white38),
//                 decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Username',
//                     labelStyle: TextStyle(color: Colors.white70),
//                     hintText: 'Enter your CMA Code',
//                     hintStyle: TextStyle(color: Colors.white38)),
//                 validator: (String? value) {
//                   if (value == null || value == '') {
//                     return "CMA Code is required";
//                   }
//                   return null;
//                 },
//                 onChanged: (value) => code = value,
//                 initialValue: 'ACMA1514',
//               ),
//             ),
//             Padding(
//               padding:
//                   EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
//               child: TextFormField(
//                 style: TextStyle(color: Colors.white38),
//                 obscureText: true,
//                 decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Password',
//                     labelStyle: TextStyle(color: Colors.white70),
//                     hintText: 'Enter your password',
//                     hintStyle: TextStyle(color: Colors.white38)),
//                 validator: (String? value) {
//                   if (value == null || value.trim().length < 6) {
//                     return "Password must be at least 6 letters long";
//                   }
//                   return null;
//                 },
//                 onChanged: (value) => password = value,
//                 initialValue: '12345',
//               ),
//             ),
//             Align(
//               alignment: Alignment.centerLeft,
//               child: Container(
//                 margin: const EdgeInsets.only(left: 15.0, top: 20.0),
//                 height: 50,
//                 width: 100,
//                 decoration: BoxDecoration(
//                     color: Colors.indigo.shade900,
//                     borderRadius: BorderRadius.circular(10.0)),
//                 child: TextButton(
//                   onPressed: () {
//                     _loginButtonClicked();
//                     // Navigator.push(context,
//                     //     MaterialPageRoute(builder: (_) => const Dashboard()));
//                   },
//                   child: const Text(
//                     'Login',
//                     style: TextStyle(color: Colors.white, fontSize: 16.0),
//                   ),
//                 ),
//               ),
//             ),
//             Align(
//               alignment: Alignment.centerRight,
//               child: Container(
//                 margin: const EdgeInsets.only(top: 30.0),
//                 child: TextButton(
//                   onPressed: () {},
//                   child: const Text(
//                     'Retrive Password',
//                     style: TextStyle(color: Colors.blue, fontSize: 16),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _loginButtonClicked() {
//     // if (_formKey.currentState?.validate() == true) {
//     //   Fluttertoast.showToast(msg: 'Okay');
//     //   setState(() {
//     //     loading = true;
//     //   });

//     loginUser();
//     // }
//     // Fluttertoast.showToast(msg: _formKey.currentState.toString());
//   }

//   void loginUser() async {
//     var formData = <String, String>{};

//     var provider = Provider.of<DataHelper>(context, listen: false);

//     formData['code'] = code ?? '';
//     formData['password'] = password ?? '';

//     var sc = ScaffoldMessenger.of(context);

//     var response = await MultipartConnectionHelper(context)
//         .createRequest<MultipartConnectionHelper>('post', 'login')
//         .addField('code', formData['code'] ?? '')
//         .addField('password', formData['password'] ?? '')
//         .sendAndMap();

//     setState(() {
//       loading = false;
//       userInfoLoaded = true;
//     });

//     if (response == null) {
//       sc.showSnackBar(const FlairSnackBar(
//         'Unable to contact the server!',
//       ).snackBar());
//     }

//     if (response!.responseCode == 200) {
//       provider.writeToken(response.data!['data']['token']);

//       response.data!['data'].remove('token');

//       provider.setUserData(response.data!['data']);

//       if (context.mounted) Fluttertoast.showToast(msg: 'All good');
//       // context.go('/');
//     } else {
//       if (context.mounted) {
//         sc.showSnackBar(FlairSnackBar(
//           response.message ?? 'Error',
//         ).snackBar());
//       }

//       setState(() {
//         loading = false;
//         userInfoLoaded = true;
//       });
//     }
//   }
// }
