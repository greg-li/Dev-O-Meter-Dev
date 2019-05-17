explore: weekly_calendar {}
view: weekly_calendar {
  derived_table: {
    sql: SELECT TOP (1000)
        ROW_NUMBER() OVER (ORDER BY [object_id]) - 1 as n,
        -- CONVERT(VARCHAR(10), CONVERT(VARCHAR(10),DATEADD(day,(0 - (((DATEPART(dw,DATEADD(week,(ROW_NUMBER() OVER (ORDER BY [object_id])), getdate() )) - 1) - 1 + 7) % (7))), DATEADD(week,(1 - ROW_NUMBER() OVER (ORDER BY [object_id]) ), getdate() ) ),120), 120) AS week,
        DATEADD(day,(0 - (((DATEPART(dw,DATEADD(week,(ROW_NUMBER() OVER (ORDER BY [object_id])), getdate() )) - 1) - 1 + 7) % (7))), DATEADD(week,(1 - ROW_NUMBER() OVER (ORDER BY [object_id]) ), getdate() ) ) AS week,
        YEAR(DATEADD(day,(0 - (((DATEPART(dw,DATEADD(week,(ROW_NUMBER() OVER (ORDER BY [object_id])), getdate() )) - 1) - 1 + 7) % (7))), DATEADD(week,(1 - ROW_NUMBER() OVER (ORDER BY [object_id]) ), getdate()))) AS year,
        YEAR(DATEADD(day,(0 - (((DATEPART(dw,DATEADD(week,(ROW_NUMBER() OVER (ORDER BY [object_id])), getdate() )) - 1) - 1 + 7) % (7))), DATEADD(week,(1 - ROW_NUMBER() OVER (ORDER BY [object_id]) ), getdate()))) -1 AS baseline_year

      FROM
        sys.all_objects
       ;;
  }

  dimension: n {
#     hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.n ;;
  }

  dimension: week {
#     hidden: yes
    type: date_time
    sql: ${TABLE}.week ;;
  }

  dimension: target_year {
#     hidden: yes
    type: number
    sql: ${TABLE}.year ;;
  }

  dimension: baseline_year {
#     hidden: yes
    type: number
    sql: ${TABLE}.baseline_year ;;
  }
}
