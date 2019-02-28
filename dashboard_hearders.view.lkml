
# explore: dashboard_headers {}

view: dashboard_headers {

  derived_table: {
#     persist_for: "3600 hours"
    sql: select 1 as number
      ;;
  }

  dimension: dashboard_section{
    sql: ${TABLE}.number;;
    html: <b><font size="20">Root Cause</font></b>;;
  }

}
