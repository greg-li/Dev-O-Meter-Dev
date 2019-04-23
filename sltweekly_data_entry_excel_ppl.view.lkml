view: sltweekly_data_entry_excel_ppl {
  sql_table_name: dataLake.SLTWeeklyDataEntry_Excel_PPL ;;

  dimension: active_fteactual {
    label: "Active FTE Actual"
    type: number
    sql: ${TABLE}.ActiveFTEActual ;;
  }

  dimension: active_ftetarget {
    label: "Active FTE Target"
    type: number
    sql: ${TABLE}.ActiveFTETarget ;;
  }

  dimension: asset_function {
    type: string
    sql: ${TABLE}.AssetFunction ;;
  }

  dimension: commentary {
    type: string
    sql: ${TABLE}.Commentary ;;
  }

#   dimension_group: load {
#     type: time
#     timeframes: [
#       raw,
#       time,
#       date,
#       week,
#       month,
#       quarter,
#       year
#     ]
#     sql: ${TABLE}.LoadDate ;;
#   }

#   dimension: load_id {
#     type: number
#     sql: ${TABLE}.LoadID ;;
#   }

  dimension: open_reqs_actual {
    type: number
    sql: ${TABLE}.OpenReqsActual ;;
  }

  dimension: open_reqs_target {
    type: number
    sql: ${TABLE}.OpenReqsTarget ;;
  }

  dimension: otifactual {
    label: "OTIF Actual"
    type: number
    sql: ${TABLE}.OTIFActual ;;
  }

  dimension: otiftarget {
    label: "OTIF Target"
    type: number
    sql: ${TABLE}.OTIFTarget ;;
  }

  dimension: receipt_number_actual {
    type: number
    sql: ${TABLE}.ReceiptNumberActual ;;
  }

  dimension: receipt_number_target {
    type: number
    sql: ${TABLE}.ReceiptNumberTarget ;;
  }

  dimension: record_source {
    type: string
    sql: ${TABLE}.RecordSource ;;
  }

  dimension: resampling_actual {
    type: number
    sql: ${TABLE}.ResamplingActual ;;
  }

  dimension: resampling_target {
    type: number
    sql: ${TABLE}.ResamplingTarget ;;
  }

  dimension: right_first_time_actual {
    type: number
    sql: ${TABLE}.RightFirstTimeActual ;;
  }

  dimension: right_first_time_target {
    type: number
    sql: ${TABLE}.RightFirstTimeTarget ;;
  }

  dimension: sampling_queue_actual {
    type: number
    sql: ${TABLE}.SamplingQueueActual ;;
  }

  dimension: sampling_queue_target {
    type: number
    sql: ${TABLE}.SamplingQueueTarget ;;
  }

  dimension: stock_outs_actual {
    type: number
    sql: ${TABLE}.StockOutsActual ;;
  }

  dimension: stock_outs_target {
    type: number
    sql: ${TABLE}.StockOutsTarget ;;
  }

  dimension_group: week_ending {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.WeekEndingDate ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: total_otif_actual {
    type: sum
    sql: ${otifactual} ;;
  }

  measure: total_otif_target {
    type: sum
    sql: ${otiftarget} ;;
  }

  measure: percent_otif {
    type: number
    value_format_name: percent_0
    sql: 1.0*${total_otif_actual}/NULLIF(${total_otif_target},0) ;;
  }

  measure: total_open_reqs_actual {
    type: sum
    sql: ${open_reqs_actual} ;;
  }

  measure: total_open_reqs_target {
    type: sum
    sql: ${open_reqs_target} ;;
  }

  measure: total_fte_actual {
    type: sum
    sql: ${active_fteactual} ;;
  }

  measure: total_fte_target {
    type: sum
    sql: ${active_ftetarget} ;;
  }


  measure: total_oos_actual {
    type: sum
    sql: ${stock_outs_actual} ;;
  }

  measure: total_oos_target {
    type: sum
    sql: ${stock_outs_target} ;;
  }

  measure: total_sampling_queue_actual {
    type: sum
    sql: ${sampling_queue_actual} ;;
  }

  measure: total_sampling_queue_target {
    type: sum
    sql: ${sampling_queue_target} ;;
  }



}
