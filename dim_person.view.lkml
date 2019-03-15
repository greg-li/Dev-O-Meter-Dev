view: dim_person {
  sql_table_name: dbo.DIM_PERSON ;;

  dimension: active_flag {
    label: "Initiating Person Active Flag"
    type: string
    sql: ${TABLE}.ACTIVE_FLAG ;;
  }

  dimension_group: insert {
    hidden: yes
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
    sql: cast(tzdb.utctolocal(${TABLE}.INSERT_DATE,{% parameter fact_deviations.timezone_selection %}) as datetime2) ;;
  }

  dimension_group: update {
    hidden: yes
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
    sql: cast(tzdb.utctolocal(${TABLE}.UPDATE_DATE,{% parameter fact_deviations.timezone_selection %}) as datetime2) ;;
  }

  dimension: network_id {
    label: "Initiating Person Network ID"
    type: string
    sql: ${TABLE}.NETWORK_ID ;;
  }

  dimension: person_key {
    label: "Initiating Person Key"
    type: number
    sql: ${TABLE}.PERSON_KEY ;;
  }

  dimension: person_name {
    label: "Initiating Person Name"
    type: string
    sql: ${TABLE}.PERSON_NAME ;;
  }


  measure: count {
    label: "Initiating Person Count"
    type: count
    drill_fields: [person_name]
  }
}
