- dashboard: dev_0_meter
  title: Dev_0_Meter
  layout: newspaper
  elements:
  - title: Area Occured of Deviation
    name: Area Occured of Deviation
    model: dev_0meter
    explore: fact_deviations
    type: looker_pie
    fields:
    - fact_deviations.count
    - vw_asset_to_area.asset
    filters:
      fact_deviations.deviation_key: '230,319,323'
    sorts:
    - fact_deviations.count desc
    limit: 500
    column_limit: 50
    value_labels: legend
    label_type: labPer
    show_value_labels: false
    font_size: 12
    stacking: ''
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: circle
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    colors: 'palette: Looker Classic'
    series_colors: {}
    listen:
      Batch: dim_lot_batch.lot_batch
      Event Area: dim_root_cause.root_cause_name
      Status: dim_deviation_status.deviation_status
      Root Cause Catagory: dim_root_cause.root_cause_category
      Customer: dim_customers.customer_name
      Asset: vw_asset_to_area.asset
      Dates: fact_deviations.date_created_date
      Business Sector: dim_bus_sec.bus_sec_name
      Site: dim_site.site_name
    row: 0
    col: 0
    width: 12
    height: 8
  - title: Deviations by Causal Factor
    name: Deviations by Causal Factor
    model: dev_0meter
    explore: fact_deviations
    type: looker_pie
    fields:
    - dim_causal.causal_name
    - fact_deviations.count
    filters:
      fact_deviations.deviation_key: '230,319,323'
    sorts:
    - dim_causal.causal_name
    limit: 500
    column_limit: 50
    value_labels: legend
    label_type: labPer
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: positron
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    map: auto
    map_projection: ''
    quantize_colors: false
    series_types: {}
    hide_legend: false
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    colors: 'palette: Looker Classic'
    series_colors: {}
    listen:
      Batch: dim_lot_batch.lot_batch
      Event Area: dim_root_cause.root_cause_name
      Status: dim_deviation_status.deviation_status
      Root Cause Catagory: dim_root_cause.root_cause_category
      Customer: dim_customers.customer_name
      Asset: vw_asset_to_area.asset
      Dates: fact_deviations.date_created_date
      Business Sector: dim_bus_sec.bus_sec_name
      Site: dim_site.site_name
    row: 14
    col: 0
    width: 12
    height: 8
  - title: Deviations Created Per Month
    name: Deviations Created Per Month
    model: dev_0meter
    explore: fact_deviations
    type: looker_column
    fields:
    - fact_deviations.count
    - fact_deviations.date_created_quarter
    - dim_event_classification.event_classification
    pivots:
    - dim_event_classification.event_classification
    filters:
      fact_deviations.deviation_key: '230,319,323'
      fact_deviations.count: NOT NULL
    sorts:
    - fact_deviations.date_created_quarter desc
    - dim_event_classification.event_classification
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: positron
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    value_labels: legend
    label_type: labPer
    show_null_points: true
    point_style: none
    interpolation: linear
    series_types:
      dim_site.monthly_deviation_goal1: line
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    hidden_fields: []
    series_labels:
      fact_deviations.count: Deviation Count
      dim_site.monthly_deviation_goal: Deviation Goal
    colors:
    - 'palette: Looker Classic'
    series_colors: {}
    y_axes:
    - label: ''
      maxValue:
      minValue:
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat: ''
      series:
      - id: fact_deviations.count
        name: Deviation Count
        __FILE: dev_o_meter/dev_0_meter.dashboard.lookml
        __LINE_NUM: 153
      - id: dim_site.monthly_deviation_goal1
        name: Monthly Deviation Goal1
        __FILE: dev_o_meter/dev_0_meter.dashboard.lookml
        __LINE_NUM: 155
      __FILE: dev_o_meter/dev_0_meter.dashboard.lookml
      __LINE_NUM: 141
    column_spacing_ratio:
    column_group_spacing_ratio:
    label_value_format: '0'
    listen:
      Batch: dim_lot_batch.lot_batch
      Event Area: dim_root_cause.root_cause_name
      Status: dim_deviation_status.deviation_status
      Root Cause Catagory: dim_root_cause.root_cause_category
      Customer: dim_customers.customer_name
      Asset: vw_asset_to_area.asset
      Dates: fact_deviations.date_created_date
      Business Sector: dim_bus_sec.bus_sec_name
      Site: dim_site.site_name
    row: 0
    col: 12
    width: 12
    height: 8
  - title: Deviations Grouped by Time Remaining
    name: Deviations Grouped by Time Remaining
    model: dev_0meter
    explore: fact_deviations
    type: looker_column
    fields:
    - fact_deviations.count
    - fact_deviations.days_remaining
    fill_fields:
    - fact_deviations.days_remaining
    filters:
      fact_deviations.date_closed_date: 'NULL'
      fact_deviations.deviation_key: '230,319,323'
    sorts:
    - fact_deviations.days_remaining
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: true
    label_density: 24
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: ordinal
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: false
    point_style: none
    interpolation: linear
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    focus_on_hover: true
    swap_axes: false
    reference_lines: []
    x_axis_label: ''
    series_types: {}
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    hide_legend: false
    listen:
      Batch: dim_lot_batch.lot_batch
      Event Area: dim_root_cause.root_cause_name
      Status: dim_deviation_status.deviation_status
      Root Cause Catagory: dim_root_cause.root_cause_category
      Customer: dim_customers.customer_name
      Asset: vw_asset_to_area.asset
      Dates: fact_deviations.date_created_date
      Business Sector: dim_bus_sec.bus_sec_name
      Site: dim_site.site_name
    row: 8
    col: 0
    width: 24
    height: 6
  - title: Age of Open Deviations by Causal Factor
    name: Age of Open Deviations by Causal Factor
    model: dev_0meter
    explore: fact_deviations
    type: looker_column
    fields:
    - fact_deviations.count
    - dim_causal.causal_name
    - fact_deviations.deviation_age_days
    pivots:
    - dim_causal.causal_name
    filters:
      fact_deviations.date_closed_date: 'NULL'
      fact_deviations.deviation_key: '230,319,323'
      fact_deviations.count: NOT NULL
    sorts:
    - dim_causal.causal_name 0
    - fact_deviations.deviation_age_days
    limit: 500
    column_limit: 50
    stacking: normal
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: true
    point_style: circle
    interpolation: linear
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    colors:
    - 'palette: Looker Classic'
    series_colors: {}
    listen:
      Batch: dim_lot_batch.lot_batch
      Event Area: dim_root_cause.root_cause_name
      Status: dim_deviation_status.deviation_status
      Root Cause Catagory: dim_root_cause.root_cause_category
      Customer: dim_customers.customer_name
      Asset: vw_asset_to_area.asset
      Dates: fact_deviations.date_created_date
      Business Sector: dim_bus_sec.bus_sec_name
      Site: dim_site.site_name
    row: 22
    col: 0
    width: 12
    height: 8
  - title: Causal Factor
    name: Causal Factor
    model: dev_0meter
    explore: fact_deviations
    type: looker_column
    fields:
    - dim_causal.causal_name
    - fact_deviations.count
    - dim_deviation_status.deviation_status
    pivots:
    - dim_deviation_status.deviation_status
    filters:
      fact_deviations.deviation_key: '230,319,323'
    sorts:
    - fact_deviations.count desc 0
    - dim_deviation_status.deviation_status
    limit: 500
    column_limit: 50
    row_total: right
    stacking: normal
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    value_labels: labels
    label_type: labPer
    show_null_points: true
    point_style: none
    interpolation: linear
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: positron
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    map: auto
    map_projection: ''
    quantize_colors: false
    series_types: {}
    hide_legend: false
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    colors:
    - 'palette: Looker Classic'
    series_colors: {}
    listen:
      Batch: dim_lot_batch.lot_batch
      Event Area: dim_root_cause.root_cause_name
      Status: dim_deviation_status.deviation_status
      Root Cause Catagory: dim_root_cause.root_cause_category
      Customer: dim_customers.customer_name
      Asset: vw_asset_to_area.asset
      Dates: fact_deviations.date_created_date
      Business Sector: dim_bus_sec.bus_sec_name
      Site: dim_site.site_name
    row: 14
    col: 12
    width: 12
    height: 8
  - title: Passed Due Date by Causal Factor (Closed Deviations)
    name: Passed Due Date by Causal Factor (Closed Deviations)
    model: dev_0meter
    explore: fact_deviations
    type: looker_column
    fields:
    - fact_deviations.closed_to_due_diff
    - fact_deviations.count
    - dim_causal.causal_name
    pivots:
    - dim_causal.causal_name
    filters:
      fact_deviations.closed_to_due_diff: "<0"
      fact_deviations.date_closed_date: NOT NULL
      fact_deviations.deviation_key: '230,319,323'
    sorts:
    - fact_deviations.closed_to_due_diff desc
    - dim_causal.causal_name 0
    limit: 500
    column_limit: 50
    stacking: normal
    show_value_labels: false
    label_density: 24
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: ordinal
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: false
    point_style: none
    interpolation: linear
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    focus_on_hover: true
    swap_axes: false
    reference_lines: []
    x_axis_label: "# of Days Difference Between Date Closed to Date Due"
    series_types: {}
    listen:
      Batch: dim_lot_batch.lot_batch
      Event Area: dim_root_cause.root_cause_name
      Status: dim_deviation_status.deviation_status
      Root Cause Catagory: dim_root_cause.root_cause_category
      Customer: dim_customers.customer_name
      Asset: vw_asset_to_area.asset
      Dates: fact_deviations.date_created_date
      Business Sector: dim_bus_sec.bus_sec_name
      Site: dim_site.site_name
    row: 22
    col: 12
    width: 12
    height: 8
  - title: Quality Impact
    name: Quality Impact
    model: dev_0meter
    explore: fact_deviations
    type: looker_column
    fields:
    - fact_deviations.quality_rating
    - dim_risk_category.risk_category_name
    - fact_deviations.count
    pivots:
    - fact_deviations.quality_rating
    filters:
      fact_deviations.date_closed_date: 'NULL'
      fact_deviations.deviation_key: '230'
    sorts:
    - fact_deviations.count desc 4
    - fact_deviations.quality_rating 0
    limit: 500
    column_limit: 50
    row_total: right
    stacking: normal
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    conditional_formatting: []
    series_types: {}
    colors:
    - 'palette: Looker Classic'
    series_colors: {}
    listen:
      Batch: dim_lot_batch.lot_batch
      Event Area: dim_root_cause.root_cause_name
      Status: dim_deviation_status.deviation_status
      Root Cause Catagory: dim_root_cause.root_cause_category
      Customer: dim_customers.customer_name
      Asset: vw_asset_to_area.asset
      Dates: fact_deviations.date_created_date
      Business Sector: dim_bus_sec.bus_sec_name
      Site: dim_site.site_name
    row: 38
    col: 0
    width: 8
    height: 8
  - title: Deviations by Root Cause Category
    name: Deviations by Root Cause Category
    model: dev_0meter
    explore: fact_deviations
    type: looker_column
    fields:
    - fact_deviations.count
    - dim_root_cause.root_cause_category
    - dim_site.site_name
    pivots:
    - dim_site.site_name
    filters:
      fact_deviations.deviation_key: '230,323,319'
    sorts:
    - fact_deviations.count desc 11
    - dim_site.site_name 0
    limit: 500
    column_limit: 50
    row_total: right
    stacking: normal
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    listen:
      Batch: dim_lot_batch.lot_batch
      Event Area: dim_root_cause.root_cause_name
      Status: dim_deviation_status.deviation_status
      Root Cause Catagory: dim_root_cause.root_cause_category
      Customer: dim_customers.customer_name
      Asset: vw_asset_to_area.asset
      Dates: fact_deviations.date_created_date
      Business Sector: dim_bus_sec.bus_sec_name
      Site: dim_site.site_name
    row: 30
    col: 0
    width: 24
    height: 8
  - title: Age of Open Deviations by Risk Factor
    name: Age of Open Deviations by Risk Factor
    model: dev_0meter
    explore: fact_deviations
    type: looker_column
    fields:
    - dim_risk_category.risk_category_name
    - fact_deviations.count
    - fact_deviations.deviation_age_days
    pivots:
    - dim_risk_category.risk_category_name
    filters:
      fact_deviations.date_closed_date: 'NULL'
      fact_deviations.deviation_key: '230'
      fact_deviations.count: NOT NULL
    sorts:
    - dim_risk_category.risk_category_name 0
    - fact_deviations.deviation_age_tier
    limit: 500
    column_limit: 50
    stacking: normal
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: true
    point_style: circle
    interpolation: linear
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    colors:
    - 'palette: Looker Classic'
    series_colors: {}
    listen:
      Batch: dim_lot_batch.lot_batch
      Event Area: dim_root_cause.root_cause_name
      Status: dim_deviation_status.deviation_status
      Root Cause Catagory: dim_root_cause.root_cause_category
      Customer: dim_customers.customer_name
      Asset: vw_asset_to_area.asset
      Dates: fact_deviations.date_created_date
      Business Sector: dim_bus_sec.bus_sec_name
      Site: dim_site.site_name
    row: 38
    col: 16
    width: 8
    height: 8
  - title: Age of Open Deviations by Quality Rating
    name: Age of Open Deviations by Quality Rating
    model: dev_0meter
    explore: fact_deviations
    type: looker_column
    fields:
    - fact_deviations.count
    - fact_deviations.quality_rating
    - fact_deviations.deviation_age_days
    pivots:
    - fact_deviations.quality_rating
    filters:
      fact_deviations.date_closed_date: 'NULL'
      fact_deviations.deviation_key: '230'
      fact_deviations.count: NOT NULL
    sorts:
    - fact_deviations.quality_rating 0
    - fact_deviations.deviation_age_tier
    limit: 500
    column_limit: 50
    stacking: normal
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: true
    point_style: circle
    interpolation: linear
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    colors:
    - 'palette: Looker Classic'
    series_colors: {}
    listen:
      Batch: dim_lot_batch.lot_batch
      Event Area: dim_root_cause.root_cause_name
      Status: dim_deviation_status.deviation_status
      Root Cause Catagory: dim_root_cause.root_cause_category
      Customer: dim_customers.customer_name
      Asset: vw_asset_to_area.asset
      Dates: fact_deviations.date_created_date
      Business Sector: dim_bus_sec.bus_sec_name
      Site: dim_site.site_name
    row: 38
    col: 8
    width: 8
    height: 8
  - title: Passed Due Date by Quality Rating (Closed Deviations)
    name: Passed Due Date by Quality Rating (Closed Deviations)
    model: dev_0meter
    explore: fact_deviations
    type: looker_column
    fields:
    - fact_deviations.closed_to_due_diff
    - fact_deviations.count
    - fact_deviations.quality_rating
    pivots:
    - fact_deviations.quality_rating
    filters:
      fact_deviations.closed_to_due_diff: "<0"
      fact_deviations.date_closed_date: NOT NULL
      fact_deviations.deviation_key: '230'
    sorts:
    - fact_deviations.closed_to_due_diff desc
    - fact_deviations.quality_rating 0
    limit: 500
    column_limit: 50
    stacking: normal
    show_value_labels: false
    label_density: 24
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: ordinal
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: false
    point_style: none
    interpolation: linear
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    focus_on_hover: true
    swap_axes: false
    reference_lines: []
    x_axis_label: "# of Days Difference Between Date Closed to Date Due"
    series_types: {}
    listen:
      Batch: dim_lot_batch.lot_batch
      Event Area: dim_root_cause.root_cause_name
      Status: dim_deviation_status.deviation_status
      Root Cause Catagory: dim_root_cause.root_cause_category
      Customer: dim_customers.customer_name
      Asset: vw_asset_to_area.asset
      Dates: fact_deviations.date_created_date
      Business Sector: dim_bus_sec.bus_sec_name
      Site: dim_site.site_name
    row: 46
    col: 12
    width: 12
    height: 10
  - title: Passed Due Date by Risk Factor (Closed Deviations)
    name: Passed Due Date by Risk Factor (Closed Deviations)
    model: dev_0meter
    explore: fact_deviations
    type: looker_column
    fields:
    - fact_deviations.closed_to_due_diff
    - fact_deviations.count
    - dim_risk_category.risk_category_name
    pivots:
    - dim_risk_category.risk_category_name
    filters:
      fact_deviations.closed_to_due_diff: "<0"
      fact_deviations.date_closed_date: NOT NULL
      fact_deviations.deviation_key: '230'
    sorts:
    - fact_deviations.closed_to_due_diff desc
    - dim_risk_category.risk_category_name 0
    limit: 500
    column_limit: 50
    stacking: normal
    show_value_labels: false
    label_density: 24
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: ordinal
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: false
    point_style: none
    interpolation: linear
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    focus_on_hover: true
    swap_axes: false
    reference_lines: []
    x_axis_label: "# of Days Difference Between Date Closed to Date Due"
    series_types: {}
    listen:
      Batch: dim_lot_batch.lot_batch
      Event Area: dim_root_cause.root_cause_name
      Status: dim_deviation_status.deviation_status
      Root Cause Catagory: dim_root_cause.root_cause_category
      Customer: dim_customers.customer_name
      Asset: vw_asset_to_area.asset
      Dates: fact_deviations.date_created_date
      Business Sector: dim_bus_sec.bus_sec_name
      Site: dim_site.site_name
    row: 46
    col: 0
    width: 12
    height: 10
  - title: Operating Performance
    name: Operating Performance
    model: dev_0meter
    explore: fact_deviations
    type: table
    fields:
    - fact_deviations.count
    - fact_deviations.count_closed
    - dim_risk_category.risk_category_name
    - fact_deviations.quality_rating
    pivots:
    - dim_risk_category.risk_category_name
    filters:
      fact_deviations.deviation_key: '319,323,230'
    sorts:
    - dim_risk_category.risk_category_name desc 0
    - fact_deviations.count desc 0
    limit: 500
    column_limit: 50
    dynamic_fields:
    - table_calculation: of_open_deviations
      label: "# of Open Deviations"
      expression: "${fact_deviations.count_closed}-${fact_deviations.count}"
      value_format:
      value_format_name:
      _kind_hint: measure
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    conditional_formatting_ignored_fields:
    - fact_deviations.count_closed
    - fact_deviations.count
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: true
    barColors:
    - red
    - blue
    labelSize: 10pt
    leftAxisLabelVisible: false
    leftAxisLabel: ''
    rightAxisLabelVisible: false
    rightAxisLabel: ''
    smoothedBars: false
    orientation: automatic
    labelPosition: left
    percentType: total
    percentPosition: inline
    valuePosition: right
    labelColorEnabled: false
    labelColor: "#FFF"
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    conditional_formatting:
    - type: less than
      value: -5
      background_color: "#fc6c58"
      font_color:
      palette:
        name: Red to Yellow to Green
        colors:
        - "#F36254"
        - "#FCF758"
        - "#4FBC89"
        __FILE: dev_o_meter/dev_0_meter.dashboard.lookml
        __LINE_NUM: 994
      bold: false
      italic: false
      strikethrough: false
      __FILE: dev_o_meter/dev_0_meter.dashboard.lookml
      __LINE_NUM: 989
    - type: between
      value:
      - -6
      - 0
      background_color: "#f2ec24"
      font_color:
      palette:
        name: Red to Yellow to Green
        colors:
        - "#F36254"
        - "#FCF758"
        - "#4FBC89"
        __FILE: dev_o_meter/dev_0_meter.dashboard.lookml
        __LINE_NUM: 1009
      bold: false
      italic: false
      strikethrough: false
      __FILE: dev_o_meter/dev_0_meter.dashboard.lookml
      __LINE_NUM: 1002
    - type: equal to
      value: 0
      background_color: "#58fc7c"
      font_color:
      palette:
        name: Red to Yellow to Green
        colors:
        - "#F36254"
        - "#FCF758"
        - "#4FBC89"
        __FILE: dev_o_meter/dev_0_meter.dashboard.lookml
        __LINE_NUM: 1022
      bold: false
      italic: false
      strikethrough: false
      __FILE: dev_o_meter/dev_0_meter.dashboard.lookml
      __LINE_NUM: 1017
    - type: 'null'
      value:
      background_color: "#58fc7c"
      font_color:
      palette:
        name: Red to Yellow to Green
        colors:
        - "#F36254"
        - "#FCF758"
        - "#4FBC89"
        __FILE: dev_o_meter/dev_0_meter.dashboard.lookml
        __LINE_NUM: 1035
      bold: false
      italic: false
      strikethrough: false
      __FILE: dev_o_meter/dev_0_meter.dashboard.lookml
      __LINE_NUM: 1030
    series_labels:
      fact_deviations.count: "# of Deviations"
      fact_deviations.count_closed: "# of Closed Deviations"
    listen:
      Batch: dim_lot_batch.lot_batch
      Event Area: dim_root_cause.root_cause_name
      Status: dim_deviation_status.deviation_status
      Root Cause Catagory: dim_root_cause.root_cause_category
      Customer: dim_customers.customer_name
      Asset: vw_asset_to_area.asset
      Dates: fact_deviations.date_created_date
      Business Sector: dim_bus_sec.bus_sec_name
      Site: dim_site.site_name
    row: 56
    col: 0
    width: 24
    height: 8
  filters:
  - name: Batch
    title: Batch
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: dev_0meter
    explore: fact_deviations
    listens_to_filters: []
    field: dim_lot_batch.lot_batch
  - name: Event Area
    title: Event Area
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: dev_0meter
    explore: fact_deviations
    listens_to_filters: []
    field: alert_limit_check.event_area
  - name: Status
    title: Status
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: dev_0meter
    explore: fact_deviations
    listens_to_filters: []
    field: dim_deviation_status.deviation_status
  - name: Root Cause Catagory
    title: Root Cause Catagory
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: dev_0meter
    explore: fact_deviations
    listens_to_filters: []
    field: dim_root_cause.root_cause_category
  - name: Customer
    title: Customer
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: dev_0meter
    explore: fact_deviations
    listens_to_filters: []
    field: dim_customers.customer_name
  - name: Asset
    title: Asset
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: dev_0meter
    explore: fact_deviations
    listens_to_filters: []
    field: vw_asset_to_area.asset
  - name: Dates
    title: Dates
    type: field_filter
    default_value: this year
    allow_multiple_values: true
    required: false
    model: dev_0meter
    explore: fact_deviations
    listens_to_filters: []
    field: fact_deviations.date_created_date
  - name: Business Sector
    title: Business Sector
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: dev_0meter
    explore: fact_deviations
    listens_to_filters: []
    field: dim_bus_sec.bus_sec_name
  - name: Site
    title: Site
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: dev_0meter
    explore: fact_deviations
    listens_to_filters: []
    field: dim_site.site_name
