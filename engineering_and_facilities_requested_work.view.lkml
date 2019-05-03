view: engineering_and_facilities_requested_work {
  derived_table: {
    sql: SELECT rmop.OrderNo
      , rmop.OrderType
      , rmop.MaintActivType
      , rmop.Description
      , rmop.MaintenancePlan
      , rmop.MainWorkCenter
      , rmop.CreatedOn
      , rmop.FunctionalLocation
    , substring(rmop.FunctionalLocation,5,case when charindex('-',rmop.FunctionalLocation,5) > 5 then charindex('-',rmop.FunctionalLocation,5) - 5 else 15 end) as Location
    , rmop.Notification
      , rmop.Priority
      , rmop.LoadDate
      , rmop.LoadID
      , rmop.RecordSource
  FROM dataLake.RequestedWork_Excel_EngAndFacilities rmop
  where rmop.LoadID = (select max(LoadID) from datalake.RequestedWork_Excel_EngAndFacilities)
 ;;
  indexes: ["OrderNo"]
  persist_for: "24hours"
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: order_no {
    type: number
    sql: ${TABLE}.OrderNo ;;
  }

  dimension: order_type {
    type: string
    sql: ${TABLE}.OrderType ;;
  }

  dimension: maint_activ_type {
    type: string
    sql: ${TABLE}.MaintActivType ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.Description ;;
  }

  dimension: maintenance_plan {
    type: string
    sql: ${TABLE}.MaintenancePlan ;;
  }

  dimension: main_work_center {
    type: string
    sql: ${TABLE}.MainWorkCenter ;;
  }

  dimension_group: created_on {
    type: time
    sql: ${TABLE}.CreatedOn ;;
  }

  dimension: functional_location {
    type: string
    sql: ${TABLE}.FunctionalLocation ;;
  }

  dimension: location {
    type: string
    sql: ${TABLE}.Location ;;
  }

  dimension: notification {
    type: string
    sql: ${TABLE}.Notification ;;
  }

  dimension: priority {
    type: string
    sql: ${TABLE}.Priority ;;
  }

  dimension_group: load_date {
    type: time
    sql: ${TABLE}.LoadDate ;;
  }

  dimension: load_id {
    type: number
    sql: ${TABLE}.LoadID ;;
  }

  dimension: record_source {
    type: string
    sql: ${TABLE}.RecordSource ;;
  }

  set: detail {
    fields: [
      order_no,
      order_type,
      maint_activ_type,
      description,
      maintenance_plan,
      main_work_center,
      created_on_time,
      functional_location,
      location,
      notification,
      priority,
      load_date_time,
      load_id,
      record_source
    ]
  }
}
