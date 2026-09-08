import 'package:flutter/material.dart';
import 'relax_screen.dart';

class ResultScreen extends StatelessWidget {
  final String name;
  final String mood;
  final double stressLevel;
  final String sleepHours;
  final String activity;

  const ResultScreen({
    super.key,
    required this.name,
    required this.mood,
    required this.stressLevel,
    required this.sleepHours,
    required this.activity,
  });

  String getMoodEmoji() {
    switch (mood) {
      case "Happy":
        return "😊";
      case "Calm":
        return "😌";
      case "Sad":
        return "😔";
      case "Angry":
        return "😡";
      case "Stressed":
        return "😰";
      case "Tired":
        return "😴";
      default:
        return "🙂";
    }
  }

  String getMessage() {
    if (stressLevel >= 8) {
      return "Your stress level seems quite high. Take some time to relax and recharge.";
    } else if (stressLevel >= 5) {
      return "You seem to be experiencing moderate stress. A short break could help.";
    } else {
      return "Your stress level looks manageable. Keep taking care of yourself!";
    }
  }

  List<String> getTips() {
    if (mood == "Happy") {
      return [
        "Keep doing things that make you happy.",
        "Share your positive energy with others.",
        "Take some time to appreciate your day."
      ];
    }

    if (mood == "Sad") {
      return [
        "Talk to someone you trust.",
        "Listen to your favorite music.",
        "Take a short walk or spend time outside."
      ];
    }

    if (mood == "Angry") {
      return [
        "Take a few slow, deep breaths.",
        "Give yourself some quiet time.",
        "Avoid making important decisions while angry."
      ];
    }

    if (mood == "Stressed") {
      return [
        "Take a 5-minute breathing break.",
        "Drink some water.",
        "Step away from your work for a while."
      ];
    }

    if (mood == "Tired") {
      return [
        "Give your body enough time to rest.",
        "Reduce screen time before sleeping.",
        "Try to maintain a regular sleep schedule."
      ];
    }

    return [
      "Keep maintaining your positive routine.",
      "Take regular breaks during the day.",
      "Spend some time doing something you enjoy."
    ];
  }

  @override
  Widget build(BuildContext context) {
    final tips = getTips();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Mood Result"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            const SizedBox(height: 10),

            Text(
              getMoodEmoji(),
              style: const TextStyle(fontSize: 80),
            ),

            const SizedBox(height: 10),

            Text(
              "Hello, $name!",
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "You are feeling $mood today.",
              style: const TextStyle(fontSize: 20),
            ),

            const SizedBox(height: 25),

            // Stress Card

            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  children: [

                    const Text(
                      "Your Stress Level",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "${stressLevel.round()} / 10",
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(getMessage()),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Daily information

            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    const Text(
                      "Today's Summary",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Text("😊 Mood: $mood"),
                    Text("😴 Sleep: $sleepHours"),
                    Text("🏃 Activity: $activity"),

                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Tips

            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    const Text(
                      "💡 Personalized Tips",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    ...tips.map(
                          (tip) => Padding(
                        padding:
                        const EdgeInsets.only(bottom: 12),

                        child: Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,

                          children: [

                            const Text(
                              "• ",
                              style: TextStyle(fontSize: 20),
                            ),

                            Expanded(
                              child: Text(
                                tip,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Relax button

            SizedBox(
              width: double.infinity,
              height: 50,

              child: ElevatedButton.icon(

                icon: const Icon(
                  Icons.self_improvement,
                ),

                label: const Text(
                  "Enter Relax Zone",
                  style: TextStyle(fontSize: 17),
                ),

                onPressed: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const RelaxScreen(),
                    ),
                  );

                },
              ),
            ),

            const SizedBox(height: 15),

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Retake Mood Check",
              ),
            ),

          ],
        ),
      ),
    );
  }
}