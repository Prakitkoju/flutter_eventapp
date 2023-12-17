import 'package:flutter/material.dart';
import 'package:eventapp/models/event.dart';
import 'package:eventapp/models/eventdetail.dart';
import 'package:eventapp/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EventDetailsScreen extends StatefulWidget {
  final Event event;

  EventDetailsScreen({required this.event});

  @override
  _EventDetailsScreenState createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  late Future<EventDetail> futureEventDetail;

  @override
  void initState() {
    super.initState();
    futureEventDetail = fetchEventDetails(widget.event); // Fetch event details
  }

  Future<EventDetail> fetchEventDetails(Event event) async {
    // final apiKey = 'AJIubp2Y9E8NY4rBrYmVt2nJqHjghF8S';
    final eventId = event.id; // Replace with the actual way to get the event ID

    final url = 'https://app.ticketmaster.com/discovery/v2/events/$eventId.json?apikey=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return EventDetail.fromJson(data);
    } else {
      throw Exception('Failed to load event details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
      ),
      body: FutureBuilder<EventDetail>(
        future: futureEventDetail,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final eventDetail = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // for (var imageUrl in eventDetail.images)
                //   Image.network(imageUrl),
                Image.network(eventDetail.images[0]),
                Text(eventDetail.name),
                Text(eventDetail.dateTime),
                Text(eventDetail.info),
                Text(eventDetail.pleasenote),
                Text('Promoters: ${eventDetail.promoters.join(', ')}'),
                // Add more details here
              ],
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          return CircularProgressIndicator(); // Loading indicator
        },
      ),
    );
  }
}