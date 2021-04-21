dv_reload:
  type: task
  script:
  - flag server dv_valid:true
  - inject dv_check_build
  - run dv_load_presets
  - run dv_remove_outdated_flags