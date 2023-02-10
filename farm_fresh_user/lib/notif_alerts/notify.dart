import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/widgets.dart';

//function for alert notifications
void NotifyAlert() async{
  String timezonegm = await AwesomeNotifications().getLocalTimeZoneIdentifier();
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'key1',
        title: 'Farm Fresh Delivery Alert!',
        body: 'Order placed! Riders are notified for your request.',
        bigPicture: 'https://app.builtin.com/cdn-cgi/image/quality=80,width=752,height=435/https://builtin.com/sites/www.builtin.com/files/styles/byline_image/public/food-delivery-companies.jpg',
        notificationLayout: NotificationLayout.BigPicture
      ),
    schedule: NotificationInterval(interval: 3, timeZone: timezonegm, repeats: false),
  );

}