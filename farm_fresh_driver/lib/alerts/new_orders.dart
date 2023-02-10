import 'package:awesome_notifications/awesome_notifications.dart';

//function for alert notifications
void NewOrders() async{
  String timezonegm = await AwesomeNotifications().getLocalTimeZoneIdentifier();
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
        id: 1,
        channelKey: 'key1',
        title: 'Farm Fresh Delivery Alert!',
        body: 'Proccess Orders if they are available, Earn more.',
        bigPicture: 'https://www.sitajoyeh.gm/onlinelogomaker-072022-2212-3747.png',
        notificationLayout: NotificationLayout.BigPicture
    ),
    schedule: NotificationInterval(interval: 1, timeZone: timezonegm, repeats: false),
  );

}