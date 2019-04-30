view: safety_union {
  derived_table: {
    sql: select id as incidentid, null as nearmissid, incidentcause, assetofevent, createdby, createdbyid, affectedbodypart, building, correctiveaction, created, dateofincidentreport, generalarea, closuredate, employeeid, incidentdate, incidentdescription, LOB, natureofincident, responsiblesupervisor, status, typeofincident, 'incident' as incident_or_nearmiss
      from dataLake.eSafety_Sharepoint_eIncident_List
      where loadid = (select max(loadid) from dataLake.eSafety_Sharepoint_eIncident_List)

      union all

      select null as incidentid, id as nearmissid, RootCause as incidentcause, assetofevent, createdby, createdbyid, null as affectedbodypart, building, CorrectiveActionsCompleted as correctiveaction, created, null as dateofincidentreport, generalarea, DateCompleted as closuredate, cast(submitterID as nvarchar) as employeeid, DateAndTimeOfNearMiss as incidentdate, NearMissSafetyObservation as incidentdescription, SubmitterLOB as LOB, null as natureofincident,   ResponsibleParty as responsiblesupervisor, null as status, hazardtype as typeofincident, 'nearmiss' as incident_or_nearmiss
      from dataLake.eSafety_Sharepoint_eSafety_List
      where loadid = (select max(loadid) from dataLake.eSafety_Sharepoint_eSafety_List)

       ;;

      persist_for: "24 hours"

      indexes: ["incidentid","nearmissid"]
  }

  measure: count {
    label: "Number of Incidents and Near Misses"
    type: count
#     drill_fields: [detail*]
  }

  measure: count_incidents_non_osha {
    label: "Number of Non-OSHA Incidents"
    filters: {
      field: incident_or_nearmiss
      value: "incident"
    }
    filters: {
      field: is_osha_recordable
      value: "no"
    }
    type: count
    drill_fields: [incident_date_date,building_abbreviated,asset_of_event,general_area,incident_cause,nature_of_incident,type_of_incident,incident_description]
  }

  measure: count_of_osha {
    label: "Number of OSHA Recordables"
    html: <p style="color: red; font-size: 30px"> {{ value }} </p> ;;
    filters: {
      field: is_osha_recordable
      value: "yes"
    }
    type: count
    drill_fields: [incident_date_date,building_abbreviated,asset_of_event,general_area,incident_cause,nature_of_incident,type_of_incident,incident_description]
  }

  measure: count_nearmiss {
    label: "Number of Near Misses"
    filters: {
      field: incident_or_nearmiss
      value: "nearmiss"
    }
    type: count
  }

  measure: count_incidents {
    label: "Number of Incidents"
    html: <p style="font-size: 30px"> {{ value }} </p> ;;
    filters: {
      field: incident_or_nearmiss
      value: "incident"
    }
    type: count
    drill_fields: [incident_date_date,building_abbreviated,asset_of_event,general_area,incident_cause,nature_of_incident,type_of_incident,incident_description]
    link: {
      label: "Safety Detail Dashboard"
      url: "/dashboards/vfUrxckmNvw6zZr7tKSfnH?&Function={{ _filters['asset_mapping_excel.master'] | url_encode }}"
    icon_url: "https://www.chichester-hockey.co.uk/wp-content/uploads/2013/09/safety-first-icon.png"
    }
  }

#   measure: safety_goal {
#     sql: 1 ;;
#     type: average
#   }

  dimension: id {
    hidden: no
    primary_key: yes
    type: number
    sql: concat(cast(${incident_id} as nvarchar),cast(${nearmiss_id} as nvarchar)) ;;
  }

  dimension: incident_id {
    hidden: yes
    type: number
    sql: ${TABLE}.incidentid ;;
    link: {
      label: "Safety Detail Dashboard"
      url: "/dashboards/vfUrxckmNvw6zZr7tKSfnH?Asset-Function Filter={{ _filters['asset_mapping_excel.Master'] | url_encode }}"
      icon_url: "https://www.chichester-hockey.co.uk/wp-content/uploads/2013/09/safety-first-icon.png"
      }
  }

  dimension: nearmiss_id {
    hidden: yes
    type: number
    sql: ${TABLE}.nearmissid ;;
  }

dimension: is_osha_recordable  {
  type:  yesno
  sql: lower(${type_of_incident}) like '%osha%' ;;

}

  dimension: incident_cause {
    type: string
    sql: ${TABLE}.incidentcause ;;
    drill_fields: [incident_date_date,building_abbreviated,asset_of_event,general_area,incident_cause,nature_of_incident,type_of_incident,incident_description]
  }

  dimension: asset_of_event {
    type: string
    sql: ${TABLE}.assetofevent ;;
    drill_fields: [incident_date_date,building_abbreviated,asset_of_event,general_area,incident_cause,nature_of_incident,type_of_incident,incident_description]
  }

  dimension: created_by {
    type: string
    sql: ${TABLE}.createdby ;;
  }

  dimension: created_by_id {
    type: number
    sql: ${TABLE}.createdbyid ;;
  }

  dimension: affected_bodypart {
    type: string
    sql: ${TABLE}.affectedbodypart ;;
  }

  dimension: building {
    type: string
    sql: ${TABLE}.building ;;
    drill_fields: [incident_date_date,building_abbreviated,asset_of_event,general_area,incident_cause,nature_of_incident,type_of_incident,incident_description]
  }

  dimension: building_abbreviated {
    type: string
    sql: case when lower(${building}) like '%international%'
          then left(${building},4)
        else ${building} end ;;
    drill_fields: [incident_date_date,building_abbreviated,asset_of_event,general_area,incident_cause,nature_of_incident,type_of_incident,incident_description]
    link: {
      label: "Safety Detail Dashboard"
      url: "/dashboards/vfUrxckmNvw6zZr7tKSfnH?&Building={{ value }}"
      icon_url: "https://www.chichester-hockey.co.uk/wp-content/uploads/2013/09/safety-first-icon.png"
    }
  }

  dimension: corrective_action {
    type: string
    sql: ${TABLE}.correctiveaction ;;
  }

  dimension_group: created {
    type: time
    timeframes: [date,week,month_name,year]
    sql: ${TABLE}.created ;;
  }

  dimension_group: date_of_incidentreport {
    label: "Incident Report"
    type: time
    timeframes: [date,week,month_name,year]
    sql: ${TABLE}.dateofincidentreport ;;
  }

  dimension: general_area {
    type: string
    sql: ${TABLE}.generalarea ;;
  }

  dimension_group: closure_date {
    label: "Closure"
    timeframes: [date,week,month_name,month,year]
    type: time
    sql: ${TABLE}.closuredate ;;
  }

  dimension: employee_id {
    type: string
    sql: ${TABLE}.employeeid ;;
  }

  dimension_group: incident_date {
    label: "Incident"
    timeframes: [date,hour_of_day,week,week_of_year,day_of_week,day_of_month,month_name, month,quarter,quarter_of_year,year]
    type: time
    sql: ${TABLE}.incidentdate ;;
  }

  dimension: incident_description {
    type: string
    sql: ${TABLE}.incidentdescription ;;
  }

  dimension: lob {
    label: "Line of Business"
    type: string
    sql: ${TABLE}.LOB ;;
  }

  dimension: nature_of_incident {
    type: string
    sql: ${TABLE}.natureofincident ;;
  }

  dimension: responsible_supervisor {
    type: string
    sql: ${TABLE}.responsiblesupervisor ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: type_of_incident {
    type: string
    sql: ${TABLE}.typeofincident ;;
  }

  dimension: incident_or_nearmiss {
    type: string
    sql: ${TABLE}.incident_or_nearmiss ;;
  }

  measure: last_incident_date {
    type: date
    sql: max(case when ${incident_or_nearmiss} = 'incident' then ${date_of_incidentreport_date} else null end) ;;
    drill_fields: [incident_date_date,building_abbreviated,asset_of_event,general_area,incident_cause,nature_of_incident,type_of_incident,incident_description]
  }

  measure: days_since_last_incident {
    type: number
    sql: datediff(day,  ${last_incident_date},  GETDATE()) ;;
  }



#   set: detail {
#     fields: [
#       id,
#       incidentcause,
#       assetofevent,
#       createdby,
#       createdbyid,
#       affectedbodypart,
#       building,
#       correctiveaction,
#       created_time,
#       dateofincidentreport_time,
#       generalarea,
#       closuredate_time,
#       employeeid,
#       incidentdate_time,
#       incidentdescription,
#       lob,
#       natureofincident,
#       responsiblesupervisor,
#       status,
#       typeofincident,
#       incident_or_nearmiss
#     ]
#   }
}
