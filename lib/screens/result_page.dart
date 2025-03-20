import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final double bmi;
  const ResultPage({super.key, required this.bmi});
  String getResultText() {
    if (bmi < 18.5) {
      return 'Zayıf';
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return 'Normal';
    } else if (bmi >= 25 && bmi < 29.9) {
      return 'Fazla Kilolu';
    } else {
      return 'Obez';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sonuç')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('BMI: ${bmi.toStringAsFixed(1)}', style: const TextStyle(fontSize: 24)),
            Text(getResultText(), style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Geri Dön'),
              ),
          ],
        ),
      ),
    );
  }
}
