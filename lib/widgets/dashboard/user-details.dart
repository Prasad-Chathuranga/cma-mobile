import 'package:cma_mobile/helpers/data_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:typed_data';

class UserDetails extends StatelessWidget {
  const UserDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<DataHelper>(context, listen: false);

    ThemeData themeData = Theme.of(context);
    
    Widget? avatar;
    var image = provider.getImage();

    //Default image
    if (image == null) {
      avatar = const CircleAvatar(
        radius: 45.0,
        child: Icon(Icons.person)
      );
    } else {
      avatar = CircleAvatar(
        radius: 45,
        backgroundImage: Image.memory(
          fit: BoxFit.cover,
          image,
          filterQuality: FilterQuality.medium,
        ).image,
      );
    }

    return Container(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, 
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                  Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Text(
                      "Welcome Back !",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Icon(
                    Icons.waving_hand,
                    color: Colors.amber,
                  ),
                ]),
                Text(
                  provider.getCMACode(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold),
                ),
                Column(
                  children: [
                  Text(
                    provider.getFullName(),
                    style: const TextStyle(color: Colors.white, fontSize: 14.0),
                  ),
                ]),
              ],
            ),
            Column(children: [
              CircleAvatar(
                backgroundColor: Colors.amber,
                radius: 50.0,
                child: avatar,
              ),
            ]),
          ]),
        ],
      ),
    );
  }
}
