# Not sure why this isnt working,
# but I created it to get the current date to put month, year, quarter at the top of dashboard 27

explore:current_dates_for_dashboard {hidden:yes}
view: current_dates_for_dashboard {
  derived_table: {
    sql_trigger_value: select getdate() as current_date ;;
    sql: select getdate() ;;
    }
  dimension: current_month {
    type: date_month
    sql: ${TABLE}.current_date ;;
  }
}
