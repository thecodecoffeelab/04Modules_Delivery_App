import 'package:awesome_notifications/awesome_notifications.dart';

//function for alert notifications
void OrderDetailsAlert() async{
  String timezonegm = await AwesomeNotifications().getLocalTimeZoneIdentifier();
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
        id: 1,
        channelKey: 'key1',
        title: 'Farm Fresh Delivery Alert!',
        body: 'Click on your order to check details!',
        bigPicture: 'https://thumbs.dreamstime.com/b/farm-fresh-delivery-design-template-classic-food-truck-organic-vegetables-meat-other-healthy-natural-prodacts-vector-172377385.jpg',
        notificationLayout: NotificationLayout.BigPicture
    ),
    schedule: NotificationInterval(interval: 1, timeZone: timezonegm, repeats: false),
  );

}