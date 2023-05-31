import 'package:cma_mobile/helpers/connection_helper.dart';
import 'package:cma_mobile/helpers/data_helper.dart';
import 'package:cma_mobile/widgets/common/loader.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class logout extends StatelessWidget {
  const logout({super.key});

  @override
  Widget build(BuildContext context) {
    _logout(context);

    return const Center(
      child: Loader(),
    );
  }

  void _logout(BuildContext context) async {
    if (context.mounted) {
      var provider = Provider.of<DataHelper>(context);

      await ConnectionHelper(context)
          .createRequest<ConnectionHelper>('post', 'logout')
          .withToken()
          .sendAndMap();

      await provider.logout();

      if (context.mounted) {
        context.go('/login');
      }
    }
  }
}
