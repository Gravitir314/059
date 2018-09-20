//zfn.sound.SoundAssets

package zfn.sound
{
import com.company.assembleegameclient.sound.SoundEffectLibrary;

import flash.media.Sound;
import flash.utils.Dictionary;

public class SoundAssets 
    {

		[Embed(source="ParsedSounds/sorc.mp3", mimeType="application/octet-stream")]
		public static const sorcEmbed:Class;
		[Embed(source="ParsedSounds/button_click.mp3", mimeType="application/octet-stream")]
		public static const button_clickEmbed:Class;
		[Embed(source="ParsedSounds/death_screen.mp3", mimeType="application/octet-stream")]
		public static const death_screenEmbed:Class;
		[Embed(source="ParsedSounds/error.mp3", mimeType="application/octet-stream")]
		public static const errorEmbed:Class;
		[Embed(source="ParsedSounds/inventory_move_item.mp3", mimeType="application/octet-stream")]
		public static const inventory_move_itemEmbed:Class;
		[Embed(source="ParsedSounds/level_up.mp3", mimeType="application/octet-stream")]
		public static const level_upEmbed:Class;
		[Embed(source="ParsedSounds/loot_appears.mp3", mimeType="application/octet-stream")]
		public static const loot_appearsEmbed:Class;
		[Embed(source="ParsedSounds/no_mana.mp3", mimeType="application/octet-stream")]
		public static const no_manaEmbed:Class;
		[Embed(source="ParsedSounds/char_select.mp3", mimeType="application/octet-stream")]
		public static const char_selectEmbed:Class;
		[Embed(source="ParsedSounds/chicken_hit.mp3", mimeType="application/octet-stream")]
		public static const chicken_hitEmbed:Class;
		[Embed(source="ParsedSounds/chicken_death.mp3", mimeType="application/octet-stream")]
		public static const chicken_deathEmbed:Class;
		[Embed(source="ParsedSounds/pirates_hit.mp3", mimeType="application/octet-stream")]
		public static const pirates_hitEmbed:Class;
		[Embed(source="ParsedSounds/pirates_death.mp3", mimeType="application/octet-stream")]
		public static const pirates_deathEmbed:Class;
		[Embed(source="ParsedSounds/skeletons_hit.mp3", mimeType="application/octet-stream")]
		public static const skeletons_hitEmbed:Class;
		[Embed(source="ParsedSounds/skeletons_death.mp3", mimeType="application/octet-stream")]
		public static const skeletons_deathEmbed:Class;
		[Embed(source="ParsedSounds/dark_elves_hit.mp3", mimeType="application/octet-stream")]
		public static const dark_elves_hitEmbed:Class;
		[Embed(source="ParsedSounds/dark_elves_death.mp3", mimeType="application/octet-stream")]
		public static const dark_elves_deathEmbed:Class;
		[Embed(source="ParsedSounds/trees_hit.mp3", mimeType="application/octet-stream")]
		public static const trees_hitEmbed:Class;
		[Embed(source="ParsedSounds/trees_death.mp3", mimeType="application/octet-stream")]
		public static const trees_deathEmbed:Class;
		[Embed(source="ParsedSounds/bats_hit.mp3", mimeType="application/octet-stream")]
		public static const bats_hitEmbed:Class;
		[Embed(source="ParsedSounds/bats_death.mp3", mimeType="application/octet-stream")]
		public static const bats_deathEmbed:Class;
		[Embed(source="ParsedSounds/default_hit.mp3", mimeType="application/octet-stream")]
		public static const default_hitEmbed:Class;
		[Embed(source="ParsedSounds/scorpions_hit.mp3", mimeType="application/octet-stream")]
		public static const scorpions_hitEmbed:Class;
		[Embed(source="ParsedSounds/scorpions_death.mp3", mimeType="application/octet-stream")]
		public static const scorpions_deathEmbed:Class;
		[Embed(source="ParsedSounds/eggs_hit.mp3", mimeType="application/octet-stream")]
		public static const eggs_hitEmbed:Class;
		[Embed(source="ParsedSounds/eggs_death.mp3", mimeType="application/octet-stream")]
		public static const eggs_deathEmbed:Class;
		[Embed(source="ParsedSounds/spiders_hit.mp3", mimeType="application/octet-stream")]
		public static const spiders_hitEmbed:Class;
		[Embed(source="ParsedSounds/spiders_death.mp3", mimeType="application/octet-stream")]
		public static const spiders_deathEmbed:Class;
		[Embed(source="ParsedSounds/spider_queen_hit.mp3", mimeType="application/octet-stream")]
		public static const spider_queen_hitEmbed:Class;
		[Embed(source="ParsedSounds/spider_queen_death.mp3", mimeType="application/octet-stream")]
		public static const spider_queen_deathEmbed:Class;
		[Embed(source="ParsedSounds/dwarves_hit.mp3", mimeType="application/octet-stream")]
		public static const dwarves_hitEmbed:Class;
		[Embed(source="ParsedSounds/dwarves_death.mp3", mimeType="application/octet-stream")]
		public static const dwarves_deathEmbed:Class;
		[Embed(source="ParsedSounds/golems_hit.mp3", mimeType="application/octet-stream")]
		public static const golems_hitEmbed:Class;
		[Embed(source="ParsedSounds/stone_walls_death.mp3", mimeType="application/octet-stream")]
		public static const stone_walls_deathEmbed:Class;
		[Embed(source="ParsedSounds/rocks_hit.mp3", mimeType="application/octet-stream")]
		public static const rocks_hitEmbed:Class;
		[Embed(source="ParsedSounds/rocks_death.mp3", mimeType="application/octet-stream")]
		public static const rocks_deathEmbed:Class;
		[Embed(source="ParsedSounds/cyclops_hit.mp3", mimeType="application/octet-stream")]
		public static const cyclops_hitEmbed:Class;
		[Embed(source="ParsedSounds/cyclops_death.mp3", mimeType="application/octet-stream")]
		public static const cyclops_deathEmbed:Class;
		[Embed(source="ParsedSounds/golems_death.mp3", mimeType="application/octet-stream")]
		public static const golems_deathEmbed:Class;
		[Embed(source="ParsedSounds/cubes_hit.mp3", mimeType="application/octet-stream")]
		public static const cubes_hitEmbed:Class;
		[Embed(source="ParsedSounds/cubes_death.mp3", mimeType="application/octet-stream")]
		public static const cubes_deathEmbed:Class;
		[Embed(source="ParsedSounds/sprites_hit.mp3", mimeType="application/octet-stream")]
		public static const sprites_hitEmbed:Class;
		[Embed(source="ParsedSounds/sprites_death.mp3", mimeType="application/octet-stream")]
		public static const sprites_deathEmbed:Class;
		[Embed(source="ParsedSounds/lizard_god_hit.mp3", mimeType="application/octet-stream")]
		public static const lizard_god_hitEmbed:Class;
		[Embed(source="ParsedSounds/lizard_god_death.mp3", mimeType="application/octet-stream")]
		public static const lizard_god_deathEmbed:Class;
		[Embed(source="ParsedSounds/orcs_hit.mp3", mimeType="application/octet-stream")]
		public static const orcs_hitEmbed:Class;
		[Embed(source="ParsedSounds/orcs_death.mp3", mimeType="application/octet-stream")]
		public static const orcs_deathEmbed:Class;
		[Embed(source="ParsedSounds/blobs_hit.mp3", mimeType="application/octet-stream")]
		public static const blobs_hitEmbed:Class;
		[Embed(source="ParsedSounds/blobs_death.mp3", mimeType="application/octet-stream")]
		public static const blobs_deathEmbed:Class;
		[Embed(source="ParsedSounds/slimes_hit.mp3", mimeType="application/octet-stream")]
		public static const slimes_hitEmbed:Class;
		[Embed(source="ParsedSounds/slimes_death.mp3", mimeType="application/octet-stream")]
		public static const slimes_deathEmbed:Class;
		[Embed(source="ParsedSounds/mummies_hit.mp3", mimeType="application/octet-stream")]
		public static const mummies_hitEmbed:Class;
		[Embed(source="ParsedSounds/mummies_death.mp3", mimeType="application/octet-stream")]
		public static const mummies_deathEmbed:Class;
		[Embed(source="ParsedSounds/dragons_hit.mp3", mimeType="application/octet-stream")]
		public static const dragons_hitEmbed:Class;
		[Embed(source="ParsedSounds/dragons_death.mp3", mimeType="application/octet-stream")]
		public static const dragons_deathEmbed:Class;
		[Embed(source="ParsedSounds/stone_walls_hit.mp3", mimeType="application/octet-stream")]
		public static const stone_walls_hitEmbed:Class;
		[Embed(source="ParsedSounds/use_key.mp3", mimeType="application/octet-stream")]
		public static const use_keyEmbed:Class;
		[Embed(source="ParsedSounds/ogres_hit.mp3", mimeType="application/octet-stream")]
		public static const ogres_hitEmbed:Class;
		[Embed(source="ParsedSounds/ogres_death.mp3", mimeType="application/octet-stream")]
		public static const ogres_deathEmbed:Class;
		[Embed(source="ParsedSounds/flayers_hit.mp3", mimeType="application/octet-stream")]
		public static const flayers_hitEmbed:Class;
		[Embed(source="ParsedSounds/flayers_death.mp3", mimeType="application/octet-stream")]
		public static const flayers_deathEmbed:Class;
		[Embed(source="ParsedSounds/demons_hit.mp3", mimeType="application/octet-stream")]
		public static const demons_hitEmbed:Class;
		[Embed(source="ParsedSounds/demons_death.mp3", mimeType="application/octet-stream")]
		public static const demons_deathEmbed:Class;
		[Embed(source="ParsedSounds/undead_dwarves_hit.mp3", mimeType="application/octet-stream")]
		public static const undead_dwarves_hitEmbed:Class;
		[Embed(source="ParsedSounds/undead_dwarves_death.mp3", mimeType="application/octet-stream")]
		public static const undead_dwarves_deathEmbed:Class;
		[Embed(source="ParsedSounds/dwarf_god_hit.mp3", mimeType="application/octet-stream")]
		public static const dwarf_god_hitEmbed:Class;
		[Embed(source="ParsedSounds/dwarf_god_death.mp3", mimeType="application/octet-stream")]
		public static const dwarf_god_deathEmbed:Class;
		[Embed(source="ParsedSounds/night_elves_hit.mp3", mimeType="application/octet-stream")]
		public static const night_elves_hitEmbed:Class;
		[Embed(source="ParsedSounds/night_elves_death.mp3", mimeType="application/octet-stream")]
		public static const night_elves_deathEmbed:Class;
		[Embed(source="ParsedSounds/default_death.mp3", mimeType="application/octet-stream")]
		public static const default_deathEmbed:Class;
		[Embed(source="ParsedSounds/cave_pirates_hit.mp3", mimeType="application/octet-stream")]
		public static const cave_pirates_hitEmbed:Class;
		[Embed(source="ParsedSounds/flying_brain_death.mp3", mimeType="application/octet-stream")]
		public static const flying_brain_deathEmbed:Class;
		[Embed(source="ParsedSounds/wooden_walls_hit.mp3", mimeType="application/octet-stream")]
		public static const wooden_walls_hitEmbed:Class;
		[Embed(source="ParsedSounds/elves_death.mp3", mimeType="application/octet-stream")]
		public static const elves_deathEmbed:Class;
		[Embed(source="ParsedSounds/abyss_brutes_hit.mp3", mimeType="application/octet-stream")]
		public static const abyss_brutes_hitEmbed:Class;
		[Embed(source="ParsedSounds/abyss_brutes_death.mp3", mimeType="application/octet-stream")]
		public static const abyss_brutes_deathEmbed:Class;
		[Embed(source="ParsedSounds/medusa_hit.mp3", mimeType="application/octet-stream")]
		public static const medusa_hitEmbed:Class;
		[Embed(source="ParsedSounds/hobbits_hit.mp3", mimeType="application/octet-stream")]
		public static const hobbits_hitEmbed:Class;
		[Embed(source="ParsedSounds/hobbits_death.mp3", mimeType="application/octet-stream")]
		public static const hobbits_deathEmbed:Class;
		[Embed(source="ParsedSounds/undead_hobbits_hit.mp3", mimeType="application/octet-stream")]
		public static const undead_hobbits_hitEmbed:Class;
		[Embed(source="ParsedSounds/undead_hobbits_death.mp3", mimeType="application/octet-stream")]
		public static const undead_hobbits_deathEmbed:Class;
		[Embed(source="ParsedSounds/elves_hit.mp3", mimeType="application/octet-stream")]
		public static const elves_hitEmbed:Class;
		[Embed(source="ParsedSounds/goblins_hit.mp3", mimeType="application/octet-stream")]
		public static const goblins_hitEmbed:Class;
		[Embed(source="ParsedSounds/goblins_death.mp3", mimeType="application/octet-stream")]
		public static const goblins_deathEmbed:Class;
		[Embed(source="ParsedSounds/skull_shrine_hit.mp3", mimeType="application/octet-stream")]
		public static const skull_shrine_hitEmbed:Class;
		[Embed(source="ParsedSounds/wooden_walls_death.mp3", mimeType="application/octet-stream")]
		public static const wooden_walls_deathEmbed:Class;
		[Embed(source="ParsedSounds/pythons_hit.mp3", mimeType="application/octet-stream")]
		public static const pythons_hitEmbed:Class;
		[Embed(source="ParsedSounds/pythons_death.mp3", mimeType="application/octet-stream")]
		public static const pythons_deathEmbed:Class;
		[Embed(source="ParsedSounds/snake_queen_hit.mp3", mimeType="application/octet-stream")]
		public static const snake_queen_hitEmbed:Class;
		[Embed(source="ParsedSounds/snake_queen_death.mp3", mimeType="application/octet-stream")]
		public static const snake_queen_deathEmbed:Class;
		[Embed(source="ParsedSounds/pirate_king_hit.mp3", mimeType="application/octet-stream")]
		public static const pirate_king_hitEmbed:Class;
		[Embed(source="ParsedSounds/pirate_king_death.mp3", mimeType="application/octet-stream")]
		public static const pirate_king_deathEmbed:Class;
		[Embed(source="ParsedSounds/cave_pirates_death.mp3", mimeType="application/octet-stream")]
		public static const cave_pirates_deathEmbed:Class;
		[Embed(source="ParsedSounds/use_potion.mp3", mimeType="application/octet-stream")]
		public static const use_potionEmbed:Class;
		[Embed(source="ParsedSounds/blunt_sword.mp3", mimeType="application/octet-stream")]
		public static const blunt_swordEmbed:Class;
		[Embed(source="ParsedSounds/bladeSwing.mp3", mimeType="application/octet-stream")]
		public static const bladeSwingEmbed:Class;
		[Embed(source="ParsedSounds/long_sword.mp3", mimeType="application/octet-stream")]
		public static const long_swordEmbed:Class;
		[Embed(source="ParsedSounds/fire_sword.mp3", mimeType="application/octet-stream")]
		public static const fire_swordEmbed:Class;
		[Embed(source="ParsedSounds/glass_sword.mp3", mimeType="application/octet-stream")]
		public static const glass_swordEmbed:Class;
		[Embed(source="ParsedSounds/golden_sword.mp3", mimeType="application/octet-stream")]
		public static const golden_swordEmbed:Class;
		[Embed(source="ParsedSounds/mithril_sword.mp3", mimeType="application/octet-stream")]
		public static const mithril_swordEmbed:Class;
		[Embed(source="ParsedSounds/fire_wand.mp3", mimeType="application/octet-stream")]
		public static const fire_wandEmbed:Class;
		[Embed(source="ParsedSounds/magicShoot.mp3", mimeType="application/octet-stream")]
		public static const magicShootEmbed:Class;
		[Embed(source="ParsedSounds/missile_wand.mp3", mimeType="application/octet-stream")]
		public static const missile_wandEmbed:Class;
		[Embed(source="ParsedSounds/hells_fire_wand.mp3", mimeType="application/octet-stream")]
		public static const hells_fire_wandEmbed:Class;
		[Embed(source="ParsedSounds/wand_of_dark_magic.mp3", mimeType="application/octet-stream")]
		public static const wand_of_dark_magicEmbed:Class;
		[Embed(source="ParsedSounds/sprite_wand.mp3", mimeType="application/octet-stream")]
		public static const sprite_wandEmbed:Class;
		[Embed(source="ParsedSounds/wand_of_death.mp3", mimeType="application/octet-stream")]
		public static const wand_of_deathEmbed:Class;
		[Embed(source="ParsedSounds/fire_spray.mp3", mimeType="application/octet-stream")]
		public static const fire_sprayEmbed:Class;
		[Embed(source="ParsedSounds/blunt_dagger.mp3", mimeType="application/octet-stream")]
		public static const blunt_daggerEmbed:Class;
		[Embed(source="ParsedSounds/daggerSwing.mp3", mimeType="application/octet-stream")]
		public static const daggerSwingEmbed:Class;
		[Embed(source="ParsedSounds/dirk.mp3", mimeType="application/octet-stream")]
		public static const dirkEmbed:Class;
		[Embed(source="ParsedSounds/golden_dagger.mp3", mimeType="application/octet-stream")]
		public static const golden_daggerEmbed:Class;
		[Embed(source="ParsedSounds/obsidian_dagger.mp3", mimeType="application/octet-stream")]
		public static const obsidian_daggerEmbed:Class;
		[Embed(source="ParsedSounds/poison_fang_dagger.mp3", mimeType="application/octet-stream")]
		public static const poison_fang_daggerEmbed:Class;
		[Embed(source="ParsedSounds/mithril_dagger.mp3", mimeType="application/octet-stream")]
		public static const mithril_daggerEmbed:Class;
		[Embed(source="ParsedSounds/fire_dagger.mp3", mimeType="application/octet-stream")]
		public static const fire_daggerEmbed:Class;
		[Embed(source="ParsedSounds/poor_quality_bow.mp3", mimeType="application/octet-stream")]
		public static const poor_quality_bowEmbed:Class;
		[Embed(source="ParsedSounds/arrowShoot.mp3", mimeType="application/octet-stream")]
		public static const arrowShootEmbed:Class;
		[Embed(source="ParsedSounds/crossbow.mp3", mimeType="application/octet-stream")]
		public static const crossbowEmbed:Class;
		[Embed(source="ParsedSounds/fire_bow.mp3", mimeType="application/octet-stream")]
		public static const fire_bowEmbed:Class;
		[Embed(source="ParsedSounds/double_bow.mp3", mimeType="application/octet-stream")]
		public static const double_bowEmbed:Class;
		[Embed(source="ParsedSounds/heavy_crossbow.mp3", mimeType="application/octet-stream")]
		public static const heavy_crossbowEmbed:Class;
		[Embed(source="ParsedSounds/golden_bow.mp3", mimeType="application/octet-stream")]
		public static const golden_bowEmbed:Class;
		[Embed(source="ParsedSounds/fire_nova.mp3", mimeType="application/octet-stream")]
		public static const fire_novaEmbed:Class;
		[Embed(source="ParsedSounds/magic_nova.mp3", mimeType="application/octet-stream")]
		public static const magic_novaEmbed:Class;
		[Embed(source="ParsedSounds/light_heal.mp3", mimeType="application/octet-stream")]
		public static const light_healEmbed:Class;
		[Embed(source="ParsedSounds/heal_nova.mp3", mimeType="application/octet-stream")]
		public static const heal_novaEmbed:Class;
		[Embed(source="ParsedSounds/major_heal.mp3", mimeType="application/octet-stream")]
		public static const major_healEmbed:Class;
		[Embed(source="ParsedSounds/djinn_hit.mp3", mimeType="application/octet-stream")]
		public static const djinn_hitEmbed:Class;
		[Embed(source="ParsedSounds/tress_death.mp3", mimeType="application/octet-stream")]
		public static const tress_deathEmbed:Class;
		[Embed(source="ParsedSounds/medusa_death.mp3", mimeType="application/octet-stream")]
		public static const medusa_deathEmbed:Class;
		[Embed(source="ParsedSounds/archdemon_hit.mp3", mimeType="application/octet-stream")]
		public static const archdemon_hitEmbed:Class;
		[Embed(source="ParsedSounds/archdemon_death.mp3", mimeType="application/octet-stream")]
		public static const archdemon_deathEmbed:Class;
		[Embed(source="ParsedSounds/oryx_hit.mp3", mimeType="application/octet-stream")]
		public static const oryx_hitEmbed:Class;
		[Embed(source="ParsedSounds/oryx_death.mp3", mimeType="application/octet-stream")]
		public static const oryx_deathEmbed:Class;
		[Embed(source="ParsedSounds/Trees_hit.mp3", mimeType="application/octet-stream")]
		public static const Trees_hitEmbed:Class;
		[Embed(source="ParsedSounds/Ts_hit.mp3", mimeType="application/octet-stream")]
		public static const Ts_hitEmbed:Class;
		[Embed(source="ParsedSounds/ghost_god_hit.mp3", mimeType="application/octet-stream")]
		public static const ghost_god_hitEmbed:Class;
		[Embed(source="ParsedSounds/ghost_god_death.mp3", mimeType="application/octet-stream")]
		public static const ghost_god_deathEmbed:Class;
		[Embed(source="ParsedSounds/traps_hit.mp3", mimeType="application/octet-stream")]
		public static const traps_hitEmbed:Class;
		[Embed(source="ParsedSounds/traps_death.mp3", mimeType="application/octet-stream")]
		public static const traps_deathEmbed:Class;
		[Embed(source="ParsedSounds/ghosts_hit.mp3", mimeType="application/octet-stream")]
		public static const ghosts_hitEmbed:Class;
		[Embed(source="ParsedSounds/ghosts_death.mp3", mimeType="application/octet-stream")]
		public static const ghosts_deathEmbed:Class;
		[Embed(source="ParsedSounds/greater_pit_snakes_death.mp3", mimeType="application/octet-stream")]
		public static const greater_pit_snakes_deathEmbed:Class;
		[Embed(source="ParsedSounds/snakes_hit.mp3", mimeType="application/octet-stream")]
		public static const snakes_hitEmbed:Class;
		[Embed(source="ParsedSounds/snakes_death.mp3", mimeType="application/octet-stream")]
		public static const snakes_deathEmbed:Class;
		[Embed(source="ParsedSounds/pit_snakes_hit.mp3", mimeType="application/octet-stream")]
		public static const pit_snakes_hitEmbed:Class;
		[Embed(source="ParsedSounds/pit_snakes_death.mp3", mimeType="application/octet-stream")]
		public static const pit_snakes_deathEmbed:Class;
		[Embed(source="ParsedSounds/greater_pit_snakes_hit.mp3", mimeType="application/octet-stream")]
		public static const greater_pit_snakes_hitEmbed:Class;
		[Embed(source="ParsedSounds/flaming_skulls_hit.mp3", mimeType="application/octet-stream")]
		public static const flaming_skulls_hitEmbed:Class;
		[Embed(source="ParsedSounds/flaming_skulls_death.mp3", mimeType="application/octet-stream")]
		public static const flaming_skulls_deathEmbed:Class;
		[Embed(source="ParsedSounds/abyss_demons_hit.mp3", mimeType="application/octet-stream")]
		public static const abyss_demons_hitEmbed:Class;
		[Embed(source="ParsedSounds/abyss_demons_death.mp3", mimeType="application/octet-stream")]
		public static const abyss_demons_deathEmbed:Class;
		[Embed(source="ParsedSounds/minion_of_oryx_hit.mp3", mimeType="application/octet-stream")]
		public static const minion_of_oryx_hitEmbed:Class;
		[Embed(source="ParsedSounds/minion_of_oryx_death.mp3", mimeType="application/octet-stream")]
		public static const minion_of_oryx_deathEmbed:Class;
		[Embed(source="ParsedSounds/beholder_hit.mp3", mimeType="application/octet-stream")]
		public static const beholder_hitEmbed:Class;
		[Embed(source="ParsedSounds/enter_realm.mp3", mimeType="application/octet-stream")]
		public static const enter_realmEmbed:Class;
		[Embed(source="ParsedSounds/sprite_god_hit.mp3", mimeType="application/octet-stream")]
		public static const sprite_god_hitEmbed:Class;
		[Embed(source="ParsedSounds/sprite_god_death.mp3", mimeType="application/octet-stream")]
		public static const sprite_god_deathEmbed:Class;
		[Embed(source="ParsedSounds/rogue_hit.mp3", mimeType="application/octet-stream")]
		public static const rogue_hitEmbed:Class;
		[Embed(source="ParsedSounds/rogue_death.mp3", mimeType="application/octet-stream")]
		public static const rogue_deathEmbed:Class;
		[Embed(source="ParsedSounds/archer_hit.mp3", mimeType="application/octet-stream")]
		public static const archer_hitEmbed:Class;
		[Embed(source="ParsedSounds/archer_death.mp3", mimeType="application/octet-stream")]
		public static const archer_deathEmbed:Class;
		[Embed(source="ParsedSounds/wizard_hit.mp3", mimeType="application/octet-stream")]
		public static const wizard_hitEmbed:Class;
		[Embed(source="ParsedSounds/wizard_death.mp3", mimeType="application/octet-stream")]
		public static const wizard_deathEmbed:Class;
		[Embed(source="ParsedSounds/priest_hit.mp3", mimeType="application/octet-stream")]
		public static const priest_hitEmbed:Class;
		[Embed(source="ParsedSounds/priest_death.mp3", mimeType="application/octet-stream")]
		public static const priest_deathEmbed:Class;
		[Embed(source="ParsedSounds/warrior_hit.mp3", mimeType="application/octet-stream")]
		public static const warrior_hitEmbed:Class;
		[Embed(source="ParsedSounds/warrior_death.mp3", mimeType="application/octet-stream")]
		public static const warrior_deathEmbed:Class;
		[Embed(source="ParsedSounds/knight_hit.mp3", mimeType="application/octet-stream")]
		public static const knight_hitEmbed:Class;
		[Embed(source="ParsedSounds/knight_death.mp3", mimeType="application/octet-stream")]
		public static const knight_deathEmbed:Class;
		[Embed(source="ParsedSounds/paladin_hit.mp3", mimeType="application/octet-stream")]
		public static const paladin_hitEmbed:Class;
		[Embed(source="ParsedSounds/paladin_death.mp3", mimeType="application/octet-stream")]
		public static const paladin_deathEmbed:Class;
		[Embed(source="ParsedSounds/skull_shrine_death.mp3", mimeType="application/octet-stream")]
		public static const skull_shrine_deathEmbed:Class;
		[Embed(source="ParsedSounds/beholder_death.mp3", mimeType="application/octet-stream")]
		public static const beholder_deathEmbed:Class;
		[Embed(source="ParsedSounds/greater_demons_hit.mp3", mimeType="application/octet-stream")]
		public static const greater_demons_hitEmbed:Class;
		[Embed(source="ParsedSounds/greater_demons_death.mp3", mimeType="application/octet-stream")]
		public static const greater_demons_deathEmbed:Class;
		[Embed(source="ParsedSounds/ents_hit.mp3", mimeType="application/octet-stream")]
		public static const ents_hitEmbed:Class;
		[Embed(source="ParsedSounds/ents_death.mp3", mimeType="application/octet-stream")]
		public static const ents_deathEmbed:Class;
		[Embed(source="ParsedSounds/flying_brain_hit.mp3", mimeType="application/octet-stream")]
		public static const flying_brain_hitEmbed:Class;
		[Embed(source="ParsedSounds/djinn_death.mp3", mimeType="application/octet-stream")]
		public static const djinn_deathEmbed:Class;
		[Embed(source="ParsedSounds/silence.mp3", mimeType="application/octet-stream")]
		public static const silenceEmbed:Class;
		[Embed(source="ParsedSounds/firework.mp3", mimeType="application/octet-stream")]
		public static const fireworkEmbed:Class;



		private static var sounds_:Dictionary = new Dictionary();


        public static function load():void
        {
            addSound("sorc", (new sorcEmbed() as Sound));
            addSound("arrowShoot", (new arrowShootEmbed() as Sound));
            addSound("bladeSwing", (new bladeSwingEmbed() as Sound));
            addSound("daggerSwing", (new daggerSwingEmbed() as Sound));
            addSound("magicShoot", (new magicShootEmbed() as Sound));
            addSound("death_screen", (new death_screenEmbed() as Sound));
            addSound("char_select", (new char_selectEmbed() as Sound));
            addSound("enter_realm", (new enter_realmEmbed() as Sound));
            addSound("button_click", (new button_clickEmbed() as Sound));
            addSound("loot_appears", (new loot_appearsEmbed() as Sound));
            addSound("level_up", (new level_upEmbed() as Sound));
            addSound("error", (new errorEmbed() as Sound));
            addSound("no_mana", (new no_manaEmbed() as Sound));
            addSound("inventory_move_item", (new inventory_move_itemEmbed() as Sound));
            addSound("use_key", (new use_keyEmbed() as Sound));
            addSound("use_potion", (new use_potionEmbed() as Sound));
            addSound("monster/abyss_brutes_death", (new abyss_brutes_deathEmbed() as Sound));
            addSound("monster/abyss_brutes_hit", (new abyss_brutes_hitEmbed() as Sound));
            addSound("monster/abyss_demons_death", (new abyss_demons_deathEmbed() as Sound));
            addSound("monster/abyss_demons_hit", (new abyss_demons_hitEmbed() as Sound));
            addSound("monster/archdemon_death", (new archdemon_deathEmbed() as Sound));
            addSound("monster/archdemon_hit", (new archdemon_hitEmbed() as Sound));
            addSound("monster/bats_death", (new bats_deathEmbed() as Sound));
            addSound("monster/bats_hit", (new bats_hitEmbed() as Sound));
            addSound("monster/beholder_death", (new beholder_deathEmbed() as Sound));
            addSound("monster/beholder_hit", (new beholder_hitEmbed() as Sound));
            addSound("monster/blobs_death", (new blobs_deathEmbed() as Sound));
            addSound("monster/blobs_hit", (new blobs_hitEmbed() as Sound));
            addSound("monster/cave_pirates_death", (new cave_pirates_deathEmbed() as Sound));
            addSound("monster/cave_pirates_hit", (new cave_pirates_hitEmbed() as Sound));
            addSound("monster/chicken_death", (new chicken_deathEmbed() as Sound));
            addSound("monster/chicken_hit", (new chicken_hitEmbed() as Sound));
            addSound("monster/cubes_death", (new cubes_deathEmbed() as Sound));
            addSound("monster/cubes_hit", (new cubes_hitEmbed() as Sound));
            addSound("monster/cyclops_death", (new cyclops_deathEmbed() as Sound));
            addSound("monster/cyclops_hit", (new cyclops_hitEmbed() as Sound));
            addSound("monster/dark_elves_death", (new dark_elves_deathEmbed() as Sound));
            addSound("monster/dark_elves_hit", (new dark_elves_hitEmbed() as Sound));
            addSound("monster/default_death", (new default_deathEmbed() as Sound));
            addSound("monster/default_hit", (new default_hitEmbed() as Sound));
            addSound("monster/demons_death", (new demons_deathEmbed() as Sound));
            addSound("monster/demons_hit", (new demons_hitEmbed() as Sound));
            addSound("monster/djinn_death", (new djinn_deathEmbed() as Sound));
            addSound("monster/djinn_hit", (new djinn_hitEmbed() as Sound));
            addSound("monster/dragons_death", (new dragons_deathEmbed() as Sound));
            addSound("monster/dragons_hit", (new dragons_hitEmbed() as Sound));
            addSound("monster/dwarf_god_death", (new dwarf_god_deathEmbed() as Sound));
            addSound("monster/dwarf_god_hit", (new dwarf_god_hitEmbed() as Sound));
            addSound("monster/dwarves_death", (new dwarves_deathEmbed() as Sound));
            addSound("monster/dwarves_hit", (new dwarves_hitEmbed() as Sound));
            addSound("monster/eggs_death", (new eggs_deathEmbed() as Sound));
            addSound("monster/eggs_hit", (new eggs_hitEmbed() as Sound));
            addSound("monster/elves_death", (new elves_deathEmbed() as Sound));
            addSound("monster/elves_hit", (new elves_hitEmbed() as Sound));
            addSound("monster/ents_death", (new ents_deathEmbed() as Sound));
            addSound("monster/ents_hit", (new ents_hitEmbed() as Sound));
            addSound("monster/flaming_skulls_death", (new flaming_skulls_deathEmbed() as Sound));
            addSound("monster/flaming_skulls_hit", (new flaming_skulls_hitEmbed() as Sound));
            addSound("monster/flayers_death", (new flayers_deathEmbed() as Sound));
            addSound("monster/flayers_hit", (new flayers_hitEmbed() as Sound));
            addSound("monster/flying_brain_death", (new flying_brain_deathEmbed() as Sound));
            addSound("monster/flying_brain_hit", (new flying_brain_hitEmbed() as Sound));
            addSound("monster/ghosts_death", (new ghosts_deathEmbed() as Sound));
            addSound("monster/ghosts_hit", (new ghosts_hitEmbed() as Sound));
            addSound("monster/ghost_god_death", (new ghost_god_deathEmbed() as Sound));
            addSound("monster/ghost_god_hit", (new ghost_god_hitEmbed() as Sound));
            addSound("monster/goblins_death", (new goblins_deathEmbed() as Sound));
            addSound("monster/goblins_hit", (new goblins_hitEmbed() as Sound));
            addSound("monster/golems_death", (new golems_deathEmbed() as Sound));
            addSound("monster/golems_hit", (new golems_hitEmbed() as Sound));
            addSound("monster/greater_demons_death", (new greater_demons_deathEmbed() as Sound));
            addSound("monster/greater_demons_hit", (new greater_demons_hitEmbed() as Sound));
            addSound("monster/greater_pit_snakes_death", (new greater_pit_snakes_deathEmbed() as Sound));
            addSound("monster/greater_pit_snakes_hit", (new greater_pit_snakes_hitEmbed() as Sound));
            addSound("monster/hobbits_death", (new hobbits_deathEmbed() as Sound));
            addSound("monster/hobbits_hit", (new hobbits_hitEmbed() as Sound));
            addSound("monster/lizard_god_death", (new lizard_god_deathEmbed() as Sound));
            addSound("monster/lizard_god_hit", (new lizard_god_hitEmbed() as Sound));
            addSound("monster/medusa_death", (new medusa_deathEmbed() as Sound));
            addSound("monster/medusa_hit", (new medusa_hitEmbed() as Sound));
            addSound("monster/minion_of_oryx_death", (new minion_of_oryx_deathEmbed() as Sound));
            addSound("monster/minion_of_oryx_hit", (new minion_of_oryx_hitEmbed() as Sound));
            addSound("monster/mummies_death", (new mummies_deathEmbed() as Sound));
            addSound("monster/mummies_hit", (new mummies_hitEmbed() as Sound));
            addSound("monster/night_elves_death", (new night_elves_deathEmbed() as Sound));
            addSound("monster/night_elves_hit", (new night_elves_hitEmbed() as Sound));
            addSound("monster/ogres_death", (new ogres_deathEmbed() as Sound));
            addSound("monster/ogres_hit", (new ogres_hitEmbed() as Sound));
            addSound("monster/orcs_death", (new orcs_deathEmbed() as Sound));
            addSound("monster/orcs_hit", (new orcs_hitEmbed() as Sound));
            addSound("monster/oryx_death", (new oryx_deathEmbed() as Sound));
            addSound("monster/oryx_hit", (new oryx_hitEmbed() as Sound));
            addSound("monster/pirates_death", (new pirates_deathEmbed() as Sound));
            addSound("monster/pirates_hit", (new pirates_hitEmbed() as Sound));
            addSound("monster/pirate_king_death", (new pirate_king_deathEmbed() as Sound));
            addSound("monster/pirate_king_hit", (new pirate_king_hitEmbed() as Sound));
            addSound("monster/pit_snakes_death", (new pit_snakes_deathEmbed() as Sound));
            addSound("monster/pit_snakes_hit", (new pit_snakes_hitEmbed() as Sound));
            addSound("monster/pythons_death", (new pythons_deathEmbed() as Sound));
            addSound("monster/pythons_hit", (new pythons_hitEmbed() as Sound));
            addSound("monster/rocks_death", (new rocks_deathEmbed() as Sound));
            addSound("monster/rocks_hit", (new rocks_hitEmbed() as Sound));
            addSound("monster/scorpions_death", (new scorpions_deathEmbed() as Sound));
            addSound("monster/scorpions_hit", (new scorpions_hitEmbed() as Sound));
            addSound("monster/skeletons_death", (new skeletons_deathEmbed() as Sound));
            addSound("monster/skeletons_hit", (new skeletons_hitEmbed() as Sound));
            addSound("monster/skull_shrine_death", (new skull_shrine_deathEmbed() as Sound));
            addSound("monster/skull_shrine_hit", (new skull_shrine_hitEmbed() as Sound));
            addSound("monster/slimes_death", (new slimes_deathEmbed() as Sound));
            addSound("monster/slimes_hit", (new slimes_hitEmbed() as Sound));
            addSound("monster/snakes_death", (new snakes_deathEmbed() as Sound));
            addSound("monster/snakes_hit", (new snakes_hitEmbed() as Sound));
            addSound("monster/snake_queen_death", (new snake_queen_deathEmbed() as Sound));
            addSound("monster/snake_queen_hit", (new snake_queen_hitEmbed() as Sound));
            addSound("monster/spiders_death", (new spiders_deathEmbed() as Sound));
            addSound("monster/spiders_hit", (new spiders_hitEmbed() as Sound));
            addSound("monster/spider_queen_death", (new spider_queen_deathEmbed() as Sound));
            addSound("monster/spider_queen_hit", (new spider_queen_hitEmbed() as Sound));
            addSound("monster/sprites_death", (new sprites_deathEmbed() as Sound));
            addSound("monster/sprites_hit", (new sprites_hitEmbed() as Sound));
            addSound("monster/sprite_god_death", (new sprite_god_deathEmbed() as Sound));
            addSound("monster/sprite_god_hit", (new sprite_god_hitEmbed() as Sound));
            addSound("monster/stone_walls_death", (new stone_walls_deathEmbed() as Sound));
            addSound("monster/stone_walls_hit", (new stone_walls_hitEmbed() as Sound));
            addSound("monster/traps_death", (new traps_deathEmbed() as Sound));
            addSound("monster/traps_hit", (new traps_hitEmbed() as Sound));
            addSound("monster/trees_death", (new trees_deathEmbed() as Sound));
            addSound("monster/trees_hit", (new trees_hitEmbed() as Sound));
            addSound("monster/undead_dwarves_death", (new undead_dwarves_deathEmbed() as Sound));
            addSound("monster/undead_dwarves_hit", (new undead_dwarves_hitEmbed() as Sound));
            addSound("monster/undead_hobbits_death", (new undead_hobbits_deathEmbed() as Sound));
            addSound("monster/undead_hobbits_hit", (new undead_hobbits_hitEmbed() as Sound));
            addSound("monster/wizard_death", (new wizard_deathEmbed() as Sound));
            addSound("monster/wooden_walls_death", (new wooden_walls_deathEmbed() as Sound));
            addSound("monster/wooden_walls_hit", (new wooden_walls_hitEmbed() as Sound));
            addSound("player/archer_death", (new archer_deathEmbed() as Sound));
            addSound("player/archer_hit", (new archer_hitEmbed() as Sound));
            addSound("player/knight_death", (new knight_deathEmbed() as Sound));
            addSound("player/knight_hit", (new knight_hitEmbed() as Sound));
            addSound("player/paladin_death", (new paladin_deathEmbed() as Sound));
            addSound("player/paladin_hit", (new paladin_hitEmbed() as Sound));
            addSound("player/priest_death", (new priest_deathEmbed() as Sound));
            addSound("player/priest_hit", (new priest_hitEmbed() as Sound));
            addSound("player/rogue_death", (new rogue_deathEmbed() as Sound));
            addSound("player/rogue_hit", (new rogue_hitEmbed() as Sound));
            addSound("player/warrior_death", (new warrior_deathEmbed() as Sound));
            addSound("player/warrior_hit", (new warrior_hitEmbed() as Sound));
            addSound("player/wizard_death", (new wizard_deathEmbed() as Sound));
            addSound("player/wizard_hit", (new wizard_hitEmbed() as Sound));
            addSound("spell/fire_nova", (new fire_novaEmbed() as Sound));
            addSound("spell/fire_spray", (new fire_sprayEmbed() as Sound));
            addSound("spell/heal_nova", (new heal_novaEmbed() as Sound));
            addSound("spell/light_heal", (new light_healEmbed() as Sound));
            addSound("spell/magic_nova", (new magic_novaEmbed() as Sound));
            addSound("spell/major_heal", (new major_healEmbed() as Sound));
            addSound("weapon/blunt_dagger", (new blunt_daggerEmbed() as Sound));
            addSound("weapon/blunt_sword", (new blunt_swordEmbed() as Sound));
            addSound("weapon/crossbow", (new crossbowEmbed() as Sound));
            addSound("weapon/dirk", (new dirkEmbed() as Sound));
            addSound("weapon/double_bow", (new double_bowEmbed() as Sound));
            addSound("weapon/firework", (new fireworkEmbed() as Sound));
            addSound("weapon/fire_bow", (new fire_bowEmbed() as Sound));
            addSound("weapon/fire_dagger", (new fire_daggerEmbed() as Sound));
            addSound("weapon/fire_sword", (new fire_swordEmbed() as Sound));
            addSound("weapon/fire_wand", (new fire_wandEmbed() as Sound));
            addSound("weapon/glass_sword", (new glass_swordEmbed() as Sound));
            addSound("weapon/golden_bow", (new golden_bowEmbed() as Sound));
            addSound("weapon/golden_dagger", (new golden_daggerEmbed() as Sound));
            addSound("weapon/golden_sword", (new golden_swordEmbed() as Sound));
            addSound("weapon/heavy_crossbow", (new heavy_crossbowEmbed() as Sound));
            addSound("weapon/hells_fire_wand", (new hells_fire_wandEmbed() as Sound));
            addSound("weapon/long_sword", (new long_swordEmbed() as Sound));
            addSound("weapon/missile_wand", (new missile_wandEmbed() as Sound));
            addSound("weapon/mithril_dagger", (new mithril_daggerEmbed() as Sound));
            addSound("weapon/mithril_sword", (new mithril_swordEmbed() as Sound));
            addSound("weapon/obsidian_dagger", (new obsidian_daggerEmbed() as Sound));
            addSound("weapon/poison_fang_dagger", (new poison_fang_daggerEmbed() as Sound));
            addSound("weapon/poor_quality_bow", (new poor_quality_bowEmbed() as Sound));
            addSound("weapon/sprite_wand", (new sprite_wandEmbed() as Sound));
            addSound("weapon/wand_of_dark_magic", (new wand_of_dark_magicEmbed() as Sound));
            addSound("weapon/wand_of_death", (new wand_of_deathEmbed() as Sound));
        }

        private static function addSound(_arg_1:String, _arg_2:Sound):void
        {
            var _local_3:Array = sounds_[_arg_1];
            if (_local_3 == null)
            {
                sounds_[_arg_1] = [];
            }
            sounds_[_arg_1] = _arg_2;
        }

        public static function grab(_arg_1:String):Sound
        {
            return (sounds_[_arg_1]);
        }

        public static function play(_arg_1:String, _arg_2:Boolean):void
        {
            SoundEffectLibrary.playCustom(sounds_[_arg_1], _arg_1, _arg_2);
        }


    }
}//package zfn.sound


