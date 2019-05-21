view: safety_union {
  derived_table: {
    sql: select id as incidentid
        , null as nearmissid
        , incidentcause
        , assetofevent
        , createdby
        , createdbyid
        , affectedbodypart
        , building
        , correctiveaction
        , created
        , dateofincidentreport
        , generalarea
        , closuredate
        , employeeid
        , incidentdate
        , incidentdescription
        , LOB
        , natureofincident
        , responsiblesupervisor
        , status
        , typeofincident
        , incidentcause as hazard
        , 'incident' as incident_or_nearmiss
      from dataLake.eSafety_Sharepoint_eIncident_List
      where loadid = (select max(loadid) from dataLake.eSafety_Sharepoint_eIncident_List)

      union all

      select null as incidentid
        , id as nearmissid
        , RootCause as incidentcause
        , assetofevent
        , createdby
        , createdbyid
        , null as affectedbodypart
        , building
        , CorrectiveActionsCompleted as correctiveaction
        , created
        , null as dateofincidentreport
        , generalarea
        , DateCompleted as closuredate
        , cast(submitterID as nvarchar) as employeeid
        , DateAndTimeOfNearMiss as incidentdate
        , NearMissSafetyObservation as incidentdescription
        , SubmitterLOB as LOB
        , null as natureofincident
        , ResponsibleParty as responsiblesupervisor
        , null as status
        , null as typeofincident
        , hazardtype as hazard
        , 'nearmiss' as incident_or_nearmiss
      from dataLake.eSafety_Sharepoint_eSafety_List
      where loadid = (select max(loadid) from dataLake.eSafety_Sharepoint_eSafety_List) ;;

      persist_for: "24 hours"

      indexes: ["incidentid","nearmissid"]
  }

  set: Safety_details {
    fields: [incident_date_date,building_abbreviated,asset_of_event,general_area,incident_cause,nature_of_incident,type_of_incident,incident_description]
  }

  measure: count {
    label: "Number of Incidents and Near Misses"
    type: count
    drill_fields: [Safety_details*]
  }

  measure: count_last_12_months{
    label: "Number of Incidents and Near Misses in the past 12 months"
    type: count
    filters: {
      field: incident_date_date
      value: "12 months"
    }
    drill_fields: [Safety_details*]
  }

  measure: count_last_24_months_ago_for_12_months{
    label: "Number of Incidents and Near Misses in the previous 12 months"
    type: count
#     drill_fields: [detail*]
    filters: {
      field: incident_date_date
      value: "24 months ago for 12 months"

    }
    drill_fields: [Safety_details*]
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
    drill_fields: [Safety_details*]
  }

  measure: count_of_osha {
    label: "Number of OSHA Recordables"
    html: <p style="color: red; font-size: 30px"> {{ linked_value }} </p> ;;
    filters: {
      field: is_osha_recordable
      value: "yes"
    }
    type: count
    drill_fields: [Safety_details*]
  }

  measure: count_nearmiss {
    label: "Number of Near Misses"
    filters: {
      field: incident_or_nearmiss
      value: "nearmiss"
    }
    type: count
    drill_fields: [Safety_details*]
  }

  measure: count_incidents {
    label: "Number of Incidents"
    html: <p style="font-size: 30px"> {{ linked_value }} </p> ;;
    filters: {
      field: incident_or_nearmiss
      value: "incident"
    }
    type: count
    drill_fields: [Safety_details*]
  }

  measure: count_incidents_one_week_ago {
    label: "Number of Incidents One Week Ago"
    filters: {
      field: incident_or_nearmiss
      value: "incident"
    }
    filters: {
      field: incident_date_date
      value: "2 weeks ago"

    }
    type: count
    drill_fields: [Safety_details*]
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
    drill_fields: [Safety_details*]
  }

  dimension: nearmiss_id {
    hidden: yes
    type: number
    sql: ${TABLE}.nearmissid ;;
    drill_fields: [Safety_details*]
  }

dimension: is_osha_recordable  {
  type:  yesno
  sql: lower(${type_of_incident}) like '%osha%' ;;
  drill_fields: [Safety_details*]

}

  dimension: incident_cause {
    type: string
    sql: ${TABLE}.incidentcause ;;
    drill_fields: [Safety_details*]
    link: {
      label: "Safety Summary Dashboard"
      url: "/embed/dashboards/vfUrxckmNvw6zZr7tKSfnH?Function={{ _filters['asset_mapping_excel.master'] | url_encode }}&Affected%20Body%20Part={{ _filters['safety_union.affected_bodypart'] | url_encode }}&Incident%20Causes={{ value }}"
      icon_url: "https://www.chichester-hockey.co.uk/wp-content/uploads/2013/09/safety-first-icon.png"
    }
    link: {
      label: "Safety Drill-Down Detail"
      url: "/embed/dashboards/BT3mOTvoQJpHAPQOsRO1i5?Function={{ _filters['asset_mapping_excel.master'] | url_encode }}&Affected%20Body%20Part={{ _filters['safety_union.affected_bodypart'] | url_encode }}&Hazard%20Type={{ value }}"
      icon_url: "http://icons.iconarchive.com/icons/iconsmind/outline/512/Down-2-2-icon.png"
      }
  }

  dimension: asset_of_event {
    type: string
    sql: ${TABLE}.assetofevent ;;
    drill_fields: [Safety_details*]
    link: {
      label: "Safety Summary Dashboard"
      url: "/embed/dashboards/vfUrxckmNvw6zZr7tKSfnH?Function={{ value }}"
      icon_url: "https://www.chichester-hockey.co.uk/wp-content/uploads/2013/09/safety-first-icon.png"
    }
    link: {
      label: "Safety Drill-Down Detail"
      url: "/embed/dashboards/BT3mOTvoQJpHAPQOsRO1i5?Function={{ value }}"
      icon_url: "http://icons.iconarchive.com/icons/iconsmind/outline/512/Down-2-2-icon.png"
    }
  }

  dimension: created_by {
    type: string
    sql: ${TABLE}.createdby ;;
    drill_fields: [Safety_details*]
  }

  dimension: created_by_id {
    type: number
    sql: ${TABLE}.createdbyid ;;
    drill_fields: [Safety_details*]
  }

  dimension: affected_bodypart {
    # hidden: yes
    map_layer_name: injured_bodypart
    type: string
    sql: ${TABLE}.affectedbodypart ;;
    link: {
      label: "Safety Summary Dashboard"
      url: "/embed/dashboards/vfUrxckmNvw6zZr7tKSfnH?Function={{ _filters['asset_mapping_excel.master'] | url_encode }}&Incident%20Causes={{ _filters['safety_union.incident_cause'] | url_encode }}&Affected%20Body%20Part={{ value }}"
      icon_url: "https://www.chichester-hockey.co.uk/wp-content/uploads/2013/09/safety-first-icon.png"
    }
    link: {
      label: "Safety Drill-Down Detail"
      url: "/embed/dashboards/BT3mOTvoQJpHAPQOsRO1i5?Function={{ _filters['asset_mapping_excel.master'] | url_encode }}&Hazard%20Type={{ _filters['safety_union.incident_cause'] | url_encode }}&Affected%20Body%20Part={{ value }}"
      icon_url: "http://icons.iconarchive.com/icons/iconsmind/outline/512/Down-2-2-icon.png"
    }
    drill_fields: [Safety_details*]
  }

  # dimension: affected_bodypart_case {
  #   map_layer_name: injured_bodypart
  #   label: "Bodypart Affected"
  #   case: {
  #     when: {
  #       label: "NO body part injured"
  #       sql: ${affected_bodypart} = 'NO body part injured' ;;
  #     }
  #     when: {
  #       label: "Fingers"
  #       sql: ${affected_bodypart} = 'Fingers' ;;
  #     }
  #     when: {
  #       label: "Face"
  #       sql: ${affected_bodypart} = 'Face' ;;
  #     }
  #     when: {
  #       label: "Head (except eyes)"
  #       sql: ${affected_bodypart} = 'Head (except eyes)' ;;
  #     }
  #     when: {
  #       label: "Generalized Body"
  #       sql: ${affected_bodypart} = 'Generalized Body' ;;
  #     }
  #     when: {
  #       label: "Respiratory System"
  #       sql: ${affected_bodypart} = 'Respiratory System' ;;
  #     }
  #     when: {
  #       label: "Arms"
  #       sql: ${affected_bodypart} = 'Arms' ;;
  #     }
  #     when: {
  #       label: "Back"
  #       sql: ${affected_bodypart} = 'Back' ;;
  #     }
  #     when: {
  #       label: "Knee"
  #       sql: ${affected_bodypart} = 'Knee' ;;
  #     }
  #     when: {
  #       label: "Shoulder"
  #       sql: ${affected_bodypart} = 'Shoulder' ;;
  #     }
  #     when: {
  #       label: "Wrist"
  #       sql: ${affected_bodypart} = 'Wrist' ;;
  #     }
  #     when: {
  #       label: "Eyes"
  #       sql: ${affected_bodypart} = 'Eyes' ;;
  #     }
  #     when: {
  #       label: "Feet"
  #       sql: ${affected_bodypart} = 'Feet' ;;
  #     }
  #     when: {
  #       label: "Ankle"
  #       sql: ${affected_bodypart} = 'Ankle' ;;
  #     }
  #     when: {
  #       label: "Buttocks/tailbone"
  #       sql: ${affected_bodypart} = 'Buttocks/tailbone' ;;
  #     }
  #     when: {
  #       label: "Neck"
  #       sql: ${affected_bodypart} = 'Neck' ;;
  #     }
  #     when: {
  #       label: "Elbow"
  #       sql: ${affected_bodypart} = 'Elbow' ;;
  #     }
  #     when: {
  #       label: "Trunk (except back)"
  #       sql: ${affected_bodypart} = 'Trunk (except back)' ;;
  #     }
  #     when: {
  #       label: "Ear"
  #       sql: ${affected_bodypart} = 'Ear' ;;
  #     }
  #     when: {
  #       label: "Mouth/Teeth"
  #       sql: ${affected_bodypart} = 'Mouth/Teeth' ;;
  #     }
  #     when: {
  #       label: "Groin"
  #       sql: ${affected_bodypart} = 'Groin' ;;
  #     }
  #     when: {
  #       label: "Toes"
  #       sql: ${affected_bodypart} = 'Toes' ;;
  #     }
  #     when: {
  #       label: "Hip"
  #       sql: ${affected_bodypart} = 'Hip' ;;
  #     }

  #   }

  # }

  dimension: building {
    type: string
    sql: ${TABLE}.building ;;
    drill_fields: [Safety_details*]
  }

  dimension: building_abbreviated {
    type: string
    sql: case when lower(${building}) like '%international%'
          then left(${building},4)
        else ${building} end ;;
    drill_fields: [Safety_details*]
    link: {
      label: "Safety Summary Dashboard"
      url: "/embed/dashboards/vfUrxckmNvw6zZr7tKSfnH?Function={{ _filters['asset_mapping_excel.master'] | url_encode }}&Building={{ value }}"
      icon_url: "https://www.chichester-hockey.co.uk/wp-content/uploads/2013/09/safety-first-icon.png"
    }
    link: {
      label: "Safety Drill-Down Detail"
      url: "/embed/dashboards/BT3mOTvoQJpHAPQOsRO1i5?Function={{ _filters['asset_mapping_excel.master'] | url_encode }}&Building={{ value }}"
      icon_url: "http://icons.iconarchive.com/icons/iconsmind/outline/512/Down-2-2-icon.png"
    }

  }

  dimension: corrective_action {
    type: string
    sql: ${TABLE}.correctiveaction ;;
    drill_fields: [Safety_details*]
  }

  dimension_group: created {
    type: time
    timeframes: [date,week,month_name,year]
    sql: ${TABLE}.created ;;
    drill_fields: [Safety_details*]
  }

  dimension_group: date_of_incidentreport {
    label: "Incident Report"
    type: time
    timeframes: [date,week,month_name,year]
    sql: ${TABLE}.dateofincidentreport ;;
    drill_fields: [Safety_details*]
  }

  dimension: general_area {
    type: string
    sql: ${TABLE}.generalarea ;;
    link: {
      label: "Safety Summary Dashboard"
      #url: "/embed/dashboards/vfUrxckmNvw6zZr7tKSfnH?&Area={{ value }}"
      url: "/embed/dashboards/vfUrxckmNvw6zZr7tKSfnH?Function={{ _filters['asset_mapping_excel.master'] | url_encode }}&Area={{ value }}"
      icon_url: "https://www.chichester-hockey.co.uk/wp-content/uploads/2013/09/safety-first-icon.png"
    }
    link: {
      label: "Safety Drill-Down Detail"
      url: "/embed/dashboards/BT3mOTvoQJpHAPQOsRO1i5?Function={{ _filters['asset_mapping_excel.master'] | url_encode }}&Area={{ value }}"
      icon_url: "http://icons.iconarchive.com/icons/iconsmind/outline/512/Down-2-2-icon.png"
    }
    drill_fields: [Safety_details*]
  }

  dimension_group: closure_date {
    label: "Closure"
    timeframes: [date,week,month_name,month,year]
    type: time
    sql: ${TABLE}.closuredate ;;
    drill_fields: [Safety_details*]
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
    drill_fields: [Safety_details*]
  }

  dimension: incident_description {
    type: string
    sql: ${TABLE}.incidentdescription ;;
    drill_fields: [Safety_details*]
  }

  dimension: lob {
    label: "Line of Business"
    type: string
    sql: ${TABLE}.LOB ;;
  }

  dimension: nature_of_incident {
    type: string
    sql: ${TABLE}.natureofincident ;;
    drill_fields: [Safety_details*]
  }

  dimension: responsible_supervisor {
    type: string
    sql: ${TABLE}.responsiblesupervisor ;;
    drill_fields: [Safety_details*]
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
    drill_fields: [Safety_details*]
  }

  dimension: type_of_incident {
    type: string
    sql: ${TABLE}.typeofincident ;;
    drill_fields: [Safety_details*]
  }

  dimension: hazard {
    type: string
    sql: ${TABLE}.hazard ;;
    drill_fields: [Safety_details*]
  }

  dimension: incident_or_nearmiss {
    type: string
    sql: ${TABLE}.incident_or_nearmiss ;;
    drill_fields: [Safety_details*]
  }

  measure: last_incident_date {
    type: date
    sql: max(case when ${incident_or_nearmiss} = 'incident' then ${date_of_incidentreport_date} else null end) ;;
    drill_fields: [Safety_details*]
  }

  measure: days_since_last_incident {
    type: number
    sql: datediff(day,  ${last_incident_date},  GETDATE()) ;;
    drill_fields: [Safety_details*]
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
