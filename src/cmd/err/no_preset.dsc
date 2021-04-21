dv_command_ERR_NO_PRESET:
  type: task
  script:
  - if !<player.has_flag[dv_preset]>:
    - narrate "<red>You don't have a preset enabled."
    - stop