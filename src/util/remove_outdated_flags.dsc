dv_remove_outdated_flags:
  type: task
  script:
  - foreach <server.players_flagged[dv_preset]> as:p:
    - if !<server.flag[dv_presets].contains[<[p].flag[dv_preset]>]>:
      - flag <[p]> dv_preset:!