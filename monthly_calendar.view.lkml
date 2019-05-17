view: monthly_calendar {
  derived_table: {
    sql: SELECT TOP (1000)
        ROW_NUMBER() OVER (ORDER BY [object_id]) - 1 as n,
        DATEADD(month, 1-(ROW_NUMBER() OVER (ORDER BY [object_id])), getdate()) AS month,
        YEAR(DATEADD(month, 1-(ROW_NUMBER() OVER (ORDER BY [object_id])), getdate())) AS year,
        YEAR(DATEADD(month, 1-(ROW_NUMBER() OVER (ORDER BY [object_id])), getdate())) -1 AS baseline_year

      FROM
        sys.all_objects
       ;;
  }

  dimension: n {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.n ;;
  }

  dimension_group: target {
    hidden: yes
    type: time
    timeframes: [month]
    datatype: datetime
    sql: ${TABLE}.month ;;
  }

  dimension: target_year {
    hidden: yes
    type: number
    sql: ${TABLE}.year ;;
  }

  dimension: baseline_year {
    hidden: yes
    type: number
    sql: ${TABLE}.baseline_year ;;
  }
}
