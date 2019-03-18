view: dim_causal {
  sql_table_name: dbo.DIM_CAUSAL ;;

  dimension: active_flag {
    label: "Causual Active Flag"
    type: string
    sql: ${TABLE}.ACTIVE_FLAG ;;
  }

  dimension: causal_key {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.CAUSAL_KEY ;;
  }



  dimension: causal_name{
    label: "Causal Factor"
    type: string
    sql: ${TABLE}.CAUSAL_NAME ;;
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

  measure: count {
    label: "Causal Count"
    type: count
    drill_fields: [causal_name]
  }
}
