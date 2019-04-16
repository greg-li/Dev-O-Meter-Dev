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
fact_deviations.TECHNOLOGY_BUSINESS_KEY,
1 as number
from dbo.FACT_DEVIATIONS
join dbo.DIM_DOCUMENT
on FACT_DEVIATIONS.DOCUMENT_KEY = DIM_DOCUMENT.DOCUMENT_KEY;;
  }


  parameter: date_selection{
    type: string
    description: "This fields allow for dynamic Time selection. It must be used in conjunction with the Reporting Period dimension."
    allowed_value: {
      label: "Quarterly"
      value: "quarterly"
    }
    allowed_value: {
      label: "Annually"
      value: "annually"
    }
    allowed_value: {
      label: "Monthly"
      value: "monthly"
    }
    allowed_value: {
      label: "Daily"
      value: "daily"
    }
  }

#   dimension: date_selection_dim {
#     type: string
#     sql: {%parameter date_selection %} ;;
#   }

  dimension: date_created_selector_helper {
    type: string
    hidden: yes
    sql:
    {% if date_selection._parameter_value == "'quarterly'" %}
    cast(${date_created_quarter} as varchar)
    {% elsif date_selection._parameter_value == "'annually'" %}
    ${date_created_year}
    {% elsif date_selection._parameter_value == "'monthly'" %}
    ${date_created_month}
    {% else %}
    cast(${date_created_date} as nvarchar)
    {% endif %}
;;
  }

  dimension: date_created_selector {
    label: "Reporting Period"
    description: "This field needs to be used in conjunction with the Date Selection Filter. This field enables Dyanmic Time Frames. By selecting a Period type in the Date Selection filter, you can toggle between Daily, Monthly, Quarter, and Annual using this one dimension in your visualizations"
    type: string
    sql:
    {% if date_selection._parameter_value == "'quarterly'" %}
    case when ${date_created_selector_helper}like '%-01' and len(${date_created_selector_helper}) = 7 then replace(${date_created_selector_helper},'-01','-Q1')
    when ${date_created_selector_helper}like '%-04' and len(${date_created_selector_helper}) = 7 then replace(${date_created_selector_helper},'-04','-Q2')
    when ${date_created_selector_helper}like '%-07' and len(${date_created_selector_helper}) = 7 then replace(${date_created_selector_helper},'-07','-Q3')
    when ${date_created_selector_helper}like '%-10' and len(${date_created_selector_helper}) = 7 then replace(${date_created_selector_helper},'-10','-Q4')
    else ${date_created_selector_helper} END
    {% else %}
     ${date_created_selector_helper}
    {% endif %}
    ;;
  }

  parameter: timezone_selection {
    type: string
    suggest_explore: available_timezones
    suggest_dimension: available_timezones.name
  }

  dimension: area_assigned_key {
    hidden: yes
    type: number
    sql: ${TABLE}.AREA_ASSIGNED_KEY ;;
  }

  dimension: area_occured_key {
    hidden: yes
    type: number
    sql: ${TABLE}.AREA_OCCURED_KEY ;;
  }

  dimension: assigned_person_key {
    hidden: yes
    type: number
    sql: ${TABLE}.ASSIGNED_PERSON_KEY ;;
  }
  dimension: bus_sec_key {
    hidden: yes
    type: number
    sql: ${TABLE}.BUS_SEC_KEY ;;
  }
  dimension: causal_key {
    hidden: yes
    type: number
    sql: ${TABLE}.CAUSAL_KEY ;;
  }

  dimension: event_class_key {
    hidden: yes
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
    label: "Deviation Description"
    type:  string
    sql: ${TABLE}.SHORT_DESCRIPTION ;;
  }
  dimension: customer_key {
    hidden: yes
    type: number
    sql: ${TABLE}.CUSTOMER_KEY ;;
  }
  dimension: risk_score {
    type: number
    sql: ${TABLE}.RISK_SCORE ;;
  }

  dimension_group: date_closed {
    label: " Closed"
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
    sql: cast(${TABLE}.DATE_CLOSED AT TIME ZONE 'UTC' AT TIME ZONE {% parameter timezone_selection %} as datetime2);;
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

  dimension_group: date_created{
    label: " Created"
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
    sql: cast(${TABLE}.DATE_CREATED AT TIME ZONE 'UTC' AT TIME ZONE {% parameter timezone_selection %} as datetime2);;
    ## Added by RHW 2019-01-24
    drill_fields: [dim_event_classification.event_classification, dim_risk_category.risk_category_name
      , date_created_week, date_created_date, count]
  }

  # last_12_months is used for the spark line viz only. Viz used in "DEVIATION DETAILED ANALYSIS DASHBOARD"
  # Reason: viz doesn't allow column renaming, and this should be the name of the trend line column.
  # Hide unless working on viz, andemember to hide again when you're done!
  dimension: last_12_months {
    description: "Trailing last 12 months"
    hidden: yes
    sql: ${date_created_month} ;;
  }

  dimension_group: date_due {
    label: " Due"
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
    sql: cast(${TABLE}.DATE_DUE AT TIME ZONE 'UTC' AT TIME ZONE {% parameter timezone_selection %} as datetime2) ;;
  }

  dimension: days_to_close {
    type: number
    sql: datediff(day,${date_created_date},${date_closed_date}) ;;
  }

  dimension: dev_status_key {
    hidden: yes
    type: number
    sql: ${TABLE}.DEV_STATUS_KEY ;;
  }

  dimension: deviation_count {
    hidden: yes
    type: number
    sql: ${TABLE}.DEVIATION_COUNT ;;
  }

  dimension: deviation_key {
    hidden: yes
    type: number
    sql: ${TABLE}.DEVIATION_KEY ;;
  }

  dimension: document_key {
    hidden: yes
    type: number
    sql: ${TABLE}.DOCUMENT_KEY ;;
  }
  dimension: document_name {
    hidden: yes
    type: string
    sql: ${TABLE}.DOCUMENT_NAME ;;
  }

  dimension: initiating_person_key {
    hidden: yes
    type: number
    sql: ${TABLE}.INITIATING_PERSON_KEY ;;
  }

  dimension: is_cancelled {
    group_label: " Yes/No Flags"
    type: yesno
    sql: ${dim_deviation_status.deviation_status} = 'Closed - Cancelled' ;;
  }

  dimension: is_closed {
    group_label: " Yes/No Flags"
    type: yesno
    sql: ${date_closed_raw} IS NOT NULL OR ${dim_deviation_status.deviation_status} like '%Closed%' ;;
  }

# The calculation for overdue looks at the current date and then adds one day.
# For deviations due on the current day, these are not overdue as they can be
# addressed at anytime during the due date
  dimension: is_overdue {
    group_label: " Yes/No Flags"
    type: yesno
    sql: ${date_due_raw} < dateadd(day,1,cast(getdate() AT TIME ZONE 'UTC' AT TIME ZONE {% parameter timezone_selection %} as datetime2))
    and ${date_closed_date} is null
    ;;
  }

  dimension: is_quality_rating_critical {

    group_label: " Quality Rating"
    type: yesno
    sql: ${quality_rating} = 'Critical' ;;
  }

  dimension: is_quality_rating_major {
    group_label: " Quality Rating"
    type: yesno
    sql: ${quality_rating} = 'Major' ;;
  }

  dimension: is_quality_rating_minor {
    group_label: " Quality Rating"
    type: yesno
    sql: ${quality_rating} = 'Minor' ;;
  }

  dimension: is_risk_rating_high {
    group_label: " Risk Rating"
    type: yesno
    sql: ${dim_risk_category.risk_category_name} = 'High' ;;
  }

  dimension: is_risk_rating_medium {
    group_label: " Risk Rating"
    type: yesno
    sql: ${dim_risk_category.risk_category_name}  = 'Medium' ;;
  }

  dimension: is_risk_rating_low {
    group_label: " Risk Rating"
    type: yesno
    sql: ${dim_risk_category.risk_category_name}  = 'Low' ;;
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
    sql: cast(${TABLE}.INSERT_DATE AT TIME ZONE 'UTC' AT TIME ZONE {% parameter fact_deviations.timezone_selection %} as datetime2);;
  }

  dimension: lot_key {
    hidden: yes
    type: number
    sql: ${TABLE}.LOT_KEY ;;
  }
  dimension: quality_rating {  ##keep
    group_label: " Quality Rating"
    type: string
    sql: ${TABLE}.QUALITY_RATING ;;
  }
  dimension: parent_record_id {
    hidden: yes
    type: number
    sql: ${TABLE}.PARENT_RECORD_ID ;;
  }

  dimension: requires_investigation {
    group_label: " Yes/No Flags"
    type: yesno
    sql: ${dim_deviation_status.deviation_status} = 'Investigation' ;;
  }

  dimension: risk_cat_key {
    hidden: yes
    type: number
    sql: ${TABLE}.RISK_CAT_KEY ;;
  }
 #   dimension: risk_category_name {
  #    type: string
   #   sql: ${TABLE}.RISK_CATEGORY_NAME ;;
    #}

  dimension: root_cause_key {
    hidden: yes
    type: number
    sql: ${TABLE}.ROOT_CAUSE_KEY ;;
  }

  dimension: site_key {
    hidden: yes
    type: number
    sql: ${TABLE}.SITE_KEY ;;
  }

  dimension: step_key {
    hidden: yes
    type: number
    sql: ${TABLE}.STEP_KEY ;;
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
    sql: cast(${TABLE}.UPDATE_DATE AT TIME ZONE 'UTC' AT TIME ZONE {% parameter fact_deviations.timezone_selection %} as datetime2);;
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
      url: "https://lonzadev.looker.com/dashboards/WBJNwY7xAFoFQwejYLdET3?Site={{ _filters['dim_site.site_name'] | url_encode }}&Status={{ _filters['dim_deviation_status.deviation_status'] | url_encode }}&Deviation%20Date={{ _filters['fact_deviations.date_created_date'] | url_encode }}&Asset={{ _filters['vw_asset_to_area.asset'] | url_encode }}&Root%20Category={{ _filters['dim_root_cause.root_cause_category'] | url_encode }}&Causal%20Factor={{ _filters['dim_causal.causal_name'] | url_encode }}&Event%20Area={{ _filters['alert_limit_check.event_area'] | url_encode }}&Batch={{ _filters['dim_lot_batch.lot_batch'] | url_encode }}&Customer={{ _filters['dim_customers.customer_name'] | url_encode }}&Event%20Classification={{ _filters['alert_limit_check.event_classification'] | url_encode }}&Area%20Where%20Occurred={{ _filters['dim_area.area_name'] | url_encode }}&Business%20Sector%20Unit={{ _filters['dim_bus_sec.bus_sec_name'] | url_encode }}&Quality%20Impact%20Rating={{ _filters['fact_deviations.quality_rating'] | url_encode }}"
      icon_url: "https://looker.com/favicon.ico"
    }
  }

  measure: investigation_required_count {
    group_label: " Investigation"
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
    group_label: " Investigation"
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
    group_label: " Overdue"
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
    group_label: " Overdue"
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
    group_label: " Rating Counts"
    type: count
    filters: {
      field: is_quality_rating_critical
      value: "Yes"
    }
  }

  measure: major_rating_count {
    group_label: " Rating Counts"
    type: count
    filters: {
      field: is_quality_rating_major
      value: "Yes"
    }
  }

  measure: minor_rating_count {
    group_label: " Rating Counts"
    type: count
    filters: {
      field: is_quality_rating_minor
      value: "Yes"
    }
  }

  measure:high_risk_rating_count {
    group_label: " Rating Counts"
    type: count
    filters: {
      field: is_risk_rating_high
      value: "Yes"
    }
  }

  measure: medium_risk_rating_count {
    group_label: " Rating Counts"
    type: count
    filters: {
      field: is_risk_rating_medium
      value: "Yes"
    }
  }

  measure: low_risk_rating_count {
    group_label: " Rating Counts"
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
      label: "Count of Deviations - formatted"
      type: number
      drill_fields: [Deviation_details*]
      sql: ${count} ;;
      html:<a href="#drillmenu" target="_self">
          {% if {{fact_deviations.count._value}} > {{dim_event_classification.alert_limit._value }} %}
          <div style="font-weight: bold; background-color: #e0434b; font-color:#ffffff; margin: 0; border-radius: 5px; text-align:center;color: white ">{{ value }}</div>

          {% else %} <div style="color:black; font-size:100%; text-align:center">{{ value }}</div>
          {% endif %};;
#           <div style="color: white;  background-color: red; font-size:100%; text-align:center">{{linked_value}}</div>

    }

  ## RHW 2019-01-24: replaced dim_event_classification.event_category with
  ## dim_event_classification.event_classification, as event_category doesn't exist.
  set: Deviation_details {
    fields: [dim_site.site_name, parent_record_id,short_description, document_name, area_occured.area_name
            , dim_customers.customer_name,dim_lot_batch.lot_batch, dim_event_classification.event_classification
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
  dimension: closed_to_due_diff {
    type: number
    sql:DATEDIFF(day,${date_closed_date},${date_due_date})  ;;

  }
  dimension: Days_Till_Due{
    type: number
    sql:DATEDIFF(day,getdate(),${date_due_date})  ;;

  }

  dimension: technology_business_key {
    hidden: yes
    type: number
    sql: ${TABLE}.TECHNOLOGY_BUSINESS_KEY ;;
  }

  dimension: customer_approval_req {
    group_label: " Yes/No Flags"
    type: yesno
    sql: ${TABLE}.CUSTOMER_APPROVAL_REQ = 1 ;;
  }

  dimension: investigation_req {
    group_label: " Yes/No Flags"
    type: yesno
    sql: ${TABLE}.investigation_req  = 1 ;;
  }

  dimension: primary_key {
    hidden: yes
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


  dimension: dashboard_section_causal_factors_root_cause{
    label: "  "
    hidden: yes
    sql: ${TABLE}.number;;
    html: <b><center><font size="18">Causal Factors & Root Causes</font></center></b>;;
  }

  dimension: dashboard_section_event{
    label: "  "
    hidden: yes
    sql: ${TABLE}.number;;
    html: <b><center><font size="18">Event</font></center></b>;;
  }

  dimension: dashboard_section_asset{
    label: "  "
    hidden: yes
    sql: ${TABLE}.number;;
    html: <b><center><font size="18">Asset</font></center></b>;;
  }

  dimension: dashboard_section_area{
    label: "  "
    hidden: yes
    sql: ${TABLE}.number;;
    html: <b><center><font size="18"> Area</font></center></b>;;
  }

 dimension: dashboard_section_causal_factors_root_cause_with_link{
   label: "  "
   hidden: yes
   sql: ${TABLE}.number;;
   html: <b><center><font size="18">Causal Factors & Root Causes</font></center></b>
       <b>
       <div align="right">
       <a href= "/dashboards/19?Date%20Selection={{ _filters['fact_deviations.date_selection'] | url_encode }}&Time%20Zone={{ _filters['fact_deviations.timezone_selection'] | url_encode }}&Site={{ _filters['dim_site.site_name'] | url_encode }}&Status={{ _filters['dim_deviation_status.deviation_status'] | url_encode }}&Deviation%20Date={{ _filters['fact_deviations.date_created_date'] | url_encode }}&Asset={{ _filters['vw_asset_to_area.asset'] | url_encode }}&Root%20Category={{ _filters['dim_root_cause.root_cause_category'] | url_encode }}&Causal%20Factor={{ _filters['dim_causal.causal_name'] | url_encode }}&Event%20Area={{ _filters['alert_limit_check.event_area'] | url_encode }}&Batch={{ _filters['dim_lot_batch.lot_batch'] | url_encode }}&Customer={{ _filters['dim_customers.customer_name'] | url_encode }}&Event%20Classification={{ _filters['alert_limit_check.event_classification'] | url_encode }}&Area%20Where%20Occurred={{ _filters['area_occured.area_name'] | url_encode }}&Business%20Sector%20Unit={{ _filters['dim_bus_sec.bus_sec_name'] | url_encode }}&Quality%20Impact%20Rating={{ _filters['fact_deviations.quality_rating'] | url_encode }}&Deviation%20Type={{_filters['dim_deviation_type.deviation_type'] | url_encode}}"
       style="color:dodgerblue;"target="_blank"“&run=1”>
       Click here for more detail</a>
       </div>
       </b>;;
     #   link: {
     #     label: "Click here for more Cause & Root Cause Detail"
     #     url:"/dashboards/19?Date%20Reporting%20Period%20Type=_filters['fact_deviations.date_selection']&Time%20Zone=US%2FEastern&Site=Portsmouth&Status=-Closed%20-%20Aborted,-Closed%20-%20Cancelled,-Closed%20-%20Voided&Deviation%20Date=2018&Asset=&Root%20Category=&Causal%20Factor=&Event%20Area=&Batch=&Customer=&Event%20Classification=&Area%20Where%20Occurred=&Business%20Sector%20Unit=LPB%20Portsmouth%20MM&Quality%20Impact%20Rating="
     #   }
   }

    dimension: dashboard_section_event_with_link{
      label: "  "
      hidden: yes
      sql: ${TABLE}.number;;
      html: <b><center><font size="18">Event</font></center></b>
              <b>
              <div align="right">
              <a href= "/dashboards/22?Date%20Selection={{ _filters['fact_deviations.date_selection'] | url_encode }}&Time%20Zone={{ _filters['fact_deviations.timezone_selection'] | url_encode }}&Site={{ _filters['dim_site.site_name'] | url_encode }}&Status={{ _filters['dim_deviation_status.deviation_status'] | url_encode }}&Deviation%20Date={{ _filters['fact_deviations.date_created_date'] | url_encode }}&Asset={{ _filters['vw_asset_to_area.asset'] | url_encode }}&Root%20Category={{ _filters['dim_root_cause.root_cause_category'] | url_encode }}&Causal%20Factor={{ _filters['dim_causal.causal_name'] | url_encode }}&Event%20Area={{ _filters['alert_limit_check.event_area'] | url_encode }}&Batch={{ _filters['dim_lot_batch.lot_batch'] | url_encode }}&Customer={{ _filters['dim_customers.customer_name'] | url_encode }}&Event%20Classification={{ _filters['alert_limit_check.event_classification'] | url_encode }}&Area%20Where%20Occurred={{ _filters['area_occured.area_name'] | url_encode }}&Business%20Sector%20Unit={{ _filters['dim_bus_sec.bus_sec_name'] | url_encode }}&Quality%20Impact%20Rating={{ _filters['fact_deviations.quality_rating'] | url_encode }}&Deviation%20Type={{_filters['dim_deviation_type.deviation_type'] | url_encode}}"
              style="color:dodgerblue;"target="_blank"“&run=1”>
              Click here for more detail</a>
              </div>
              </b;;
    }

    dimension: dashboard_section_asset_with_link{
      label: "  "
      hidden: yes
      sql: ${TABLE}.number;;
      html: <b><center><font size="18">Asset</font></center></b>
              <b>
              <div align="right">
              <a href= "/dashboards/21?Date%20Selection={{ _filters['fact_deviations.date_selection'] | url_encode }}&Time%20Zone={{ _filters['fact_deviations.timezone_selection'] | url_encode }}&Site={{ _filters['dim_site.site_name'] | url_encode }}&Status={{ _filters['dim_deviation_status.deviation_status'] | url_encode }}&Deviation%20Date={{ _filters['fact_deviations.date_created_date'] | url_encode }}&Asset={{ _filters['vw_asset_to_area.asset'] | url_encode }}&Root%20Category={{ _filters['dim_root_cause.root_cause_category'] | url_encode }}&Causal%20Factor={{ _filters['dim_causal.causal_name'] | url_encode }}&Event%20Area={{ _filters['alert_limit_check.event_area'] | url_encode }}&Batch={{ _filters['dim_lot_batch.lot_batch'] | url_encode }}&Customer={{ _filters['dim_customers.customer_name'] | url_encode }}&Event%20Classification={{ _filters['alert_limit_check.event_classification'] | url_encode }}&Area%20Where%20Occurred={{ _filters['area_occured.area_name'] | url_encode }}&Business%20Sector%20Unit={{ _filters['dim_bus_sec.bus_sec_name'] | url_encode }}&Quality%20Impact%20Rating={{ _filters['fact_deviations.quality_rating'] | url_encode }}&Deviation%20Type={{_filters['dim_deviation_type.deviation_type'] | url_encode}}"
              style="color:dodgerblue;"target="_blank"“&run=1”>
              Click here for more detail</a>
              </div>
              </b;;
    }

    dimension: dashboard_section_area_with_link{
      label: "  "
      hidden: yes
      sql: ${TABLE}.number;;
      html: <b><center><font size="18"> Area</font></center></b>
              <b>
              <div align="right">
              <a href= "/dashboards/20?Date%20Selection={{ _filters['fact_deviations.date_selection'] | url_encode }}&Time%20Zone={{ _filters['fact_deviations.timezone_selection'] | url_encode }}&Site={{ _filters['dim_site.site_name'] | url_encode }}&Status={{ _filters['dim_deviation_status.deviation_status'] | url_encode }}&Deviation%20Date={{ _filters['fact_deviations.date_created_date'] | url_encode }}&Asset={{ _filters['vw_asset_to_area.asset'] | url_encode }}&Root%20Category={{ _filters['dim_root_cause.root_cause_category'] | url_encode }}&Causal%20Factor={{ _filters['dim_causal.causal_name'] | url_encode }}&Event%20Area={{ _filters['alert_limit_check.event_area'] | url_encode }}&Batch={{ _filters['dim_lot_batch.lot_batch'] | url_encode }}&Customer={{ _filters['dim_customers.customer_name'] | url_encode }}&Event%20Classification={{ _filters['alert_limit_check.event_classification'] | url_encode }}&Area%20Where%20Occurred={{ _filters['area_occured.area_name'] | url_encode }}&Business%20Sector%20Unit={{ _filters['dim_bus_sec.bus_sec_name'] | url_encode }}&Quality%20Impact%20Rating={{ _filters['fact_deviations.quality_rating'] | url_encode }}&Deviation%20Type={{_filters['dim_deviation_type.deviation_type'] | url_encode}}"
              style="color:dodgerblue;"target="_blank"“&run=1”>
              Click here for more detail</a>
              </div>
              </b;;
    }

}