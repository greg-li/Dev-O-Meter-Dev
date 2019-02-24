view: fact_deviations {
  derived_table: {

  sql: Select fact_deviations.PARENT_RECORD_ID,
  fact_deviations.SITE_KEY,
  fact_deviations.BUS_SEC_KEY,
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
fact_deviations.EVENT_CLASS_KEY,
fact_deviations.CUSTOMER_APPROVAL_REQ,
fact_deviations.INVESTIGATION_REQ,
fact_deviations.TECHNOLOGY_BUSINESS_KEY

from dbo.FACT_DEVIATIONS join dbo.DIM_DOCUMENT on FACT_DEVIATIONS.DOCUMENT_KEY = DIM_DOCUMENT.DOCUMENT_KEY;;
  }


  parameter: date_selection{
    type: string
    allowed_value: {
      label: "Quarterly"
      value: "quarterly"
    }
    allowed_value: {
      label: "Annually"
      value: "annually"
    }
    allowed_value: {
      label: "Daily"
      value: "daily"
    }
  }

  dimension: date_created_selector {
    type: string
    sql:
    {% if date_selection._parameter_value == "'quarterly'" %}
    cast(${date_created_quarter} as varchar)
    {% elsif date_selection._parameter_value == "'annually'" %}
    ${date_created_year}
    {% else %}
    cast(${date_created_date} as nvarchar)
    {% endif %}
;;
    html:     {% if date_selection._parameter_value == "'quarterly'" %}
    {{date_created_quarter._rendered_value}}
    {% elsif date_selection._parameter_value == "'annually'" %}
    {{date_created_year._rendered_value}}
    {% else %}
    {{date_created_date._rendered_value}}
    {% endif %}
     ;;
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
  dimension: bus_sec_key {
    type: number
    sql: ${TABLE}.BUS_SEC_KEY ;;
  }
  dimension: causal_key {
    type: number
    sql: ${TABLE}.CAUSAL_KEY ;;
  }

  dimension: event_class_key {
    type: number
    sql: ${TABLE}.EVENT_CLASS_KEY ;;
  }

  ## RHW 2019-01-25: this column isn't part of the derived table SQL
  dimension: causal_name {
    type: string
    sql: ${TABLE}.CAUSAL_NAME ;;
    hidden: yes
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
    label: "Closed"
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
    label: "Created"
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
    ## Added by RHW 2019-01-24
    drill_fields: [dim_event_classification.event_classification, dim_risk_category.risk_category_name
                  , date_created_week, date_created_date, count]
  }

  dimension_group: date_due {
    label: "Due"
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

  dimension: days_to_close {
    type: number
    sql: datediff(day,${date_created_date},${date_closed_date}) ;;
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

  dimension: is_cancelled {
    type: yesno
    sql: ${dim_deviation_status.deviation_status} = 'Closed - Cancelled' ;;
  }

  dimension: is_closed {
    type: yesno
    sql: ${date_closed_raw} IS NOT NULL OR ${dim_deviation_status.deviation_status} like '%Closed%' ;;
  }

# The calculation for overdue looks at the current date and then adds one day.
# For deviations due on the current day, these are not overdue as they can be
# addressed at anytime during the due date
  dimension: is_overdue {
    type: yesno
    sql: ${date_due_raw} < dateadd(day,1,cast(getdate() as date))
    and ${date_closed_date} is null
    ;;
  }

  dimension: is_quality_rating_critical {
    type: yesno
    sql: ${quality_rating} = 'Critical' ;;
  }

  dimension: is_quality_rating_major {
    type: yesno
    sql: ${quality_rating} = 'Major' ;;
  }

  dimension: is_quality_rating_minor {
    type: yesno
    sql: ${quality_rating} = 'Minor' ;;
  }

  dimension: is_risk_rating_high {
    type: yesno
    sql: ${dim_risk_category.risk_category_name} = 'High' ;;
  }

  dimension: is_risk_rating_medium {
    type: yesno
    sql: ${dim_risk_category.risk_category_name}  = 'Medium' ;;
  }

  dimension: is_risk_rating_low {
    type: yesno
    sql: ${dim_risk_category.risk_category_name}  = 'Low' ;;
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

  dimension: requires_investigation {
    type: yesno
    sql: ${dim_deviation_status.deviation_status} = 'Investigation' ;;
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

  measure: average_days_to_close {
    type: average
    sql: ${days_to_close} ;;
  }

  measure: count {
    type: count
    label: "Count of Deviations"
    #link: {label:"Low/Minor Root Cause Category"
    #  url:"/dashboards/5?Risk%20Factor=Low&Quality%20Rating=Minor&causal factor={{dim_causal.causal_name._value}}"}
    drill_fields: [Deviation_details*]
    link: {
      label: "Deviation Details"
      url: "/dashboards/4?Site={{ _filters['dim_site.site_name'] | url_encode }}&Status={{ _filters['dim_deviation_status.deviation_status'] | url_encode }}&Deviation%20Date={{ _filters['fact_deviations.date_created_date'] | url_encode }}&Asset={{ _filters['vw_asset_to_area.asset'] | url_encode }}&Root%20Category={{ _filters['dim_root_cause.root_cause_category'] | url_encode }}&Causal%20Factor={{ _filters['dim_causal.causal_name'] | url_encode }}&Event%20Area={{ _filters['alert_limit_check.event_area'] | url_encode }}&Batch={{ _filters['dim_lot_batch.lot_batch'] | url_encode }}&Customer={{ _filters['dim_customer.customer_name'] | url_encode }}&Event%20Classification={{ _filters['alert_limit_check.event_classification'] | url_encode }}&Area%20Where%20Occurred={{ _filters['dim_area.area_name'] | url_encode }}&Business%20Sector%20Unit={{ _filters['dim_bus_sec.bus_sec_name'] | url_encode }}&Quality%20Impact%20Rating={{ _filters['fact_deviations.quality_rating'] | url_encode }}"
      icon_url: "https://looker.com/favicon.ico"
    }
  }

  measure: investigation_required_count {
    type: count
    label: "Count of Investigation Deviations"
    filters: {
      field:is_overdue
      value:"Yes"
    }
    filters: {
      field: is_closed
      value: "No"
    }
  }

  measure: investigated_percentage {
    value_format_name: percent_1
    type: number
    sql:  1.0*${investigation_required_count}/nullif(${count_open},0);;
  }

  measure: track_and_trend_percentage {
    value_format_name: percent_1
    type: number
    sql: 1.0*(${count_open}-${investigation_required_count})/nullif(${count_open},0) ;;
  }

  measure: overdue_count {
    type: count
    label: "Count of Overdue Deviations"
    filters: {
      field:is_overdue
      value:"Yes"
      }
    filters: {
      field: is_closed
      value: "No"
      }
  }


  measure: overdue_percentage {
    value_format_name: percent_1
    type: number
    sql:  1.0*${overdue_count}/nullif(${count_open},0);;
  }

  measure: cancelled_count {
    type: count
    label: "Count of Cancelled Deviations"
    filters: {
      field: is_cancelled
      value: "Yes"
    }
  }

  measure: critical_rating_count {
    type: count
    filters: {
      field: is_quality_rating_critical
      value: "Yes"
    }
  }

  measure: major_rating_count {
    type: count
    filters: {
      field: is_quality_rating_major
      value: "Yes"
    }
  }

  measure: minor_rating_count {
    type: count
    filters: {
      field: is_quality_rating_minor
      value: "Yes"
    }
  }

  measure:high_risk_rating_count {
    type: count
    filters: {
      field: is_risk_rating_high
      value: "Yes"
    }
  }

  measure: medium_risk_rating_count {
    type: count
    filters: {
      field: is_risk_rating_medium
      value: "Yes"
    }
  }

  measure: low_risk_rating_count {
    type: count
    filters: {
      field: is_risk_rating_low
      value: "Yes"
    }
  }




  measure: percent_cancelled_deviations {
    type: number
    value_format_name: percent_2
    sql: ${cancelled_count}/coalesce(${count},0) ;;
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


  ## RHW 2019-01-24: replaced dim_event_classification.event_category with
  ## dim_event_classification.event_classification, as event_category doesn't exist.
  set: Deviation_details {
    fields: [dim_site.site_name, parent_record_id,short_description, document_name, area_occured.area_name
            , dim_customer.customer_name,dim_lot_batch.lot_batch, dim_event_classification.event_classification
            , dim_event_classification.event_area, dim_risk_category.risk_category_name, quality_rating
            , dim_causal.causal_name, dim_root_cause.root_cause_category, dim_root_cause.root_cause_name
            , DIM_DEVIATION_STATUS.deviation_status, date_created_date]
  }

  measure: count_closed {
    type: number
    drill_fields: []
    sql: count( ${TABLE}.DATE_CLOSED) ;;
  }

#   measure: count_open {
#     type: sum
#     drill_fields: []
#     sql: case when ${TABLE}.DATE_CLOSED is null then 1 else 0 END ;;
#   }

  measure: count_open {
    type: count
    drill_fields: []
    filters: {field:is_closed value: "No"}
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

  dimension: technology_business_key {
    type: number
    sql: ${TABLE}.TECHNOLOGY_BUSINESS_KEY ;;
  }

  dimension: customer_approval_req {
    type: yesno
    sql: ${TABLE}.CUSTOMER_APPROVAL_REQ = 1 ;;
  }

  dimension: investigation_req {
    type: yesno
    sql: ${TABLE}.investigation_req  = 1 ;;
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
