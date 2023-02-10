import 'package:awesome_notifications/awesome_notifications.dart';

//function for alert notifications
void WelcomeAlert() async{
  String timezonegm = await AwesomeNotifications().getLocalTimeZoneIdentifier();
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'key1',
        title: 'Farm Fresh Delivery Alert!',
        body: 'Welcome Farm Fresh! Upload your items now & receive orders.',
        bigPicture: 'https://pbs.twimg.com/media/EiC5jfVXYAA6oOz.jpg',
        notificationLayout: NotificationLayout.BigPicture
      ),
    schedule: NotificationInterval(interval: 1, timeZone: timezonegm, repeats: false),
  );

}