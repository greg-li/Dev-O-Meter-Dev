view: incident_word_count {
  derived_table: {
    sql: select * from
      (select word, count(*) as num_words
      from (
        SELECT [ss].[value] as word
        FROM looker_scratch.LR$MZXOUIAKM62RC1F2XOCYF_safety_union su
        CROSS APPLY STRING_SPLIT(su.incidentdescription, ' ') AS [ss]
      ) words
      group by word) w
      where w.word not in('
      ','

      ',
      '


      ','''','-','--',' ','the',
      'to',
      'was',
      'of',
      'a',
      'in',
      'on',
      'and',
      'not',
      'from',
      'floor',
      'that',
      'with',
      'found',
      'is',
      'for',
      'it',
      'while',
      'were',
      'when',
      'room',
      'this',
      'be',
      'could',
      'left',
      'I',
      'have',
      'during',
      'had',
      'an',
      'by',
      'at')
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
    sql: ${TABLE}.num_words ;;
  }

  measure: word_count {
    label: "Incident Word Count"
    type: sum
    sql:${TABLE}.num_words  ;;
  }

  set: detail {
    fields: [word, num_words]
  }
}
