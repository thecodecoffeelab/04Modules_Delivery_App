import 'package:awesome_notifications/awesome_notifications.dart';

//function for alert notifications
void CashOn() async{
  String timezonegm = await AwesomeNotifications().getLocalTimeZoneIdentifier();
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
        id: 1,
        channelKey: 'key1',
        title: 'Farm Fresh Delivery Alert!',
        body: 'Finish the order delivery & check out your earnings!.',
        bigPicture: 'https://thumbs.dreamstime.com/b/cash-delivery-cod-service-vector-red-tag-payment-fast-door-to-door-e-commerce-flat-illustration-64321954.jpg',
        notificationLayout: NotificationLayout.BigPicture
    ),
    schedule: NotificationInterval(interval: 1, timeZone: timezonegm, repeats: false),
  );

}