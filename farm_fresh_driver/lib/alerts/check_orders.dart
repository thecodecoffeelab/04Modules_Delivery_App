import 'package:awesome_notifications/awesome_notifications.dart';

//function for alert notifications
void CheckOrders() async{
  String timezonegm = await AwesomeNotifications().getLocalTimeZoneIdentifier();
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
        id: 1,
        channelKey: 'key1',
        title: 'Farm Fresh Delivery Alert!',
        body: 'Welcome Driver! Check out now available orders.',
        bigPicture: 'https://us.123rf.com/450wm/alexandraklestova/alexandraklestova2003/alexandraklestova200300110/143010568-vector-stock-illustration-with-green-truck-full-of-fresh-vegetables-and-berries-farm-products-delive.jpg?ver=6',
        notificationLayout: NotificationLayout.BigPicture
    ),
    schedule: NotificationInterval(interval: 1, timeZone: timezonegm, repeats: false),
  );

}