import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


Future<void> _messageHandler(RemoteMessage message) async {
  print('background message ${message.notification!.body}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  runApp(MessagingTutorial());
}

class MessagingTutorial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Messaging',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Firebase Messaging'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late FirebaseMessaging messaging;
  String? notificationText;
  @override
  void initState() {
    super.initState();
    _signInAnon();
    messaging = FirebaseMessaging.instance;
    messaging.subscribeToTopic("messaging");
    messaging.getToken().then((value) {
      print(value);
    });
    FirebaseMessaging.instance.getToken().then((value) {
      print('Device Token: $value');
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message received");
      final notification = event.notification;
      final data = event.data;
      String messageType = data['type'] ?? 'regular';
      String messageBody = notification?.body ?? 'No body';
      _storeNotification(messageType, messageBody);
      print("Type: $messageType");
      print("Body: $messageBody");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(messageType == 'important' ? "Important Message" : "Notification"),
            content: Text(messageBody),
            backgroundColor: messageType == 'important' ? Colors.red[100] : null,
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
    });
  }

  Future<void> _signInAnon() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
      print("Signed in anonymously");
    } catch (e) {
      print("Anonymous sign-in failed: $e");
    }
  }

  Future<void> _storeNotification(String type, String body) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    await FirebaseFirestore.instance.collection('notifications').add({
      'uid': uid,
      'type': type,
      'body': body,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('notifications')
            .orderBy('timestamp', descending: true)
            .where('uid', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No notifications yet."));
          }
          final notifications = snapshot.data!.docs.map((doc) {
            return {
              'type': doc['type'],
              'body': doc['body'],
              'timestamp': doc['timestamp'],
            };
          }).toList();
          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              return ListTile(
                title: Text(notification['type'] == 'important'
                    ? 'Important: ${notification['body']}'
                    : notification['body']),
                leading: Icon(Icons.notifications),
                tileColor: notification['type'] == 'important'
                    ? Colors.red[100]
                    : null,
                subtitle: Text(
                    'Received: ${notification['timestamp']?.toDate().toString() ?? ''}'),
              );
            },
          );
        },
      ),
    );
  }
}
