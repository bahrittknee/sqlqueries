SELECT date(vd.date_created_utc) AS visitor_date,
   conv.conversion_event_type_id AS event_id,
   count(*) AS cohort_count,
   date_part('days'::text, conv.request_date - vd.date_created_utc) AS conversion_days,
   sum(conv.revenue) AS cohort_revenue,
   count(conv.conversion_v3_id) AS event_count,
   cl.ftd_v1 AS utm_source,
   cl.ftd_v2 AS utm_medium,
   cl.ftd_v3 AS utm_campaign,
   cl.ftd_v4 AS utm_term,
   cl.ftd_v5 AS utm_content,
   cl.ftd_v6 AS utm_admix,
   cl.ftd_v7 AS utm_mediatype,
   cl.ftd_v8 AS utm_reality,
   cl.ftd_v9 AS utm_sense,
   cl.referrer_domain
  FROM api_visitors_by_date vd
    JOIN api_conversion_export conv ON vd.visitor_id = conv.visitor_id
    JOIN api_click_export cl ON conv.last_click_id = cl.click_id
 GROUP BY (date(vd.date_created_utc)), (date_part('days'::text, conv.request_date - vd.date_created_utc)), conv.conversion_event_type_id, cl.ftd_v1, cl.ftd_v2, cl.ftd_v3, cl.ftd_v4, cl.ftd_v5, cl.ftd_v6, cl.ftd_v7, cl.ftd_v8, cl.ftd_v9, cl.referrer_domain
 ORDER BY (date(vd.date_created_utc)), (date_part('days'::text, conv.request_date - vd.date_created_utc)), conv.conversion_event_type_id, cl.ftd_v1, cl.ftd_v2, cl.ftd_v3, cl.ftd_v4, cl.ftd_v5, cl.ftd_v6, cl.ftd_v7, cl.ftd_v8, cl.ftd_v9, cl.referrer_domain;
