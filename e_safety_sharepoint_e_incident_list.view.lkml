view: e_safety_sharepoint_e_incident_list {
#   sql_table_name: dataLake.eSafety_Sharepoint_eIncident_List ;;

  derived_table: {
    sql: SELECT * FROM dataLake.eSafety_Sharepoint_eIncident_List
      where loadid = (select max(loadid) from dataLake.eSafety_Sharepoint_eIncident_List) ;;
    persist_for: "24 hours"
  }

  parameter: timezone_selection {
    type: string
    # suggest_explore: available_timezones
    # suggest_dimension: available_timezones.name
  }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension: affected_body_part {
    type: string
    sql: ${TABLE}.AffectedBodyPart ;;
  }

#   dimension: app_created_by {
#     type: string
#     sql: ${TABLE}.AppCreatedBy ;;
#   }
#
#   dimension: app_created_by_id {
#     type: number
#     sql: ${TABLE}.AppCreatedByID ;;
#   }
#
#   dimension: app_modified_by {
#     type: string
#     sql: ${TABLE}.AppModifiedBy ;;
#   }
#
#   dimension: app_modified_by_id {
#     type: number
#     sql: ${TABLE}.AppModifiedByID ;;
#   }

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
    sql:LEFT(${TABLE}.Building,4) ;;
  }

  dimension_group: closure {
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
    sql: cast(${TABLE}.ClosureDate  AT TIME ZONE 'UTC' AT TIME ZONE {% parameter timezone_selection %} as datetime2) ;;
  }

  dimension: content_type {
    type: string
    sql: ${TABLE}.ContentType ;;
  }

  dimension: corrective_action {
    type: string
    sql: ${TABLE}.CorrectiveAction ;;
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
    sql: cast(${TABLE}.Created  AT TIME ZONE 'UTC' AT TIME ZONE {% parameter timezone_selection %} as datetime2) ;;
  }

  dimension: created_by {
    type: string
    sql: ${TABLE}.CreatedBy ;;
  }

#   dimension: created_by_id {
#     type: number
#     sql: ${TABLE}.CreatedByID ;;
#   }

  dimension_group: date_of_incident_report {
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
    sql: cast( ${TABLE}.DateOfIncidentReport  AT TIME ZONE 'UTC' AT TIME ZONE {% parameter timezone_selection %} as datetime2) ;;

  }

#   dimension: e_incident {
#     type: string
#     sql: ${TABLE}.eIncident ;;
#   }
#
#   dimension: e_incident2 {
#     type: string
#     sql: ${TABLE}.eIncident2 ;;
#   }
#
#   dimension: e_incident3 {
#     type: string
#     sql: ${TABLE}.eIncident3 ;;
#   }

#   dimension: edit {
#     type: string
#     sql: ${TABLE}.Edit ;;
#   }

  dimension: employee_id {
    type: string
    sql: ${TABLE}.EmployeeID ;;
  }

#   dimension: folder_child_count {
#     type: string
#     sql: ${TABLE}.FolderChildCount ;;
#   }
#
#   dimension: folder_child_count_id {
#     type: number
#     sql: ${TABLE}.FolderChildCountID ;;
#   }

  dimension: general_area {
    type: string
    sql: ${TABLE}.GeneralArea ;;
  }

  dimension: incident_cause {
    type: string
    sql: ${TABLE}.IncidentCause ;;
  }

  dimension_group: incident {
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
    sql: cast( ${TABLE}.IncidentDate  AT TIME ZONE 'UTC' AT TIME ZONE {% parameter timezone_selection %} as datetime2) ;;

  }

  dimension: incident_description {
    type: string
    sql: ${TABLE}.IncidentDescription ;;
  }

#   dimension: item_child_count {
#     type: string
#     sql: ${TABLE}.ItemChildCount ;;
#   }
#
#   dimension: item_child_count_id {
#     type: number
#     sql: ${TABLE}.ItemChildCountID ;;
#   }

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
#
#   dimension: load_id {
#     type: number
#     sql: ${TABLE}.LoadID ;;
#   }

  dimension: lob {
    type: string
    sql: ${TABLE}.LOB ;;
  }

#   dimension_group: modified {
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
#     sql: ${TABLE}.Modified ;;
#   }
#
#   dimension: modified_by {
#     type: string
#     sql: ${TABLE}.ModifiedBy ;;
#   }
#
#   dimension: modified_by_id {
#     type: number
#     sql: ${TABLE}.ModifiedByID ;;
#   }

  dimension: nature_of_incident {
    type: string
    sql: ${TABLE}.NatureOfIncident ;;
  }

  dimension: original_report {
    type: string
    sql: ${TABLE}.OriginalReport ;;
  }

  dimension: record_source {
    type: string
    sql: ${TABLE}.RecordSource ;;
  }

  dimension: responsible_supervisor {
    type: string
    sql: ${TABLE}.ResponsibleSupervisor ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.Status ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.Type ;;
  }

  dimension: type_of_incident {
    type: string
    sql: ${TABLE}.TypeOfIncident ;;
  }

#   dimension: version {
#     type: string
#     sql: ${TABLE}.Version ;;
#   }

  measure: count {
    label: "Number of Incidents"
    type: count
    drill_fields: [id]
  }
}
