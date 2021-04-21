dv_load_presets:
  type: task
  script:
  - define preset_scripts <server.scripts.filter[list_keys.contains[dv_preset]]>
  - define err " No errors encountered."

  - if <[preset_scripts].any>:
    - debug approval "Starting Diversify load process with <[preset_scripts].size> Preset Script(s): <aqua><[preset_scripts].parse[name].comma_separated>"

  - foreach <[preset_scripts]> as:ps:
    - define eval <proc[dv_check_preset].context[<[ps]>]>
    - if <[eval].is_boolean>:
      - define result:->:<[ps]>
    - else:
      - debug error <[eval]>

  - if <[result].size> < <[preset_scripts].size>:
    - define err " Encountered <[preset_scripts].size.sub[<[result].size>]> errored script(s)."

  - debug approval "Diversify load process complete.<[err]>"
  - flag server dv_presets:<[result]>