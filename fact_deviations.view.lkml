view: fact_deviations {
  derived_table: {

  sql: Select fact_deviations.PARENT_RECORD_ID,
  fact_deviations.SITE_KEY,
fact_deviations.CUSTOMER_KEY,
fact_deviations.LOT_KEY,
fact_deviations.DOCUMENT_KEY,
fact_deviations.STEP_KEY,
fact_deviations.AREA_OCCURED_KEY,
fact_deviations.INITIATING_PERSON_KEY,
fact_deviations.DEV_STATUS_KEY,
fact_deviations.DEVIATION_KEY,
fact_deviations.SHORT_DESCRIPTION,
fact_deviations.RISK_CAT_KEY,
fact_deviations.CAUSAL_KEY,
fact_deviations.ROOT_CAUSE_KEY,
fact_deviations.AREA_ASSIGNED_KEY,
fact_deviations.QUALITY_RATING,
fact_deviations.ASSIGNED_PERSON_KEY,
fact_deviations.DATE_CREATED,
fact_deviations.DATE_DUE,
fact_deviations.DATE_CLOSED,
fact_deviations.DEVIATION_COUNT,
fact_deviations.INSERT_DATE,
fact_deviations.UPDATE_DATE,
dim_Document.Document_name,
fact_deviations.EVENT_CLASS_KEY

from dbo.FACT_DEVIATIONS join dbo.DIM_DOCUMENT on FACT_DEVIATIONS.DOCUMENT_KEY = DIM_DOCUMENT.DOCUMENT_KEY;;
  }

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

  dimension: event_class_key {
    type: number
    sql: ${TABLE}.EVENT_CLASS_KEY ;;
  }
  dimension: causal_name {
    type: string
    sql: ${TABLE}.CAUSAL_NAME ;;
  }
  dimension: short_description {
    type:  string
    sql: ${TABLE}.SHORT_DESCRIPTION ;;
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
dimension: deviation_age_days{
  type: tier
  tiers: [ -45, -30, -15, -8, 0, 8, 15,30,45]
  style: integer
  sql: ${deviation_age};;

}
  dimension: days_remaining{
    type: tier
    tiers: [ -45, -30, -15, -8, 0, 8, 15,30,45]
    style: integer
    sql: ${Days_Till_Due};;

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
    sql: ${TABLE}.DOCUMENT_NAME ;;
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
    #link: {label:"Low/Minor Root Cause Category"
    #  url:"/dashboards/5?Risk%20Factor=Low&Quality%20Rating=Minor&causal factor={{dim_causal.causal_name._value}}"}
    drill_fields: [Deviation_details*]



  }
    measure: count_event {

      type: number
      drill_fields: [Deviation_details*]
     sql: ${count} ;;
      html:<a href="#drillmenu" target="_self">
          {% if {{fact_deviations.count._value}} > {{dim_event_classification.Alert_Limit._value }} %}  <div style="color: white;  background-color: red; font-size:100%; text-align:center">{{linked_value}}</div>
          {% else %} <div  style="color: black; font-size:100%; text-align:center">{{linked_value}}</div>
          {% endif %};;

    }

  measure: action_count {
   sql: ${count} ;;
    drill_fields: [Deviation_details*]
    html:<a href="#drillmenu" target="_self">
          {% if {{fact_deviations.count._value}} > {{dim_event_classification.Action_Limit._value }} %} <div style="color: white;  background-color: red; font-size:100%; text-align:center">{{linked_value}}</div>
          {% else %} <div  style="color: black; font-size:100%; text-align:center">{{linked_value}}</span>
          {% endif %}</a>;;
  }
  set: Deviation_details {
    fields: [dim_site.site_name, parent_record_id,short_description, document_name, dim_area.area_name, dim_customer.customer_name,dim_lot_batch.lot_batch, dim_event_classification.event_category, dim_event_classification.event_area,dim_deviation_type.deviation_type, dim_risk_category.risk_category_name, quality_rating,dim_causal.causal_name, dim_root_cause.root_cause_category, dim_root_cause.root_cause_name,DIM_DEVIATION_STATUS.deviation_status, date_created_date,date_closed_date,date_due_date]
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
  dimension: Days_Till_Due{
    type: number
    sql:DATEDIFF(day,getdate(),${date_due_date})  ;;

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
${TABLE}.EVENT_CLASS_KEY,
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
