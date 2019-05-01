view: incident_word_count {
  derived_table: {
    sql: with nearmiss_words as
( SELECT lower(LEFT(SUBSTRING([ss].[value], PATINDEX('%[A-Za-z0-9]%', [ss].[value]), 8000)
        , PATINDEX('%[^A-Za-z0-9]%', SUBSTRING([ss].[value], PATINDEX('%[A-Za-z0-9]%', [ss].[value]), 8000) + ' ') -1)) as word
  FROM looker_scratch.LR$MZXOUIAKM62RC1F2XOCYF_safety_union su
  CROSS APPLY STRING_SPLIT(su.incidentdescription, ' ') AS [ss]
  where su.incident_or_nearmiss = 'nearmiss'
  and ISNUMERIC(ss.value)=0
)
,
stop_words as
(
select lower(stop_word) as stop_word from english_stop_words
)

  select
  count(nearmiss_words.word) as word_count
  ,nearmiss_words.word
  from nearmiss_words
  left join stop_words
  on nearmiss_words.word = stop_words.stop_word
  where stop_words.stop_word is null
  and nearmiss_words.word <> ''
  group by
  nearmiss_words.word
  order by word_count desc
    persist_for: "24 hours"
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: word {
    type: string
    sql: ${TABLE}.word ;;
  }

  dimension: num_words {
    type: number
    sql: ${TABLE}.word_count ;;
  }

  measure: word_count {
    label: "NearMiss Word Count"
    type: sum
    sql:${TABLE}.word_count  ;;
  }

  set: detail {
    fields: [word, word_count]
  }
}
