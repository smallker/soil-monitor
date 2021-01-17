import 'package:air_quality/model/history_model.dart';
import 'package:air_quality/model/status_model.dart';
import 'package:get/get.dart';

class StatusCtl extends GetxController {
  HistoryModel status;

  updateRealtime(HistoryModel status) {
    this.status = status;
    update();
  }
}
