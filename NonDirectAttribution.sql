-- View: public."v$_touchpoint_fml"

-- DROP VIEW public."v$_touchpoint_fml";

CREATE OR REPLACE VIEW public."v$_touchpoint_fml" AS
 SELECT click.click_id,
    click.request_date,
    click.visitor_id,
    conversions.conversion_id,
    conversions.conversion_date,
    rank() OVER conv_window AS touch_point,
    count(click.click_id) OVER count_window AS total_touches,
        CASE
            WHEN count(click.click_id) OVER count_window = 1 THEN 'single'::text
            WHEN count(click.click_id) OVER count_window > 1 AND rank() OVER conv_window = 1 THEN 'first'::text
            WHEN count(click.click_id) OVER count_window > 1 AND rank() OVER conv_window = count(click.click_id) OVER count_window THEN 'last'::text
            ELSE 'middle'::text
        END AS fml,
        CASE
            WHEN rank() OVER conv_window = 1 THEN 1.0
            ELSE 0.0
        END AS conv_share_first_touch,
        CASE
            WHEN rank() OVER conv_window = 1 THEN 1.0
            ELSE 0.0
        END * conversions.revenue AS rev_share_first_touch,
        CASE
            WHEN rank() OVER conv_window = count(click.click_id) OVER count_window THEN 1.0
            ELSE 0.0
        END AS conv_share_last_touch,
        CASE
            WHEN rank() OVER conv_window = count(click.click_id) OVER count_window THEN 1.0
            ELSE 0.0
        END * conversions.revenue AS rev_share_last_touch,
    1.0 / count(click.click_id) OVER count_window::numeric AS conv_share_linear,
    1.0 / count(click.click_id) OVER count_window::numeric * conversions.revenue AS rev_share_linear,
        CASE
            WHEN count(click.click_id) OVER count_window > 2 THEN
            CASE
                WHEN rank() OVER conv_window = 1 OR rank() OVER conv_window = count(click.click_id) OVER count_window THEN 1.0 / (count(click.click_id) OVER count_window + 2)::numeric * 2::numeric
                ELSE 1.0 / (count(click.click_id) OVER count_window + 2)::numeric
            END
            ELSE 1.0 / count(click.click_id) OVER count_window::numeric
        END AS conv_share_ushape,
        CASE
            WHEN count(click.click_id) OVER count_window > 2 THEN
            CASE
                WHEN rank() OVER conv_window = 1 OR rank() OVER conv_window = count(click.click_id) OVER count_window THEN 1.0 / (count(click.click_id) OVER count_window + 2)::numeric * 2::numeric
                ELSE 1.0 / (count(click.click_id) OVER count_window + 2)::numeric
            END
            ELSE 1.0 / count(click.click_id) OVER count_window::numeric
        END * conversions.revenue AS rev_share_ushape
   FROM api_click_export click
     JOIN LATERAL ( SELECT conv.conversion_v3_id AS conversion_id,
            conv.request_date AS conversion_date,
            conv.revenue
           FROM api_conversion_export conv
          WHERE conv.request_date > click.request_date AND conv.visitor_id = click.visitor_id
          ORDER BY conv.request_date
         LIMIT 1) conversions ON true
  WHERE (click.visitor_id IN ( SELECT api_conversion_export.visitor_id
           FROM api_conversion_export))
  WINDOW conv_window AS (PARTITION BY click.visitor_id, conversions.conversion_id ORDER BY click.request_date), count_window AS (PARTITION BY click.visitor_id, conversions.conversion_id)
  ORDER BY click.visitor_id, click.request_date;

ALTER TABLE public."v$_touchpoint_fml"
    OWNER TO cake_export;
