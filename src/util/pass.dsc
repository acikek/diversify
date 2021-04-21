dv_pass:
  type: procedure
  definitions: preset
  script:
  - determine <proc[dv_percentage_chance].context[<[preset].data_key[dv_preset].get[chance].if_null[33]>]>