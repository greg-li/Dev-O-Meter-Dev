- dashboard: devtrending
  title: Dev-Trending
  layout: newspaper
  elements:
  - title: Deviations by Month
    name: Deviations by Month
    model: dev_0meter
    explore: fact_deviations
    type: looker_line
    fields:
    - fact_deviations.date_created_month
    - fact_deviations.count
    filters:
      fact_deviations.deviation_key: '230,323,319'
      fact_deviations.count: NOT NULL
    sorts:
    - fact_deviations.date_created_month desc
    limit: 500
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
    show_null_points: true
    point_style: none
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    trend_lines: []
    listen:
      Site: dim_site.site_name
      Status: dim_deviation_status.deviation_status
      Asset: vw_asset_to_area.asset
      Root Category: dim_root_cause.root_cause_category
      Causal Factor: dim_causal.causal_name
      Event Area: alert_limit_check.event_area
      Batch: dim_lot_batch.lot_batch
      Customer: dim_customer.customer_name
      Event Classification: alert_limit_check.event_classification
      Area Where Occurred: area_occured.area_name
      Business Sector Unit: dim_bus_sec.bus_sec_name
      Quality Impact Rating: fact_deviations.quality_rating
      Dates: fact_deviations.date_created_date
    row: 0
    col: 8
    width: 16
    height: 6
  - title: Deviations
    name: Deviations
    model: dev_0meter
    explore: fact_deviations
    type: single_value
    fields:
    - fact_deviations.count
    filters:
      fact_deviations.deviation_key: '230,323,319'
    limit: 500
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    stacking: ''
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
    series_types: {}
    listen:
      Site: dim_site.site_name
      Status: dim_deviation_status.deviation_status
      Asset: vw_asset_to_area.asset
      Root Category: dim_root_cause.root_cause_category
      Causal Factor: dim_causal.causal_name
      Event Area: alert_limit_check.event_area
      Batch: dim_lot_batch.lot_batch
      Customer: dim_customer.customer_name
      Event Classification: alert_limit_check.event_classification
      Area Where Occurred: area_occured.area_name
      Business Sector Unit: dim_bus_sec.bus_sec_name
      Quality Impact Rating: fact_deviations.quality_rating
      Dates: fact_deviations.date_created_date
    row: 0
    col: 0
    width: 8
    height: 6
  - title: Deviations by Risk Factor
    name: Deviations by Risk Factor
    model: dev_0meter
    explore: fact_deviations
    type: looker_column
    fields:
    - dim_risk_category.risk_category_name
    - fact_deviations.count
    - fact_deviations.date_created_month
    pivots:
    - fact_deviations.date_created_month
    filters:
      fact_deviations.deviation_key: '230,319,323'
      fact_deviations.count: NOT NULL
    sorts:
    - dim_risk_category.risk_category_name 0
    - fact_deviations.date_created_month
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
    show_totals_labels: true
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
    column_spacing_ratio:
    listen:
      Site: dim_site.site_name
      Status: dim_deviation_status.deviation_status
      Asset: vw_asset_to_area.asset
      Root Category: dim_root_cause.root_cause_category
      Causal Factor: dim_causal.causal_name
      Event Area: alert_limit_check.event_area
      Batch: dim_lot_batch.lot_batch
      Customer: dim_customer.customer_name
      Event Classification: alert_limit_check.event_classification
      Area Where Occurred: area_occured.area_name
      Business Sector Unit: dim_bus_sec.bus_sec_name
      Quality Impact Rating: fact_deviations.quality_rating
      Dates: fact_deviations.date_created_year
    row: 6
    col: 6
    width: 9
    height: 8
  - title: Quality and Risk
    name: Quality and Risk
    model: dev_0meter
    explore: fact_deviations
    type: looker_donut_multiples
    fields:
    - dim_risk_category.risk_category_name
    - fact_deviations.quality_rating
    - fact_deviations.count
    pivots:
    - fact_deviations.quality_rating
    filters:
      fact_deviations.deviation_key: '230,319,323'
    sorts:
    - dim_risk_category.risk_category_name
    - fact_deviations.quality_rating
    limit: 500
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    listen:
      Site: dim_site.site_name
      Status: dim_deviation_status.deviation_status
      Asset: vw_asset_to_area.asset
      Root Category: dim_root_cause.root_cause_category
      Causal Factor: dim_causal.causal_name
      Event Area: alert_limit_check.event_area
      Batch: dim_lot_batch.lot_batch
      Customer: dim_customer.customer_name
      Event Classification: alert_limit_check.event_classification
      Area Where Occurred: area_occured.area_name
      Business Sector Unit: dim_bus_sec.bus_sec_name
      Quality Impact Rating: fact_deviations.quality_rating
      Dates: fact_deviations.date_created_date
    row: 6
    col: 0
    width: 6
    height: 8
  - title: Deviations by Quality Rating
    name: Deviations by Quality Rating
    model: dev_0meter
    explore: fact_deviations
    type: looker_column
    fields:
    - fact_deviations.quality_rating
    - fact_deviations.date_created_month
    - fact_deviations.count
    pivots:
    - fact_deviations.date_created_month
    fill_fields:
    - fact_deviations.date_created_month
    filters:
      fact_deviations.deviation_key: '230,323,319'
    sorts:
    - fact_deviations.quality_rating 0
    - fact_deviations.date_created_month
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
    show_totals_labels: true
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
      Site: dim_site.site_name
      Status: dim_deviation_status.deviation_status
      Asset: vw_asset_to_area.asset
      Root Category: dim_root_cause.root_cause_category
      Causal Factor: dim_causal.causal_name
      Event Area: alert_limit_check.event_area
      Batch: dim_lot_batch.lot_batch
      Customer: dim_customer.customer_name
      Event Classification: alert_limit_check.event_classification
      Area Where Occurred: area_occured.area_name
      Business Sector Unit: dim_bus_sec.bus_sec_name
      Quality Impact Rating: fact_deviations.quality_rating
      Dates: fact_deviations.date_created_year
    row: 6
    col: 15
    width: 9
    height: 8
  - title: Total Deviations by Asset
    name: Total Deviations by Asset
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
    value_labels: labels
    label_type: labVal
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    stacking: ''
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
    series_types: {}
    hidden_fields: []
    listen:
      Site: dim_site.site_name
      Status: dim_deviation_status.deviation_status
      Asset: vw_asset_to_area.asset
      Root Category: dim_root_cause.root_cause_category
      Causal Factor: dim_causal.causal_name
      Event Area: alert_limit_check.event_area
      Batch: dim_lot_batch.lot_batch
      Customer: dim_customer.customer_name
      Event Classification: alert_limit_check.event_classification
      Area Where Occurred: area_occured.area_name
      Business Sector Unit: dim_bus_sec.bus_sec_name
      Quality Impact Rating: fact_deviations.quality_rating
      Dates: fact_deviations.date_created_year
    row: 14
    col: 0
    width: 8
    height: 7
  - title: Asset Deviations By Month
    name: Asset Deviations By Month
    model: dev_0meter
    explore: fact_deviations
    type: looker_column
    fields:
    - fact_deviations.date_created_month
    - vw_asset_to_area.asset
    - fact_deviations.count
    pivots:
    - fact_deviations.date_created_month
    fill_fields:
    - fact_deviations.date_created_month
    filters:
      fact_deviations.deviation_key: '230,319,323'
    sorts:
    - fact_deviations.date_created_month
    - vw_asset_to_area.asset
    limit: 500
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
    listen:
      Site: dim_site.site_name
      Status: dim_deviation_status.deviation_status
      Asset: vw_asset_to_area.asset
      Root Category: dim_root_cause.root_cause_category
      Causal Factor: dim_causal.causal_name
      Event Area: alert_limit_check.event_area
      Batch: dim_lot_batch.lot_batch
      Customer: dim_customer.customer_name
      Event Classification: alert_limit_check.event_classification
      Area Where Occurred: area_occured.area_name
      Business Sector Unit: dim_bus_sec.bus_sec_name
      Quality Impact Rating: fact_deviations.quality_rating
      Dates: fact_deviations.date_created_year
    row: 14
    col: 8
    width: 16
    height: 7
  - title: Causal Name by Month
    name: Causal Name by Month
    model: dev_0meter
    explore: fact_deviations
    type: looker_column
    fields:
    - fact_deviations.date_created_month
    - dim_causal.causal_name
    - fact_deviations.count
    pivots:
    - fact_deviations.date_created_month
    fill_fields:
    - fact_deviations.date_created_month
    filters:
      fact_deviations.deviation_key: '230,319,323'
    sorts:
    - fact_deviations.date_created_month
    - dim_causal.causal_name
    limit: 500
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
    column_group_spacing_ratio:
    listen:
      Site: dim_site.site_name
      Status: dim_deviation_status.deviation_status
      Asset: vw_asset_to_area.asset
      Root Category: dim_root_cause.root_cause_category
      Causal Factor: dim_causal.causal_name
      Event Area: alert_limit_check.event_area
      Batch: dim_lot_batch.lot_batch
      Customer: dim_customer.customer_name
      Event Classification: alert_limit_check.event_classification
      Area Where Occurred: area_occured.area_name
      Business Sector Unit: dim_bus_sec.bus_sec_name
      Quality Impact Rating: fact_deviations.quality_rating
      Dates: fact_deviations.date_created_date
    row: 21
    col: 8
    width: 16
    height: 8
  - title: Causal Factor
    name: Causal Factor
    model: dev_0meter
    explore: fact_deviations
    type: looker_pie
    fields:
    - dim_causal.causal_name
    - fact_deviations.count
    filters:
      fact_deviations.deviation_key: '230,319,323'
    sorts:
    - fact_deviations.count desc
    limit: 500
    column_limit: 50
    row_total: right
    value_labels: labels
    label_type: labVal
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
      Site: dim_site.site_name
      Status: dim_deviation_status.deviation_status
      Asset: vw_asset_to_area.asset
      Root Category: dim_root_cause.root_cause_category
      Causal Factor: dim_causal.causal_name
      Event Area: alert_limit_check.event_area
      Batch: dim_lot_batch.lot_batch
      Customer: dim_customer.customer_name
      Event Classification: alert_limit_check.event_classification
      Area Where Occurred: area_occured.area_name
      Business Sector Unit: dim_bus_sec.bus_sec_name
      Quality Impact Rating: fact_deviations.quality_rating
      Dates: fact_deviations.date_created_year
    row: 21
    col: 0
    width: 8
    height: 8
  - title: Casual Name by Customer
    name: Casual Name by Customer
    model: dev_0meter
    explore: fact_deviations
    type: looker_donut_multiples
    fields:
    - dim_customer.customer_name
    - fact_deviations.count
    - dim_causal.causal_name
    pivots:
    - dim_causal.causal_name
    filters:
      fact_deviations.deviation_key: '230,323,319'
    sorts:
    - fact_deviations.count desc 0
    - dim_causal.causal_name
    limit: 500
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    listen:
      Site: dim_site.site_name
      Status: dim_deviation_status.deviation_status
      Asset: vw_asset_to_area.asset
      Root Category: dim_root_cause.root_cause_category
      Causal Factor: dim_causal.causal_name
      Event Area: alert_limit_check.event_area
      Batch: dim_lot_batch.lot_batch
      Customer: dim_customer.customer_name
      Event Classification: alert_limit_check.event_classification
      Area Where Occurred: area_occured.area_name
      Business Sector Unit: dim_bus_sec.bus_sec_name
      Quality Impact Rating: fact_deviations.quality_rating
      Dates: fact_deviations.date_created_date
    row: 29
    col: 0
    width: 24
    height: 8
  - title: Root Cause Category
    name: Root Cause Category
    model: dev_0meter
    explore: fact_deviations
    type: looker_pie
    fields:
    - dim_root_cause.root_cause_category
    - fact_deviations.count
    filters:
      fact_deviations.deviation_key: '230,323,319'
    sorts:
    - fact_deviations.count desc
    limit: 500
    value_labels: legend
    label_type: labPer
    stacking: ''
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
    series_types: {}
    listen:
      Site: dim_site.site_name
      Status: dim_deviation_status.deviation_status
      Asset: vw_asset_to_area.asset
      Root Category: dim_root_cause.root_cause_category
      Causal Factor: dim_causal.causal_name
      Event Area: alert_limit_check.event_area
      Batch: dim_lot_batch.lot_batch
      Customer: dim_customer.customer_name
      Event Classification: alert_limit_check.event_classification
      Area Where Occurred: area_occured.area_name
      Business Sector Unit: dim_bus_sec.bus_sec_name
      Quality Impact Rating: fact_deviations.quality_rating
      Dates: fact_deviations.date_created_date
    row: 37
    col: 0
    width: 8
    height: 7
  - title: Event Area
    name: Event Area
    model: dev_0meter
    explore: fact_deviations
    type: looker_pie
    fields:
    - fact_deviations.count
    - dim_event_classification.event_area
    filters:
      fact_deviations.deviation_key: '230,319,323'
    sorts:
    - fact_deviations.count desc
    limit: 500
    value_labels: labels
    label_type: labVal
    stacking: ''
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
    series_types: {}
    listen:
      Site: dim_site.site_name
      Status: dim_deviation_status.deviation_status
      Asset: vw_asset_to_area.asset
      Root Category: dim_root_cause.root_cause_category
      Causal Factor: dim_causal.causal_name
      Event Area: alert_limit_check.event_area
      Batch: dim_lot_batch.lot_batch
      Customer: dim_customer.customer_name
      Event Classification: alert_limit_check.event_classification
      Area Where Occurred: area_occured.area_name
      Business Sector Unit: dim_bus_sec.bus_sec_name
      Quality Impact Rating: fact_deviations.quality_rating
      Dates: fact_deviations.date_created_date
    row: 44
    col: 0
    width: 8
    height: 7
  - title: Root Cause Category by Month
    name: Root Cause Category by Month
    model: dev_0meter
    explore: fact_deviations
    type: looker_column
    fields:
    - fact_deviations.count
    - dim_root_cause.root_cause_category
    - fact_deviations.date_created_month
    pivots:
    - fact_deviations.date_created_month
    fill_fields:
    - fact_deviations.date_created_month
    filters:
      fact_deviations.deviation_key: '230,319,323'
    sorts:
    - fact_deviations.count desc 0
    - dim_root_cause.root_cause_category
    - fact_deviations.date_created_month
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
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    listen:
      Site: dim_site.site_name
      Status: dim_deviation_status.deviation_status
      Asset: vw_asset_to_area.asset
      Root Category: dim_root_cause.root_cause_category
      Causal Factor: dim_causal.causal_name
      Event Area: alert_limit_check.event_area
      Batch: dim_lot_batch.lot_batch
      Customer: dim_customer.customer_name
      Event Classification: alert_limit_check.event_classification
      Area Where Occurred: area_occured.area_name
      Business Sector Unit: dim_bus_sec.bus_sec_name
      Quality Impact Rating: fact_deviations.quality_rating
      Dates: fact_deviations.date_created_year
    row: 37
    col: 8
    width: 16
    height: 7
  - title: Event Classifications
    name: Event Classifications
    model: dev_0meter
    explore: fact_deviations
    type: looker_pie
    fields:
    - fact_deviations.count
    - dim_event_classification.event_classification
    filters:
      fact_deviations.deviation_key: '230,319,323'
    sorts:
    - fact_deviations.count desc
    limit: 500
    column_limit: 50
    value_labels: labels
    label_type: labVal
    stacking: ''
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
    series_types: {}
    listen:
      Site: dim_site.site_name
      Status: dim_deviation_status.deviation_status
      Asset: vw_asset_to_area.asset
      Root Category: dim_root_cause.root_cause_category
      Causal Factor: dim_causal.causal_name
      Event Area: alert_limit_check.event_area
      Batch: dim_lot_batch.lot_batch
      Customer: dim_customer.customer_name
      Event Classification: alert_limit_check.event_classification
      Area Where Occurred: area_occured.area_name
      Business Sector Unit: dim_bus_sec.bus_sec_name
      Quality Impact Rating: fact_deviations.quality_rating
      Dates: fact_deviations.date_created_date
    row: 51
    col: 0
    width: 8
    height: 7
  - title: Event Area by Month
    name: Event Area by Month
    model: dev_0meter
    explore: fact_deviations
    type: looker_column
    fields:
    - fact_deviations.count
    - fact_deviations.date_created_month
    - dim_event_classification.event_area
    pivots:
    - fact_deviations.date_created_month
    fill_fields:
    - fact_deviations.date_created_month
    filters:
      fact_deviations.deviation_key: '230,319,323'
    sorts:
    - fact_deviations.count desc 0
    - fact_deviations.date_created_month
    limit: 500
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
    listen:
      Site: dim_site.site_name
      Status: dim_deviation_status.deviation_status
      Asset: vw_asset_to_area.asset
      Root Category: dim_root_cause.root_cause_category
      Causal Factor: dim_causal.causal_name
      Event Area: alert_limit_check.event_area
      Batch: dim_lot_batch.lot_batch
      Customer: dim_customer.customer_name
      Event Classification: alert_limit_check.event_classification
      Area Where Occurred: area_occured.area_name
      Business Sector Unit: dim_bus_sec.bus_sec_name
      Quality Impact Rating: fact_deviations.quality_rating
      Dates: fact_deviations.date_created_date
    row: 44
    col: 8
    width: 16
    height: 7
  - title: Event Classification by Month
    name: Event Classification by Month
    model: dev_0meter
    explore: fact_deviations
    type: looker_column
    fields:
    - fact_deviations.count
    - fact_deviations.date_created_month
    - dim_event_classification.event_classification
    pivots:
    - fact_deviations.date_created_month
    fill_fields:
    - fact_deviations.date_created_month
    filters:
      fact_deviations.deviation_key: '230,319,323'
    sorts:
    - fact_deviations.count desc 0
    - fact_deviations.date_created_month
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
    listen:
      Site: dim_site.site_name
      Status: dim_deviation_status.deviation_status
      Asset: vw_asset_to_area.asset
      Root Category: dim_root_cause.root_cause_category
      Causal Factor: dim_causal.causal_name
      Event Area: alert_limit_check.event_area
      Batch: dim_lot_batch.lot_batch
      Customer: dim_customer.customer_name
      Event Classification: alert_limit_check.event_classification
      Area Where Occurred: area_occured.area_name
      Business Sector Unit: dim_bus_sec.bus_sec_name
      Quality Impact Rating: fact_deviations.quality_rating
      Dates: fact_deviations.date_created_date
    row: 51
    col: 8
    width: 16
    height: 7
  - title: Event Classification by Customer
    name: Event Classification by Customer
    model: dev_0meter
    explore: fact_deviations
    type: looker_column
    fields:
    - fact_deviations.count
    - alert_limit_check.event_classification
    - dim_customer.customer_name
    pivots:
    - alert_limit_check.event_classification
    filters:
      fact_deviations.deviation_key: '230,319,323'
    sorts:
    - fact_deviations.count desc 0
    - alert_limit_check.event_classification
    limit: 500
    column_limit: 50
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
    font_size: '12'
    series_types: {}
    listen:
      Site: dim_site.site_name
      Status: dim_deviation_status.deviation_status
      Asset: vw_asset_to_area.asset
      Root Category: dim_root_cause.root_cause_category
      Causal Factor: dim_causal.causal_name
      Event Area: alert_limit_check.event_area
      Batch: dim_lot_batch.lot_batch
      Customer: dim_customer.customer_name
      Event Classification: alert_limit_check.event_classification
      Area Where Occurred: area_occured.area_name
      Business Sector Unit: dim_bus_sec.bus_sec_name
      Quality Impact Rating: fact_deviations.quality_rating
      Dates: fact_deviations.date_created_date
    row: 58
    col: 0
    width: 24
    height: 8
  - title: Area Occurred by Month
    name: Area Occurred by Month
    model: dev_0meter
    explore: fact_deviations
    type: looker_column
    fields:
    - area_occured.area_name
    - fact_deviations.count
    - fact_deviations.date_created_month
    pivots:
    - area_occured.area_name
    fill_fields:
    - fact_deviations.date_created_month
    filters:
      fact_deviations.deviation_key: '230,319,323'
    sorts:
    - fact_deviations.count desc 0
    - fact_deviations.date_created_month
    - area_occured.area_name
    limit: 50000
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
    show_null_points: true
    point_style: none
    interpolation: linear
    series_types: {}
    listen:
      Site: dim_site.site_name
      Status: dim_deviation_status.deviation_status
      Asset: vw_asset_to_area.asset
      Root Category: dim_root_cause.root_cause_category
      Causal Factor: dim_causal.causal_name
      Event Area: alert_limit_check.event_area
      Batch: dim_lot_batch.lot_batch
      Customer: dim_customer.customer_name
      Event Classification: alert_limit_check.event_classification
      Area Where Occurred: area_occured.area_name
      Business Sector Unit: dim_bus_sec.bus_sec_name
      Quality Impact Rating: fact_deviations.quality_rating
      Dates: fact_deviations.date_created_date
    row: 66
    col: 8
    width: 16
    height: 9
  - title: Deviations by Area Occurred
    name: Deviations by Area Occurred
    model: dev_0meter
    explore: fact_deviations
    type: looker_pie
    fields:
    - area_occured.area_name
    - fact_deviations.count
    filters:
      fact_deviations.deviation_key: '230,319,323'
    sorts:
    - fact_deviations.count desc
    limit: 500
    value_labels: labels
    label_type: labVal
    stacking: ''
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
    show_null_points: true
    point_style: circle
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    leftAxisLabelVisible: true
    leftAxisLabel: ''
    rightAxisLabelVisible: true
    rightAxisLabel: ''
    barColors:
    - red
    - blue
    - "#3dff00"
    smoothedBars: false
    orientation: automatic
    labelPosition: inline
    percentType: total
    percentPosition: inline
    valuePosition: right
    labelColorEnabled: true
    labelColor: "#FFF"
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
    ordering: none
    show_null_labels: false
    font_size: '12'
    series_types: {}
    listen:
      Site: dim_site.site_name
      Status: dim_deviation_status.deviation_status
      Asset: vw_asset_to_area.asset
      Root Category: dim_root_cause.root_cause_category
      Causal Factor: dim_causal.causal_name
      Event Area: alert_limit_check.event_area
      Batch: dim_lot_batch.lot_batch
      Customer: dim_customer.customer_name
      Event Classification: alert_limit_check.event_classification
      Area Where Occurred: area_occured.area_name
      Business Sector Unit: dim_bus_sec.bus_sec_name
      Quality Impact Rating: fact_deviations.quality_rating
      Dates: fact_deviations.date_created_date
    row: 66
    col: 0
    width: 8
    height: 9
  - title: Total by Event Classification
    name: Total by Event Classification
    model: dev_0meter
    explore: fact_deviations
    type: looker_column
    fields:
    - fact_deviations.count
    - dim_event_classification.event_classification
    filters:
      fact_deviations.deviation_key: '319,230,323'
    sorts:
    - fact_deviations.count desc
    limit: 500
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
    listen:
      Site: dim_site.site_name
      Status: dim_deviation_status.deviation_status
      Asset: vw_asset_to_area.asset
      Root Category: dim_root_cause.root_cause_category
      Causal Factor: dim_causal.causal_name
      Event Area: alert_limit_check.event_area
      Batch: dim_lot_batch.lot_batch
      Customer: dim_customer.customer_name
      Event Classification: alert_limit_check.event_classification
      Area Where Occurred: area_occured.area_name
      Business Sector Unit: dim_bus_sec.bus_sec_name
      Quality Impact Rating: fact_deviations.quality_rating
      Dates: fact_deviations.date_created_date
    row: 83
    col: 0
    width: 8
    height: 6
  - title: Batch by Causal Name
    name: Batch by Causal Name
    model: dev_0meter
    explore: fact_deviations
    type: looker_column
    fields:
    - dim_causal.causal_name
    - fact_deviations.count
    - dim_lot_batch.lot_batch
    pivots:
    - dim_causal.causal_name
    filters:
      fact_deviations.deviation_key: '230,319,323'
    sorts:
    - fact_deviations.count desc 0
    - dim_causal.causal_name
    limit: 500
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
    font_size: '12'
    series_types: {}
    listen:
      Site: dim_site.site_name
      Status: dim_deviation_status.deviation_status
      Asset: vw_asset_to_area.asset
      Root Category: dim_root_cause.root_cause_category
      Causal Factor: dim_causal.causal_name
      Event Area: alert_limit_check.event_area
      Batch: dim_lot_batch.lot_batch
      Customer: dim_customer.customer_name
      Event Classification: alert_limit_check.event_classification
      Area Where Occurred: area_occured.area_name
      Business Sector Unit: dim_bus_sec.bus_sec_name
      Quality Impact Rating: fact_deviations.quality_rating
      Dates: fact_deviations.date_created_date
    row: 75
    col: 0
    width: 24
    height: 8
  filters:
  - name: Site
    title: Site
    type: field_filter
    default_value: Portsmouth
    allow_multiple_values: true
    required: false
    model: dev_0meter
    explore: fact_deviations
    listens_to_filters: []
    field: dim_site.site_name
  - name: Status
    title: Status
    type: field_filter
    default_value: "-Closed - Aborted,-Closed - Cancelled,-Closed - Voided"
    allow_multiple_values: true
    required: false
    model: dev_0meter
    explore: fact_deviations
    listens_to_filters: []
    field: dim_deviation_status.deviation_status
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
  - name: Root Category
    title: Root Category
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: dev_0meter
    explore: fact_deviations
    listens_to_filters: []
    field: dim_root_cause.root_cause_category
  - name: Causal Factor
    title: Causal Factor
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: dev_0meter
    explore: fact_deviations
    listens_to_filters: []
    field: dim_causal.causal_name
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
  - name: Customer
    title: Customer
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: dev_0meter
    explore: fact_deviations
    listens_to_filters: []
    field: dim_customer.customer_name
  - name: Event Classification
    title: Event Classification
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: dev_0meter
    explore: fact_deviations
    listens_to_filters: []
    field: alert_limit_check.event_classification
  - name: Area Where Occurred
    title: Area Where Occurred
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: dev_0meter
    explore: fact_deviations
    listens_to_filters: []
    field: area_occured.area_name
  - name: Business Sector Unit
    title: Business Sector Unit
    type: field_filter
    default_value: LPB Portsmouth MM
    allow_multiple_values: true
    required: false
    model: dev_0meter
    explore: fact_deviations
    listens_to_filters: []
    field: dim_bus_sec.bus_sec_name
  - name: Quality Impact Rating
    title: Quality Impact Rating
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: dev_0meter
    explore: fact_deviations
    listens_to_filters: []
    field: fact_deviations.quality_rating
  - name: Dates
    title: Dates
    type: date_filter
    default_value: this year
    allow_multiple_values: true
    required: false
