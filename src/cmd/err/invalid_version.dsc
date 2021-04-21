dv_command_ERR_INVALID_VERSION:
  type: task
  script:
  - if !<server.has_flag[dv_valid]>:
    - narrate "<red>The server's Denizen build is out-of-date; update it to use Diversify features."
    - stop