dv_check_preset:
  type: procedure
  definitions: script
  script:
  # | This following definition will never error.
  # All scripts passed into this task should (internally, at least) have this key.
  - define preset <[script].data_key[dv_preset]>
  - define missing <list[name|blocks].exclude[<[preset].keys>]>

  - if <[missing].any>:
    - run dv_ERR_SCRIPT_MLF "def:<[script]>|is missing the following required keys under the <&sq><aqua>dv_preset<white><&sq> key: <red><[missing].comma_separated>"
    - determine false

  # Assuming the required keys have been accounted for, it is safe to check them without fallbacks.
  - define blocks <[preset].get[blocks]>

  - if !<[blocks].keys.exists>:
    - run dv_ERR_SCRIPT_MLF "def:<[script]>|has a non-map value for the <&sq><aqua>blocks<white><&sq> key."
    - determine false

  - debug log <[blocks]>
  - define ur_keys <[blocks].keys.filter[proc[dv_invalid_mat]]>
  - define ur_vals <[blocks].values.combine.filter[proc[dv_invalid_mat]]>

  - if <[ur_keys].any>:
    - run dv_ERR_INVALID_MATS def:<[script]>|key def.l:<[ur_keys]>

  - if <[ur_vals].any>:
    - run dv_ERR_INVALID_MATS def:<[script]>|value def.l:<[ur_vals]>

  - if <[ur_keys].any> || <[ur_vals].any>:
    - determine false

  # "chance" being an integer shouldn't have to be accounted for in the percentage check.
  - if <[preset].get[chance].exists> && !<[preset].get[chance].is_decimal>:
    - run dv_ERR_SCRIPT_MLF "def:<[script]>|has a non-number value for the <&sq><aqua>chance<white><&sq> key."
    - determine false

  - determine true