view: deviations_by_event_classifications {
  derived_table: {
  sql:SELECT        dbo.DIM_EVENT_CLASSIFICATION.EVENT_CLASS_KEY,
                  COUNT(dbo.FACT_DEVIATIONS.DEVIATION_KEY) AS Count_Deviations,
                  dbo.FACT_DEVIATIONS.DATE_CREATED
FROM            dbo.DIM_EVENT_CLASSIFICATION INNER JOIN
                         dbo.FACT_DEVIATIONS ON dbo.DIM_EVENT_CLASSIFICATION.EVENT_CLASS_KEY = dbo.FACT_DEVIATIONS.EVENT_CLASS_KEY
GROUP BY dbo.DIM_EVENT_CLASSIFICATION.EVENT_CLASS_KEY, dbo.FACT_DEVIATIONS.DATE_CREATED;;
}
    dimension: event_class_key {
      type: number
      sql: ${TABLE}.EVENT_CLASS_KEY ;;
    }
    dimension: dev_count {
      label: "Event Classification Deviations Count"
      type: number
      sql: ${TABLE}.Count_Deviations ;;
    }

    dimension_group: create {
      type: time
      timeframes: [
        raw,
        time,
        date,
        week,
        month,
        quarter,
        year
      ]
      convert_tz: no
      datatype: date
      sql: cast(tzdb.utctolocal(${TABLE}.DATE_CREATED,{% parameter fact_deviations.timezone_selection %}) as datetime2) ;;

    }
}
