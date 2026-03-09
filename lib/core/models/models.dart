class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String status;
  final DateTime joinedDate;
  final int totalRides;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.status,
    required this.joinedDate,
    required this.totalRides,
  });
}

class RideModel {
  final String id;
  final String userName;
  final String driverName;
  final String pickup;
  final String dropoff;
  final double fare;
  final String status;
  final DateTime date;
  final double distance;

  const RideModel({
    required this.id,
    required this.userName,
    required this.driverName,
    required this.pickup,
    required this.dropoff,
    required this.fare,
    required this.status,
    required this.date,
    required this.distance,
  });
}

class PaymentModel {
  final String id;
  final String userName;
  final String rideId;
  final double amount;
  final String method;
  final String status;
  final DateTime date;

  const PaymentModel({
    required this.id,
    required this.userName,
    required this.rideId,
    required this.amount,
    required this.method,
    required this.status,
    required this.date,
  });
}

class DashboardStats {
  final int totalUsers;
  final int totalRides;
  final double totalRevenue;
  final int activeDrivers;
  final double avgRating;
  final int todayRides;

  const DashboardStats({
    required this.totalUsers,
    required this.totalRides,
    required this.totalRevenue,
    required this.activeDrivers,
    required this.avgRating,
    required this.todayRides,
  });
}
