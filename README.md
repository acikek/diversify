# diversify

## About

Diversify is a [DenizenScript](https://denizenscript.com) module that allows Minecraft builders to add variety to their creations.

* Accessible command tool
* Uses a Preset Script system
* Extentable, customizable
* Efficient and lightweight

## Installation

**This project requires [Denizen build 1736](https://ci.citizensnpcs.co/job/Denizen/1736/) or newer.**

In your server folder, navigate to the `scripts` directory, and clone this repository.

```sh
cd plugins/Denizen/scripts
git clone https://github.com/acikek/diversify
```

Run `/ex reload` in-game - and that's it!

## Usage

### By Example

To enable Diversify on your user, run `/dv`, which toggles the building mode. If you try placing blocks, nothing happens yet - don't worry, you need to enable a preset.

To see the list of current presets loaded on the server, run `/dv preset list`. If you included the example presets, `ancient` and `rainbow`, you'll see them and their descriptions included in the displayed list.

To enable a preset, run `/dv preset use <name>`. Alternatively, click the name of the preset (in yellow) in the list. For this instance, enable the `rainbow` preset.

Now, start placing some white wool. Every time it gets placed, it should immediately turn into a random colored wool block. Many presets are more complicated than this, though, so if you need to view more information about a preset, run `/dv preset info <name>`.

If you forget which preset you have enabled, run `/dv preset current`. If you'd like to disable your current present, run `/dv preset off`. If you're a server operator, you can reset all Diversify player data with `/dv reset`, or initialize the reloading process with `/dv reload`.

To view all the sub-commands and their description, run `/dv help`!

### Custom Presets

All Preset Scripts are data scripts that include the `dv_preset` key. This map specifies:

* **name**: The preset name
* **description**: The description (optional)
* **chance**: The chance that placed blocks will be modified for this preset (optional, must be an integer from 0-100)
* **blocks**: The block data*, with keys acting as the placed block and the values being the new block (**must** be a map, values can either be elements or lists)

*All keys and values **must** be valid material names.

Below is a sample Preset Script:

```yml
dv_preset_underground:
  type: data
  dv_preset:
    name: Underground
    description: Cave-like generation
    chance: 25
    blocks:
      stone:
      - coal_ore
      - iron_ore
      - redstone_ore
      - gold_ore
      - diamond_ore
      cobblestone: mossy_cobblestone
      andesite:
      - andesite_slab
      - andesite_stairs
```

Preset Scripts can be placed anywhere, and they will be loaded in after the server starts or after reloading. Note that each script is run through a strict checker, and any errors with the script will be logged in the console.

## Scripts

All scripts used in this project, apart from dependencies, are prefixed with the `dv_` namespace.

### Task

* `dv_check_build`
* `dv_load_presets`
* `dv_reload`
* `dv_remove_outdated_flags`
* `dv_reset_flags`
* `dv_command_presets_single`
* `dv_command_presets`
* `dv_command_ERR_INVALID_ARGUMENT`
* `dv_command_ERR_INVALID_VERSION`
* `dv_command_ERR_NO_PRESET`
* `dv_command_ERR_NOT_OP`

### Procedure

* `dv_check_preset`
* `dv_invalid_mat`
* `dv_pass`
* `dv_percentage_chance`
* `dv_ERR_INVALID_MATS`
* `dv_ERR_SCRIPT_MLF`
* `dv_command_tab_complete_preset`

### Command

* `dv_command`

### Data

**Required**:
* `dv_help`
* `dv_info`
* `dv_command_tab_complete`

**Preset Examples**:
* `dv_preset_ancient`
* `dv_preset_rainbow`

### World

* `dv_diversify`
* `dv_on_load`

### Dependencies

* [`tab_complete`](https://forum.denizenscript.com/viewtopic.php?f=9&t=299)