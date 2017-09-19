view: deviation_goal {
  derived_table: {
    sql: SELECT         dbo.DIM_SITE.DEVIATION_GOAL, month(dbo.FACT_DEVIATIONS.DATE_CREATED) as create_month, year(dbo.FACT_DEVIATIONS.DATE_CREATED) as create_year,SUM(dbo.FACT_DEVIATIONS.DEVIATION_COUNT) AS Number_Deviations,
                         dbo.DIM_SITE.DEVIATION_GOAL / 12 AS Monthly_Goal
FROM            dbo.FACT_DEVIATIONS INNER JOIN
                         dbo.DIM_SITE ON dbo.FACT_DEVIATIONS.SITE_KEY = dbo.DIM_SITE.SITE_KEY INNER JOIN
                         dbo.DIM_DOCUMENT ON dbo.FACT_DEVIATIONS.DOCUMENT_KEY = dbo.DIM_DOCUMENT.DOCUMENT_KEY INNER JOIN
                         dbo.DIM_RISK_CATEGORY ON dbo.FACT_DEVIATIONS.RISK_CAT_KEY = dbo.DIM_RISK_CATEGORY.RISK_CAT_KEY
GROUP BY dbo.DIM_SITE.SITE_NAME, dbo.DIM_SITE.DEVIATION_GOAL, dbo.FACT_DEVIATIONS.DATE_CREATED
HAVING        (dbo.DIM_SITE.DEVIATION_GOAL IS NOT NULL) ;;
  }
  dimension: site_name {
    type: string
    sql: ${TABLE}.SITE_NAME ;;

  }
  dimension: deviation_goal {
    type: number
    sql: ${TABLE}.DEVIATION_GOAL ;;
    }
  dimension_group: date_created {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      month_name,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.DATE_CREATED ;;
  }
  measure: deviation_goal_month {
    type: average
    sql: ${TABLE}.Monthly_Goal ;;
  }
  measure: count {
    type: count
    drill_fields: [site_name]

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

# view: deviation_goal {
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
