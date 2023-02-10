import 'package:awesome_notifications/awesome_notifications.dart';

//function for alert notifications
void ProgressDelivery() async{
  String timezonegm = await AwesomeNotifications().getLocalTimeZoneIdentifier();
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
        id: 1,
        channelKey: 'key1',
        title: 'Farm Fresh Delivery Alert!',
        body: 'These orders are pending, continue the process.',
        bigPicture: 'https://www.goteso.com/products/assets/images/fruit-and-vegetable-business-management-app.png',
        notificationLayout: NotificationLayout.BigPicture
    ),
    schedule: NotificationInterval(interval: 1, timeZone: timezonegm, repeats: false),
  );

}