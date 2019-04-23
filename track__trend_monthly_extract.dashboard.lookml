# - dashboard: track__trend_monthly_extract
#   title: Track & Trend Monthly Extract
#   layout: newspaper
#   elements:
#   - title: Above Alert Limit
#     name: Above Alert Limit
#     model: dev_0meter
#     explore: fact_deviations
#     type: table
#     fields:
#     - dim_event_classification.event_area
#     - dim_event_classification.event_classification
#     - dim_event_classification.Alert_Limit
#     - fact_deviations.count_event
#     - fact_deviations.count
#     filters:
#       fact_deviations.deviation_key: '230,319,323'
#     sorts:
#     - dim_event_classification.event_area
#     limit: 1500
#     column_limit: 50
#     dynamic_fields:
#     - table_calculation: alert_limit_hit
#       label: Alert Limit Hit
#       expression: "${fact_deviations.count}>${dim_event_classification.Alert_Limit}"
#       value_format:
#       value_format_name:
#       _kind_hint: measure
#       _type_hint: yesno
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
#     stacking: ''
#     show_value_labels: false
#     label_density: 25
#     legend_position: center
#     x_axis_gridlines: false
#     y_axis_gridlines: true
#     y_axis_combined: true
#     show_y_axis_labels: true
#     show_y_axis_ticks: true
#     y_axis_tick_density: default
#     y_axis_tick_density_custom: 5
#     show_x_axis_label: true
#     show_x_axis_ticks: true
#     x_axis_scale: auto
#     y_axis_scale_mode: linear
#     ordering: none
#     show_null_labels: false
#     show_totals_labels: false
#     show_silhouette: false
#     totals_color: "#808080"
#     series_types: {}
#     hidden_fields:
#     - fact_deviations.count
#     - alert_limit_hit
#     hidden_points_if_no:
#     - alert_limit_hit
#     listen:
#       Site: dim_site.site_name
#       start date: fact_deviations.date_created_date
#       Event Type: dim_event_classification.event_classification
#       Status: dim_deviation_status.deviation_status
#       Bus Sec: dim_bus_sec.bus_sec_name
#     row: 0
#     col: 0
#     width: 12
#     height: 5
#   - title: Above Action Limit
#     name: Above Action Limit
#     model: dev_0meter
#     explore: fact_deviations
#     type: table
#     fields:
#     - dim_event_classification.event_area
#     - dim_event_classification.event_classification
#     - dim_event_classification.action_limit
#     - fact_deviations.action_count
#     - fact_deviations.count
#     filters:
#       dim_event_classification.event_class_key: NOT NULL
#       fact_deviations.deviation_key: '230,323,319'
#     sorts:
#     - fact_deviations.action_count desc
#     limit: 500
#     column_limit: 50
#     dynamic_fields:
#     - table_calculation: action_limit_hit
#       label: Action Limit Hit
#       expression: "${fact_deviations.count}>${dim_event_classification.action_limit}"
#       value_format:
#       value_format_name:
#       _kind_hint: measure
#       _type_hint: yesno
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
#     stacking: ''
#     show_value_labels: false
#     label_density: 25
#     legend_position: center
#     x_axis_gridlines: false
#     y_axis_gridlines: true
#     y_axis_combined: true
#     show_y_axis_labels: true
#     show_y_axis_ticks: true
#     y_axis_tick_density: default
#     y_axis_tick_density_custom: 5
#     show_x_axis_label: true
#     show_x_axis_ticks: true
#     x_axis_scale: auto
#     y_axis_scale_mode: linear
#     ordering: none
#     show_null_labels: false
#     show_totals_labels: false
#     show_silhouette: false
#     totals_color: "#808080"
#     series_types: {}
#     hidden_points_if_no:
#     - action_limit_hit
#     hidden_fields:
#     - fact_deviations.count
#     - action_limit_hit
#     listen:
#       Site: dim_site.site_name
#       Event Type: dim_event_classification.event_classification
#       Status: dim_deviation_status.deviation_status
#       Bus Sec: dim_bus_sec.bus_sec_name
#       Year: fact_deviations.date_created_year
#     row: 0
#     col: 12
#     width: 12
#     height: 5
#   - title: Deviation Detail
#     name: Deviation Detail
#     model: dev_0meter
#     explore: fact_deviations
#     type: table
#     fields:
#     - dim_site.site_name
#     - dim_bus_sec.bus_sec_name
#     - fact_deviations.parent_record_id
#     - fact_deviations.short_description
#     - area_occured.area_name
#     - dim_customers.customer_name
#     - dim_lot_batch.lot_batch
#     - dim_event_classification.event_area
#     - dim_event_classification.event_classification
#     - dim_risk_category.risk_category_name
#     - fact_deviations.quality_rating
#     - dim_deviation_status.deviation_status
#     - dim_event_classification.Alert_Limit
#     - alert_limit_check.alert_flag
#     - fact_deviations.date_created_month
#     filters:
#       alert_limit_check.alert_flag: 'Yes'
#       fact_deviations.deviation_key: '230,319,323'
#     sorts:
#     - dim_event_classification.event_classification
#     limit: 500
#     show_view_names: false
#     show_row_numbers: true
#     truncate_column_names: true
#     hide_totals: false
#     hide_row_totals: false
#     table_theme: transparent
#     limit_displayed_rows: false
#     enable_conditional_formatting: false
#     conditional_formatting_ignored_fields: []
#     conditional_formatting_include_totals: false
#     conditional_formatting_include_nulls: false
#     stacking: ''
#     show_value_labels: false
#     label_density: 25
#     legend_position: center
#     x_axis_gridlines: false
#     y_axis_gridlines: true
#     y_axis_combined: true
#     show_y_axis_labels: true
#     show_y_axis_ticks: true
#     y_axis_tick_density: default
#     y_axis_tick_density_custom: 5
#     show_x_axis_label: true
#     show_x_axis_ticks: true
#     x_axis_scale: auto
#     y_axis_scale_mode: linear
#     ordering: none
#     show_null_labels: false
#     show_totals_labels: false
#     show_silhouette: false
#     totals_color: "#808080"
#     series_types: {}
#     hidden_fields:
#     - dim_event_classification.Alert_Limit
#     - alert_limit_check.alert_flag
#     hidden_points_if_no:
#     - alert_limit_check.alert_flag
#     listen:
#       Site: dim_site.site_name
#       start date: fact_deviations.date_created_date
#       Event Type: dim_event_classification.event_classification
#       Status: dim_deviation_status.deviation_status
#       Bus Sec: dim_bus_sec.bus_sec_name
#     row: 16
#     col: 0
#     width: 24
#     height: 37
#   - title: Category Limits and Counts by Month
#     name: Category Limits and Counts by Month
#     model: dev_0meter
#     explore: fact_deviations
#     type: table
#     fields:
#     - dim_event_classification.event_classification
#     - fact_deviations.date_created_month
#     - dim_event_classification.action_limit
#     - dim_event_classification.Alert_Limit
#     - fact_deviations.count_event
#     pivots:
#     - fact_deviations.date_created_month
#     fill_fields:
#     - fact_deviations.date_created_month
#     filters:
#       fact_deviations.deviation_key: '230,319,323'
#     sorts:
#     - fact_deviations.date_created_month 0
#     - dim_event_classification.event_classification desc
#     limit: 500
#     show_view_names: false
#     show_row_numbers: true
#     truncate_column_names: false
#     hide_totals: false
#     hide_row_totals: false
#     table_theme: white
#     limit_displayed_rows: false
#     enable_conditional_formatting: false
#     conditional_formatting_ignored_fields: []
#     conditional_formatting_include_totals: false
#     conditional_formatting_include_nulls: false
#     stacking: ''
#     show_value_labels: false
#     label_density: 25
#     legend_position: center
#     x_axis_gridlines: false
#     y_axis_gridlines: true
#     y_axis_combined: true
#     show_y_axis_labels: true
#     show_y_axis_ticks: true
#     y_axis_tick_density: default
#     y_axis_tick_density_custom: 5
#     show_x_axis_label: true
#     show_x_axis_ticks: true
#     x_axis_scale: auto
#     y_axis_scale_mode: linear
#     ordering: none
#     show_null_labels: false
#     show_totals_labels: false
#     show_silhouette: false
#     totals_color: "#808080"
#     series_types: {}
#     conditional_formatting:
#     - type: greater than
#       value:
#       background_color:
#       font_color:
#       palette:
#         name: Red to Yellow to Green
#         colors:
#         - "#F36254"
#         - "#FCF758"
#         - "#4FBC89"
#         __FILE: dev_o_meter/track__trend_monthly_extract.dashboard.lookml
#         __LINE_NUM: 65
#       bold: false
#       italic: false
#       strikethrough: false
#       __FILE: dev_o_meter/track__trend_monthly_extract.dashboard.lookml
#       __LINE_NUM: 60
#     - type: low to high
#       value:
#       background_color:
#       font_color:
#       palette:
#         name: Red to Yellow to Green
#         colors:
#         - "#F36254"
#         - "#FCF758"
#         - "#4FBC89"
#         __FILE: dev_o_meter/track__trend_monthly_extract.dashboard.lookml
#         __LINE_NUM: 78
#       bold: false
#       italic: false
#       strikethrough: false
#       __FILE: dev_o_meter/track__trend_monthly_extract.dashboard.lookml
#       __LINE_NUM: 73
#     listen:
#       Site: dim_site.site_name
#       Event Type: dim_event_classification.event_classification
#       Status: dim_deviation_status.deviation_status
#       Bus Sec: dim_bus_sec.bus_sec_name
#       Year: fact_deviations.date_created_year
#     row: 5
#     col: 0
#     width: 18
#     height: 11
#   - title: Total Events
#     name: Total Events
#     model: dev_0meter
#     explore: fact_deviations
#     type: table
#     fields:
#     - dim_event_classification.event_classification
#     - dim_event_classification.action_limit
#     - fact_deviations.action_count
#     - fact_deviations.date_created_year
#     pivots:
#     - fact_deviations.date_created_year
#     fill_fields:
#     - fact_deviations.date_created_year
#     filters:
#       dim_event_classification.event_classification: "-N/A"
#       fact_deviations.deviation_key: '230'
#       dim_deviation_status.deviation_status: "-Closed - Cancelled"
#     sorts:
#     - dim_event_classification.event_classification desc
#     - fact_deviations.date_created_year
#     limit: 500
#     column_limit: 50
#     show_view_names: false
#     show_row_numbers: true
#     truncate_column_names: false
#     hide_totals: false
#     hide_row_totals: false
#     table_theme: white
#     limit_displayed_rows: false
#     enable_conditional_formatting: false
#     conditional_formatting_ignored_fields: []
#     conditional_formatting_include_totals: false
#     conditional_formatting_include_nulls: false
#     stacking: ''
#     show_value_labels: false
#     label_density: 25
#     legend_position: center
#     x_axis_gridlines: false
#     y_axis_gridlines: true
#     y_axis_combined: true
#     show_y_axis_labels: true
#     show_y_axis_ticks: true
#     y_axis_tick_density: default
#     y_axis_tick_density_custom: 5
#     show_x_axis_label: true
#     show_x_axis_ticks: true
#     x_axis_scale: auto
#     y_axis_scale_mode: linear
#     ordering: none
#     show_null_labels: false
#     show_totals_labels: false
#     show_silhouette: false
#     totals_color: "#808080"
#     series_types: {}
#     conditional_formatting:
#     - type: greater than
#       value:
#       background_color:
#       font_color:
#       palette:
#         name: Red to Yellow to Green
#         colors:
#         - "#F36254"
#         - "#FCF758"
#         - "#4FBC89"
#         __FILE: dev_o_meter/track__trend_monthly_extract.dashboard.lookml
#         __LINE_NUM: 381
#       bold: false
#       italic: false
#       strikethrough: false
#       __FILE: dev_o_meter/track__trend_monthly_extract.dashboard.lookml
#       __LINE_NUM: 376
#     - type: low to high
#       value:
#       background_color:
#       font_color:
#       palette:
#         name: Red to Yellow to Green
#         colors:
#         - "#F36254"
#         - "#FCF758"
#         - "#4FBC89"
#         __FILE: dev_o_meter/track__trend_monthly_extract.dashboard.lookml
#         __LINE_NUM: 394
#       bold: false
#       italic: false
#       strikethrough: false
#       __FILE: dev_o_meter/track__trend_monthly_extract.dashboard.lookml
#       __LINE_NUM: 389
#     listen:
#       Site: dim_site.site_name
#       Bus Sec: dim_bus_sec.bus_sec_name
#       Year: fact_deviations.date_created_year
#     row: 5
#     col: 18
#     width: 6
#     height: 11
#   filters:
#   - name: Site
#     title: Site
#     type: field_filter
#     default_value: Portsmouth
#     allow_multiple_values: true
#     required: false
#     model: dev_0meter
#     explore: fact_deviations
#     listens_to_filters:
#     - Event Classification
#     field: dim_site.site_name
#   - name: start date
#     title: start date
#     type: field_filter
#     default_value: 1 months ago for 1 months
#     allow_multiple_values: true
#     required: false
#     model: dev_0meter
#     explore: fact_deviations
#     listens_to_filters: []
#     field: fact_deviations.date_created_date
#   - name: Event Type
#     title: Event Type
#     type: field_filter
#     default_value: "-N/A"
#     allow_multiple_values: true
#     required: false
#     model: dev_0meter
#     explore: fact_deviations
#     listens_to_filters: []
#     field: dim_event_classification.event_classification
#   - name: Status
#     title: Status
#     type: field_filter
#     default_value: "-Closed - Cancelled"
#     allow_multiple_values: true
#     required: false
#     model: dev_0meter
#     explore: fact_deviations
#     listens_to_filters: []
#     field: dim_deviation_status.deviation_status
#   - name: Bus Sec
#     title: Bus Sec
#     type: field_filter
#     default_value: LPB Portsmouth MM
#     allow_multiple_values: true
#     required: false
#     model: dev_0meter
#     explore: fact_deviations
#     listens_to_filters: []
#     field: dim_bus_sec.bus_sec_name
#   - name: Year
#     title: Year
#     type: field_filter
#     default_value: this year
#     allow_multiple_values: true
#     required: false
#     model: dev_0meter
#     explore: fact_deviations
#     listens_to_filters: []
#     field: fact_deviations.date_created_year
