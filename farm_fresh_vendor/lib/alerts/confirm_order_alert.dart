import 'package:awesome_notifications/awesome_notifications.dart';

//function for alert notifications
void PackOrder() async{
  String timezonegm = await AwesomeNotifications().getLocalTimeZoneIdentifier();
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
        id: 1,
        channelKey: 'key1',
        title: 'Farm Fresh Delivery Alert!',
        body: 'Check out your new orders & confirm if the packing ready!',
        bigPicture: 'https://www.packagingstrategies.com/ext/resources/2019-Postings/Supplier-Products/Novolux-for-web.png',
        notificationLayout: NotificationLayout.BigPicture
    ),
    schedule: NotificationInterval(interval: 1, timeZone: timezonegm, repeats: false),
  );

}