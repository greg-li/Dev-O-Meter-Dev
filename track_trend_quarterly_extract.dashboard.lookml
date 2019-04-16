- dashboard: track__trend_quarterly_extract
  title: Track & Trend Quarterly Extract
  layout: newspaper
  elements:
  - title: Category Limits and Counts by Month
    name: Category Limits and Counts by Month
    model: dev_0meter
    explore: fact_deviations
    type: table
    fields:
    - dim_event_classification.event_classification
    - fact_deviations.date_created_month
    - dim_event_classification.action_limit
    - dim_event_classification.alert_limit
    - fact_deviations.count_event
    pivots:
    - fact_deviations.date_created_month
    fill_fields:
    - fact_deviations.date_created_month
    filters:
      fact_deviations.deviation_key: '230,319,323'
    sorts:
    - fact_deviations.date_created_month 0
    - dim_event_classification.event_classification desc
    limit: 500
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    - type: greater than
      value:
      background_color:
      font_color:
      palette:
        name: Red to Yellow to Green
        colors:
        - "#F36254"
        - "#FCF758"
        - "#4FBC89"
        __FILE: dev_o_meter/track_trend_quarterly_extract.dashboard.lookml
        __LINE_NUM: 64
      bold: false
      italic: false
      strikethrough: false
      __FILE: dev_o_meter/track_trend_quarterly_extract.dashboard.lookml
      __LINE_NUM: 59
    - type: low to high
      value:
      background_color:
      font_color:
      palette:
        name: Red to Yellow to Green
        colors:
        - "#F36254"
        - "#FCF758"
        - "#4FBC89"
        __FILE: dev_o_meter/track_trend_quarterly_extract.dashboard.lookml
        __LINE_NUM: 77
      bold: false
      italic: false
      strikethrough: false
      __FILE: dev_o_meter/track_trend_quarterly_extract.dashboard.lookml
      __LINE_NUM: 72
    listen:
      Site: dim_site.site_name
      Current Quarter: fact_deviations.date_created_date
      Has Event: dim_event_classification.event_classification
      Business Sector: dim_bus_sec.bus_sec_name
    row: 0
    col: 0
    width: 24
    height: 10
  - title: Events by Root Cause Category
    name: Events by Root Cause Category
    model: dev_0meter
    explore: fact_deviations
    type: looker_column
    fields:
    - dim_event_classification.event_classification
    - dim_root_cause.root_cause_category
    - fact_deviations.count
    pivots:
    - dim_root_cause.root_cause_category
    filters:
      dim_event_classification.event_area: "-NULL"
      fact_deviations.deviation_key: '230,323,319'
    sorts:
    - dim_root_cause.root_cause_category 0
    - fact_deviations.count desc 0
    limit: 500
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
    y_axes:
    - label: Count
      maxValue:
      minValue:
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: Automation / Software Error
        name: Automation / Software Error
        axisId: fact_deviations.count
        __FILE: dev_o_meter/track_trend_quarterly_extract.dashboard.lookml
        __LINE_NUM: 147
      - id: Building and Utility Failure including HVAC
        name: Building and Utility Failure including HVAC
        axisId: fact_deviations.count
        __FILE: dev_o_meter/track_trend_quarterly_extract.dashboard.lookml
        __LINE_NUM: 150
      - id: Cell Culture Excursion
        name: Cell Culture Excursion
        axisId: fact_deviations.count
        __FILE: dev_o_meter/track_trend_quarterly_extract.dashboard.lookml
        __LINE_NUM: 153
      - id: Documentation Management Error
        name: Documentation Management Error
        axisId: fact_deviations.count
        __FILE: dev_o_meter/track_trend_quarterly_extract.dashboard.lookml
        __LINE_NUM: 156
      - id: Equipment Maintenance
        name: Equipment Maintenance
        axisId: fact_deviations.count
        __FILE: dev_o_meter/track_trend_quarterly_extract.dashboard.lookml
        __LINE_NUM: 159
      - id: Equipment Malfunction / Failure
        name: Equipment Malfunction / Failure
        axisId: fact_deviations.count
        __FILE: dev_o_meter/track_trend_quarterly_extract.dashboard.lookml
        __LINE_NUM: 162
      - id: Equipment Preparation
        name: Equipment Preparation
        axisId: fact_deviations.count
        __FILE: dev_o_meter/track_trend_quarterly_extract.dashboard.lookml
        __LINE_NUM: 165
      - id: Error in Approved Batch Records / SOPs
        name: Error in Approved Batch Records / SOPs
        axisId: fact_deviations.count
        __FILE: dev_o_meter/track_trend_quarterly_extract.dashboard.lookml
        __LINE_NUM: 168
      - id: Good Documentation Practice (GDP)
        name: Good Documentation Practice (GDP)
        axisId: fact_deviations.count
        __FILE: dev_o_meter/track_trend_quarterly_extract.dashboard.lookml
        __LINE_NUM: 171
      - id: Inoculum Excursion
        name: Inoculum Excursion
        axisId: fact_deviations.count
        __FILE: dev_o_meter/track_trend_quarterly_extract.dashboard.lookml
        __LINE_NUM: 174
      - id: Leak - Non Product
        name: Leak - Non Product
        axisId: fact_deviations.count
        __FILE: dev_o_meter/track_trend_quarterly_extract.dashboard.lookml
        __LINE_NUM: 177
      - id: Leak - Product
        name: Leak - Product
        axisId: fact_deviations.count
        __FILE: dev_o_meter/track_trend_quarterly_extract.dashboard.lookml
        __LINE_NUM: 180
      - id: Material Management / Supply Chain
        name: Material Management / Supply Chain
        axisId: fact_deviations.count
        __FILE: dev_o_meter/track_trend_quarterly_extract.dashboard.lookml
        __LINE_NUM: 183
      - id: N/A
        name: N/A
        axisId: fact_deviations.count
        __FILE: dev_o_meter/track_trend_quarterly_extract.dashboard.lookml
        __LINE_NUM: 186
      - id: Performed outside BR/SOP Instructions
        name: Performed outside BR/SOP Instructions
        axisId: fact_deviations.count
        __FILE: dev_o_meter/track_trend_quarterly_extract.dashboard.lookml
        __LINE_NUM: 189
      - id: Production Support Excursion
        name: Production Support Excursion
        axisId: fact_deviations.count
        __FILE: dev_o_meter/track_trend_quarterly_extract.dashboard.lookml
        __LINE_NUM: 192
      - id: Purification Excursion
        name: Purification Excursion
        axisId: fact_deviations.count
        __FILE: dev_o_meter/track_trend_quarterly_extract.dashboard.lookml
        __LINE_NUM: 195
      - id: Testing or Reporting Error / Failure
        name: Testing or Reporting Error / Failure
        axisId: fact_deviations.count
        __FILE: dev_o_meter/track_trend_quarterly_extract.dashboard.lookml
        __LINE_NUM: 198
      - id: Validation / Qualification
        name: Validation / Qualification
        axisId: fact_deviations.count
        __FILE: dev_o_meter/track_trend_quarterly_extract.dashboard.lookml
        __LINE_NUM: 201
      - id: Visual Inspection Failures including Foreign Matter
        name: Visual Inspection Failures including Foreign Matter
        axisId: fact_deviations.count
        __FILE: dev_o_meter/track_trend_quarterly_extract.dashboard.lookml
        __LINE_NUM: 204
      - id: "∅"
        name: "∅"
        axisId: fact_deviations.count
        __FILE: dev_o_meter/track_trend_quarterly_extract.dashboard.lookml
        __LINE_NUM: 207
      __FILE: dev_o_meter/track_trend_quarterly_extract.dashboard.lookml
      __LINE_NUM: 135
    hide_legend: false
    listen:
      Site: dim_site.site_name
      Current Quarter: fact_deviations.date_created_date
      Has Event: dim_event_classification.event_classification
      Business Sector: dim_bus_sec.bus_sec_name
    row: 10
    col: 0
    width: 24
    height: 8
  - title: Deviation Detail
    name: Deviation Detail
    model: dev_0meter
    explore: fact_deviations
    type: table
    fields:
    - fact_deviations.parent_record_id
    - fact_deviations.short_description
    - dim_site.site_name
    - area_occured.area_name
    - dim_customers.customer_name
    - dim_lot_batch.lot_batch
    - dim_event_classification.event_area
    - dim_event_classification.event_classification
    - dim_risk_category.risk_category_name
    - fact_deviations.quality_rating
    - dim_deviation_status.deviation_status
    - alert_limit_check.alert_flag
    filters:
      alert_limit_check.alert_flag: 'Yes'
      fact_deviations.deviation_key: '230,323,319'
    sorts:
    - dim_deviation_status.deviation_status desc
    limit: 500
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: true
    hide_totals: false
    hide_row_totals: false
    table_theme: transparent
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    hidden_fields: []
    hidden_points_if_no:
    - alert_limit_check.alert_flag
    listen:
      Site: dim_site.site_name
      Current Quarter: fact_deviations.date_created_date
      Has Event: dim_event_classification.event_classification
      Business Sector: dim_bus_sec.bus_sec_name
    row: 18
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
    listens_to_filters:
    - Event Classification
    field: dim_site.site_name
  - name: Current Quarter
    title: Current Quarter
    type: field_filter
    default_value: 1 quarters ago for 1 quarters
    allow_multiple_values: true
    required: false
    model: dev_0meter
    explore: fact_deviations
    listens_to_filters: []
    field: fact_deviations.date_created_date
  - name: Has Event
    title: Has Event
    type: field_filter
    default_value: "-N/A"
    allow_multiple_values: true
    required: false
    model: dev_0meter
    explore: fact_deviations
    listens_to_filters: []
    field: dim_event_classification.event_classification
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
