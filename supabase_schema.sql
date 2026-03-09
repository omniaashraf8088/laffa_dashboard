-- ============================================================
-- Laffa Dashboard — Supabase Schema
-- Run this in your Supabase SQL Editor to create all tables,
-- views, and functions needed by the dashboard.
-- ============================================================

-- 1. Users table
CREATE TABLE IF NOT EXISTS users (
  id         TEXT PRIMARY KEY,
  name       TEXT NOT NULL,
  email      TEXT NOT NULL,
  phone      TEXT NOT NULL,
  status     TEXT NOT NULL DEFAULT 'Active',
  joined_date TIMESTAMPTZ NOT NULL DEFAULT now(),
  total_rides INT NOT NULL DEFAULT 0
);

-- 2. Rides table
CREATE TABLE IF NOT EXISTS rides (
  id          TEXT PRIMARY KEY,
  user_name   TEXT NOT NULL,
  driver_name TEXT NOT NULL,
  pickup      TEXT NOT NULL,
  dropoff     TEXT NOT NULL,
  fare        DOUBLE PRECISION NOT NULL,
  status      TEXT NOT NULL DEFAULT 'Completed',
  date        TIMESTAMPTZ NOT NULL DEFAULT now(),
  distance    DOUBLE PRECISION NOT NULL
);

-- 3. Payments table
CREATE TABLE IF NOT EXISTS payments (
  id        TEXT PRIMARY KEY,
  user_name TEXT NOT NULL,
  ride_id   TEXT NOT NULL,
  amount    DOUBLE PRECISION NOT NULL,
  method    TEXT NOT NULL,
  status    TEXT NOT NULL DEFAULT 'Completed',
  date      TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- 4. Dashboard stats view (aggregated from tables)
CREATE OR REPLACE VIEW dashboard_stats AS
SELECT
  (SELECT COUNT(*) FROM users)::INT                        AS total_users,
  (SELECT COUNT(*) FROM rides)::INT                        AS total_rides,
  COALESCE((SELECT SUM(fare) FROM rides), 0)               AS total_revenue,
  (SELECT COUNT(*) FROM users WHERE status = 'Active')::INT AS active_drivers,
  COALESCE((SELECT AVG(fare) FROM rides), 0)               AS avg_rating,
  (SELECT COUNT(*) FROM rides
   WHERE date >= CURRENT_DATE)::INT                        AS today_rides;

-- 5. RPC: monthly_revenue()
CREATE OR REPLACE FUNCTION monthly_revenue()
RETURNS TABLE(month INT, amount DOUBLE PRECISION)
LANGUAGE sql STABLE
AS $$
  SELECT
    EXTRACT(MONTH FROM date)::INT AS month,
    COALESCE(SUM(fare), 0)        AS amount
  FROM rides
  GROUP BY month
  ORDER BY month;
$$;

-- 6. RPC: monthly_rides()
CREATE OR REPLACE FUNCTION monthly_rides()
RETURNS TABLE(month INT, count DOUBLE PRECISION)
LANGUAGE sql STABLE
AS $$
  SELECT
    EXTRACT(MONTH FROM date)::INT AS month,
    COUNT(*)::DOUBLE PRECISION    AS count
  FROM rides
  GROUP BY month
  ORDER BY month;
$$;

-- 7. RPC: ride_status_distribution()
CREATE OR REPLACE FUNCTION ride_status_distribution()
RETURNS TABLE(status TEXT, count DOUBLE PRECISION)
LANGUAGE sql STABLE
AS $$
  SELECT
    status,
    COUNT(*)::DOUBLE PRECISION AS count
  FROM rides
  GROUP BY status;
$$;

-- 8. RPC: weekly_users()
CREATE OR REPLACE FUNCTION weekly_users()
RETURNS TABLE(day INT, count DOUBLE PRECISION)
LANGUAGE sql STABLE
AS $$
  SELECT
    EXTRACT(DOW FROM joined_date)::INT AS day,
    COUNT(*)::DOUBLE PRECISION         AS count
  FROM users
  WHERE joined_date >= CURRENT_DATE - INTERVAL '7 days'
  GROUP BY day
  ORDER BY day;
$$;

-- 9. Enable Row Level Security (RLS) — adjust policies as needed
ALTER TABLE users    ENABLE ROW LEVEL SECURITY;
ALTER TABLE rides    ENABLE ROW LEVEL SECURITY;
ALTER TABLE payments ENABLE ROW LEVEL SECURITY;

-- Allow read access for authenticated users (adjust to your needs)
CREATE POLICY "Allow read users"    ON users    FOR SELECT USING (true);
CREATE POLICY "Allow read rides"    ON rides    FOR SELECT USING (true);
CREATE POLICY "Allow read payments" ON payments FOR SELECT USING (true);
