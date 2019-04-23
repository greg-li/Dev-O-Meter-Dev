include: "*.model"
include: "dim_event_classification.view"
# explore: event_classification_year_stats_dt {hidden:yes}
view: event_classification_year_stats_dt {
  derived_table: {
    explore_source: fact_deviations {
      column: date_created_year {}
#       column: date_created_quarter {}
      column: event_classification { field: dim_event_classification.event_classification }
      column: action_limit { field: dim_event_classification.action_limit }
      column: count {}
      column: site_name {field: dim_site.site_name}
      column: bus_sec_name {field: dim_bus_sec.bus_sec_name}
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
    sql: concat(${event_classification}, '-', ${date_created_year},'-',${site_name},'-',${bus_sec_name}) ;;
  }
  dimension: date_created_year {
    hidden: yes
    label: " Deviations  Created Year"
    type: date_year
  }
#
#   dimension: date_created_quarter {
#     hidden: yes
#     label: " Deviations  Created Year"
#     type: date_year
#   }


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
    sql: ${action_limit}<${category_yearly_deviation_count} ;;
  }

  dimension: site_name {
    type: string
    sql: ${TABLE}.site_name ;;
  }

  dimension: bus_sec_name {
    type: string
    sql: ${TABLE}.bus_sec_name ;;
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
      label: "Current Year: View Deviation Detailed Analysis Dashboard"
      url: "https://lonzadev.looker.com/dashboards/WBJNwY7xAFoFQwejYLdET3?Event%20Classification={{ list_of_categories_for_link_action_limit_this_year._value }}&Deviation%20Date={{ _filters['fact_deviations.date_created_date'] }}&Timezone={{ _filters['fact_deviations.timezone_selection'] }}&Site={{ _filters['dim_site.site_name'] }}&Business%20Sector%20Unit={{ _filters['dim_bus_sec.bus_sec_name'] }}"
      icon_url: "http://www.looker.com/favicon.ico"
    }
#      link: {
#        label: "This Quarter: View Deviation Detailed Analysis Dashboard"
#        url: "https://lonzadev.looker.com/dashboards/WBJNwY7xAFoFQwejYLdET3?Event%20Classification={{ list_of_categories_for_link_action_limit_by_quarter._value }}&Deviation%20Date={{ _filters['fact_deviations.date_created_date'] }}&Timezone={{ _filters['fact_deviations.timezone_selection'] }}&Site={{ _filters['dim_site.site_name'] }}&Business%20Sector%20Unit={{ _filters['dim_bus_sec.bus_sec_name'] }}"
#        icon_url: "http://www.looker.com/favicon.ico"
#      }
  }
  measure: list_of_categories_for_link_action_limit_this_year {
    description: "A list of categories with action_limit_exceeded. Categories repeat."
    type: string
    sql: (SELECT STRING_AGG(CAST(${event_classification} AS VARCHAR(MAX)), ',')
          WITHIN GROUP ( ORDER BY ${event_classification} ) from ${event_classification_year_stats_dt.SQL_TABLE_NAME}
          where {% condition dim_site.site_name %} ${site_name} {% endcondition %} and {% condition dim_bus_sec.bus_sec_name %} ${bus_sec_name} {% endcondition %} and ${action_limit}<=${category_yearly_deviation_count}
          and ${date_created_year} = datepart(year,cast(getdate() AT TIME ZONE 'UTC' AT TIME ZONE {% parameter fact_deviations.timezone_selection %} as datetime2))
          ) ;;
#     html: <a href="/dashboards/WBJNwY7xAFoFQwejYLdET3?Event%20Classification={{ value }}">{{ value }}</a>  ;;
  }

#   measure: list_of_categories_for_link_action_limit_by_quarter {
#     description: "A list of categories with action_limit_exceeded. Categories repeat."
#     type: string
#     sql: (SELECT STRING_AGG(CAST(${event_classification} AS VARCHAR(MAX)), ',')
#     WITHIN GROUP ( ORDER BY ${event_classification} ) from ${event_classification_year_stats_dt.SQL_TABLE_NAME}
#     where ${action_limit}<=${category_yearly_deviation_count}
#     and cast(${date_created_quarter} as varchar) = cast(concat(datepart(year,cast(getdate() AT TIME ZONE 'UTC' AT TIME ZONE {% parameter fact_deviations.timezone_selection %} as datetime2)),'-0',  case datepart(q,cast(getdate() AT TIME ZONE 'UTC' AT TIME ZONE {% parameter fact_deviations.timezone_selection %} as datetime2)) when 1 then 1 when 2 then 4 when 3 then 7 when 4 then 10 END) as varchar)
#     );;
#     html: <a href="/dashboards/WBJNwY7xAFoFQwejYLdET3?Event%20Classification={{ value }}">{{ value }}</a>  ;;
#     }
#
# }


#    and ${date_created_quarter} = concat(datepart(year,cast(getdate() AT TIME ZONE 'UTC' AT TIME ZONE {% parameter fact_deviations.timezone_selection %} as datetime2)),'-0',  case datepart(q,cast(getdate() AT TIME ZONE 'UTC' AT TIME ZONE {% parameter fact_deviations.timezone_selection %} as datetime2)) when 1 then 1 when 2 then 4 when 3 then 7 when 4 then 10 END)



# Trying to create list of categories for link.
# plain category_list has too many values
# This is trying to get filtered values where action_limit_exceeded = Yes and bind filter gets set to same year as dt above

# explore:dt1 {hidden:yes}
# view: dt1 {
#   derived_table: {
#     explore_source: event_classification_year_stats_dt {
#       column: event_classification {}
#       filters: {
#         field: event_classification_year_stats_dt.action_limit_exceeded
#         value: "Yes"
#       }
#       bind_filters: {
#         from_field: dt1.bind_filter
#         to_field: event_classification_year_stats_dt.date_created_year
#       }
#     }
#   }
#   filter: bind_filter {type:date default_value: "this year"}
#   dimension: event_classification {primary_key:yes}
#
#   measure: list_of_categories_for_link {
#     description: "A list of categories with action_limit_exceeded. Categories repeat."
#     type: string
#     sql: (SELECT STRING_AGG(CAST(${event_classification} AS VARCHAR(MAX)), ',')
#     WITHIN GROUP ( ORDER BY ${event_classification} ) from ${event_classification_year_stats_dt.SQL_TABLE_NAME}
#     wher ${event_classification_year_stats_dt.action_limit_exceeded} = 'Yes' and ${event_classification_year_stats_dt.date_created_year} = datepart(year,cast(getdate() AT TIME ZONE 'UTC' AT TIME ZONE {% parameter fact_deviations.timezone_selection %} as datetime2)) ) ;;
#     html: <a href="/dashboards/WBJNwY7xAFoFQwejYLdET3?Event%20Classification={{ value }}">{{ value }}</a>  ;;
#   }
# }

# Error: Circular dependency detected from derived table to source explore "fact_deviations".
# explore: extended_for_year {
#   hidden: yes
#   label: "Extended deviations for year metric"
#   view_name: fact_deviations
#   extends: [fact_deviations]
#   always_filter: {
#     filters: {
#       field: dt1.bind_filter
#       value: "this year"
#     }
#   }
#   join: dt1 {
#     sql_on: ${event_classification_year_stats_dt.event_classification} = ${dt1.event_classification} ;;
#     relationship: many_to_one
#   }
}




#
