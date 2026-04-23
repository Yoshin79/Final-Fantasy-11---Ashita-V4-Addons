
# missiontracker — FFXI Mission Tracker for Ashita v4

Track all FFXI mission lines with step-by-step walkthroughs, prerequisite quest lists,
and per-character completion checkboxes — all inside a resizable ImGui window.

---

## Installation

1. Copy the `missiontracker/` folder into:
   ```
   <Ashita v4 root>/addons/
   ```
   So the path is: `Ashita/addons/missiontracker/missiontracker.lua`

2. Load the addon in-game:
   ```
   /addon load missiontracker
   ```
   Or add it to your `Ashita/config/boot/default.lua` to auto-load:
   ```lua

---

## Commands

| Command | Description |
|---|---|
| `/mt` | Toggle the window open/closed |
| `/mt show` | Show the window |
| `/mt hide` | Hide the window |
| `/mt reset` | Reset completion data for your current character (prompts confirmation) |

---

## Features

- **9 Mission Lines** covered:
  - Bastok Missions (Rank 1–10)
  - San d'Oria Missions (Rank 1–10)
  - Windurst Missions (Rank 1–10)
  - Rise of the Zilart (ZM1–ZM17)
  - Chains of Promathia (CoP 1-1 through 8-4)
  - Treasures of Aht Urhgan (TOAU 1–44)
  - Wings of the Goddess (WotG 1–38)
  - Seekers of Adoulin (SoA 1-1 through 5-1)
  - Rhapsodies of Vana'diel (RoV 1-1 through Final)

- **Per-mission checkboxes** — saved to `Ashita/config/missiontracker/<charname>.json`
- **Collapsible prerequisite dropdowns** — see what's required before each mission
- **Step-by-step walkthroughs** — key locations, NPCs, and objectives
- **Reward display** per mission
- **Entry requirements** shown at the top of each mission line
- **Search bar** — filter missions by name or number
- **Group filter buttons** — jump to a specific expansion
- **Global completion counter** in the window header
- **Per-character save files** — switches automatically when you change characters
- **Resizable and movable** window (standard ImGui drag/resize)

---

## Save File Location

```
Ashita/config/missiontracker/<CharacterName>.json
```

Each character has their own file. Backup or share these files to preserve progress.

---

## Data Sources

- Final Fantasy 11 - Game Play Since Launch
- Online Forums - Searches
- https://www.bg-wiki.com
- https://ffxiclopedia.fandom.com/ 

---

## Expanding Mission Data

All mission data is at the top of `missiontracker.lua` in the `MISSION_LINES` table.
Each entry follows this structure:

```lua
{ num='1-1', name='Mission Name',
  steps={
      'Step 1 description.',
      'Step 2 description.',
  },
  prereqs={
      {name='Previous Mission Name'},
      {name='Other requirement'},
  },
  rewards={'Reward 1', 'Reward 2'} },
```

Add new missions, expand step details, or add missing missions by editing that table.

---

## Changelog


- Initial release
- All 9 major mission lines with steps, prerequisites, rewards
- Per-character JSON save system
- Search, filter, collapsible UI
