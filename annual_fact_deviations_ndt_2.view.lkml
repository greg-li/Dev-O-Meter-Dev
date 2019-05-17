view: annual_fact_deviations_ndt_2 {
  derived_table: {
    explore_source: fact_deviations {
      column: date_created_year {}
      column: count {}
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
  dimension: date_created_year {
    label: " Deviations  Created Year"
    type: date_year
  }
  dimension: count {
    label: " Deviations Count of Deviations"
    type: number
  }
  dimension: site_name {
    label: "Site Site Name"
  }
  dimension: master {
    label: "Function / Asset Filter Asset - Function"
  }
}
