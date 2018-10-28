# 059
Custom hacked client to game RotMG
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
- Custom Sounds
- Event Notification
- Anti-Debuffs
- AutoLoot (Commands not tested)
- Accounts list
- Auto Nexus
- Auto Sync HP
- Mob Insta Kill
- Auto Responder
- Auto Claim Calendar
- Weapon Offset
- Teleport to Quest
- Ignore Ice and Push
- Safe Walk
- Reconnects
- Hide non-locked players
- Hide pets (Your will stay)
- Loot Preview
- Percent of Damage
- Lite stat monitor
- Mob Info
- Even Lower Graphics Mode
- Transparent players
- Big Loot Bags
- Map Hack
- Disable Shot Rotation
- Quest Bar (CC Edition)
- ScreenShot Mode
- Teleport to Self
- No Trade Delay
- Projectile No-Clip
- RC-Quest-Following
- RC-Ability
- RC-Tilt-Camera
- Chat Length
- Full-Screen V3
- Teleport to Anchor
- Vaults Preview
- /con (CC Edition)
- Inventories Switch (?)
- Vault Switch (?)
- Low CPU Mode
- Timers
## TODO
- Auto Aim
- Auto Ability
- FameBot
- New HUD
- Custom Hotkeys
- Toggle Skin/Dye
- Change Skin
- Mobs HP Counter [X/X left]
