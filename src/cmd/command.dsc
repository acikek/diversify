dv_command:
  type: command
  name: diversify
  description: The Diversify command tool
  usage: /diversify (help/info/preset/reload/reset) (current/info/list/off/use) (<&lt>preset<&gt>)
  aliases:
  - dv
  tab completions:
    1: <player.is_op.if_true[help|info|preset|reload|reset].if_false[preset]>
    2: <context.args.get[1].equals[preset].if_true[current|info|list|off|use].if_false[<context.args.get[1].equals[reset].if_true[confirm].if_false[]>]>
    3: <list[info|use].contains[<context.args.get[2]>].if_true[<server.flag[dv_presets].parse[data_key[dv_preset].get[name]]>].if_false[]>
  script:
  - if !<context.args.get[1].exists>:
    - if <player.has_flag[dv_enabled]>:
      - flag <player> dv_enabled:!
      - define state <red>off
    - else:
      - flag <player> dv_enabled:true
      - define state <green>on
    - narrate "<gray>Diversify has been turned <[state]><gray>."
    - stop

  - choose <context.args.get[1]>:
    - case help:
      - define help <script[dv_help].data_key[help]>

      - narrate "<yellow><&gt><&gt> <gold>Diversify Commands"
      - narrate "<[help].parse_tag[<green>/<context.alias> <[parse_value].unescaped.replace_text[:].with[<gray>:]>].separated_by[<n>]>"
    - case info:
      - define info <script[dv_info].data_key[info]>

      - narrate "<yellow><&gt><&gt> <gold>Diversify v<[info].get[version]> <gray>by <green><[info].get[author]>"
      - narrate "<yellow>Diversify is an efficient and powerful tool for adding variety and texture to your builds.<n>Using a Preset Script system, this tool is able to randomly modify placed blocks that correspond to different materials, all specified in the preset data.<n>With the addition of the command tool, Diversify is both scripter- and user-friendly!<n><aqua>Visit the <dark_aqua><element[homepage].underline.on_click[<[info].get[repo]>].type[OPEN_URL]> <aqua>for documentation and more info!"
    - case preset:
      - if !<context.args.get[2].exists>:
        - inject dv_command_ERR_INVALID_ARGUMENT

      - choose <context.args.get[2]>:
        - case current:
          - inject dv_command_ERROR_NO_PRESET
          - narrate "<gray>You're using the <yellow><player.flag[dv_preset].data_key[dv_preset].get[name]> <gray>preset."
        - case info:
          - define name <context.args.get[3].if_null[null]>
          - inject dv_command_presets_single

          - define data <[preset].data_key[dv_preset]>
          - define blocks <[data].get[blocks]>

          - narrate "<yellow><&gt><&gt> <gold>Diversify Preset <&dq><aqua><[data].get[name]><gold><&dq> <gray>- <italic><[data].get[description].if_null[No description]>"
          - narrate "<yellow>Convert chance<gray>: <gold><[data].get[chance].if_null[33]><&pc>"
          - narrate "<yellow>Block list<gray>:"

          - narrate "<[blocks].keys.parse_tag[<yellow>- <[parse_value]>: <aqua><list[<[blocks].get[<[parse_value]>]>].comma_separated>].separated_by[<n>]>"
        - case list:
          - define presets <server.flag[dv_presets]>
          - define page <context.args.get[3].if_null[1]>
          - define pages <[presets].size.div[8].truncate.add[1]>

          - if <[page]> < 1:
            - define page 1
          - else if <[page]> > <[pages]>:
            - define page <[pages]>

          - narrate "<yellow><&gt><&gt> <gold>Diversify Presets <gray>(<[page]>/<[pages]>)<gold>"

          # | Long tag explanation!
          # The list of presets gets sorted alphabetically by the dv_preset internal name, not the script name.
          # It then gets the indexes determined by the chosen page number.
          # Each script is then parsed as the dv_preset MapTag, since the base script is no longer needed.
          # Each of those MapTags are parsed into the name, which:
          # - on hover, displays "Click to enable"
          # - on click, runs a command to enable that preset
          # and the description, if it has one (defaults to "No description")
          # Finally, all of these get joined by a newline.
          - narrate "<[presets].sort_by_value[data_key[dv_preset].get[name]].get[<[page].sub[1].mul[8].add[1]>].to[<[page].mul[8]>].parse[data_key[dv_preset]].parse_tag[<yellow><[parse_value].get[name].on_hover[<green>Click to enable].on_click[/dv preset use <[parse_value].get[name]>].type[RUN_COMMAND]><gray>: <[parse_value].get[description].if_null[No description]>].separated_by[<n>]>"
        - case off:
          - inject dv_command_ERROR_NO_PRESET
          - flag player dv_preset:!
          - narrate "<green>Successfully removed your preset."
        - case use:
          - define name <context.args.get[3].if_null[null]>
          - inject dv_command_presets_single

          - flag player dv_preset:<[preset]>
          - narrate "<gray>Now using the <yellow><[preset].data_key[dv_preset].get[name]> <gray>preset."
        - default:
          - inject dv_command_ERR_INVALID_ARGUMENT
    - case reload:
      - inject dv_command_ERR_NOT_OP
      - run dv_reload
      - narrate "<green>Reload complete."
    - case reset:
      - inject dv_command_ERR_NOT_OP

      - if <context.args.get[2].if_null[null]> == confirm:
        - run dv_reset_flags def:dv_enabled
        - run dv_reset_flags def:dv_preset
        - narrate "<green>Reset complete."
        - stop

      - narrate "<gray>Running this command will <red>reset Diversify player data<gray>."
      - narrate "<gray>To continue, run <yellow>/<context.alias> reset confirm<gray>."
    - default:
      - inject dv_command_ERR_INVALID_ARGUMENT