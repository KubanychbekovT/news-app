import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../infrastructure/configs/configs.dart';
import '../../utils/app_utils.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        leadingWidth: 0,
        title: Text(
          'Newsy',
          style: AppText.h2b,
        ),
        actions: [
          CircleAvatar(),
          Space.x!,
        ],
      ),
      body: Column(
        children: [
          SingleChildScrollView(

            scrollDirection: Axis.horizontal,
            child: Row(
              children: AppUtils.categories
                  .map((e) => Padding(
                  padding: Space.all(1, 1),
                  child: Text(
                    toBeginningOfSentenceCase(e)!,
                  ),
              ),
              )
                    .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
