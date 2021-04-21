dv_percentage_chance:
  type: procedure
  definitions: percent
  script:
  - determine <util.random.decimal[0].to[99].is_less_than[<[percent]>]>