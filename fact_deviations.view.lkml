view: fact_deviations {
  sql_table_name: dbo.FACT_DEVIATIONS ;;

  dimension: area_assigned_key {
    type: number
    sql: ${TABLE}.AREA_ASSIGNED_KEY ;;
  }

  dimension: area_occured_key {
    type: number
    sql: ${TABLE}.AREA_OCCURED_KEY ;;
  }

  dimension: assigned_person_key {
    type: number
    sql: ${TABLE}.ASSIGNED_PERSON_KEY ;;
  }

  dimension: causal_key {
    type: number
    sql: ${TABLE}.CAUSAL_KEY ;;
  }
  dimension: causal_name {
    type: string
    sql: ${TABLE}.CAUSAL_NAME ;;
  }
  dimension: customer_key {
    type: number
    sql: ${TABLE}.CUSTOMER_KEY ;;
  }
  dimension: risk_score {
    type: number
    sql: ${TABLE}.RISK_SCORE ;;
  }

  dimension_group: date_closed {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.DATE_CLOSED ;;
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

  dimension_group: date_due {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.DATE_DUE ;;
  }

  dimension: dev_status_key {
    type: number
    sql: ${TABLE}.DEV_STATUS_KEY ;;
  }

  dimension: deviation_count {
    type: number
    sql: ${TABLE}.DEVIATION_COUNT ;;
  }

  dimension: deviation_key {
    type: number
    sql: ${TABLE}.DEVIATION_KEY ;;
  }

  dimension: document_key {
    type: number
    sql: ${TABLE}.DOCUMENT_KEY ;;
  }
  dimension: document_name {
    type: string
    sql: dim_document.DOCUMENT_NAME ;;
  }

  dimension: initiating_person_key {
    type: number
    sql: ${TABLE}.INITIATING_PERSON_KEY ;;
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

  dimension: lot_key {
    type: number
    sql: ${TABLE}.LOT_KEY ;;
  }
  dimension: quality_rating {
    type: string
    sql: ${TABLE}.QUALITY_RATING ;;
  }
  dimension: parent_record_id {
    type: number
    sql: ${TABLE}.PARENT_RECORD_ID ;;
  }

  dimension: risk_cat_key {
    type: number
    sql: ${TABLE}.RISK_CAT_KEY ;;
  }
 #   dimension: risk_category_name {
  #    type: string
   #   sql: ${TABLE}.RISK_CATEGORY_NAME ;;
    #}

  dimension: root_cause_key {
    type: number
    sql: ${TABLE}.ROOT_CAUSE_KEY ;;
  }

  dimension: site_key {
    type: number
    sql: ${TABLE}.SITE_KEY ;;
  }
  dimension: site_name {
    type: number
    sql: dim_site.SITE_Name ;;
  }



  dimension: step_key {
    type: number
    sql: ${TABLE}.STEP_KEY ;;
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
    drill_fields: [Deviation_details*]

  }
  set: Deviation_details {
    fields: [document_name,site_name, quality_rating, date_created_date,date_closed_date,date_due_date]
  }


  measure: count_closed {
    type: number
    drill_fields: []
    sql: count( ${TABLE}.DATE_CLOSED) ;;
  }
  dimension: deviation_age {
    type: number
    sql:DATEDIFF(day,${date_created_date},getdate())  ;;

  }
  dimension: Closed_to_Due_Diff {
    type: number
    sql:DATEDIFF(day,${date_closed_date},${date_due_date})  ;;

  }
  dimension: primary_key {
    primary_key: yes
    sql: CONCAT(${TABLE}.PARENT_RECORD_ID,
${TABLE}.SITE_KEY,
${TABLE}.CUSTOMER_KEY,
${TABLE}.LOT_KEY,
${TABLE}.DOCUMENT_KEY,
${TABLE}.STEP_KEY,
${TABLE}.AREA_OCCURED_KEY,
${TABLE}.INITIATING_PERSON_KEY,
${TABLE}.DEV_STATUS_KEY,
${TABLE}.DEVIATION_KEY,
${TABLE}.RISK_CAT_KEY,
${TABLE}.CAUSAL_KEY,
${TABLE}.ROOT_CAUSE_KEY,
${TABLE}.AREA_ASSIGNED_KEY,
${TABLE}.ASSIGNED_PERSON_KEY,
${TABLE}.DATE_CREATED,
${TABLE}.DATE_DUE,
${TABLE}.DATE_CLOSED,
${TABLE}.DEVIATION_COUNT,
${TABLE}.INSERT_DATE,
${TABLE}.UPDATE_DATE
) ;;
  }
}
