import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  int _rating = 0;
  List<String> _improvementAreas = [
    'Overall Service',
    'Customer Support',
    'Speed and Efficiency',
    'Repair Quality',
    'Pickup and Delivery Service',
    'Transparency'
  ];
  List<String> _selectedAreas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rate Your Experience',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Are you Satisfied with the Service?'),
            SizedBox(height: 10),
            Row(
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < _rating ? Icons.star : Icons.star_border,
                    color: Colors.black,
                    size: 30,
                  ),
                  onPressed: () {
                    setState(() {
                      _rating = index + 1;
                    });
                  },
                );
              }),
            ),
            SizedBox(height: 20),
            Text('Tell us what can be Improved?',
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: _improvementAreas.map((area) {
                final isSelected = _selectedAreas.contains(area);
                return FilterChip(
                  label: Text(area),
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                  backgroundColor: Colors.white,
                  selectedColor: Colors.black,
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedAreas.add(area);
                      } else {
                        _selectedAreas.remove(area);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Tell us how can we improve...',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Submit feedback logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.black, // Background color for the button
                  foregroundColor: Colors.white, // Text color
                ),
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
