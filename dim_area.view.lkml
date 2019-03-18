view: dim_area {
    sql_table_name:dbo.dim_area;;


  dimension: active_flag {
    label: "{% if _view._name == 'dim_area' %} Area Assigned Active Flag {% else %} Area Occurred Alert Flag {% endif %}"
    type: string
    sql: ${TABLE}.ACTIVE_FLAG ;;
  }

  dimension: area_key {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.AREA_KEY ;;
  }

  dimension: area_name {          ##keep
    label: "{% if _view._name == 'dim_area' %} Area Assigned Name {% else %} Area Occurred Name {% endif %}"
    type: string
    sql: ${TABLE}.AREA_NAME ;;
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
    label: "{% if _view._name == 'dim_area' %} Area Assigned Count {% else %} Area Occurred Count {% endif %}"
    type: count
    drill_fields: [area_name]
  }
  }
