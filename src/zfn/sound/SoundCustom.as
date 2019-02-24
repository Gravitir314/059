//zfn.sound.SoundCustom

package zfn.sound
	{
    import com.company.assembleegameclient.parameters.Parameters;
    import com.company.assembleegameclient.sound.SoundEffectLibrary;

    import flash.media.Sound;
    import flash.utils.Dictionary;

    public class SoundCustom
		{
			[Embed(source="EmbeddedSound_ding.mp3")]
			private static const dingEmbed:Class;
			[Embed(source="EmbeddedSound_treasure.mp3")]
			private static const treasureEmbed:Class;
			[Embed(source="EmbeddedSound_mslevel.mp3")]
			private static const msLevelEmbed:Class;
			[Embed(source="EmbeddedSound_tomscream.mp3")]
			private static const tomScreamEmbed:Class;
			[Embed(source="EmbeddedSound_inbox.mp3")]
			private static const inboxEmbed:Class;
			[Embed(source="EmbeddedSound_nuke.mp3")]
			private static const nukeEmbed:Class;
			[Embed(source="EmbeddedSound_skullshrine.mp3")]
			private static const eventSkullShrine:Class;
			[Embed(source="EmbeddedSound_cubegod.mp3")]
			private static const eventCubeGod:Class;
			[Embed(source="EmbeddedSound_pentaract.mp3")]
			private static const eventPentaract:Class;
			[Embed(source="EmbeddedSound_grandsphinx.mp3")]
			private static const eventGrandSphinx:Class;
			[Embed(source="EmbeddedSound_hermit.mp3")]
			private static const eventHermitGod:Class;
			[Embed(source="EmbeddedSound_lotll.mp3")]
			private static const eventLordoftheLostLands:Class;
			[Embed(source="EmbeddedSound_ghostship.mp3")]
			private static const eventGhostShip:Class;
			[Embed(source="EmbeddedSound_avatar.mp3")]
			private static const eventAvataroftheForgottenKing:Class;
			[Embed(source="EmbeddedSound_statues.mp3")]
			private static const eventJadeandGarnetStatues:Class;
			[Embed(source="EmbeddedSound_dragon.mp3")]
			private static const eventRockDragon:Class;
			[Embed(source="EmbeddedSound_killer_bee.mp3")]
			private static const eventKillerBeeNest:Class;
			[Embed(source="EmbeddedSound_sentry.mp3")]
			private static const eventLostSentry:Class;
			[Embed(source="EmbeddedSound_pumpkin.mp3")]
			private static const eventPumpkinShrine:Class;
			[Embed(source="EmbeddedSound_zombiehorde.mp3")]
			private static const eventZombieHorde:Class;
			[Embed(source="EmbeddedSound_turkeygod.mp3")]
			private static const eventTurkeyGod:Class;
			[Embed(source="EmbeddedSound_beachbum.mp3")]
			private static const eventBeachBum:Class;

			private static var sounds_:Dictionary = new Dictionary();


			public static function load():void
			{
				addSound("ding", (new dingEmbed() as Sound));
				addSound("treasure", (new treasureEmbed() as Sound));
				addSound("mslevel", (new msLevelEmbed() as Sound));
				addSound("tomscream", (new tomScreamEmbed() as Sound));
				addSound("inbox", (new inboxEmbed() as Sound));
				addSound("nuke", (new nukeEmbed() as Sound));
				addSound("eventSkullShrine", (new eventSkullShrine() as Sound));
				addSound("eventCubeGod", (new eventCubeGod() as Sound));
				addSound("eventPentaract", (new eventPentaract() as Sound));
				addSound("eventGrandSphinx", (new eventGrandSphinx() as Sound));
				addSound("eventHermitGod", (new eventHermitGod() as Sound));
				addSound("eventLordoftheLostLands", (new eventLordoftheLostLands() as Sound));
				addSound("eventGhostShip", (new eventGhostShip() as Sound));
				addSound("eventAvataroftheForgottenKing", (new eventAvataroftheForgottenKing() as Sound));
				addSound("eventJadeandGarnetStatues", (new eventJadeandGarnetStatues() as Sound));
				addSound("eventRockDragon", (new eventRockDragon() as Sound));
				addSound("eventKillerBeeNest", (new eventKillerBeeNest() as Sound));
				addSound("eventLostSentry", (new eventLostSentry() as Sound));
				addSound("eventPumpkinShrine", (new eventPumpkinShrine() as Sound));
				addSound("eventZombieHorde", (new eventZombieHorde() as Sound));
				addSound("eventTurkeyGod", (new eventTurkeyGod() as Sound));
				addSound("eventBeachBum", (new eventBeachBum() as Sound));
			}

			private static function addSound(_arg_1:String, _arg_2:Sound):void
			{
				sounds_[_arg_1] = _arg_2;
			}

			public static function grab(_arg_1:String):Sound
			{
				return (sounds_[_arg_1]);
			}

			public static function play(_arg_1:String):void
			{
				if (Parameters.data_.customSounds || _arg_1.indexOf("event") != -1 && Parameters.data_.eventNotifier)
				{
					SoundEffectLibrary.playCustomSFX(_arg_1);
				}
			}


		}
	}//package zfn.sound

