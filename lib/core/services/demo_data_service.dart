import 'dart:math';
import '../models/models.dart';

/// Provides realistic demo data for all dashboard sections.
class DemoDataService {
  static final _random = Random(42);

  static final List<String> _firstNames = [
    'Ahmad',
    'Sara',
    'Omar',
    'Lina',
    'Khaled',
    'Nour',
    'Youssef',
    'Rania',
    'Hassan',
    'Dina',
    'Tarek',
    'Mona',
    'Ali',
    'Fatima',
    'Ziad',
    'Hana',
    'Bassem',
    'Layla',
    'Sami',
    'Rana',
    'Waleed',
    'Amira',
    'Fadi',
    'Jenna',
    'Rami',
    'Salma',
    'Nabil',
    'Yara',
    'Majed',
    'Dana',
  ];

  static final List<String> _lastNames = [
    'Al-Masri',
    'Haddad',
    'Khoury',
    'Nasser',
    'Saleh',
    'Abed',
    'Farah',
    'Mansour',
    'Jabari',
    'Hamdan',
    'Issa',
    'Qasim',
    'Barakat',
    'Darwish',
    'Sabbagh',
    'Khalil',
    'Taha',
    'Rizk',
    'Awad',
    'Shaheen',
  ];

  static final List<String> _locations = [
    'Downtown Amman',
    'Abdali Mall',
    'Airport Road',
    'University of Jordan',
    'Sweifieh',
    'Mecca Mall',
    'Jabal Amman',
    'Rainbow Street',
    'Khalda',
    'Shmeisani',
    'Tla Al-Ali',
    'Dabouq',
    'Marj Al-Hamam',
    'Sports City',
    'Tabarbour',
    'Abu Nseir',
    'Al-Jubeiha',
    'Bayader Wadi Seer',
  ];

  static String _randomName() =>
      '${_firstNames[_random.nextInt(_firstNames.length)]} ${_lastNames[_random.nextInt(_lastNames.length)]}';

  static String _randomLocation() =>
      _locations[_random.nextInt(_locations.length)];

  static DashboardStats getStats() {
    return const DashboardStats(
      totalUsers: 12847,
      totalRides: 45230,
      totalRevenue: 328750.50,
      activeDrivers: 1243,
      avgRating: 4.7,
      todayRides: 342,
    );
  }

  static List<UserModel> getUsers() {
    return List.generate(50, (i) {
      final name = _randomName();
      final email = '${name.split(' ').first.toLowerCase()}${i + 1}@email.com';
      return UserModel(
        id: 'USR-${(1000 + i).toString()}',
        name: name,
        email: email,
        phone:
            '+962 7${_random.nextInt(9)}${_random.nextInt(10000000).toString().padLeft(7, '0')}',
        status: [
          'Active',
          'Active',
          'Active',
          'Inactive',
          'Suspended',
        ][_random.nextInt(5)],
        joinedDate: DateTime(
          2024,
          _random.nextInt(12) + 1,
          _random.nextInt(28) + 1,
        ),
        totalRides: _random.nextInt(200),
      );
    });
  }

  static List<RideModel> getRides() {
    final statuses = [
      'Completed',
      'Completed',
      'Completed',
      'In Progress',
      'Cancelled',
    ];
    return List.generate(50, (i) {
      String pickup = _randomLocation();
      String dropoff = _randomLocation();
      while (dropoff == pickup) {
        dropoff = _randomLocation();
      }
      return RideModel(
        id: 'RDE-${(5000 + i).toString()}',
        userName: _randomName(),
        driverName: _randomName(),
        pickup: pickup,
        dropoff: dropoff,
        fare: (2.0 + _random.nextDouble() * 18.0),
        status: statuses[_random.nextInt(statuses.length)],
        date: DateTime(
          2025,
          _random.nextInt(3) + 1,
          _random.nextInt(28) + 1,
          _random.nextInt(24),
          _random.nextInt(60),
        ),
        distance: (1.0 + _random.nextDouble() * 25.0),
      );
    });
  }

  static List<PaymentModel> getPayments() {
    final methods = ['Credit Card', 'Cash', 'Wallet', 'Debit Card'];
    final statuses = [
      'Completed',
      'Completed',
      'Pending',
      'Refunded',
      'Failed',
    ];
    return List.generate(50, (i) {
      return PaymentModel(
        id: 'PAY-${(9000 + i).toString()}',
        userName: _randomName(),
        rideId: 'RDE-${(5000 + _random.nextInt(50)).toString()}',
        amount: (2.0 + _random.nextDouble() * 18.0),
        method: methods[_random.nextInt(methods.length)],
        status: statuses[_random.nextInt(statuses.length)],
        date: DateTime(2025, _random.nextInt(3) + 1, _random.nextInt(28) + 1),
      );
    });
  }

  // Chart data
  static List<double> getMonthlyRevenue() => [
    18500,
    22300,
    19800,
    25400,
    28100,
    31200,
    27800,
    33500,
    35200,
    29800,
    38400,
    42100,
  ];

  static List<double> getMonthlyRides() => [
    2800,
    3200,
    2900,
    3600,
    4100,
    4500,
    3900,
    4800,
    5200,
    4300,
    5600,
    6100,
  ];

  static Map<String, double> getRideStatusDistribution() => {
    'Completed': 68,
    'In Progress': 12,
    'Cancelled': 15,
    'Scheduled': 5,
  };

  static List<double> getWeeklyUsers() => [120, 145, 132, 168, 155, 190, 175];

  static List<String> get months => [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  static List<String> get weekDays => [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];
}
