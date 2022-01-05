import 'package:bank_sathi/Model/response/notification_response.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/dashboard_controller.dart';
import 'package:get/get.dart';

class NotificationController extends BaseController {
  final _notificationList = <Notification>[].obs;

  List<Notification> get notificationList => _notificationList.value;

  set notificationList(val) => _notificationList.value = val;

  DateTime? lastNotificationTime;

  @override
  void onReady() async {
    super.onReady();
    pageState = PageStates.PAGE_LOADING;
    lastNotificationTime =
        DateTime.tryParse(prefManager.getNotificationTime()!);
    try {
      NotificationResponse value = await restClient.getNotifications();
      pageState = PageStates.PAGE_IDLE;
      if (value.success) {
        notificationList = value.data.notification;
        prefManager.setNotificationTime(value.data.current_time);
        Get.find<DashboardController>().notifCount = 0;
      }
    } catch (e) {
      pageState = PageStates.PAGE_ERROR;
    }
  }

  bool isNewNotification(String date) {
    return lastNotificationTime == null ||
        DateTime.parse(date).isAfter(lastNotificationTime!);
  }
}
