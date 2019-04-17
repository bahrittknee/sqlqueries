select
  case when rank() over (partition by "visitor_id" order by "request_date" asc) = 1 then 'New'
      else 'Returning'
    end as click_status,
  case
    when count(click_id) over (partition by "visitor_id" order by "request_date" asc rows between unbounded preceding and unbounded following) = 1 then 'single_touch'
    when click_id = first_value(click_id) over (partition by "visitor_id" order by "request_date" asc rows between unbounded preceding and unbounded following) then 'introducer'
      when click_id = last_value(click_id) over (partition by "visitor_id" order by "request_date" asc rows between unbounded preceding and unbounded following) then 'closer'
      else 'influencer'
  end as click_fml,
  count(click_id) over (partition by "visitor_id" order by "request_date" asc rows between unbounded preceding and unbounded following) as touch_count,
  *
  from "cake_export_1817_click_ftd_etl"
