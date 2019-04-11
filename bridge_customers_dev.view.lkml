view: bridge_customers_dev {
  sql_table_name: dbo.BRIDGE_CUSTOMERS_DEV ;;

  dimension: active_flag {
    type: string
    sql: ${TABLE}.ACTIVE_FLAG ;;
  }

  dimension: customer_dev_bridge_id {
    hidden: yes
    type: number
    primary_key: yes
    sql: ${TABLE}.CUSTOMER_DEV_BRIDGE_ID ;;
  }

  dimension: customer_key {
    hidden: yes
    type: number
    sql: ${TABLE}.CUSTOMER_KEY ;;
  }

  dimension_group: insert {
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
    hidden: yes
    datatype: date
    sql: cast(${TABLE}.INSERT_DATE AT TIME ZONE 'UTC' AT TIME ZONE {% parameter fact_deviations.timezone_selection %} as datetime2);;
  }

  dimension: parent_record_id {
    hidden: yes
    type: number
    sql: ${TABLE}.PARENT_RECORD_ID ;;
  }

  dimension_group: update {
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
    hidden: yes
    datatype: date
    sql: cast(${TABLE}.UPDATE_DATE AT TIME ZONE 'UTC' AT TIME ZONE {% parameter fact_deviations.timezone_selection %} as datetime2);;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}