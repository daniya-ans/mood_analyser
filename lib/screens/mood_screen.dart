import 'package:flutter/material.dart';
import 'result_screen.dart';

class MoodScreen extends StatefulWidget {
  const MoodScreen({super.key});

  @override
  State<MoodScreen> createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  String? gender;
  String? sleepHours;
  String? activity;
  String? selectedMood;

  double stressLevel = 5;

  bool receiveSuggestions = true;

  final List<Map<String, String>> moods = [
    {"emoji": "😊", "name": "Happy"},
    {"emoji": "😌", "name": "Calm"},
    {"emoji": "😔", "name": "Sad"},
    {"emoji": "😡", "name": "Angry"},
    {"emoji": "😰", "name": "Stressed"},
    {"emoji": "😴", "name": "Tired"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mood Assessment"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text(
                "Tell us how you're feeling today!",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 25),

              // Name

              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter your name";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // Age

              TextFormField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Age",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.cake),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your age";
                  }

                  final age = int.tryParse(value);

                  if (age == null || age < 10 || age > 100) {
                    return "Enter a valid age";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              // Gender

              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Gender",
                  border: OutlineInputBorder(),
                ),
                value: gender,
                items: ["Male", "Female", "Other"]
                    .map(
                      (g) => DropdownMenuItem(
                    value: g,
                    child: Text(g),
                  ),
                )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    gender = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return "Select your gender";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 25),

              const Text(
                "Choose Your Mood",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: moods.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final mood = moods[index];

                  bool isSelected =
                      selectedMood == mood["name"];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedMood = mood["name"];
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.teal.shade200
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? Colors.teal
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "${mood["emoji"]}  ${mood["name"]}",
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 25),

              const Text(
                "Stress Level",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Slider(
                value: stressLevel,
                min: 0,
                max: 10,
                divisions: 10,
                label: stressLevel.round().toString(),
                onChanged: (value) {
                  setState(() {
                    stressLevel = value;
                  });
                },
              ),

              Center(
                child: Text(
                  "${stressLevel.round()} / 10",
                  style: const TextStyle(fontSize: 18),
                ),
              ),

              const SizedBox(height: 20),

              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Sleep Hours",
                  border: OutlineInputBorder(),
                ),
                value: sleepHours,
                items: [
                  "Less than 5 hours",
                  "5 - 6 hours",
                  "7 - 8 hours",
                  "More than 8 hours"
                ]
                    .map(
                      (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ),
                )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    sleepHours = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return "Select sleep hours";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Today's Activity",
                  border: OutlineInputBorder(),
                ),
                value: activity,
                items: [
                  "Studying",
                  "Working",
                  "Exercise",
                  "Gaming",
                  "Reading",
                  "Watching TV",
                  "Shopping",
                  "Travelling"
                ]
                    .map(
                      (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ),
                )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    activity = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return "Select an activity";
                  }
                  return null;
                },
              ),

              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                value: receiveSuggestions,
                title: const Text(
                    "I want wellness suggestions"),
                onChanged: (value) {
                  setState(() {
                    receiveSuggestions = value!;
                  });
                },
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  child: const Text(
                    "Analyze Mood",
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {

                    if (selectedMood == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                          Text("Please select your mood"),
                        ),
                      );
                      return;
                    }

                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ResultScreen(
                                name: nameController.text,
                                mood: selectedMood!,
                                stressLevel: stressLevel,
                                sleepHours: sleepHours!,
                                activity: activity!,
                              ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}