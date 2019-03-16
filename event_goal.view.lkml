view: event_goal {
    derived_table: {
      sql: SELECT
        dbo.DIM_EVENT_CLASSIFICATION.EVENT_LIMIT,
        month(cast(tzdb.utctolocal(dbo.FACT_DEVIATIONS.DATE_CREATED,{% parameter timezone_selection %}) as datetime2)) as create_month,
        year(cast(tzdb.utctolocal(dbo.FACT_DEVIATIONS.DATE_CREATED,{% parameter timezone_selection %}) as datetime2)) as create_year,
        SUM(dbo.FACT_DEVIATIONS.DEVIATION_COUNT) AS Number_Deviations,
        dbo.DIM_EVENT_CLASSIFICATION.EVENT_LIMIT / 12 AS Monthly_Goal
FROM            dbo.FACT_DEVIATIONS INNER JOIN
                          dbo.DIM_EVENT_CLASSIFICATION ON dbo.FACT_DEVIATIONS.EVENT_CLASS_KEY = dbo.DIM_EVENT_CLASSIFICATION.EVENT_CLASS_KEY INNER JOIN
                         dbo.DIM_DOCUMENT ON dbo.FACT_DEVIATIONS.DOCUMENT_KEY = dbo.DIM_DOCUMENT.DOCUMENT_KEY INNER JOIN
                         dbo.DIM_RISK_CATEGORY ON dbo.FACT_DEVIATIONS.RISK_CAT_KEY = dbo.DIM_RISK_CATEGORY.RISK_CAT_KEY
GROUP BY dbo.DIM_SITE.SITE_NAME, dbo.DIM_EVENT_CLASSIFICATION.EVENT_LIMIT, dbo.FACT_DEVIATIONS.DATE_CREATED
HAVING        ( dbo.DIM_EVENT_CLASSIFICATION.EVENT_LIMIT IS NOT NULL) ;;
    }
    dimension: site_name {
      type: string
      sql: ${TABLE}.SITE_NAME ;;

    }
    dimension:event_limit {
      type: number
      sql: ${TABLE}.EVENT_LIMIT ;;
    }
    dimension: month {
      label: "Event Goal Month"
      sql: ${TABLE}.create_month ;;
    }

    dimension: year {
      label: "Event Goal Year"
      sql: ${TABLE}.create_year ;;
    }

    measure: event_goal_month {
      label: "Average Event Monthly Goal"
      type: average
      sql: ${TABLE}.Monthly_Goal ;;
    }
    measure: count {
      label: "Event Goal Count"
      type: count
      drill_fields: [site_name]
    }

  parameter: timezone_selection {
    type: string
    suggest_explore: available_timezones
    suggest_dimension: available_timezones.timezone_name
  }
}
