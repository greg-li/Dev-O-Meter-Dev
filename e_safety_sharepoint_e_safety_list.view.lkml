view: e_safety_sharepoint_e_safety_list {
  derived_table: {
    sql: select esaf.ID
          , esaf.AppCreatedBy
          , esaf.AppCreatedByID
          , esaf.AppModifiedBy
          , esaf.AppModifiedByID
          , case when esaf.DateAndTimeOfNearMiss < '01/01/2019' then isnull(am.Asset,am2.AssetOfEvent) else esaf.AssetOfEvent end as AssetOfEvent
          , esaf.Attachments
          , esaf.CreatedBy
          , esaf.CreatedByID
          , esaf.Building
          , esaf.SubmitterLOB
          , esaf.ContentType
          , esaf.CorrectiveActionsCompleted
          , esaf.Created
          , esaf.Timestamp
          , esaf.DateAndTimeOfNearMiss
          , esaf.DateCompleted
          , esaf.Type
          , esaf.Edit
          , esaf.ModifiedBy
          , esaf.ModifiedByID
          , esaf.EmployeeSupervisor
          , esaf.EmployeeSupervisorID
          , esaf.FolderChildCount
          , esaf.FolderChildCountID
          , esaf.GeneralArea
          , esaf.HazardType
          , esaf.ItemChildCount
          , esaf.ItemChildCountID
          , esaf.Modified
          , esaf.DateOfNearMiss
          , esaf.NearMissSafetyObservation
          , esaf.ResponsibleParty
          , esaf.ResponsiblePartyID
          , esaf.RootCause
          , esaf.Submitter
          , esaf.SubmitterID
          , esaf.Title
          , esaf.ReferenceNumber_WO_Notif_CC
          , esaf.Version
          , esaf.LoadDate
          , esaf.LoadID
          , esaf.RecordSource
        FROM dataLake.eSafety_Sharepoint_eSafety_List esaf
        left join datalake.PastRecordSafety_AssetMapping am
        on esaf.generalarea = am.Area
        and esaf.Building = am.[Building Full]
        left join datalake.PastRecordSafety_AssetMapping2 am2
        on am2.GeneralArea = esaf.GeneralArea
        where loadid = (
          select max(loadid)
          from dataLake.eSafety_Sharepoint_eSafety_List
        )
        group by esaf.ID
          , esaf.AppCreatedBy
          , esaf.AppCreatedByID
          , esaf.AppModifiedBy
          , esaf.AppModifiedByID
          , am.Asset
          , am2.AssetOfEvent
          , esaf.AssetOfEvent
          , esaf.Attachments
          , esaf.CreatedBy
          , esaf.CreatedByID
          , esaf.Building
          , esaf.SubmitterLOB
          , esaf.ContentType
          , esaf.CorrectiveActionsCompleted
          , esaf.Created
          , esaf.Timestamp
          , esaf.DateAndTimeOfNearMiss
          , esaf.DateCompleted
          , esaf.Type
          , esaf.Edit
          , esaf.ModifiedBy
          , esaf.ModifiedByID
          , esaf.EmployeeSupervisor
          , esaf.EmployeeSupervisorID
          , esaf.FolderChildCount
          , esaf.FolderChildCountID
          , esaf.GeneralArea
          , esaf.HazardType
          , esaf.ItemChildCount
          , esaf.ItemChildCountID
          , esaf.Modified
          , esaf.DateOfNearMiss
          , esaf.NearMissSafetyObservation
          , esaf.ResponsibleParty
          , esaf.ResponsiblePartyID
          , esaf.RootCause
          , esaf.Submitter
          , esaf.SubmitterID
          , esaf.Title
          , esaf.ReferenceNumber_WO_Notif_CC
          , esaf.Version
          , esaf.LoadDate
          , esaf.LoadID
          , esaf.RecordSource ;;
    persist_for: "24 hours"
  }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  # dimension: app_created_by {
  #   type: string
  #   sql: ${TABLE}.AppCreatedBy ;;
  # }

  # dimension: app_created_by_id {
  #   type: number
  #   sql: ${TABLE}.AppCreatedByID ;;
  # }

  # dimension: app_modified_by {
  #   type: string
  #   sql: ${TABLE}.AppModifiedBy ;;
  # }

  # dimension: app_modified_by_id {
  #   type: number
  #   sql: ${TABLE}.AppModifiedByID ;;
  # }

  dimension: asset_of_event {
    type: string
    sql: ${TABLE}.AssetOfEvent ;;
  }

  dimension: attachments {
    type: string
    sql: ${TABLE}.Attachments ;;
  }

  dimension: building {
    type: string
    sql: ${TABLE}.Building ;;
  }

  dimension: content_type {
    type: string
    sql: ${TABLE}.ContentType ;;
  }

  dimension: corrective_actions_completed {
    type: string
    sql: ${TABLE}.CorrectiveActionsCompleted ;;
  }

  dimension_group: created {
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
    sql: ${TABLE}.Created ;;
  }

  dimension: created_by {
    type: string
    sql: ${TABLE}.CreatedBy ;;
  }

  dimension: created_by_id {
    type: number
    sql: ${TABLE}.CreatedByID ;;
  }

  dimension_group: date_and_time_of_near_miss {
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
    sql: ${TABLE}.DateAndTimeOfNearMiss ;;
  }

  dimension_group: date_completed {
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
    sql: ${TABLE}.DateCompleted ;;
  }

  dimension_group: date_of_near_miss {
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
    sql: ${TABLE}.DateOfNearMiss ;;
  }

  dimension: edit {
    type: string
    sql: ${TABLE}.Edit ;;
  }

  dimension: employee_supervisor {
    type: string
    sql: ${TABLE}.EmployeeSupervisor ;;
  }

  dimension: employee_supervisor_id {
    type: number
    sql: ${TABLE}.EmployeeSupervisorID ;;
  }

  dimension: folder_child_count {
    type: string
    sql: ${TABLE}.FolderChildCount ;;
  }

  dimension: folder_child_count_id {
    type: number
    sql: ${TABLE}.FolderChildCountID ;;
  }

  dimension: general_area {
    type: string
    sql: ${TABLE}.GeneralArea ;;
  }

  dimension: hazard_type {
    type: string
    sql: ${TABLE}.HazardType ;;
  }

  dimension: item_child_count {
    type: string
    sql: ${TABLE}.ItemChildCount ;;
  }

  dimension: item_child_count_id {
    type: number
    sql: ${TABLE}.ItemChildCountID ;;
  }

  dimension_group: load {
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
    sql: ${TABLE}.LoadDate ;;
  }

  dimension: load_id {
    type: number
    sql: ${TABLE}.LoadID ;;
  }

  dimension_group: modified {
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
    sql: ${TABLE}.Modified ;;
  }

  dimension: modified_by {
    type: string
    sql: ${TABLE}.ModifiedBy ;;
  }

  dimension: modified_by_id {
    type: number
    sql: ${TABLE}.ModifiedByID ;;
  }

  dimension: near_miss_safety_observation {
    type: string
    sql: ${TABLE}.NearMissSafetyObservation ;;
  }

  dimension: record_source {
    type: string
    sql: ${TABLE}.RecordSource ;;
  }

  dimension: reference_number_wo_notif_cc {
    type: string
    sql: ${TABLE}.ReferenceNumber_WO_Notif_CC ;;
  }

  dimension: responsible_party {
    type: string
    sql: ${TABLE}.ResponsibleParty ;;
  }

  dimension: responsible_party_id {
    type: number
    sql: ${TABLE}.ResponsiblePartyID ;;
  }

  dimension: root_cause {
    type: string
    sql: ${TABLE}.RootCause ;;
  }

  dimension: submitter {
    type: string
    sql: ${TABLE}.Submitter ;;
  }

  dimension: submitter_id {
    type: number
    sql: ${TABLE}.SubmitterID ;;
  }

  dimension: submitter_lob {
    type: string
    sql: ${TABLE}.SubmitterLOB ;;
  }

  dimension_group: timestamp {
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
    sql: ${TABLE}.Timestamp ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.Title ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.Type ;;
  }

  dimension: version {
    type: string
    sql: ${TABLE}.Version ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
