dv_diversify:
  type: world
  events:
    on player places block flagged:dv_preset server_flagged:dv_valid:
    - if <player.has_flag[dv_enabled]>:
      - define preset <player.flag[dv_preset]>
      - define blocks <[preset].data_key[dv_preset].get[blocks]>
      - define prev <context.material>

      - if <[blocks].contains[<[prev].name>]> && <proc[dv_pass].context[<[preset]>]>:
        # A random material from the list of blocks the key corresponds to
        # Wrapped in another list to resolve ambiguity between elements and lists
        - define material <material[<list[<[blocks].get[<[prev].name>]>].random>]>
        # Applies all the supported mechanisms of the previous material to the new one
        - define new <[material].with_map[<[prev].property_map.filter_tag[<[material].supports[<[filter_key]>]>]>]>
        # Places the new block
        - modifyblock <context.location> <[new]>