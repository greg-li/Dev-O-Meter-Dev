# view: dim_customer {
#   sql_table_name: dbo.dim_customer ;;
#
# #   dimension: active_flag {
# #     type: string
# #     sql: ${TABLE}.ACTIVE_FLAG ;;
# #   }
#
#   dimension: customer_key {
#     type: number
#     sql: ${TABLE}.CUSTOMER_KEY ;;
#   }
#
#   dimension: customer_name {
#     type: string
#     sql: ${TABLE}.CUSTOMER_NAME ;;
#   }
# #
# #   dimension_group: insert {
# #     type: time
# #     timeframes: [
# #       raw,
# #       time,
# #       date,
# #       week,
# #       month,
# #       quarter,
# #       year
# #     ]
# #     sql: ${TABLE}.INSERT_DATE ;;
# #   }
# #
# #   dimension_group: update {
# #     type: time
# #     timeframes: [
# #       raw,
# #       time,
# #       date,
# #       week,
# #       month,
# #       quarter,
# #       year
# #     ]
# #     sql: ${TABLE}.UPDATE_DATE ;;
# #   }
# #
# #   measure: count {
# #     type: count
# #     drill_fields: [customer_name]
# #   }
# }
