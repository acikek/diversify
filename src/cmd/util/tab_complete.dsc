dv_command_tab_complete:
  type: data
  diversify:
    help: end
    info: end
    preset:
      current: end
      info:
        _*preset: end
      list: end
      off: end
      use:
        _*preset: end
    reload: end
    reset: end

dv_command_tab_complete_preset:
  type: procedure
  script:
  - determine <server.flag[dv_presets].parse[data_key[dv_preset].get[name]]>