# Purpose: Get count of SA Investigation Required
# This builds from event_classification_month_stats_dt and aggregates at the quarter
# explore: event_classification_quarter_stats_dt {hidden:yes}
view: event_classification_quarter_stats_dt {
  derived_table: {
    explore_source: event_classification_month_stats_dt {
      column: date_created_quarter {}
      column: count_alert_limit_exceeded_without_links  {}
      column: event_class_key {}
      column: event_classification {}
      column: site_name {}
      column: bus_sec_name {}
    }
  }
  dimension: pk {
    hidden: yes
    primary_key: yes
    sql: concat(${event_class_key},'-',${date_created_quarter},'-',${site_name},'-',${bus_sec_name}) ;;
  }
  dimension: date_created_quarter {
    hidden: yes
    type: date_quarter
  }
  dimension: count_alert_limit_exceeded {
    label: "Count Months where Alert Limit Exceeded"
    group_label: "Category Quarterly Facts"
    description: "Count of months in quarter per category where deviations exceeded"
    type: number
    sql: ${TABLE}.count_alert_limit_exceeded_without_links  ;;
  }
  dimension: event_class_key {
    hidden: yes
  }

  dimension: event_classification_greg_test{
    sql: ${TABLE}.event_classification ;;
  }

  measure: list_of_categories_last_quarter {
    description: "A list of categories that have a result for the selected dimensions. Categories repeat."
    type: string
    sql: (SELECT STRING_AGG(CAST(${event_classification_greg_test} AS VARCHAR(MAX)), ',')
    WITHIN GROUP ( ORDER BY ${event_classification_greg_test} ) from ${event_classification_quarter_stats_dt.SQL_TABLE_NAME}
    where ${count_alert_limit_exceeded}>=2 and ${date_created_quarter} = concat(case datepart(q,cast(getdate() AT TIME ZONE 'UTC' AT TIME ZONE {% parameter fact_deviations.timezone_selection %} as datetime2)) when 4 then datepart(year,cast(getdate() AT TIME ZONE 'UTC' AT TIME ZONE {% parameter fact_deviations.timezone_selection %} as datetime2))-1 else datepart(year,cast(getdate() AT TIME ZONE 'UTC' AT TIME ZONE {% parameter fact_deviations.timezone_selection %} as datetime2)) END ,'-0',  case   (case datepart(q,cast(getdate() AT TIME ZONE 'UTC' AT TIME ZONE {% parameter fact_deviations.timezone_selection %} as datetime2)) when 1 then 4 when 2 then 1 when 3 then 2 when 4 then 3 END) when 1 then 1 when 2 then 4 when 3 then 7 when 4 then 10 END));;

    ## concat(datepart(year,cast(getdate() AT TIME ZONE 'UTC' AT TIME ZONE {% parameter fact_deviations.timezone_selection %} as datetime2)),'-0',  datepart(q,cast(getdate() AT TIME ZONE 'UTC' AT TIME ZONE {% parameter fact_deviations.timezone_selection %} as datetime2))) need to cut over to this logic to get current quarterx
#     link: {
#       label: "Pass Categories to Dashboard 25"
#       url: "https://lonzadev.looker.com/dashboards/WBJNwY7xAFoFQwejYLdET3?Event%20Classification={{ value }}"
#       icon_url: "http://www.looker.com/favicon.ico"
#     }
  }

  measure: list_of_categories_current_quarter {
    description: "A list of categories that have a result for the selected dimensions. Categories repeat."
    type: string
    sql: (SELECT STRING_AGG(CAST(${event_classification_greg_test} AS VARCHAR(MAX)), ',')
          WITHIN GROUP ( ORDER BY ${event_classification_greg_test} ) from ${event_classification_quarter_stats_dt.SQL_TABLE_NAME}
          where ${count_alert_limit_exceeded}>=2 and ${date_created_quarter} = concat(datepart(year,cast(getdate() AT TIME ZONE 'UTC' AT TIME ZONE {% parameter fact_deviations.timezone_selection %} as datetime2)),'-0',  case datepart(q,cast(getdate() AT TIME ZONE 'UTC' AT TIME ZONE {% parameter fact_deviations.timezone_selection %} as datetime2)) when 1 then 1 when 2 then 4 when 3 then 7 when 4 then 10 END));;

          ## concat(datepart(year,cast(getdate() AT TIME ZONE 'UTC' AT TIME ZONE {% parameter fact_deviations.timezone_selection %} as datetime2)),'-0',  datepart(q,cast(getdate() AT TIME ZONE 'UTC' AT TIME ZONE {% parameter fact_deviations.timezone_selection %} as datetime2))) need to cut over to this logic to get current quarterx
      #     link: {
      #       label: "Pass Categories to Dashboard 25"
      #       url: "https://lonzadev.looker.com/dashboards/WBJNwY7xAFoFQwejYLdET3?Event%20Classification={{ value }}"
      #       icon_url: "http://www.looker.com/favicon.ico"
      #     }
    }

  dimension: site_name {
    type: string
    sql: ${TABLE}.site_name ;;
  }

  dimension: bus_sec_name {
    type: string
    sql: ${TABLE}.bus_sec_name ;;
  }


  dimension: sa_investigation_required {
    label: "SA Investigation Required"
    group_label: "Category Quarterly Facts"
    type: yesno
    sql: ${count_alert_limit_exceeded}>=2 ;;
  }
  measure: count_sa_investigation_required {
    label: "Count SA Investigation Required"
    group_label: "Category Quarterly Facts"
    type: count
    filters: {
      field: sa_investigation_required
      value: "Yes"
    }
    link: {
      label: "Last Quarter: View Deviation Detailed Analysis Dashboard"
      url: "https://lonzadev.looker.com/dashboards/WBJNwY7xAFoFQwejYLdET3?Event%20Classification={{ list_of_categories_last_quarter._value }}"
      icon_url: "http://www.looker.com/favicon.ico"
    }
    link: {
      label: "This Quarter: View Deviation Detailed Analysis Dashboard"
      url: "https://lonzadev.looker.com/dashboards/WBJNwY7xAFoFQwejYLdET3?Event%20Classification={{ list_of_categories_current_quarter._value }}"
      icon_url: "http://www.looker.com/favicon.ico"
    }
    drill_fields: [detail*]

  }
  set: detail {
    fields: [
      date_created_quarter
      , dim_event_classification.event_classification
      , event_classification_month_stats_dt.count_alert_limit_exceeded
#       , dim_event_classification.alert_limit
#       , event_classification_month_stats_dt.category_monthly_deviation_count
#       , fact_deviations.count
    ]
  }
}
