
view: deviation_goal {
  derived_table: {
    sql: SELECT
        dbo.DIM_SITE.SITE_NAME,
        dbo.DIM_SITE.DEVIATION_GOAL,
        month(cast(tzdb.utctolocal(dbo.FACT_DEVIATIONS.DATE_CREATED,{% parameter timezone_selection %}) as datetime2)) as create_month,
        year(cast(tzdb.utctolocal(dbo.FACT_DEVIATIONS.DATE_CREATED,{% parameter timezone_selection %}) as datetime2)) as create_year,
        SUM(dbo.FACT_DEVIATIONS.DEVIATION_COUNT) AS Number_Deviations,
        dbo.DIM_SITE.DEVIATION_GOAL / 12 AS Monthly_Goal
    FROM dbo.FACT_DEVIATIONS
      INNER JOIN dbo.DIM_SITE
        ON dbo.FACT_DEVIATIONS.SITE_KEY = dbo.DIM_SITE.SITE_KEY
      INNER JOIN dbo.DIM_DOCUMENT
        ON dbo.FACT_DEVIATIONS.DOCUMENT_KEY = dbo.DIM_DOCUMENT.DOCUMENT_KEY
      INNER JOIN dbo.DIM_RISK_CATEGORY
        ON dbo.FACT_DEVIATIONS.RISK_CAT_KEY = dbo.DIM_RISK_CATEGORY.RISK_CAT_KEY
      GROUP BY dbo.DIM_SITE.SITE_NAME, dbo.DIM_SITE.DEVIATION_GOAL, dbo.FACT_DEVIATIONS.DATE_CREATED
      HAVING (dbo.DIM_SITE.DEVIATION_GOAL IS NOT NULL) ;;
  }
  dimension: site_name {
    type: string
    sql: ${TABLE}.SITE_NAME ;;
  }
  dimension: site_key {
    type: string
    sql: ${TABLE}.SITE_KEY ;;
    hidden: yes
  }

  dimension: deviation_goal {
    type: number
    sql: ${TABLE}.DEVIATION_GOAL ;;
    }

  dimension: month {
    sql: ${TABLE}.create_month ;;
  }

  dimension: year {
    sql: ${TABLE}.create_year ;;
    }

  measure: deviation_goal_month {
    type: average
    sql: ${TABLE}.Monthly_Goal ;;
  }
  measure: count {
    type: count
    drill_fields: [site_name]
  }

  parameter: timezone_selection {
    type: string
    suggest_explore: available_timezones
    suggest_dimension: available_timezones.timezone_name
  }
}
