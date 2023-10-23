/**
 * Adapted from https://github.com/lohanidamodar/flutter_events_2023/tree/p3-optimization-and-more
 */

import 'package:cloud_firestore/cloud_firestore.dart';

//error with sleep and intake

class Event {
  final String? type;
  final DateTime date;

  // dreams vars
  final int? nightmares;
  final int? normal_dreams;
  final int? lucid_dreams;
  final int? day_dreams;
  final int? false_awakenings;

  // intake vars
  final String? caffeineIntake;
  final String? foodIntake;
  final String? otherIntake;

  // sleep vars
  final String? time_asleep;
  final String? mood;

  // journal vars
  final String? message;

  Event({
    required this.type,
    required this.date,

    this.normal_dreams,
    this.lucid_dreams,
    this.day_dreams,
    this.nightmares,
    this.false_awakenings,

    this.caffeineIntake,
    this.foodIntake,
    this.otherIntake,

    this.time_asleep,
    this.mood,

    this.message,

  });

  factory Event.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      [SnapshotOptions? options]) {
    final data = snapshot.data()!;

      return Event(
        date: data['date'].toDate(),
        type: data['type'],

        normal_dreams: data['normal_dreams'],
        lucid_dreams: data['lucid_dreams'],
        day_dreams: data['day_dreams'],
        nightmares: data['nightmares'],
        false_awakenings: data['false_awakenings'],

        caffeineIntake: data['caffeineIntake'],
        foodIntake: data['foodIntake'],
        otherIntake: data['otherIntake'],

        time_asleep: data['Time Asleep'],
        mood: data['Mood'],

        message: data['message'],

      );

  }

  Map<String, Object?> toFirestore() {
    return {
      "date": Timestamp.fromDate(date),
      "type": type,

      "normal_dreams": normal_dreams,
      "lucid_dreams": lucid_dreams,
      "day_dreams": day_dreams,
      "nightmares": nightmares,
      "false_awakenings": false_awakenings,

      "caffeineIntake": caffeineIntake,
      "foodIntake": foodIntake,
      "otherIntake": otherIntake,

      "Time Asleep": time_asleep,
      "Mood": mood,

      "message": message,
    };
  }
}