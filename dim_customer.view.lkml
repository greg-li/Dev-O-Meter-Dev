view: dim_customer {
  sql_table_name: dbo.DIM_CUSTOMER ;;

  dimension: active_flag {
    type: string
    sql: ${TABLE}.ACTIVE_FLAG ;;
  }

  dimension: customer_key {
    type: number
    sql: ${TABLE}.CUSTOMER_KEY ;;
  }

  dimension: customer_name {
    type: string
    sql: ${TABLE}.CUSTOMER_NAME ;;
    link: {
      label: "Dev Trending (Filtered on Selected Client)"
      url: "/dashboards/5?Site={{ _filters['dim_site.site_name'] | url_encode }}&Status={{ _filters['dim_deviation_status.deviation_status'] | url_encode }}&Deviation%20Date={{ _filters['fact_deviations.date_created_date'] | url_encode }}&Asset={{ _filters['vw_asset_to_area.asset'] | url_encode }}&Root%20Category={{ _filters['dim_root_cause.root_cause_category'] | url_encode }}&Causal%20Factor={{ _filters['dim_causal.causal_name'] | url_encode }}&Event%20Area={{ _filters['alert_limit_check.event_area'] | url_encode }}&Batch={{ _filters['dim_lot_batch.lot_batch'] | url_encode }}
      &Customer={{customer_name._value}}&Event%20Classification={{ _filters['alert_limit_check.event_classification'] | url_encode }}&Area%20Where%20Occurred={{ _filters['dim_area.area_name'] | url_encode }}&Business%20Sector%20Unit={{ _filters['dim_bus_sec.bus_sec_name'] | url_encode }}&Quality%20Impact%20Rating={{ _filters['fact_deviations.quality_rating'] | url_encode }}"
      icon_url: "https://looker.com/favicon.ico"
    }
  }

  dimension_group: insert {
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
    sql: ${TABLE}.INSERT_DATE ;;
  }

  dimension_group: update {
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
    sql: ${TABLE}.UPDATE_DATE ;;
  }

  measure: count {
    type: count
    drill_fields: [customer_name]
  }
}
