view: assigned_person {

    sql_table_name: dbo.DIM_PERSON ;;

    dimension: active_flag {
      type: string
      sql: ${TABLE}.ACTIVE_FLAG ;;
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
      sql: ${TABLE}.INSERT_DATE ;;
    }

    dimension: network_id {
      type: string
      sql: ${TABLE}.NETWORK_ID ;;
    }

    dimension: person_key {
      type: number
      sql: ${TABLE}.PERSON_KEY ;;
    }

    dimension: person_name {
      type: string
      sql: ${TABLE}.PERSON_NAME ;;
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
      sql: ${TABLE}.UPDATE_DATE ;;
    }

    measure: count {
      type: count
      drill_fields: [person_name]
    }
  }
