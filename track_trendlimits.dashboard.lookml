
# - dashboard: track__trend_limits
#   title: Track & Trend Limits
#   layout: newspaper
#   elements:
#   - title: Alerts and Action Limits
#     name: Alerts and Action Limits
#     model: dev_0meter
#     explore: fact_deviations
#     type: table
#     fields:
#     - dim_site.site_name
#     - dim_bus_sec.bus_sec_name
#     - dim_event_classification.event_area
#     - dim_event_classification.event_classification
#     - dim_event_classification.Action_Limit
#     - dim_event_classification.Alert_Limit
#     - dim_event_classification.effective_year
#     filters:
#       dim_event_classification.event_area: "-NULL"
#       fact_deviations.deviation_key: ''
#     sorts:
#     - dim_bus_sec.bus_sec_name
#     limit: 500
#     show_view_names: false
#     show_row_numbers: true
#     truncate_column_names: false
#     hide_totals: false
#     hide_row_totals: false
#     table_theme: transparent
#     limit_displayed_rows: false
#     enable_conditional_formatting: false
#     conditional_formatting_ignored_fields: []
#     conditional_formatting_include_totals: false
#     conditional_formatting_include_nulls: false
#     series_labels:
#       fact_deviations.count: 2017 Deviations
#     listen:
#       Site: dim_site.site_name
#       Business Sector: dim_bus_sec.bus_sec_name
#       Dates: dim_event_classification.effective_year
#     row: 0
#     col: 0
#     width: 24
#     height: 21
#   filters:
#   - name: Site
#     title: Site
#     type: field_filter
#     default_value: ''
#     allow_multiple_values: true
#     required: false
#     model: dev_0meter
#     explore: fact_deviations
#     listens_to_filters: []
#     field: dim_site.site_name
#   - name: Business Sector
#     title: Business Sector
#     type: field_filter
#     default_value: ''
#     allow_multiple_values: true
#     required: false
#     model: dev_0meter
#     explore: fact_deviations
#     listens_to_filters: []
#     field: dim_bus_sec.bus_sec_name
#   - name: Dates
#     title: Dates
#     type: field_filter
#     default_value: this year
#     allow_multiple_values: true
#     required: false
#     model: dev_0meter
#     explore: fact_deviations
#     listens_to_filters: []
#     field: dim_event_classification.effective_year
