import 'package:awesome_notifications/awesome_notifications.dart';

//function for alert notifications
void WelcomeAlert() async{
  String timezonegm = await AwesomeNotifications().getLocalTimeZoneIdentifier();
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
        id: 1,
        channelKey: 'key1',
        title: 'Farm Fresh Delivery Alert!',
        body: 'Welcome! Visit Our Store, Order & We deliver for you!',
        bigPicture: 'https://i.pinimg.com/736x/1a/4c/26/1a4c263e7bd0652030f9e4d6c32f0c27--farms-grocery-delivery-service.jpg',
        notificationLayout: NotificationLayout.BigPicture
    ),
    schedule: NotificationInterval(interval: 1, timeZone: timezonegm, repeats: false),
  );

}