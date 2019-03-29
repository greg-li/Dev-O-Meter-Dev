view: dim_customers {
  sql_table_name: dbo.dim_customers ;;

  dimension: active_flag {
    type: string
    sql: ${TABLE}.ACTIVE_FLAG ;;
  }

  dimension: customer_key {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.CUSTOMER_KEY ;;
  }

  dimension: customer_name {          ##keep
    type: string
    sql: ${TABLE}.CUSTOMER_NAME ;;
    link: {
      label: "Customer Details"
      url: "/dashboards/24?Date%20Selection={{ _filters['fact_deviations.date_selection'] | url_encode }}&Time%20Zone={{ _filters['fact_deviations.timezone_selection'] | url_encode }}&Site={{ _filters['dim_site.site_name'] | url_encode }}&Status={{ _filters['dim_deviation_status.deviation_status'] | url_encode }}&Deviation%20Date={{ _filters['fact_deviations.date_created_date'] | url_encode }}&Asset={{ _filters['vw_asset_to_area.asset'] | url_encode }}&Root%20Category={{ _filters['dim_root_cause.root_cause_category'] | url_encode }}&Causal%20Factor={{ _filters['dim_causal.causal_name'] | url_encode }}&Event%20Area={{ _filters['alert_limit_check.event_area'] | url_encode }}&Batch={{ _filters['dim_lot_batch.lot_batch'] | url_encode }}&Customer={{ value }}&Event%20Classification={{ _filters['alert_limit_check.event_classification'] | url_encode }}&Area%20Where%20Occurred={{ _filters['area_occured.area_name'] | url_encode }}&Business%20Sector%20Unit={{ _filters['dim_bus_sec.bus_sec_name'] | url_encode }}&Quality%20Impact%20Rating={{ _filters['fact_deviations.quality_rating'] | url_encode }}&Deviation%20Type={{_filters['dim_deviation_type.deviation_type'] | url_encode}}"
      icon_url: "https://looker.com/favicon.ico"
    }
    html: Customer Name: {{rendered_value}} <p> Customer Key: {{customer_key._rendered_value}} </p>;;
  }

  dimension_group: insert {
    hidden: yes
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
    convert_tz: no
    datatype: date
    sql: cast(tzdb.utctolocal(${TABLE}.INSERT_DATE,{% parameter fact_deviations.timezone_selection %}) as datetime2) ;;
  }

  dimension_group: update {
    hidden: yes
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
    convert_tz: no
    datatype: date
    sql: cast(tzdb.utctolocal(${TABLE}.UPDATE_DATE,{% parameter fact_deviations.timezone_selection %}) as datetime2) ;;
  }

  measure: count {
    type: count
    drill_fields: [customer_name]
  }
}
