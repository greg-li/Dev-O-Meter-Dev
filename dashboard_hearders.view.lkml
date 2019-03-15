
# explore: dashboard_headers {}

view: dashboard_headers {

  derived_table: {
#     persist_for: "3600 hours"
    sql: select 1 as number
      ;;
  }

  dimension: dashboard_section_causal_factors_root_cause{
    label: "  "
    sql: ${TABLE}.number;;
    html: <b><center><font size="18">Causal Factors <br>& Root Causes</font></center></b>;;
  }

  dimension: dashboard_section_event{
    label: "  "
    sql: ${TABLE}.number;;
    html: <b><center><font size="18">Event</font></center></b>;;
  }

  dimension: dashboard_section_asset{
    label: "  "
    sql: ${TABLE}.number;;
    html: <b><center><font size="18">Asset</font></center></b>;;
  }

  dimension: dashboard_section_areat{
    label: "  "
    sql: ${TABLE}.number;;
    html: <b><center><font size="18"> Area</font></center></b>;;
  }

}
