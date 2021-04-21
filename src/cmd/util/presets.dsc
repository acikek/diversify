dv_command_presets:
  type: task
  definitions: name
  script:
  - if <[name]> == null:
    - narrate "<red>No preset name provided."
    - stop

  - define presets <server.flag[dv_presets].filter[data_key[dv_preset].get[name].to_lowercase.equals[<[name]>]]>

  - if <[presets].is_empty>:
    - narrate "<red>Invalid preset name."
    - stop