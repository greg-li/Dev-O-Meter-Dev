include: "*.model"
include: "dim_event_classification.view"
explore: event_classification_year_stats_dt {hidden:yes}
view: event_classification_year_stats_dt {
  derived_table: {
    explore_source: fact_deviations {
      column: date_created_year {}
      column: event_classification { field: dim_event_classification.event_classification }
      column: action_limit { field: dim_event_classification.action_limit }
      column: count {}
      filters: {
        field: dim_deviation_type.deviation_type
        value: "Unplanned,Customer Complaint - Product quality complaints,Customer Complaint - Packaging and shipping complaints"
      }
      filters: {
        field: fact_deviations.timezone_selection
        value: "Eastern Standard Time"
      }
      filters: {
        field: dim_site.site_name
        value: "Portsmouth"
      }
      filters: {
        field: dim_deviation_status.deviation_status
        value: "-Closed - Aborted,-Closed - Cancelled,-Closed - Voided"
      }
      filters: {
        field: dim_bus_sec.bus_sec_name
        value: "LPB Portsmouth MM"
      }
    }
  }
  dimension: pk {
    hidden: yes
    primary_key: yes
    sql: concat(${event_classification}, '-', ${date_created_year}) ;;
  }
  dimension: date_created_year {
    hidden: yes
    label: " Deviations  Created Year"
    type: date_year
  }
  dimension: event_classification {
    hidden: yes
    label: "Event Category Name"
  }
  dimension: action_limit {
    hidden: yes
    label: "Event Action Limit"
    description: "Annual Deviation Limit"
    type: number
  }
  dimension: category_yearly_deviation_count {
    group_label: "Category Yearly Facts"
    type: number
    sql: ${TABLE}.count ;;
  }
  dimension: percent_action_limit_reached {
    type: number
    sql: ${category_yearly_deviation_count}*100.0/NULLIF(${action_limit},0) ;;
    value_format: "0\%"
  }
  dimension: action_limit_exceeded {
    group_label: "Category Yearly Facts"
    type: yesno
    description: "Annual limit to deviations hit or exceeded"
    sql: ${action_limit}<=${category_yearly_deviation_count} ;;
  }

  ##### The link here doesn't work yeat #####
  # Passes too many values (see dim_event_classification.list_of_categories._value)
  # Trying to limit values with following derived table, no luck yet
  measure: count_action_limit_exceeded {
    description: "Annual limit to deviations hit or exceeded"
    type: count
    filters: {
      field: action_limit_exceeded
      value: "Yes"
    }
    drill_fields: [fact_deviations.date_created_year, event_classification, action_limit, percent_action_limit_reached, fact_deviations.count]
    link: {
      label: "View Categories in Deviation Detailed Dashboard"
      url: "https://lonzadev.looker.com/dashboards/25?Event%20Classification={{ dim_event_classification.list_of_categories._value }}"
      icon_url: "http://www.looker.com/favicon.ico"
    }
  }
}

# Trying to create list of categories for link.
# plain category_list has too many values
# This is trying to get filtered values where action_limit_exceeded = Yes and bind filter gets set to same year as dt above

explore:dt1 {hidden:yes}
view: dt1 {
  derived_table: {
    explore_source: event_classification_year_stats_dt {
      column: event_classification {}
      filters: {
        field: event_classification_year_stats_dt.action_limit_exceeded
        value: "Yes"
      }
      bind_filters: {
        from_field: dt1.bind_filter
        to_field: event_classification_year_stats_dt.date_created_year
      }
    }
  }
  filter: bind_filter {type:date default_value: "this year"}
  dimension: event_classification {primary_key:yes}

  measure: list_of_categories_for_link {
    description: "A list of categories with action_limit_exceeded. Categories repeat."
    type: string
    sql: STRING_AGG(CAST(${event_classification} AS VARCHAR(MAX)), ',') ;;
    html: <a href="/dashboards/25?Event%20Classification={{ value }}">{{ value }}</a>  ;;
  }
}

# Error: Circular dependency detected from derived table to source explore "fact_deviations".
explore: extended_for_year {
  hidden: yes
  label: "Extended deviations for year metric"
  view_name: fact_deviations
  extends: [fact_deviations]
  always_filter: {
    filters: {
      field: dt1.bind_filter
      value: "this year"
    }
  }
  join: dt1 {
    sql_on: ${event_classification_year_stats_dt.event_classification} = ${dt1.event_classification} ;;
    relationship: many_to_one
  }
}




#
