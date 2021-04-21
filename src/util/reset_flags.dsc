dv_reset_flags:
  type: task
  definitions: flag
  script:
  - foreach <server.players_flagged[<[flag]>]> as:p:
    - flag <[p]> <[flag]>:!