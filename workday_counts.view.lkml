view: workday_counts {
  derived_table: {
    sql: select ccm.assetMapping
        , ccm.assetName
        , ccm.area
        , ccm.costCenterCategory
        , ccm.costCenter
        , ccm.costCenterDescription
        , wc.head_count as headCount
        , wc.open_positions as openPositions
        , wc.open_reqs as openReqs
        , wc.LoadDate
      from datalake.CostCenterMapping ccm
      inner join datalake.WorkdayCounts wc
      on ccm.costCenter = wc.cost_center_id
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: asset_mapping {
    type: string
    sql: ${TABLE}.assetMapping ;;
  }

  dimension: asset_name {
    type: string
    sql: ${TABLE}.assetName ;;
  }

  dimension: area {
    type: string
    sql: ${TABLE}.area ;;
  }

  dimension: cost_center_category {
    type: string
    sql: ${TABLE}.costCenterCategory ;;
  }

  dimension: cost_center {
    type: string
    sql: ${TABLE}.costCenter ;;
  }

  dimension: cost_center_description {
    type: string
    sql: ${TABLE}.costCenterDescription ;;
  }

  dimension: head_count {
    type: number
    sql: ${TABLE}.headCount ;;
  }

  dimension: open_positions {
    type: number
    sql: ${TABLE}.openPositions ;;
  }

  dimension: open_reqs {
    type: number
    sql: ${TABLE}.openReqs ;;
  }

  dimension_group: load_date {
    type: time
    sql: ${TABLE}.LoadDate ;;
  }

  dimension: max_load_date {
    type: date
    sql: select max(loadDate) from ${TABLE} ;;
  }

  measure: total_head_count {
    type: sum
    sql: ${head_count} ;;
  }

  measure: total_open_reqs {
    type: sum
    sql: ${open_reqs} ;;
  }

  measure: total_open_positions {
    type: sum
    sql: ${open_positions} ;;
  }

  set: detail {
    fields: [
      asset_mapping,
      asset_name,
      area,
      cost_center_category,
      cost_center,
      cost_center_description,
      head_count,
      open_positions,
      open_reqs,
      load_date_time
    ]
  }
}
