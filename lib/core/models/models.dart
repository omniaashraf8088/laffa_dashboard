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

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      status: json['status'] as String,
      joinedDate: DateTime.parse(json['joined_date'] as String),
      totalRides: json['total_rides'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'phone': phone,
    'status': status,
    'joined_date': joinedDate.toIso8601String(),
    'total_rides': totalRides,
  };
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

  factory RideModel.fromJson(Map<String, dynamic> json) {
    return RideModel(
      id: json['id'] as String,
      userName: json['user_name'] as String,
      driverName: json['driver_name'] as String,
      pickup: json['pickup'] as String,
      dropoff: json['dropoff'] as String,
      fare: (json['fare'] as num).toDouble(),
      status: json['status'] as String,
      date: DateTime.parse(json['date'] as String),
      distance: (json['distance'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_name': userName,
    'driver_name': driverName,
    'pickup': pickup,
    'dropoff': dropoff,
    'fare': fare,
    'status': status,
    'date': date.toIso8601String(),
    'distance': distance,
  };
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

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json['id'] as String,
      userName: json['user_name'] as String,
      rideId: json['ride_id'] as String,
      amount: (json['amount'] as num).toDouble(),
      method: json['method'] as String,
      status: json['status'] as String,
      date: DateTime.parse(json['date'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_name': userName,
    'ride_id': rideId,
    'amount': amount,
    'method': method,
    'status': status,
    'date': date.toIso8601String(),
  };
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

  factory DashboardStats.fromJson(Map<String, dynamic> json) {
    return DashboardStats(
      totalUsers: json['total_users'] as int,
      totalRides: json['total_rides'] as int,
      totalRevenue: (json['total_revenue'] as num).toDouble(),
      activeDrivers: json['active_drivers'] as int,
      avgRating: (json['avg_rating'] as num).toDouble(),
      todayRides: json['today_rides'] as int,
    );
  }
}
