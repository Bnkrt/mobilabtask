import 'package:flutter/material.dart';
import 'result_page.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});
  @override
  State<InputPage> createState() => _InputPageState();
}
class _InputPageState extends State<InputPage> {
  int height = 168;
  int weight = 63;
  int age = 22;
  bool isMale = true;
  double calculateBMI() {
    double heightInMeters = height / 100;
    return weight / (heightInMeters * heightInMeters);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'BMI Hesaplayıcı',
          style: TextStyle(color: Colors.white),),
        centerTitle: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              genderButton('Erkek', Icons.male, isMale),
              const SizedBox(width: 20),
              genderButton('Kadın', Icons.female, !isMale),
            ],
          ),
          const SizedBox(height: 20),
          buildInfoBox(
            label: 'Boy',
            value: '$height cm',
            child: Slider(
              value: height.toDouble(),
              min: 100,
              max: 220,
              activeColor: Colors.redAccent,
              inactiveColor: Colors.grey,
              onChanged: (value) {
                setState(() {
                  height = value.toInt();
                });
              },
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildInfoBox(
                label: 'Kilo',
                value: '$weight kg',
                child: buildIncrementButtons(() {
                  setState(() {
                    if (weight > 30) weight--;
                  });
                }, () {
                  setState(() {
                    if (weight < 200) weight++;
                  });
                }),
              ),
              const SizedBox(width: 20),
              buildInfoBox(
                label: 'Yaş',
                value: '$age',
                child: buildIncrementButtons(() {
                  setState(() {
                    if (age > 10) age--;
                  });
                }, () {
                  setState(() {
                    if (age < 100) age++;
                  });
                }),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                double bmi = calculateBMI();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultPage(bmi: bmi),
                  ),
                );
              },
              child: const Text(
                'HESAPLA',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget genderButton(String text, IconData icon, bool isSelected) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isMale = (text == 'Erkek');
          });
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isSelected ? Colors.redAccent : Colors.black54,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Icon(icon, color: Colors.white, size: 40),
              const SizedBox(height: 10),
              Text(
                text,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget buildInfoBox({required String label, required String value, required Widget child}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(label, style: const TextStyle(color: Colors.white, fontSize: 16)),
            const SizedBox(height: 10),
            Text(value, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }
  Widget buildIncrementButtons(VoidCallback onDecrease, VoidCallback onIncrease) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onDecrease,
          icon: const Icon(Icons.remove, color: Colors.white),
        ),
        IconButton(
          onPressed: onIncrease,
          icon: const Icon(Icons.add, color: Colors.white),
        ),
      ],
    );
  }
}
