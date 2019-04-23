# If necessary, uncomment the line below to include explore_source.
include: "safety.model.lkml"

view: last_incident {
  derived_table: {
    explore_source: safety_union {
      column: id {}
      column: incident_date_date {}
      column: incident_or_nearmiss {}
      derived_column: days_since_last_incident {
        sql: datediff(day,  lag(cast(incident_date_date as date)) OVER (ORDER BY cast(incident_date_date as date)), incident_date_date) ;;
      }
      filters: {
        field: safety_union.incident_or_nearmiss
        value: "incident"
      }
    }
  }
  dimension: id {
    label: "Incidents and Near Misses ID"
    type: number
  }
  dimension: incident_date_date {
    label: "Last Incident Date"
    type: date
  }

  dimension: days_since_last_incident {
    type: number
    sql: ${TABLE}.days_since_last_incident ;;
  }

  measure: average_days_between_incidents {
    type: average
    sql: 1.0 * ${days_since_last_incident};;
    value_format_name: decimal_2
  }
}
