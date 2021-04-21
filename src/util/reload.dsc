dv_reload:
  type: task
  script:
  - run dv_load_presets
  - run dv_remove_outdated_flags