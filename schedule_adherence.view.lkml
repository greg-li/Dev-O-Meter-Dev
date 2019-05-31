view: schedule_adherence {
  derived_table: {
    sql: SELECT * FROM dataLake.ScheduleAdherence_Orchestrate
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: order_code {
    type: string
    sql: ${TABLE}.OrderCode ;;
  }

  dimension: job_code {
    type: string
    sql: ${TABLE}.JobCode ;;
  }

  dimension: op_step {
    type: number
    sql: ${TABLE}.OpStep ;;
  }

  dimension: task_description {
    type: string
    sql: ${TABLE}.TaskDescription ;;
  }

  dimension: resource_code {
    type: string
    sql: ${TABLE}.ResourceCode ;;
  }

  dimension: asset {
    type: string
    sql: ${TABLE}.Asset ;;
  }

  dimension: area {
    type: string
    sql: ${TABLE}.Area ;;
  }

  dimension: critical {
    type: number
    sql: ${TABLE}.Critical ;;
  }

  dimension: batch_id {
    type: string
    sql: ${TABLE}.BatchID ;;
  }

  dimension: wbselement {
    type: string
    sql: ${TABLE}.WBSElement ;;
  }

  dimension: late_reason {
    type: string
    sql: ${TABLE}.LateReason ;;
  }

  dimension_group: actual_finish_date {
    type: time
    sql: ${TABLE}.Actual_Finish_Date ;;
  }

  dimension_group: baseline_finish_date {
    type: time
    sql: ${TABLE}.Baseline_finish_date ;;
  }

  dimension: on_time {
    type: number
    sql: ${TABLE}.OnTime ;;
  }

  measure: events_on_time {
    label: "On-Time Events"
    type: sum
    sql: ${on_time} ;;
  }

  measure: events_late {
    label: "Late Events"
    type: count
    filters: {
      field: on_time
      value: "0"
    }
    }

  measure: schedule_adherence {
    label: "Schedule Adherence"
    type: number
    value_format: "0.00\%"
    sql: ${events_on_time}/${count} ;;
  }





  set: detail {
    fields: [
      order_code,
      job_code,
      op_step,
      task_description,
      resource_code,
      asset,
      area,
      critical,
      batch_id,
      wbselement,
      late_reason,
      actual_finish_date_time,
      baseline_finish_date_time,
      on_time
    ]
  }
}
