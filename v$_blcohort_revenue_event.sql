SELECT date(vd.date_created_utc) AS visitor_date,
   conv.conversion_event_type_id AS event_id,
   count(*) AS cohort_count,
   date_part('days'::text, conv.request_date - vd.date_created_utc) AS conversion_days,
   sum(conv.revenue) AS cohort_revenue,
   count(conv.conversion_v3_id) AS event_count,
   cl.ftd_v1 AS utm_medium,
   cl.ftd_v2 AS utm_campaign,
   cl.ftd_v3 AS utm_partner,
   cl.referrer_domain
  FROM api_visitors_by_date vd
    JOIN api_conversion_export conv ON vd.visitor_id = conv.visitor_id
    JOIN api_click_export cl ON conv.last_click_id = cl.click_id
 GROUP BY (date(vd.date_created_utc)), (date_part('days'::text, conv.request_date - vd.date_created_utc)), conv.conversion_event_type_id, cl.ftd_v1, cl.ftd_v2, cl.ftd_v3, cl.referrer_domain
 ORDER BY (date(vd.date_created_utc)), (date_part('days'::text, conv.request_date - vd.date_created_utc)), conv.conversion_event_type_id, cl.ftd_v1, cl.ftd_v2, cl.ftd_v3, cl.referrer_domain;
