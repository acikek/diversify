#| TabComplete Engine
#| @author zozer_firehood
#| @homepage https://forum.denizenscript.com/viewtopic.php?f=9&t=299

tab_complete:
  type: procedure
  debug: false
  definitions: command|data|raw_args
  script:
    - define raw_args <[raw_args].if_null[<empty>]>
    - define path <[command]>
    - define script <script[<[data]>]>
    - define "args:|:<[raw_args].split[ ]>"
    - if <[args].get[1]> == <empty>:
      - define args:!|:<[args].remove[1]>
    - define argsSize <[args].size>
    - define newArg <[raw_args].ends_with[<&sp>].or[<[raw_args].is[==].to[<empty>]>]>
    - if <[newArg]>:
      - define argsSize:+:1
    - repeat <[argsSize].sub[1]> as:index:
      - define value <[args].get[<[index]>]>
      - define keys:!|:<[script].list_keys[<[path]>]>
      - define permLockedKeys:!|:<[keys].filter[starts_with[?]]>
      - define keys:<-:<[permLockedKeys]>
      - if <[value]> == <empty>:
        - foreach next
      - if <[keys].contains[<[value]>]>:
        - define path <[path]>.<[value]>
      - else:
        - if <[permLockedKeys].size> > 0:
          - define permMap "<[permLockedKeys].parse[after[ ]].map_with[<[permLockedKeys].parse[before[ ]]>]>"
          - define perm <[permMap].get[<[value]>].if_null[null]>
          - if <[perm]> != null && <player.has_permission[<[perm].after[?]>]>:
            - define path "<[path]>.<[perm]> <[value]>"
            - repeat next
        - define default <[keys].filter[starts_with[_]].get[1].if_null[null]>
        - if <[default]> == null:
          - determine <list[]>
        - define path <[path]>.<[default]>
      - if <[script].data_key[<[path]>]> == end:
        - determine <list[]>
    - foreach <[script].list_keys[<[path]>]>:
      - if <[value].starts_with[_]>:
        - define value <[value].after[_]>
        - if <[value].starts_with[*]>:
          - define ret:|:<proc[<[data]>_<[value].after[*]>].context[<[args]>]>
      - else if <[value].starts_with[?]>:
        - define perm "<[value].before[ ].after[?]>"
        - if <player.has_permission[<[perm]>]>:
          - define "ret:|:<[value].after[ ]>"
      - else:
        - define ret:->:<[value]>
    - if !<definition[ret].exists>:
      - determine <list[]>
    - if <[newArg]>:
      - determine <[ret]>
    - determine <[ret].filter[starts_with[<[args].last>]]>