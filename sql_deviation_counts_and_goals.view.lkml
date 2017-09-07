view: sql_runner_query {
  derived_table: {
    sql: SELECT
      TOP 500
        DIM_SITE.SITE_NAME,
        CONVERT(VARCHAR(7),fact_deviations.DATE_CREATED ,120) AS "fact_deviations.date_created_month",
        dim_site.DEVIATION_GOAL/12  AS "dim_site.deviation_goal",
        sum(fact_deviations.DEVIATION_COUNT) as "fact_deviations.count"
      FROM dbo.FACT_DEVIATIONS  AS fact_deviations
      LEFT JOIN dbo.DIM_SITE  AS dim_site ON fact_deviations.SITE_KEY =dim_site.SITE_KEY

      LEFT JOIN dbo.DIM_CAUSAL  AS dim_causal ON fact_deviations.CAUSAL_KEY = dim_causal.CAUSAL_KEY

      WHERE
        (dim_causal.CAUSAL_NAME <> 'NULL' OR dim_causal.CAUSAL_NAME IS NULL) and dim_site.DEVIATION_GOAL is not Null
      group by site_name,   CONVERT(VARCHAR(7),fact_deviations.DATE_CREATED ,120), dim_site.DEVIATION_GOAL/12
      ORDER BY 1 DESC
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }


  dimension: site_name {
    type: string
    sql: ${TABLE}.SITE_NAME ;;
  }

  dimension: fact_deviations_date_created_month {
    type: string
    sql: ${TABLE}."fact_deviations.date_created_month" ;;
  }

  measure: dim_site_deviation_goal {
    type: number
    sql: ${TABLE}."dim_site.deviation_goal" ;;
  }

  measure: fact_deviations_count {
    type: number
    sql: ${TABLE}."fact_deviations.count" ;;
  }

  set: detail {
    fields: [site_name, fact_deviations_date_created_month, dim_site_deviation_goal, fact_deviations_count]
  }
}
