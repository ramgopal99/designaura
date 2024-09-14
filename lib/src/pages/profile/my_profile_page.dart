import 'package:flutter/material.dart';

class MyProfilePage extends StatefulWidget {
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  // Controllers for text fields
  final TextEditingController _firstNameController =
      TextEditingController(text: 'Sonu');
  final TextEditingController _lastNameController =
      TextEditingController(text: 'Bagh');
 
  final TextEditingController _emailController =
      TextEditingController(text: 'SonuBagh009@gmail.com');
  final TextEditingController _phoneController =
      TextEditingController(text: '+91 8280993756');
  final TextEditingController _birthDateController =
      TextEditingController(text: 'Birth');


  String _selectedGender = 'Gender';

  Future<void> _selectBirthDate(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(1900),
      lastDate: currentDate,
    );

    if (selectedDate != null && selectedDate != currentDate) {
      setState(() {
        _birthDateController.text = '${selectedDate.toLocal()}'.split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture with Edit Icon
            SizedBox(height: 20),
            Text(
              'Edit Profile',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // First Name Field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 15),

            // Last Name Field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 15),

          
            // Email Field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 15),

            // Phone Number Field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 15),

            // Birth Date Field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _birthDateController,
                decoration: InputDecoration(
                  labelText: 'Birth Date',
                  border: OutlineInputBorder(),
                ),
                onTap: () => _selectBirthDate(context),
                readOnly: true,
              ),
            ),
            SizedBox(height: 15),

            // Gender Dropdown
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: DropdownButtonFormField<String>(
                value: _selectedGender,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                items: ['Gender', 'Male', 'Female', 'Other']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedGender = newValue!;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
