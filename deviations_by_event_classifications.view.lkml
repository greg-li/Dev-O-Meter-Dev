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

  # # You can specify the table name if it's different from the view name:
  # sql_table_name: my_schema_name.tester ;;
  #
  # # Define your dimensions and measures here, like this:
  # dimension: user_id {
  #   description: "Unique ID for each user that has ordered"
  #   type: number
  #   sql: ${TABLE}.user_id ;;
  # }
  #
  # dimension: lifetime_orders {
  #   description: "The total number of orders for each user"
  #   type: number
  #   sql: ${TABLE}.lifetime_orders ;;
  # }
  #
  # dimension_group: most_recent_purchase {
  #   description: "The date when each user last ordered"
  #   type: time
  #   timeframes: [date, week, month, year]
  #   sql: ${TABLE}.most_recent_purchase_at ;;
  # }
  #
  # measure: total_lifetime_orders {
  #   description: "Use this for counting lifetime orders across many users"
  #   type: sum
  #   sql: ${lifetime_orders} ;;
  # }
}

# view: deviations_by_event_classifications {
#   # Or, you could make this view a derived table, like this:
#   derived_table: {
#     sql: SELECT
#         user_id as user_id
#         , COUNT(*) as lifetime_orders
#         , MAX(orders.created_at) as most_recent_purchase_at
#       FROM orders
#       GROUP BY user_id
#       ;;
#   }
#
#   # Define your dimensions and measures here, like this:
#   dimension: user_id {
#     description: "Unique ID for each user that has ordered"
#     type: number
#     sql: ${TABLE}.user_id ;;
#   }
#
#   dimension: lifetime_orders {
#     description: "The total number of orders for each user"
#     type: number
#     sql: ${TABLE}.lifetime_orders ;;
#   }
#
#   dimension_group: most_recent_purchase {
#     description: "The date when each user last ordered"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.most_recent_purchase_at ;;
#   }
#
#   measure: total_lifetime_orders {
#     description: "Use this for counting lifetime orders across many users"
#     type: sum
#     sql: ${lifetime_orders} ;;
#   }
# }
