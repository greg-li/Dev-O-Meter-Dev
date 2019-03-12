view: bridge_customers_dev {
  sql_table_name: dbo.BRIDGE_CUSTOMERS_DEV ;;

#   dimension: active_flag {
#     type: string
#     sql: ${TABLE}.ACTIVE_FLAG ;;
#   }
#
#   dimension: customer_dev_bridge_id {
#     type: number
#     sql: ${TABLE}.CUSTOMER_DEV_BRIDGE_ID ;;
#   }

  dimension: customer_key {
    type: number
    sql: ${TABLE}.CUSTOMER_KEY ;;
  }

#   dimension_group: insert {
#     type: time
#     timeframes: [
#       raw,
#       time,
#       date,
#       week,
#       month,
#       quarter,
#       year
#     ]
#     sql: ${TABLE}.INSERT_DATE ;;
#   }

  dimension: parent_record_id {
    type: number
    sql: ${TABLE}.PARENT_RECORD_ID ;;
  }

#   dimension_group: update {
#     type: time
#     timeframes: [
#       raw,
#       time,
#       date,
#       week,
#       month,
#       quarter,
#       year
#     ]
#     sql: ${TABLE}.UPDATE_DATE ;;
#   }
#
#   measure: count {
#     type: count
#     drill_fields: []
#   }
}
