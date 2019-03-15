
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

dimension: dashboard_section_area{
  label: "  "
  sql: ${TABLE}.number;;
  html: <b><center><font size="18"> Area</font></center></b>;;
}
dimension: dashboard_section_causal_factors_root_cause_with_link{
#   label: "  "
  sql: ${TABLE}.number;;
  html: <b><center><font size="18">Causal Factors <br>& Root Causes</font></center></b>
      <b>
      <div align="right">
      <a href= "/dashboards/19?Date%20Reporting%20Period%20Type=&Time%20Zone=US%2FEastern&Site=Portsmouth&Status=-Closed%20-%20Aborted,-Closed%20-%20Cancelled,-Closed%20-%20Voided&Deviation%20Date=2018&Asset=&Root%20Category=&Causal%20Factor=&Event%20Area=&Batch=&Customer=&Event%20Classification=&Area%20Where%20Occurred=&Business%20Sector%20Unit=LPB%20Portsmouth%20MM&Quality%20Impact%20Rating="
      style="color:dodgerblue;">
      Click here for more detail</a>
      </div>
      </b>;;
    #   link: {
    #     label: "Click here for more Cause & Root Cause Detail"
    #     url:"/dashboards/19?Date%20Reporting%20Period%20Type=_filters['fact_deviations.date_selection']&Time%20Zone=US%2FEastern&Site=Portsmouth&Status=-Closed%20-%20Aborted,-Closed%20-%20Cancelled,-Closed%20-%20Voided&Deviation%20Date=2018&Asset=&Root%20Category=&Causal%20Factor=&Event%20Area=&Batch=&Customer=&Event%20Classification=&Area%20Where%20Occurred=&Business%20Sector%20Unit=LPB%20Portsmouth%20MM&Quality%20Impact%20Rating="
    #   }
  }


  dimension: dashboard_section_event_with_link{
    label: "  "
    sql: ${TABLE}.number;;
    html: <b><center><font size="18">Event</font></center></b>;;
  }

  dimension: dashboard_section_asset_with_link{
    label: "  "
    sql: ${TABLE}.number;;
    html: <b><center><font size="18">Asset</font></center></b>;;
  }

  dimension: dashboard_section_area_with_link{
    label: "  "
    sql: ${TABLE}.number;;
    html: <b><center><font size="18"> Area</font></center></b>;;
  }
}
