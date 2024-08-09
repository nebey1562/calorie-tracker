import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'user.dart';

class SettingsScreen extends StatefulWidget {
  final User user; // Pass the user instance when navigating to this screen

  SettingsScreen({required this.user});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final TextEditingController _weightController;
  late final TextEditingController _heightController;
  late final TextEditingController _ageController;

  String? _bmi;
  String? _bmr;

  @override
  void initState() {
    super.initState();
    _weightController = TextEditingController(text: widget.user.weight.toString());
    _heightController = TextEditingController(text: widget.user.height.toString());
    _ageController = TextEditingController(text: widget.user.age.toString());
  }

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '\nUpdate Personal Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.indigoAccent,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  TextField(
                    controller: _weightController,
                    decoration: InputDecoration(
                      labelText: 'Weight (kg)',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.black87,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _heightController,
                    decoration: InputDecoration(
                      labelText: 'Height (m)',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.black87,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _ageController,
                    decoration: InputDecoration(
                      labelText: 'Age (years)',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.black87,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      final double weight = double.tryParse(_weightController.text) ?? 0.0;
                      final double height = double.tryParse(_heightController.text) ?? 0.0;
                      final int age = int.tryParse(_ageController.text) ?? 0;

                      // Update the user instance
                      widget.user.weight = weight;
                      widget.user.height = height;
                      widget.user.age = age;

                      // Optionally, save the updated user to ObjectBox
                      // store.write(() => store.userBox.put(widget.user));

                      setState(() {
                        _bmi = (weight / (height * height)).toStringAsFixed(2);
                        _bmr = ((88.362 + (13.397 * weight) + (4.799 * (height * 100)) - (5.677 * age)) * 1.55).toStringAsFixed(0);
                      });
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            if (_bmi != null && _bmr != null)
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        'Your BMI: $_bmi',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Divider(color: Colors.white),
                    const SizedBox(height: 8),
                    ListTile(
                      title: Text(
                        'Your Daily Calorie Intake: $_bmr',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
