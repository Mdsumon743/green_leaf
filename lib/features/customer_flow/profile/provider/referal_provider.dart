
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReferralStat {
  final String title;
  final String value;
  final IconData icon;

  ReferralStat({
    required this.title,
    required this.value,
    required this.icon,
  });
}

class Referral {
  final String name;
  final String date;
  final String amount;
  final String status;

  Referral({
    required this.name,
    required this.date,
    required this.amount,
    required this.status,
  });
}

// Providers
final referralStatsProvider = Provider<List<ReferralStat>>((ref) {
  return [
    ReferralStat(
      title: 'Total Earned',
      value: '€10',
      icon: Icons.wallet_outlined,
    ),
    ReferralStat(
      title: 'Successful Referrals',
      value: '01',
      icon: Icons.check_circle_outline,
    ),
  ];
});

final referralsListProvider = Provider<List<Referral>>((ref) {
  return [
    Referral(
      name: 'Sarah Johnson',
      date: '1 Dec 2025',
      amount: '+€10',
      status: 'Joined',
    ),
    Referral(
      name: 'Sarah Johnson',
      date: '1 Dec 2025',
      amount: '+€10',
      status: 'Joined',
    ),
  ];
});