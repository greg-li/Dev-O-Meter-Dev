- dashboard: track__trend_limits
  title: Track & Trend Limits
  layout: newspaper
  elements:
  - name: Alerts and Action Limits
    title: Alerts and Action Limits
    model: dev_0meter
    explore: fact_deviations
    type: table
    fields:
    - dim_event_classification.event_area
    - dim_event_classification.event_classification
    - dim_event_classification.Action_Limit
    - dim_event_classification.Alert_Limit
    filters:
      dim_event_classification.event_area: "-NULL"
      fact_deviations.date_created_year: '2017'
      fact_deviations.deviation_key: '230'
    limit: 500
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: transparent
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_labels:
      fact_deviations.count: 2017 Deviations
    row: 0
    col: 0
    width: 24
    height: 12
