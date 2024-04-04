import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Contact {
  final String name;
  final String phoneNumber;
  final String address;
  final String imageUrl;

  Contact({
    required this.name,
    required this.phoneNumber,
    required this.address,
    this.imageUrl = '',
  });
}

class CallLog {
  final String callerName;
  final String callerPhoneNumber;
  final String callTime;

  CallLog({
    required this.callerName,
    required this.callerPhoneNumber,
    required this.callTime,
  });
}

class MyApp extends StatelessWidget {
  final List<Contact> contacts = [
    Contact(
        name: 'tuong',
        phoneNumber: '1234567890',
        address: 'bac ninh',
        imageUrl:
            'https://noithatbinhminh.com.vn/wp-content/uploads/2022/08/anh-dep-40.jpg.webp'),
    Contact(
        name: 'truong',
        phoneNumber: '4567890123',
        address: 'nam dinh',
        imageUrl:
            'https://www.elle.vn/wp-content/uploads/2017/07/25/hinh-anh-dep-1.jpg'),
    Contact(
        name: 'toan',
        phoneNumber: '7890123456',
        address: 'phu tho',
        imageUrl:
            'https://dulichviet.com.vn/images/bandidau/danh-sach-nhung-buc-anh-viet-nam-lot-top-anh-dep-the-gioi.jpg'),
  ];

  final List<CallLog> callLogs = [
    CallLog(
        callerName: 'kiên',
        callerPhoneNumber: '0987654321',
        callTime: 'tuần trước'),
    CallLog(
        callerName: 'truong',
        callerPhoneNumber: '0123456789',
        callTime: 'hôm nay '),
    CallLog(
        callerName: 'biet',
        callerPhoneNumber: '0123456789',
        callTime: '2 h trước '),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phonebook',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ContactListScreen(contacts: contacts, callLogs: callLogs),
    );
  }
}

class ContactListScreen extends StatelessWidget {
  final List<Contact> contacts;
  final List<CallLog> callLogs;

  ContactListScreen({required this.contacts, required this.callLogs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('quay số'),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(contacts[index].imageUrl),
              child: Text(contacts[index].name[0]),
            ),
            title: Text(contacts[index].name),
            subtitle: Text(contacts[index].phoneNumber),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContactDetailScreen(
                      contact: contacts[index], callLogs: callLogs),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ContactDetailScreen extends StatelessWidget {
  final Contact contact;
  final List<CallLog> callLogs;

  ContactDetailScreen({required this.contact, required this.callLogs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contact.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (contact.imageUrl.isNotEmpty)
              Image.network(
                contact.imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            SizedBox(height: 20),
            Text(
              'số:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(contact.phoneNumber),
            SizedBox(height: 10),
            Text(
              'địa chit:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(contact.address),
            SizedBox(height: 20),
            Text(
              'nhật ký :',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: callLogs.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(callLogs[index].callerName),
                    subtitle: Text(callLogs[index].callerPhoneNumber),
                    trailing: Text(callLogs[index].callTime),
                    onTap: () {
                      // Do something when tapped
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
