
view: deviation_goal {
  derived_table: {
    sql: SELECT
        dbo.DIM_SITE.SITE_NAME,
        dbo.DIM_SITE.DEVIATION_GOAL,
        month(cast(${TABLE}.DATE_CREATED AT TIME ZONE 'UTC' AT TIME ZONE {% parameter timezone_selection %} as datetime2)) as create_month,
        year(cast(${TABLE}.DATE_CREATED AT TIME ZONE 'UTC' AT TIME ZONE {% parameter timezone_selection %} as datetime2)) as create_year,
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
    hidden: yes
    sql: ${TABLE}.create_month ;;
  }

  dimension: year {
    hidden: yes
    sql: ${TABLE}.create_year ;;
    }

  dimension: unique_id {
    primary_key: yes
    hidden: yes
    sql: concat(${site_name},${site_key},${deviation_goal},${month},${year}) ;;
  }
  measure: deviation_goal_month {
    label: "Average Monthly Deviation Goal"
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
