import 'dart:async';
import 'package:flutter/material.dart';

class RelaxScreen extends StatefulWidget {
  const RelaxScreen({super.key});

  @override
  State<RelaxScreen> createState() => _RelaxScreenState();
}

class _RelaxScreenState extends State<RelaxScreen> {
  Timer? timer;

  int seconds = 60;
  bool isRunning = false;
  bool isBreathingIn = true;

  int affirmationIndex = 0;

  final List<String> affirmations = [
    "You are doing better than you think. 💙",
    "Take it one step at a time. 🌱",
    "You deserve a moment of peace. ☁️",
    "Believe in yourself. ✨",
    "It is okay to take a break. 🌸",
    "You are stronger than you think. 💪",
  ];

  final List<Map<String, dynamic>> activities = [
    {
      "icon": Icons.water_drop,
      "title": "Drink Water",
      "description": "Take a few sips of water and refresh yourself."
    },
    {
      "icon": Icons.directions_walk,
      "title": "Take a Walk",
      "description": "Walk around for 5 minutes and get some fresh air."
    },
    {
      "icon": Icons.music_note,
      "title": "Listen to Music",
      "description": "Play a calm song that makes you feel relaxed."
    },
    {
      "icon": Icons.phone,
      "title": "Talk to Someone",
      "description": "Connect with a friend or someone you trust."
    },
  ];

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startBreathing() {
    if (isRunning) return;

    setState(() {
      isRunning = true;
      seconds = 60;
      isBreathingIn = true;
    });

    timer = Timer.periodic(
      const Duration(seconds: 1),
          (Timer timer) {
        if (seconds > 0) {
          setState(() {
            seconds--;

            // Change breathing instruction every 4 seconds
            if ((60 - seconds) % 4 == 0) {
              isBreathingIn = !isBreathingIn;
            }
          });
        } else {
          timer.cancel();

          setState(() {
            isRunning = false;
          });

          showFinishedDialog();
        }
      },
    );
  }

  void stopBreathing() {
    timer?.cancel();

    setState(() {
      isRunning = false;
      seconds = 60;
      isBreathingIn = true;
    });
  }

  void showFinishedDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Well Done! 🌿"),
          content: const Text(
            "You completed the breathing exercise. "
                "Take a moment to notice how you feel.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Continue"),
            ),
          ],
        );
      },
    );
  }

  void nextAffirmation() {
    setState(() {
      affirmationIndex =
          (affirmationIndex + 1) % affirmations.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Relax Zone"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Header

            const Center(
              child: Text(
                "Take a Moment for Yourself 🧘",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 8),

            const Center(
              child: Text(
                "Slow down, breathe, and relax.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Breathing Exercise

            const Text(
              "🫁 Breathing Exercise",
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),

              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  children: [

                    const Text(
                      "60 Second Breathing",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    AnimatedContainer(
                      duration: const Duration(seconds: 4),

                      width: isRunning && isBreathingIn
                          ? 180
                          : 120,

                      height: isRunning && isBreathingIn
                          ? 180
                          : 120,

                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.teal.shade100,
                      ),

                      child: Center(
                        child: Text(
                          isRunning
                              ? (isBreathingIn
                              ? "Breathe In"
                              : "Breathe Out")
                              : "Ready?",

                          textAlign: TextAlign.center,

                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      "$seconds seconds",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    SizedBox(
                      width: double.infinity,
                      height: 48,

                      child: ElevatedButton.icon(
                        icon: Icon(
                          isRunning
                              ? Icons.stop
                              : Icons.play_arrow,
                        ),

                        label: Text(
                          isRunning
                              ? "Stop Exercise"
                              : "Start Breathing",
                        ),

                        onPressed: isRunning
                            ? stopBreathing
                            : startBreathing,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Affirmation

            const Text(
              "💭 Positive Affirmation",
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Card(
              elevation: 3,
              color: Colors.teal.shade50,

              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  children: [

                    Text(
                      affirmations[affirmationIndex],
                      textAlign: TextAlign.center,

                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 15),

                    OutlinedButton(
                      onPressed: nextAffirmation,
                      child: const Text(
                        "New Affirmation ✨",
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Relaxation Activities

            const Text(
              "🌿 Quick Relaxation Activities",
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            ...activities.map(
                  (activity) => Card(
                margin: const EdgeInsets.only(bottom: 12),

                child: ListTile(
                  leading: CircleAvatar(
                    child: Icon(activity["icon"]),
                  ),

                  title: Text(
                    activity["title"],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  subtitle: Text(
                    activity["description"],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Mood Check

            const Center(
              child: Text(
                "How do you feel now?",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 15),

            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceEvenly,

              children: [

                moodButton("😊", "Better"),
                moodButton("😌", "Calm"),
                moodButton("😐", "Same"),
                moodButton("😔", "Still Low"),

              ],
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget moodButton(String emoji, String label) {
    return GestureDetector(
      onTap: () {

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Thanks for checking in! You feel $label.",
            ),
          ),
        );

      },

      child: Column(
        children: [

          Container(
            padding: const EdgeInsets.all(12),

            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),

            child: Text(
              emoji,
              style: const TextStyle(fontSize: 28),
            ),
          ),

          const SizedBox(height: 5),

          Text(
            label,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}