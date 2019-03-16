#
# # explore: dashboard_headers {}
#
# view: dashboard_headers {
#
#   derived_table: {
# #     persist_for: "3600 hours"
#   sql: select 1 as number
#     ;;
# }
#
# dimension: dashboard_section_causal_factors_root_cause{
#   label: "  "
#   hidden: yes
#   sql: ${TABLE}.number;;
#   html: <b><center><font size="18">Causal Factors & Root Causes</font></center></b>;;
# }
#
# dimension: dashboard_section_event{
#   label: "  "
#   hidden: yes
#   sql: ${TABLE}.number;;
#   html: <b><center><font size="18">Event</font></center></b>;;
# }
#
# dimension: dashboard_section_asset{
#   label: "  "
#   hidden: yes
#   sql: ${TABLE}.number;;
#   html: <b><center><font size="18">Asset</font></center></b>;;
# }
#
# dimension: dashboard_section_area{
#   label: "  "
#   hidden: yes
#   sql: ${TABLE}.number;;
#   html: <b><center><font size="18"> Area</font></center></b>;;
# }
# dimension: dashboard_section_causal_factors_root_cause_with_link{
#   label: "  "
#   hidden: yes
#   sql: ${TABLE}.number;;
#   html: <b><center><font size="18">Causal Factors & Root Causes</font></center></b>
#       <b>
#       <div align="right">
#       <a href= "/dashboards/19?Date%20Selection={{ _filters['fact_deviations.date_selection'] | url_encode }}&Time%20Zone={{ _filters['fact_deviations.timezone_selection'] | url_encode }}&Site={{ _filters['dim_site.site_name'] | url_encode }}&Status={{ _filters['dim_deviation_status.deviation_status'] | url_encode }}&Deviation%20Date={{ _filters['fact_deviations.date_created_date'] | url_encode }}&Asset={{ _filters['vw_asset_to_area.asset'] | url_encode }}&Root%20Category={{ _filters['dim_root_cause.root_cause_category'] | url_encode }}&Causal%20Factor={{ _filters['dim_causal.causal_name'] | url_encode }}&Event%20Area={{ _filters['alert_limit_check.event_area'] | url_encode }}&Batch={{ _filters['dim_lot_batch.lot_batch'] | url_encode }}&Customer={{ _filters['dim_customers.customer_name'] | url_encode }}&Event%20Classification={{ _filters['alert_limit_check.event_classification'] | url_encode }}&Area%20Where%20Occurred={{ _filters['area_occured.area_name'] | url_encode }}&Business%20Sector%20Unit={{ _filters['dim_bus_sec.bus_sec_name'] | url_encode }}&Quality%20Impact%20Rating={{ _filters['fact_deviations.quality_rating'] | url_encode }}"
#       style="color:dodgerblue;"target="_blank"“&run=1”>
#       Click here for more detail</a>
#       </div>
#       </b>;;
#     #   link: {
#     #     label: "Click here for more Cause & Root Cause Detail"
#     #     url:"/dashboards/19?Date%20Reporting%20Period%20Type=_filters['fact_deviations.date_selection']&Time%20Zone=US%2FEastern&Site=Portsmouth&Status=-Closed%20-%20Aborted,-Closed%20-%20Cancelled,-Closed%20-%20Voided&Deviation%20Date=2018&Asset=&Root%20Category=&Causal%20Factor=&Event%20Area=&Batch=&Customer=&Event%20Classification=&Area%20Where%20Occurred=&Business%20Sector%20Unit=LPB%20Portsmouth%20MM&Quality%20Impact%20Rating="
#     #   }
#   }
#
#
#   dimension: dashboard_section_event_with_link{
#     label: "  "
#     hidden: yes
#     sql: ${TABLE}.number;;
#     html: <b><center><font size="18">Event</font></center></b>
#       <b>
#       <div align="right">
#       <a href= "/dashboards/22?Date%20Selection={{ _filters['fact_deviations.date_selection'] | url_encode }}&Time%20Zone={{ _filters['fact_deviations.timezone_selection'] | url_encode }}&Site={{ _filters['dim_site.site_name'] | url_encode }}&Status={{ _filters['dim_deviation_status.deviation_status'] | url_encode }}&Deviation%20Date={{ _filters['fact_deviations.date_created_date'] | url_encode }}&Asset={{ _filters['vw_asset_to_area.asset'] | url_encode }}&Root%20Category={{ _filters['dim_root_cause.root_cause_category'] | url_encode }}&Causal%20Factor={{ _filters['dim_causal.causal_name'] | url_encode }}&Event%20Area={{ _filters['alert_limit_check.event_area'] | url_encode }}&Batch={{ _filters['dim_lot_batch.lot_batch'] | url_encode }}&Customer={{ _filters['dim_customers.customer_name'] | url_encode }}&Event%20Classification={{ _filters['alert_limit_check.event_classification'] | url_encode }}&Area%20Where%20Occurred={{ _filters['area_occured.area_name'] | url_encode }}&Business%20Sector%20Unit={{ _filters['dim_bus_sec.bus_sec_name'] | url_encode }}&Quality%20Impact%20Rating={{ _filters['fact_deviations.quality_rating'] | url_encode }}"
#       style="color:dodgerblue;"target="_blank"“&run=1”>
#       Click here for more detail</a>
#       </div>
#       </b;;
#   }
#
#   dimension: dashboard_section_asset_with_link{
#     label: "  "
#     hidden: yes
#     sql: ${TABLE}.number;;
#     html: <b><center><font size="18">Asset</font></center></b>
#       <b>
#       <div align="right">
#       <a href= "/dashboards/21?Date%20Selection={{ _filters['fact_deviations.date_selection'] | url_encode }}&Time%20Zone={{ _filters['fact_deviations.timezone_selection'] | url_encode }}&Site={{ _filters['dim_site.site_name'] | url_encode }}&Status={{ _filters['dim_deviation_status.deviation_status'] | url_encode }}&Deviation%20Date={{ _filters['fact_deviations.date_created_date'] | url_encode }}&Asset={{ _filters['vw_asset_to_area.asset'] | url_encode }}&Root%20Category={{ _filters['dim_root_cause.root_cause_category'] | url_encode }}&Causal%20Factor={{ _filters['dim_causal.causal_name'] | url_encode }}&Event%20Area={{ _filters['alert_limit_check.event_area'] | url_encode }}&Batch={{ _filters['dim_lot_batch.lot_batch'] | url_encode }}&Customer={{ _filters['dim_customers.customer_name'] | url_encode }}&Event%20Classification={{ _filters['alert_limit_check.event_classification'] | url_encode }}&Area%20Where%20Occurred={{ _filters['area_occured.area_name'] | url_encode }}&Business%20Sector%20Unit={{ _filters['dim_bus_sec.bus_sec_name'] | url_encode }}&Quality%20Impact%20Rating={{ _filters['fact_deviations.quality_rating'] | url_encode }}"
#       style="color:dodgerblue;"target="_blank"“&run=1”>
#       Click here for more detail</a>
#       </div>
#       </b;;
#   }
#
#   dimension: dashboard_section_area_with_link{
#     label: "  "
#     hidden: yes
#     sql: ${TABLE}.number;;
#     html: <b><center><font size="18"> Area</font></center></b>
#       <b>
#       <div align="right">
#       <a href= "/dashboards/20?Date%20Selection={{ _filters['fact_deviations.date_selection'] | url_encode }}&Time%20Zone={{ _filters['fact_deviations.timezone_selection'] | url_encode }}&Site={{ _filters['dim_site.site_name'] | url_encode }}&Status={{ _filters['dim_deviation_status.deviation_status'] | url_encode }}&Deviation%20Date={{ _filters['fact_deviations.date_created_date'] | url_encode }}&Asset={{ _filters['vw_asset_to_area.asset'] | url_encode }}&Root%20Category={{ _filters['dim_root_cause.root_cause_category'] | url_encode }}&Causal%20Factor={{ _filters['dim_causal.causal_name'] | url_encode }}&Event%20Area={{ _filters['alert_limit_check.event_area'] | url_encode }}&Batch={{ _filters['dim_lot_batch.lot_batch'] | url_encode }}&Customer={{ _filters['dim_customers.customer_name'] | url_encode }}&Event%20Classification={{ _filters['alert_limit_check.event_classification'] | url_encode }}&Area%20Where%20Occurred={{ _filters['area_occured.area_name'] | url_encode }}&Business%20Sector%20Unit={{ _filters['dim_bus_sec.bus_sec_name'] | url_encode }}&Quality%20Impact%20Rating={{ _filters['fact_deviations.quality_rating'] | url_encode }}"
#       style="color:dodgerblue;"target="_blank"“&run=1”>
#       Click here for more detail</a>
#       </div>
#       </b;;
#   }
# }
