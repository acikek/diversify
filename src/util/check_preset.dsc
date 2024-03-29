dv_check_preset:
  type: procedure
  definitions: script
  script:
  # | This following definition will never error.
  # All scripts passed into this task should (internally, at least) have this key.
  - define preset <[script].data_key[dv_preset]>
  - define missing <list[name|blocks].exclude[<[preset].keys>]>

  - if <[missing].any>:
    - determine "<proc[dv_ERR_SCRIPT_MLF].context[<[script]>|is missing the following required keys under the <&sq><aqua>dv_preset<white><&sq> key: <red><[missing].comma_separated>]>"

  # Assuming the required keys have been accounted for, it is safe to check them without fallbacks.
  - define blocks <[preset].get[blocks]>

  - if !<[blocks].keys.exists>:
    - determine "<proc[dv_ERR_SCRIPT_MLF].context[<[script]>|has a non-map value for the <&sq><aqua>blocks<white><&sq> key.]>"

  - debug log <[blocks]>
  - define ur_keys <[blocks].keys.filter[proc[dv_invalid_mat]]>
  - define ur_vals <[blocks].values.combine.filter[proc[dv_invalid_mat]]>

  - if <[ur_keys].any>:
    - determine <proc[dv_ERR_INVALID_MATS].context[<[script]>|key|<[ur_keys].comma_separated>]>

  - if <[ur_vals].any>:
    - determine <proc[dv_ERR_INVALID_MATS].context[<[script]>|value|<[ur_vals].comma_separated>]>

  - if <[ur_keys].any> || <[ur_vals].any>:
    - determine false

  # "chance" being an integer shouldn't have to be accounted for in the percentage check.
  - if <[preset].get[chance].exists> && !<[preset].get[chance].is_decimal>:
    - determine "<proc[dv_ERR_SCRIPT_MLF].context[<[script]>|has a non-number value for the <&sq><aqua>chance<white><&sq> key.]>"

  - determine true