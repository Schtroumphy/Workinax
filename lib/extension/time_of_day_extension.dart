
import 'package:flutter/material.dart';

extension TimeOfDayExtension on TimeOfDay? {
  String get formatTimeOfDay {
    if(this == null) return 'N/A';

    final hour = this!.hour.toString().padLeft(2, '0');
    final minute = this!.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }
}

String timeDifference(TimeOfDay t1, TimeOfDay t2) {
  // Convertir les TimeOfDay en minutes
  int minutes1 = t1.hour * 60 + t1.minute;
  int minutes2 = t2.hour * 60 + t2.minute;

  // Calculer la différence en minutes
  int differenceInMinutes = minutes1 - minutes2;

  // Calculer les heures et minutes à partir de la différence
  int hours = (differenceInMinutes ~/ 60).abs(); // Utiliser la division entière
  int minutes = (differenceInMinutes % 60).abs(); // Reste de la division par 60

  // Formater la chaîne au format HH:mm
  return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
}