view: daily_calendar {
  derived_table: {
    sql: SELECT  TOP (DATEDIFF(DAY, '01/01/2010', DATEADD(yy, DATEDIFF(yy, 0, GETDATE()) + 1, -1)) + 1)
          ROW_NUMBER() OVER (ORDER BY a.object_id) - 1 as n
          , DATEADD(DAY, ROW_NUMBER() OVER(ORDER BY a.object_id) - 1, '01/01/2010') date
          , year(DATEADD(DAY, ROW_NUMBER() OVER(ORDER BY a.object_id) - 1, '01/01/2010')) year
          , year(DATEADD(DAY, ROW_NUMBER() OVER(ORDER BY a.object_id) - 1, '01/01/2010'))-1 prior_year
        FROM    sys.all_objects a
        CROSS JOIN sys.all_objects b
       ;;
  }

  dimension: n {
    hidden: yes
    type: number
    sql: ${TABLE}.n ;;
  }

  dimension: week {
    type: date_time
    sql: ${TABLE}.week ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}.year ;;
  }

  dimension: prior_year {
    type: number
    sql: ${TABLE}.prior_year ;;
  }

  set: detail {
    fields: [n, week, year, prior_year]
  }
}
