dv_check_build:
  type: task
  script:
  - define cb "<server.denizen_version.after[build ].before[-]>"
  - define ib <script[dv_info].data_key[info].get[dsc_build]>

  - if <[cb]> < <[ib]>:
    - debug error "Diversify requires Denizen build <[ib]> or newer (your build: <[cb]>). Make sure your Denizen build is always up-to-date."
    - flag server dv_valid:!
    - stop