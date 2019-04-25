view: looker_sltdashlinks {
  derived_table: {
    sql: select * from looker_sltdashboardlinks
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: next_link_url {
    label: "Next Asset-Function Link"
    type: max
    sql: ${TABLE}.NextPageURL ;;
  }

  measure: next_link {
    label: "Next Asset-Function"
    type: max
    sql: ${TABLE}.NextPage ;;
  }

  dimension: asset_function {
    type: string
    sql: ${TABLE}.AssetFunction ;;
  }

  dimension: next_page {
    type: string
    sql: ${TABLE}.NextPage ;;
  }

  dimension: next_page_url {
    type: string
    sql: ${TABLE}.NextPageURL ;;
  }

  set: detail {
    fields: [asset_function, next_page, next_page_url]
  }
}
