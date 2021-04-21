dv_command_presets_single:
  type: task
  definitions: name
  script:
  - inject dv_command_presets

  - if <[presets].size> > 1:
    - narrate "<red>Warning: There are multiple presets with this name."
    - narrate "<red>Script chosen: <gray><[preset]>"

  - define preset <[presets].first>