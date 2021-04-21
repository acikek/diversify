dv_ERR_INVALID_MATS:
  type: task
  definitions: script|type|l
  script:
  - debug debug <[l]>
  - run dv_ERR_SCRIPT_MLF "def:<[script]>|contains the following invalid material <[type]>(s) under the <&sq><aqua>blocks<white><&sq> key: <red><[l].comma_separated>"