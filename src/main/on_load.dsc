dv_on_load:
  type: world
  events:
    after server start:
    - run dv_reload
    after reload scripts:
    - run dv_reload