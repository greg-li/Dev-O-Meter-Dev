view: dim_person {
  sql_table_name: dbo.DIM_PERSON ;;

  dimension: active_flag {
  #  label: "{% if _view._name == 'dim_person' %} Initiating Person Active Flag {% elseif _view._name == 'assigned_person' %} Assigned Person Alert Flag {% endif %}"
    label: "{% if _view._name == 'dim_person' %} Initiating Person Active Flag {% else %} Assigned Person Alert Flag {% endif %}"
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
    label: "{% if _view._name == 'dim_person' %} Initiating Person Network ID {% else %} Assigned Person Network ID {% endif %}"
    type: string
    sql: ${TABLE}.NETWORK_ID ;;
  }

  dimension: person_key {
    primary_key: yes
    label: "{% if _view._name == 'dim_person' %} Initiating Person Person Key {% else %} Assigned Person Person Key {% endif %}"
    type: number
    sql: ${TABLE}.PERSON_KEY ;;
  }

  dimension: person_name {
    label: "{% if _view._name == 'dim_person' %} Initiating Person Name {% else %} Assigned Person Name {% endif %}"
    type: string
    sql: ${TABLE}.PERSON_NAME ;;
  }



  measure: count {
    label: "{% if _view._name == 'dim_person' %} Initiating Person Count {% else %} Assigned Person Count {% endif %}"
    type: count
    drill_fields: [person_name]
  }
}
