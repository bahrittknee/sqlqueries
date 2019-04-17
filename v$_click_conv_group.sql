SELECT a.req_date,
   count(a.click_id) AS click_count,
   count(DISTINCT a.visitor_id) AS visitor_count,
   count(DISTINCT a.conv_id) AS conversion_count,
   a.referrer_domain,
   a.ftd_v1,
   a.ftd_v2,
   a.ftd_v3,
   a.ftd_v4,
   a.ftd_v5,
   a.ftd_v6,
   a.ftd_v7,
   a.ftd_v8,
   a.ftd_v9,
   count(a.event_type_0) AS event_type_0,
   count(a.event_type_1) AS event_type_1,
   count(a.event_type_2) AS event_type_2,
   count(a.event_type_3) AS event_type_3,
   count(a.event_type_4) AS event_type_4,
   count(a.event_type_5) AS event_type_5
  FROM ( SELECT date(api_click_export.request_date) AS req_date,
           api_click_export.click_id,
           api_click_export.visitor_id,
           NULL::text AS conv_id,
           api_click_export.referrer_domain,
           api_click_export.ftd_v1,
           api_click_export.ftd_v2,
           api_click_export.ftd_v3,
           api_click_export.ftd_v4,
           api_click_export.ftd_v5,
           api_click_export.ftd_v6,
           api_click_export.ftd_v7,
           api_click_export.ftd_v8,
           api_click_export.ftd_v9,
           NULL::integer AS event_type_0,
           NULL::integer AS event_type_1,
           NULL::integer AS event_type_2,
           NULL::integer AS event_type_3,
           NULL::integer AS event_type_4,
           NULL::integer AS event_type_5
          FROM api_click_export
       UNION ALL
        SELECT date(conv.request_date) AS req_date,
           NULL::text AS click_id,
           NULL::text AS visitor_id,
           conv.conversion_v3_id AS conv_id,
           click.referrer_domain,
           click.ftd_v1,
           click.ftd_v2
           click.ftd_v3,
           click.ftd_v4,
           click.ftd_v5,
           click.ftd_v6,
           click.ftd_v7,
           click.ftd_v8,
           click.ftd_v9,
               CASE
                   WHEN conv.conversion_event_type_id = 0 THEN 1
                   ELSE NULL::integer
               END AS event_type_0,
               CASE
                   WHEN conv.conversion_event_type_id = 1 THEN 1
                   ELSE NULL::integer
               END AS event_type_1,
               CASE
                   WHEN conv.conversion_event_type_id = 2 THEN 1
                   ELSE NULL::integer
               END AS event_type_2,
               CASE
                   WHEN conv.conversion_event_type_id = 3 THEN 1
                   ELSE NULL::integer
               END AS event_type_3,
               CASE
                   WHEN conv.conversion_event_type_id = 4 THEN 1
                   ELSE NULL::integer
               END AS event_type_4,
               CASE
                   WHEN conv.conversion_event_type_id = 5 THEN 1
                   ELSE NULL::integer
               END AS event_type_5
            FROM api_conversion_export conv
            LEFT JOIN api_click_export click ON conv.last_click_id = click.click_id) a
 GROUP BY a.req_date, a.referrer_domain, a.ftd_v1, a.ftd_v2, a.ftd_v3, a.ftd_v4, a.ftd_v5, a.ftd_v6, a.ftd_v7, a.ftd_v8, a.ftd_v9
 ORDER BY a.req_date DESC;
