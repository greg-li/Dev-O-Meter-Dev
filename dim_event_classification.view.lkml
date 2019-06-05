
# explore: dim_event_classification {hidden:yes}
view: dim_event_classification {

  sql_table_name: dbo.DIM_EVENT_CLASSIFICATION ;;

  dimension: event_class_key{
    primary_key: yes
#     hidden: yes
    type: number
    sql: ${TABLE}.EVENT_CLASS_KEY ;;
  }
  dimension: bus_sec_key{
    hidden: yes
    type: number
    sql: ${TABLE}.BUS_SEC_KEY ;;
  }
  dimension: site_key{
    hidden: yes
    type: number
    sql: ${TABLE}.SITE_KEY ;;
  }

  dimension: event_classification {
    label: "Event Category Name"
    type: string
    sql: ${TABLE}.EVENT_CLASSIFICATION ;;
    link: {
      label: "View Category in Deviation Detailed Dashboard"
      url: "/dashboards/WBJNwY7xAFoFQwejYLdET3?Site={{ _filters['dim_site.site_name'] | url_encode }}&Deviation%20Date={{ _filters['fact_deviations.date_created_date'] | url_encode }}&Event%20Classification={{ value }}&Business%20Sector%20Unit={{ _filters['dim_bus_sec.bus_sec_name'] }}&Timezone={{ _filters['fact_deviations.timezone_selection'] }}"
      icon_url: "http://www.looker.com/favicon.ico"
    }
  }

  ##############
  # Documentation: list_of_categories
  # Uses this SQL Server function: https://docs.microsoft.com/en-us/sql/t-sql/functions/string-agg-transact-sql?view=sql-server-2017
  # FUTURE WORK: This should return distinct values.
  # Would require SELECT STRING_AGG(a, ',') FROM (SELECT DISTINCT a FROM dbo.Test) t    (Source: https://feedback.azure.com/forums/908035-sql-server/suggestions/35243533-support-distinct-for-string-agg)
  ##############
  measure: list_of_categories {
    description: "A list of categories that have a result for the selected dimensions. Categories repeat."
    type: string
    sql: STRING_AGG(CAST(${event_classification} AS VARCHAR(MAX)), ',') ;;
    link: {
      label: "Pass Categories to Dashboard 25"
      url: "/dashboards/WBJNwY7xAFoFQwejYLdET3?Event%20Classification={{ value }}"
      icon_url: "http://www.looker.com/favicon.ico"
    }
  }

  dimension: event_area{
    label: "Event General Category"
    type: string
    sql: ${TABLE}.EVENT_AREA ;;
  }
  dimension: action_limit {
    label: "Event Action Limit"
    description: "Annual Deviation Limit"
    group_label: "Category Yearly Facts"
    type: number
    sql: ${TABLE}.EVENT_LIMIT ;;
  }
  measure: count {
    type: count
    drill_fields: [event_classification, count]
  }
  dimension: alert_limit  { # Using this instead of alert_limit_check.alert_limit
    group_label: "Category Monthly Facts"
#   label: "Category Monthly Limit"
    description: "Category Monthly Limit AKA Alert Limit"
    type:  number
    sql: ${TABLE}.EVENT_MONTH_LIMIT;;
  }

  dimension_group: effective {
    label: "Event Effective"
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
    sql: cast(${TABLE}.EFFECTIVE_DATE AT TIME ZONE 'UTC' AT TIME ZONE {% parameter fact_deviations.timezone_selection %} as datetime2) ;;
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
    sql: cast(${TABLE}.INSERT_DATE AT TIME ZONE 'UTC' AT TIME ZONE {% parameter fact_deviations.timezone_selection %} as datetime2) ;;
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
    sql: cast(${TABLE}.UPDATE_DATE AT TIME ZONE 'UTC' AT TIME ZONE {% parameter fact_deviations.timezone_selection %} as datetime2) ;;
  }


  dimension: active_flag {
    label: "Event Active Flag"
    type: string
    sql: ${TABLE}.ACTIVE_FLAG ;;
  }
  measure: total_alert_limit {
    label: "Total Event Alert Limit"
    type: sum
    sql: ${alert_limit} ;;
  }
}
