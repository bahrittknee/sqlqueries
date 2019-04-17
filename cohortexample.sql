
-- Demonstration on how Cohort Analysis is done. In order to do this we just need 2 tables:
-- users (id, timestamp)
-- activities (user_id, timestamp)

-- The below example use the following table names and fields, feel free to replace them with yours.
-- - users (id, created_at)
-- - activities (user_id, created_at)

Demo: https://demo.holistics.io/queries/11118-buyer-cohort-retention-analysis

-- MONTH_DIFF is a custom Postgres function that calculate the number difference between 2 months.

-- (user_id, cohort_month), each
with cohort_items as (
  select
    date_trunc('month', U.created_at)::date as cohort_month,
    id as user_id
  from public.users U
  order by 1, 2
),
-- (user_id, month_number): user X has activity in month number X
user_activities as (
  select
    A.user_id,
    MONTH_DIFF(
      date_trunc('month', A.created_at)::date,
      C.cohort_month
    ) as month_number
  from public.activities A
  left join cohort_items C ON A.user_id = C.user_id
  group by 1, 2
),
-- (cohort_month, size)
cohort_size as (
  select cohort_month, count(1) as num_users
  from cohort_items
  group by 1
  order by 1
),
-- (cohort_month, month_number, cnt)
B as (
  select
    C.cohort_month,
    A.month_number,
    count(1) as num_users
  from user_activities A
  left join cohort_items C ON A.user_id = C.user_id
  group by 1, 2
)
-- our final value: (cohort_month, size, month_number, percentage)
select
  B.cohort_month,
  S.num_users as total_users,
  B.month_number,
  B.num_users::float * 100 / S.num_users as percentage
from B
left join cohort_size S ON B.cohort_month = S.cohort_month
order by 1, 3
where B.cohort_month IS NOT NULL
