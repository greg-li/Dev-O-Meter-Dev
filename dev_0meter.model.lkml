connection: "edm"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

explore: dim_area {}

explore: dim_causal {}

explore: dim_customer {}

explore: dim_deviation_status {}

explore: dim_deviation_type {}

explore: dim_document {}

explore: dim_lot_batch {}

explore: dim_person {}

explore: dim_risk_category {}

explore: dim_root_cause {}

explore: dim_site {}

explore: dim_step {}

explore: fact_deviations {}
