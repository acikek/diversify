dv_command_ERR_NOT_OP:
  type: task
  script:
  - if !<player.is_op>:
    - narrate "<red>You don't have permission to perform this command."
    - stop