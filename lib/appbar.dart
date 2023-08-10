import 'package:flutter/material.dart';

Widget customAppBar = AppBar(
          // elevation: 2,
          title: Container(
            margin: const EdgeInsets.only(top: 5),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: 3,
                ),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image(
                  image: AssetImage('./assets/images/gitpher.jpeg'),
                  width: 40,
                  height: 40,
                ),
                Text(
                  'Githper',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
        );
