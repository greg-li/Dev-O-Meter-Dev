view: annual_fact_deviations_ndt_2 {
  derived_table: {
    explore_source: fact_deviations {
      column: baseline_year { field: fact_deviations.date_created_year }
      column: annual_deviations { field: fact_deviations.count }
      column: site_name { field: dim_site.site_name }
      column: master { field: asset_mapping_excel.master }
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
      filters: {
        field: asset_mapping_excel.master
        value: ""
      }
    }
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

  dimension: master {
    label: "Function / Asset Filter Asset - Function"
  }
}
