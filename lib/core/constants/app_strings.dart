/// Centralized UI strings for the entire dashboard.
class AppStrings {
  AppStrings._();

  // ── App ──
  static const appTitle = 'Laffa Dashboard';
  static const brandName = 'Laffa';

  // ── Navigation ──
  static const navHome = 'Home';
  static const navUsers = 'Users';
  static const navRides = 'Rides';
  static const navPayments = 'Payments';
  static const navAnalytics = 'Analytics';
  static const navTitles = [
    navHome,
    navUsers,
    navRides,
    navPayments,
    navAnalytics,
  ];
  static const expand = 'Expand';
  static const collapse = 'Collapse';

  // ── Search ──
  static const searchAnything = 'Search anything...';
  static const searchDefault = 'Search...';
  static const searchUsers = 'Search users by name, email, or ID...';
  static const searchRides = 'Search rides by rider, driver, or location...';
  static const searchPayments = 'Search payments by user or ID...';

  // ── Home Screen ──
  static const dashboardOverview = 'Dashboard Overview';
  static const live = 'Live';
  static const realtimeMetrics = 'Real-time metrics and insights';
  static const totalUsers = 'Total Users';
  static const totalRides = 'Total Rides';
  static const totalRevenue = 'Total Revenue';
  static const activeDrivers = 'Active Drivers';
  static const recentRides = 'Recent Rides';
  static const monthlyRevenue = 'Monthly Revenue';
  static const revenueOverview = 'Revenue overview for the past 12 months';
  static const rideStatus = 'Ride Status';
  static const distributionBreakdown = 'Distribution breakdown';

  // ── Analytics Screen ──
  static const analytics = 'Analytics';
  static const chartsCount = '4 Charts';
  static const detailedMetrics = 'Detailed performance metrics and trends';
  static const revenueTrend = 'Revenue Trend';
  static const revenuePerformance = '12-month revenue performance';
  static const monthlyRides = 'Monthly Rides';
  static const ridesPerMonth = 'Number of rides per month';
  static const rideDistribution = 'Ride Distribution';
  static const statusBreakdown = 'Status breakdown of all rides';
  static const weeklyNewUsers = 'Weekly New Users';
  static const weeklyRegistrations = 'New user registrations this week';

  // ── Tooltip Suffixes ──
  static const rides = ' rides';
  static const users = ' users';

  // ── Table Columns ──
  static const colId = 'ID';
  static const colName = 'Name';
  static const colEmail = 'Email';
  static const colPhone = 'Phone';
  static const colStatus = 'Status';
  static const colJoined = 'Joined';
  static const colRides = 'Rides';
  static const colUser = 'User';
  static const colRider = 'Rider';
  static const colDriver = 'Driver';
  static const colPickup = 'Pickup';
  static const colDropoff = 'Dropoff';
  static const colFare = 'Fare';
  static const colDate = 'Date';
  static const colRideId = 'Ride ID';
  static const colAmount = 'Amount';
  static const colMethod = 'Method';

  // ── Filters ──
  static const filterAll = 'All';
  static const filterCompleted = 'Completed';
  static const filterInProgress = 'In Progress';
  static const filterCancelled = 'Cancelled';
  static const filterPending = 'Pending';
  static const filterRefunded = 'Refunded';
  static const filterFailed = 'Failed';

  // ── Avatar ──
  static const avatarDefault = 'A';
}
