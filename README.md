# 059
Custom hacked client to game RotMG.
<br>Development frozen indefinitely.
## Requirements
- [IntelliJ IDEA](https://en.wikipedia.org/wiki/IntelliJ_IDEA) / [Flash Develop](https://en.wikipedia.org/wiki/FlashDevelop)
- [Apache Flex](https://en.wikipedia.org/wiki/Apache_Flex)
## Installation
[Video](https://www.youtube.com/watch?v=zBKwq1ayeHw)
<br>This method implies you already have successfully installed Apache Flex and IntelliJ IDEA.
<br>
1. Download the repository and unpack somewhere on your PC.
```
git clone https://github.com/Gravitir314/059.git
```
2. Run IntelliJ IDEA.
3. In Welcome Window click to the "Create New Project".
4. Select your Apache Flex SDK and set parameters as on screenshot.
![](https://i.imgur.com/wtqadjd.png)
5. On next step, select in the "Project location" path to downloaded repository.
6. Thereafter you should see main window, where you will work.
7. Open "Project Structure" in tab "File" (Ctrl+Alt+Shift+S).
<br>7.1. Project:
- Select your Apache Flex SDK.
- Select "Project language level" to Experimental.
<br>7.2. Modules:
- Open your module and in "General" change "Main class" to ROTMG.
- Optionally in "General" you can change "Output file name" and "Output folder".
- Go to "Compiler Options", uncheck "Copy resource files to output folder" and add your options to "Additional compiler options":
```
-default-size 800 600 -default-frame-rate 60 -default-background-color #000000 -swf-version=31 -optimize -use-network=true
```
<br>7.3. Libraries:
- Click to the plus and add new "ActionScript/Flex" libraries, they located in repository/lib.
8. Close the "Project Structure", in the upper right corner you can find your build configurations and buttons to build client.
## Finished
- /con (CC Edition)
- Auto Aim
- Auto Ability
- Accounts list
- Anti-Debuffs
- Auto Claim Calendar
- Auto Nexus
- Auto Responder
- Auto Sync HP
- Auto Version Updater
- Auto Loot (Commands not tested)
- Big Loot Bags
- Change Dye
- Change Skin (not toggleable by SS-Mode)
- Chat Length
- Custom Hotkeys
- Custom Sounds
- Custom Glow
- Disable Shot Rotation
- Even Lower Graphics Mode
- Event Notification
- FameBot
- Full-Screen V3 (+Steam)
- Hide non-locked players
- Hide pets (Your will stay)
- Ignore Ice and Push
- Inventories Switch
- Lite stat monitor
- Loot Preview
- Low CPU Mode
- Map Hack
- Mob Info
- Mob Insta Kill
- Mobs HP Counter [X/X left]
- New UI
- No Trade Delay
- Percent of Damage
- Projectile No-Clip
- Player Following (Portals/Nexus too)
- Quest Bar (CC Edition)
- RC-Ability
- RC-Quest-Following
- RC-Tilt-Camera
- RC-Select Items on Trade
- Reconnects
- Refresh Account
- Safe Walk
- ScreenShot Mode
- Teleport to Anchor
- Teleport to Quest
- Teleport to Self
- Timers
- Toggle Skin/Dye
- Transparent players
- Vault Switch
- Vaults Preview
- Vial Checker (Not tested)
- Weapon Offset
## TODO
- DB Keys
- Tomb Hack
- Controller Input (Can't test)
- Fix Hardware Acceleration with Fullscreen