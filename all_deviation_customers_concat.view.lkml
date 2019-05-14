view: all_deviation_customers_concat {
  derived_table: {
    sql: select fd.PARENT_RECORD_ID
        , STRING_AGG(cast(c.CUSTOMER_NAME as nvarchar(max)), ', ') as AllCustomers
       from dbo.FACT_DEVIATIONS fd
       inner join dbo.BRIDGE_CUSTOMERS_DEV bd
       on bd.PARENT_RECORD_ID = fd.PARENT_RECORD_ID
       inner join dbo.DIM_CUSTOMERS c
       on bd.CUSTOMER_KEY = c.CUSTOMER_KEY
       group by fd.PARENT_RECORD_ID
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: parent_record_id {
    type: number
    sql: ${TABLE}.PARENT_RECORD_ID ;;
  }

  dimension: all_customers {
    type: string
    sql: ${TABLE}.AllCustomers ;;
  }

  set: detail {
    fields: [parent_record_id, all_customers]
  }
}
