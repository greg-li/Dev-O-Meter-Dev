view: annual_fact_deviations {
  derived_table: {
    explore_source: fact_deviations {
      column: baseline_year { field: fact_deviations.date_created_year }
      column: annual_deviations { field: fact_deviations.count }
      column: site_name { field: dim_site.site_name }
      filters: {
        field: fact_deviations.timezone_selection
        value: "Eastern Standard Time"
      }
      filters: {
        field: dim_deviation_type.deviation_type
        value: "Customer Complaint - Packaging and shipping complaints,Customer Complaint - Product quality complaints,Unplanned"
      }
      filters: {
        field: dim_site.site_name
        value: ""
      }
    }
  }

  dimension: pk {
    hidden: yes
    primary_key: yes
    sql: CONCAT(${baseline_year}, ${site_name})  ;;
  }

  dimension: baseline_year {
    type: date_time
  }

  dimension: annual_deviations {
    label: "Annual Deviations"
    type: number
  }

  dimension: site_name {
    label: "Site Name"
  }
}
