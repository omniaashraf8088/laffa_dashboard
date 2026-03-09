import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/models.dart';

/// Fetches data from Supabase tables.
/// Falls back to empty lists on error.
class SupabaseDataService {
  static SupabaseClient get _client => Supabase.instance.client;

  // ────────────────────── Users ──────────────────────
  static Future<List<UserModel>> getUsers() async {
    final response = await _client.from('users').select();
    return (response as List).map((e) => UserModel.fromJson(e)).toList();
  }

  // ────────────────────── Rides ──────────────────────
  static Future<List<RideModel>> getRides() async {
    final response = await _client.from('rides').select();
    return (response as List).map((e) => RideModel.fromJson(e)).toList();
  }

  // ────────────────────── Payments ──────────────────────
  static Future<List<PaymentModel>> getPayments() async {
    final response = await _client.from('payments').select();
    return (response as List).map((e) => PaymentModel.fromJson(e)).toList();
  }

  // ────────────────────── Dashboard Stats ──────────────────────
  /// Expects a Supabase view or RPC named 'dashboard_stats' that
  /// returns a single row with aggregated stats.
  static Future<DashboardStats> getStats() async {
    final response =
        await _client.from('dashboard_stats').select().single();
    return DashboardStats.fromJson(response);
  }

  // ────────────────────── Chart Data (RPCs) ──────────────────────
  /// Calls a Postgres function: monthly_revenue() → [{month, amount}]
  static Future<List<double>> getMonthlyRevenue() async {
    final response = await _client.rpc('monthly_revenue');
    return (response as List).map((e) => (e['amount'] as num).toDouble()).toList();
  }

  static Future<List<double>> getMonthlyRides() async {
    final response = await _client.rpc('monthly_rides');
    return (response as List).map((e) => (e['count'] as num).toDouble()).toList();
  }

  static Future<Map<String, double>> getRideStatusDistribution() async {
    final response = await _client.rpc('ride_status_distribution');
    final map = <String, double>{};
    for (final row in response as List) {
      map[row['status'] as String] = (row['count'] as num).toDouble();
    }
    return map;
  }

  static Future<List<double>> getWeeklyUsers() async {
    final response = await _client.rpc('weekly_users');
    return (response as List).map((e) => (e['count'] as num).toDouble()).toList();
  }
}
