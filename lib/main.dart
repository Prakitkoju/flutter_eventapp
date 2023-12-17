import 'package:flutter/material.dart';
import 'package:eventapp/models/event.dart';
import 'package:eventapp/eventdetailpage.dart';
import 'package:eventapp/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EventListPage(),
    );
  }
}

class EventListPage extends StatefulWidget {
  @override
  _EventListPageState createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> {
  // final String apiKey = "AJIubp2Y9E8NY4rBrYmVt2nJqHjghF8S"; // Replace with your Ticket Master API key
  final String apiUrl = "https://app.ticketmaster.com/discovery/v2/events.json";
  List<Event> events = [];

  @override
  void initState() {
    super.initState();
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    final response = await http.get(Uri.parse('$apiUrl?apikey=$apiKey&size=30'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> eventList = data['_embedded']['events'];
      setState(() {
        events = eventList.map((eventData) => Event.fromJson(eventData)).toList();
      });
    } else {
      // Handle error
      print('Failed to load events');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event List'),
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EventDetailsScreen(event: events[index]),
                ),
              );
            },
            leading: Image.network(events[index].imageUrl),
            title: Text(events[index].name),
            subtitle: Text(events[index].dateTime),
          );
        },
      ),
    );
  }
}

// class EventDetailsPage extends StatelessWidget {
//   final Event event;
//
//   const EventDetailsPage({required this.event});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Event Details'),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Image.network(event.imageUrl),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               'Name: ${event.name}',
//               style: TextStyle(fontSize: 20),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text('Date Time: ${event.dateTime}'),
//           ),
//           // Add more details as needed
//         ],
//       ),
//     );
//   }
// }

