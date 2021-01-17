import 'package:air_quality/controller/history_ctl.dart';
import 'package:air_quality/widgets/my_colors.dart';
import 'package:air_quality/widgets/mytext.dart';
import 'package:air_quality/widgets/pixel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:lottie/lottie.dart';

class HistoryPage extends StatelessWidget {
  Widget _header() {
    return Expanded(
      flex: 2,
      child: Container(
        margin: EdgeInsets.all(
          Pixel.x * 2,
        ),
        padding: EdgeInsets.all(Pixel.x * 10),
        child: Column(
          children: [
            Flexible(
              flex: 3,
              child: Lottie.asset('assets/plant.json'),
            ),
            Flexible(
              flex: 1,
              child: MyText(
                text: 'Soil Monitoring',
                color: MyColors.embers,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _body() {
    return Expanded(
      flex: 4,
      child: GetBuilder<HistoryCtl>(
        init: HistoryCtl(),
        builder: (snapshot) {
          snapshot.history = snapshot.history.reversed.toList();
          return Container(
            width: Pixel.x * 90,
            height: Pixel.y * 40,
            child: snapshot.history == null || snapshot.history.length == 0
                ? Center(
                    child: MyText(
                      text: 'Tidak ada data',
                      color: MyColors.embers,
                      fontSize: Pixel.x * 7,
                    ),
                  )
                : ListView.builder(
                    itemCount: snapshot.history.length,
                    itemBuilder: (context, index) {
                      int temp = snapshot.history[index].temperature;
                      int hum = snapshot.history[index].humidity;
                      int soil = snapshot.history[index].soil;
                      double ph = snapshot.history[index].ph;
                      return _item(
                        'History',
                        'Temp : $temp  Hum : $hum  Soil : $soil  pH : $ph',
                        snapshot.history[index].timestamp,
                      );
                    },
                  ),
          );
        },
      ),
    );
  }

  Widget _item(String status, String detail, int timestamp) {
    return Container(
      width: Pixel.x * 90,
      height: Pixel.y * 20,
      padding: EdgeInsets.all(
        Pixel.x * 2,
      ),
      margin: EdgeInsets.all(
        Pixel.x * 2,
      ),
      decoration: BoxDecoration(
          color: MyColors.embers,
          borderRadius: BorderRadius.circular(
            Pixel.x * 3,
          )),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Icon(
                Icons.history,
                size: Pixel.x * 10,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    text: status,
                    fontSize: Pixel.x * 5,
                  ),
                  MyText(
                    text: detail,
                    fontSize: Pixel.x * 4,
                  ),
                  MyText(
                    text: DateTime.fromMillisecondsSinceEpoch(timestamp)
                        .toString()
                        .split('.')[0],
                    fontSize: Pixel.x * 4,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Pixel().init(context);
    return Column(
      children: [
        _header(),
        _body(),
      ],
    );
  }
}
