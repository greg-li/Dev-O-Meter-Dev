view: weekly_calendar {
  derived_table: {
    sql: SELECT TOP (1000)
        ROW_NUMBER() OVER (ORDER BY [object_id]) - 1 as n,
        CONVERT(VARCHAR(10), CONVERT(VARCHAR(10),DATEADD(day,(0 - (((DATEPART(dw,DATEADD(week,(ROW_NUMBER() OVER (ORDER BY [object_id])), getdate() )) - 1) - 1 + 7) % (7))), DATEADD(week,(1 - ROW_NUMBER() OVER (ORDER BY [object_id]) ), getdate() ) ),120), 120) AS week,
        YEAR(DATEADD(day,(0 - (((DATEPART(dw,DATEADD(week,(ROW_NUMBER() OVER (ORDER BY [object_id])), getdate() )) - 1) - 1 + 7) % (7))), DATEADD(week,(1 - ROW_NUMBER() OVER (ORDER BY [object_id]) ), getdate()))) AS year,
        YEAR(DATEADD(day,(0 - (((DATEPART(dw,DATEADD(week,(ROW_NUMBER() OVER (ORDER BY [object_id])), getdate() )) - 1) - 1 + 7) % (7))), DATEADD(week,(1 - ROW_NUMBER() OVER (ORDER BY [object_id]) ), getdate()))) -1 AS prior_year

      FROM
        sys.all_objects
       ;;
  }

  dimension: n {
    hidden: yes
    type: number
    sql: ${TABLE}.n ;;
  }

  dimension: week {
    type: string
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
