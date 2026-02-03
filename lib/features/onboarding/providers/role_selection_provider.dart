


import 'package:flutter_riverpod/legacy.dart';

enum UserRole { customer, employee }

final selectedRoleProvider = StateProvider<UserRole?>((ref) => null);
