//com.company.assembleegameclient.util.AssetLoader

package com.company.assembleegameclient.util
	{
	import com.company.assembleegameclient.engine3d.Model3D;
	import com.company.assembleegameclient.map.GroundLibrary;
	import com.company.assembleegameclient.map.RegionLibrary;
	import com.company.assembleegameclient.objects.ObjectLibrary;
	import com.company.assembleegameclient.objects.particles.ParticleLibrary;
	import com.company.assembleegameclient.parameters.Parameters;
	import com.company.assembleegameclient.sound.IMusic;
	import com.company.assembleegameclient.sound.SFX;
	import com.company.assembleegameclient.sound.SoundEffectLibrary;
	import com.company.assembleegameclient.ui.options.Options;
	import com.company.util.AssetLibrary;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.utils.ByteArray;
	import flash.utils.getQualifiedClassName;

	import kabam.rotmg.assets.EmbeddedAssets;
	import kabam.rotmg.assets.EmbeddedData;

	import zfn.sound.SoundAssets;
	import zfn.sound.SoundCustom;

	public class AssetLoader
		{

			public static var currentXmlIsTesting:Boolean = false;
			public static var realmMaps:Vector.<BitmapData>;
			public static var nexusMaps:Vector.<BitmapData>;
			public static var nexusMap:BitmapData;
			public static var castleMap:BitmapData;
			public static var chamberMap:BitmapData;
			public static var wcMap:BitmapData;
			public static var vaultMap:BitmapData;
			public static var shattersMap:BitmapData;

			[Embed(source="AssetLoader_W1.dat", mimeType="application/octet-stream")]
			private var w1:Class;
			[Embed(source="AssetLoader_W2.dat", mimeType="application/octet-stream")]
			private var w2:Class;
			[Embed(source="AssetLoader_W3.dat", mimeType="application/octet-stream")]
			private var w3:Class;
			[Embed(source="AssetLoader_W4.dat", mimeType="application/octet-stream")]
			private var w4:Class;
			[Embed(source="AssetLoader_W5.dat", mimeType="application/octet-stream")]
			private var w5:Class;
			[Embed(source="AssetLoader_W6.dat", mimeType="application/octet-stream")]
			private var w6:Class;
			[Embed(source="AssetLoader_W7.dat", mimeType="application/octet-stream")]
			private var w7:Class;
			[Embed(source="AssetLoader_W8.dat", mimeType="application/octet-stream")]
			private var w8:Class;
			[Embed(source="AssetLoader_W9.dat", mimeType="application/octet-stream")]
			private var w9:Class;
			[Embed(source="AssetLoader_W10.dat", mimeType="application/octet-stream")]
			private var w10:Class;
			[Embed(source="AssetLoader_W11.dat", mimeType="application/octet-stream")]
			private var w11:Class;
			[Embed(source="AssetLoader_W12.dat", mimeType="application/octet-stream")]
			private var w12:Class;
			[Embed(source="AssetLoader_W13.dat", mimeType="application/octet-stream")]
			private var w13:Class;
			[Embed(source="AssetLoader_Castle.dat", mimeType="application/octet-stream")]
			private var castle:Class;
			[Embed(source="AssetLoader_Chamber.dat", mimeType="application/octet-stream")]
			private var chamber:Class;
			[Embed(source="AssetLoader_WC.dat", mimeType="application/octet-stream")]
			private var wc:Class;
			[Embed(source="AssetLoader_Vault.dat", mimeType="application/octet-stream")]
			private var vault:Class;
			[Embed(source="AssetLoader_Shatters.dat", mimeType="application/octet-stream")]
			private var shatters:Class;
			[Embed(source="AssetLoader_Nexus_Winter.dat", mimeType="application/octet-stream")]
			private var nexus:Class;
			[Embed(source="AssetLoader_Nexus_Autumn.dat", mimeType="application/octet-stream")]
			private var nexus_autumn:Class;
			[Embed(source="AssetLoader_Nexus_Halloween.dat", mimeType="application/octet-stream")]
			private var nexus_halloween:Class;
			[Embed(source="AssetLoader_Nexus_Day.dat", mimeType="application/octet-stream")]
			private var nexus_day:Class;
			[Embed(source="AssetLoader_Nexus_Night.dat", mimeType="application/octet-stream")]
			private var nexus_night:Class;
			[Embed(source="AssetLoader_Nexus_Sunrise.dat", mimeType="application/octet-stream")]
			private var nexus_sunrise:Class;
			[Embed(source="AssetLoader_Nexus_Sunset.dat", mimeType="application/octet-stream")]
			private var nexus_sunset:Class;

			public var music:IMusic = new MusicProxy();

			private function loadMaps():void
			{
				realmMaps = new Vector.<BitmapData>(13);
				nexusMaps = new Vector.<BitmapData>(4);
				this.loadMap(new this.w1(), 0);
				this.loadMap(new this.w2(), 1);
				this.loadMap(new this.w3(), 2);
				this.loadMap(new this.w4(), 3);
				this.loadMap(new this.w5(), 4);
				this.loadMap(new this.w6(), 5);
				this.loadMap(new this.w7(), 6);
				this.loadMap(new this.w8(), 7);
				this.loadMap(new this.w9(), 8);
				this.loadMap(new this.w10(), 9);
				this.loadMap(new this.w11(), 10);
				this.loadMap(new this.w12(), 11);
				this.loadMap(new this.w13(), 12);
				this.loadMap(new this.castle(), 13);
				this.loadMap(new this.chamber(), 14);
				this.loadMap(new this.wc(), 15);
				this.loadMap(new this.vault(), 16);
				this.loadMap(new this.shatters(), 17);
				this.loadMap(new this.nexus_day(), 18);
				this.loadMap(new this.nexus_night(), 19);
				this.loadMap(new this.nexus_sunrise(), 20);
				this.loadMap(new this.nexus_sunset(), 21);
				this.loadMap(new this.nexus(), 22);
			}

			private function loadMap(_arg_1:*, _arg_2:int):void
			{
				var _local_5:ByteArray = (_arg_1 as ByteArray);
				var _local_4:Loader = new Loader();
				var _local_3:ParameterizedHandlerContainer = new ParameterizedHandlerContainer();
				_local_3.registerHandler(_local_4.contentLoaderInfo, Event.COMPLETE, this.getBitmapData, _arg_2, _local_3);
				_local_4.loadBytes(_local_5);
			}

			private function getBitmapData(_arg_1:Event, _arg_2:int, _arg_3:ParameterizedHandlerContainer):void
			{
				_arg_3.destroyHandler(this.getBitmapData, _arg_1);
				var _local_4:BitmapData = Bitmap(_arg_1.target.content).bitmapData;
				if (_arg_2 < 13)
				{
					realmMaps[_arg_2] = _local_4;
				}
				else
				{
					switch (_arg_2)
					{
						case 13:
							castleMap = _local_4;
							return;
						case 14:
							chamberMap = _local_4;
							return;
						case 15:
							wcMap = _local_4;
							return;
						case 16:
							vaultMap = _local_4;
							return;
						case 17:
							shattersMap = _local_4;
							return;
						case 18:
							nexusMaps[0] = _local_4;
							return;
						case 19:
							nexusMaps[1] = _local_4;
							return;
						case 20:
							nexusMaps[2] = _local_4;
							return;
						case 21:
							nexusMaps[3] = _local_4;
							return;
						case 22:
							nexusMap = _local_4;
							return;
						default:
					}
				}
			}


			public function load():void
			{
				this.addImages();
				this.addAnimatedCharacters();
				this.addSoundEffects();
				this.parse3DModels();
				this.parseParticleEffects();
				this.parseGroundFiles();
				this.parseObjectFiles();
				this.parseRegionFiles();
				Parameters.load();
				Options.refreshCursor();
				this.music.load();
				SFX.load();
				SoundCustom.load();
				SoundAssets.load();
				this.loadMaps();
			}

			private function addImages():void
			{
				AssetLibrary.addImageSet("lofiChar8x8", new EmbeddedAssets.lofiCharEmbed_().bitmapData, 8, 8);
				AssetLibrary.addImageSet("lofiChar16x8", new EmbeddedAssets.lofiCharEmbed_().bitmapData, 16, 8);
				AssetLibrary.addImageSet("lofiChar16x16", new EmbeddedAssets.lofiCharEmbed_().bitmapData, 16, 16);
				AssetLibrary.addImageSet("lofiChar28x8", new EmbeddedAssets.lofiChar2Embed_().bitmapData, 8, 8);
				AssetLibrary.addImageSet("lofiChar216x8", new EmbeddedAssets.lofiChar2Embed_().bitmapData, 16, 8);
				AssetLibrary.addImageSet("lofiChar216x16", new EmbeddedAssets.lofiChar2Embed_().bitmapData, 16, 16);
				AssetLibrary.addImageSet("lofiCharBig", new EmbeddedAssets.lofiCharBigEmbed_().bitmapData, 16, 16);
				AssetLibrary.addImageSet("lofiEnvironment", new EmbeddedAssets.lofiEnvironmentEmbed_().bitmapData, 8, 8);
				AssetLibrary.addImageSet("lofiEnvironment2", new EmbeddedAssets.lofiEnvironment2Embed_().bitmapData, 8, 8);
				AssetLibrary.addImageSet("lofiEnvironment3", new EmbeddedAssets.lofiEnvironment3Embed_().bitmapData, 8, 8);
				AssetLibrary.addImageSet("lofiInterface", new EmbeddedAssets.lofiInterfaceEmbed_().bitmapData, 8, 8);
				AssetLibrary.addImageSet("redLootBag", new EmbeddedAssets.redLootBagEmbed_().bitmapData, 8, 8);
				AssetLibrary.addImageSet("lofiInterfaceBig", new EmbeddedAssets.lofiInterfaceBigEmbed_().bitmapData, 16, 16);
				AssetLibrary.addImageSet("lofiInterface2", new EmbeddedAssets.lofiInterface2Embed_().bitmapData, 8, 8);
				AssetLibrary.addImageSet("lofiObj", new EmbeddedAssets.lofiObjEmbed_().bitmapData, 8, 8);
				AssetLibrary.addImageSet("lofiObj2", new EmbeddedAssets.lofiObj2Embed_().bitmapData, 8, 8);
				AssetLibrary.addImageSet("lofiObj3", new EmbeddedAssets.lofiObj3Embed_().bitmapData, 8, 8);
				AssetLibrary.addImageSet("lofiObj4", new EmbeddedAssets.lofiObj4Embed_().bitmapData, 8, 8);
				AssetLibrary.addImageSet("lofiObj5", new EmbeddedAssets.lofiObj5Embed_().bitmapData, 8, 8);
				AssetLibrary.addImageSet("lofiObj5new", new EmbeddedAssets.lofiObj5bEmbed_().bitmapData, 8, 8);
				AssetLibrary.addImageSet("lofiObj6", new EmbeddedAssets.lofiObj6Embed_().bitmapData, 8, 8);
				AssetLibrary.addImageSet("lofiObjBig", new EmbeddedAssets.lofiObjBigEmbed_().bitmapData, 16, 16);
				AssetLibrary.addImageSet("lofiObj40x40", new EmbeddedAssets.lofiObj40x40Embed_().bitmapData, 40, 40);
				AssetLibrary.addImageSet("lofiProjs", new EmbeddedAssets.lofiProjsEmbed_().bitmapData, 8, 8);
				AssetLibrary.addImageSet("lofiParticlesShocker", new EmbeddedAssets.lofiParticlesShockerEmbed_().bitmapData, 16, 16);
				AssetLibrary.addImageSet("lofiProjsBig", new EmbeddedAssets.lofiProjsBigEmbed_().bitmapData, 16, 16);
				AssetLibrary.addImageSet("lofiParts", new EmbeddedAssets.lofiPartsEmbed_().bitmapData, 8, 8);
				AssetLibrary.addImageSet("stars", new EmbeddedAssets.starsEmbed_().bitmapData, 5, 5);
				AssetLibrary.addImageSet("textile4x4", new EmbeddedAssets.textile4x4Embed_().bitmapData, 4, 4);
				AssetLibrary.addImageSet("textile5x5", new EmbeddedAssets.textile5x5Embed_().bitmapData, 5, 5);
				AssetLibrary.addImageSet("textile9x9", new EmbeddedAssets.textile9x9Embed_().bitmapData, 9, 9);
				AssetLibrary.addImageSet("textile10x10", new EmbeddedAssets.textile10x10Embed_().bitmapData, 10, 10);
				AssetLibrary.addImageSet("inner_mask", new EmbeddedAssets.innerMaskEmbed_().bitmapData, 4, 4);
				AssetLibrary.addImageSet("sides_mask", new EmbeddedAssets.sidesMaskEmbed_().bitmapData, 4, 4);
				AssetLibrary.addImageSet("outer_mask", new EmbeddedAssets.outerMaskEmbed_().bitmapData, 4, 4);
				AssetLibrary.addImageSet("innerP1_mask", new EmbeddedAssets.innerP1MaskEmbed_().bitmapData, 4, 4);
				AssetLibrary.addImageSet("innerP2_mask", new EmbeddedAssets.innerP2MaskEmbed_().bitmapData, 4, 4);
				AssetLibrary.addImageSet("invisible", new BitmapData(8, 8, true, 0), 8, 8);
				AssetLibrary.addImageSet("d3LofiObjEmbed", new EmbeddedAssets.d3LofiObjEmbed_().bitmapData, 8, 8);
				AssetLibrary.addImageSet("d3LofiObjEmbed16", new EmbeddedAssets.d3LofiObjEmbed_().bitmapData, 16, 16);
				AssetLibrary.addImageSet("d3LofiObjBigEmbed", new EmbeddedAssets.d3LofiObjBigEmbed_().bitmapData, 16, 16);
				AssetLibrary.addImageSet("d2LofiObjEmbed", new EmbeddedAssets.d2LofiObjEmbed_().bitmapData, 8, 8);
				AssetLibrary.addImageSet("d2LofiObjBigEmbed", new EmbeddedAssets.d2LofiObjBigEmbed_().bitmapData, 16, 16);
				AssetLibrary.addImageSet("d1lofiObjBig", new EmbeddedAssets.d1LofiObjBigEmbed_().bitmapData, 16, 16);
				AssetLibrary.addImageSet("cursorsEmbed", new EmbeddedAssets.cursorsEmbed_().bitmapData, 32, 32);
				AssetLibrary.addImageSet("mountainTempleObjects8x8", new EmbeddedAssets.mountainTempleObjects8x8Embed_().bitmapData, 8, 8);
				AssetLibrary.addImageSet("mountainTempleObjects16x16", new EmbeddedAssets.mountainTempleObjects16x16Embed_().bitmapData, 16, 16);
				AssetLibrary.addImageSet("oryxHordeObjects8x8", new EmbeddedAssets.oryxHordeObjects8x8Embed_().bitmapData, 8, 8);
				AssetLibrary.addImageSet("oryxHordeObjects16x16", new EmbeddedAssets.oryxHordeObjects16x16Embed_().bitmapData, 16, 16);
				AssetLibrary.addImageSet("battleOryxObjects8x8", new EmbeddedAssets.battleOryxObjects8x8Embed_().bitmapData, 8, 8);
				AssetLibrary.addImageSet("battleOryxObjects16x16", new EmbeddedAssets.battleOryxObjects16x16Embed_().bitmapData, 16, 16);
				AssetLibrary.addImageSet("santaWorkshopObjects8x8", new EmbeddedAssets.santaWorkshopObjects8x8Embed_().bitmapData, 8, 8);
				AssetLibrary.addImageSet("santaWorkshopObjects16x16", new EmbeddedAssets.santaWorkshopObjects16x16Embed_().bitmapData, 16, 16);
				AssetLibrary.addImageSet("parasiteDenObjects8x8", new EmbeddedAssets.parasiteDenObjects8x8Embed_().bitmapData, 8, 8);
				AssetLibrary.addImageSet("parasiteDenObjects16x16", new EmbeddedAssets.parasiteDenObjects16x16Embed_().bitmapData, 16, 16);
				AssetLibrary.addImageSet("stPatricksObjects8x8", new EmbeddedAssets.stPatricksObjects8x8Embed_().bitmapData, 8, 8);
				AssetLibrary.addImageSet("stPatricksObjects16x16", new EmbeddedAssets.stPatricksObjects16x16Embed_().bitmapData, 16, 16);
				AssetLibrary.addImageSet("buffedBunnyObjects8x8", new EmbeddedAssets.buffedBunnyObjects8x8Embed_().bitmapData, 8, 8);
				AssetLibrary.addImageSet("buffedBunnyObjects16x16", new EmbeddedAssets.buffedBunnyObjects16x16Embed_().bitmapData, 16, 16);
				AssetLibrary.addImageSet("SakuraEnvironment16x16", new EmbeddedAssets.SakuraEnvironment16x16Embed_().bitmapData, 16, 16);
				AssetLibrary.addImageSet("SakuraEnvironment8x8", new EmbeddedAssets.SakuraEnvironment8x8Embed_().bitmapData, 8, 8);
				AssetLibrary.addImageSet("HanamiParts", new EmbeddedAssets.HanamiParts8x8Embed_().bitmapData, 8, 8);
				AssetLibrary.addImageSet("summerNexusObjects8x8", new EmbeddedAssets.summerNexusObjects8x8Embed_().bitmapData, 8, 8);
				AssetLibrary.addImageSet("summerNexusObjects16x16", new EmbeddedAssets.summerNexusObjects16x16Embed_().bitmapData, 16, 16);
				AssetLibrary.addImageSet("autumnNexusObjects8x8", new EmbeddedAssets.autumnNexusObjects8x8Embed_().bitmapData, 8, 8);
				AssetLibrary.addImageSet("autumnNexusObjects16x16", new EmbeddedAssets.autumnNexusObjects16x16Embed_().bitmapData, 16, 16);
				AssetLibrary.addImageSet("xmasNexusObjects8x8", new EmbeddedAssets.xmasNexusObjects8x8Embed_().bitmapData, 8, 8);
				AssetLibrary.addImageSet("xmasNexusObjects16x16", new EmbeddedAssets.xmasNexusObjects16x16Embed_().bitmapData, 16, 16);
				AssetLibrary.addImageSet("epicHiveObjects8x8", new EmbeddedAssets.epicHiveObjects8x8Embed_().bitmapData, 8, 8);
				AssetLibrary.addImageSet("epicHiveObjects16x16", new EmbeddedAssets.epicHiveObjects16x16Embed_().bitmapData, 16, 16);
				AssetLibrary.addImageSet("lostHallsObjects8x8", new EmbeddedAssets.lostHallsObjects8x8Embed_().bitmapData, 8, 8);
				AssetLibrary.addImageSet("lostHallsObjects16x16", new EmbeddedAssets.lostHallsObjects16x16Embed_().bitmapData, 16, 16);
				AssetLibrary.addImageSet("cnidarianReefObjects8x8", new EmbeddedAssets.cnidarianReefObjects8x8Embed_().bitmapData, 8, 8);
				AssetLibrary.addImageSet("cnidarianReefObjects16x16", new EmbeddedAssets.cnidarianReefObjects16x16Embed_().bitmapData, 16, 16);
				AssetLibrary.addImageSet("magicWoodsObjects8x8", new EmbeddedAssets.magicWoodsObjects8x8Embed_().bitmapData, 8, 8);
				AssetLibrary.addImageSet("magicWoodsObjects16x16", new EmbeddedAssets.magicWoodsObjects16x16Embed_().bitmapData, 16, 16);
				AssetLibrary.addImageSet("secludedThicketObjects8x8", new EmbeddedAssets.secludedThicketObjects8x8Embed_().bitmapData, 8, 8);
				AssetLibrary.addImageSet("secludedThicketObjects16x16", new EmbeddedAssets.secludedThicketObjects16x16Embed_().bitmapData, 16, 16);
				AssetLibrary.addImageSet("lofiGravestone8x8", new EmbeddedAssets.lofiGravestoneEmbed_().bitmapData, 8, 8);
				AssetLibrary.addImageSet("lofiGravestone16x8", new EmbeddedAssets.lofiGravestoneEmbed_().bitmapData, 16, 8);
				AssetLibrary.addImageSet("lofiGravestone16x16", new EmbeddedAssets.lofiGravestoneEmbed_().bitmapData, 16, 16);
			}

			private function addAnimatedCharacters():void
			{
				AnimatedChars.add("chars8x8rBeach", new EmbeddedAssets.chars8x8rBeachEmbed_().bitmapData, null, 8, 8, 56, 8, AnimatedChar.RIGHT);
				AnimatedChars.add("chars8x8dBeach", new EmbeddedAssets.chars8x8dBeachEmbed_().bitmapData, null, 8, 8, 56, 8, AnimatedChar.DOWN);
				AnimatedChars.add("chars8x8rLow1", new EmbeddedAssets.chars8x8rLow1Embed_().bitmapData, null, 8, 8, 56, 8, AnimatedChar.RIGHT);
				AnimatedChars.add("chars8x8rLow2", new EmbeddedAssets.chars8x8rLow2Embed_().bitmapData, null, 8, 8, 56, 8, AnimatedChar.RIGHT);
				AnimatedChars.add("chars8x8rMid", new EmbeddedAssets.chars8x8rMidEmbed_().bitmapData, null, 8, 8, 56, 8, AnimatedChar.RIGHT);
				AnimatedChars.add("chars8x8rMid2", new EmbeddedAssets.chars8x8rMid2Embed_().bitmapData, null, 8, 8, 56, 8, AnimatedChar.RIGHT);
				AnimatedChars.add("chars8x8rHigh", new EmbeddedAssets.chars8x8rHighEmbed_().bitmapData, null, 8, 8, 56, 8, AnimatedChar.RIGHT);
				AnimatedChars.add("chars8x8rHero1", new EmbeddedAssets.chars8x8rHero1Embed_().bitmapData, null, 8, 8, 56, 8, AnimatedChar.RIGHT);
				AnimatedChars.add("chars8x8rHero2", new EmbeddedAssets.chars8x8rHero2Embed_().bitmapData, null, 8, 8, 56, 8, AnimatedChar.RIGHT);
				AnimatedChars.add("chars8x8dHero1", new EmbeddedAssets.chars8x8dHero1Embed_().bitmapData, null, 8, 8, 56, 8, AnimatedChar.DOWN);
				AnimatedChars.add("chars16x16dMountains1", new EmbeddedAssets.chars16x16dMountains1Embed_().bitmapData, null, 16, 16, 112, 16, AnimatedChar.DOWN);
				AnimatedChars.add("chars16x16dMountains2", new EmbeddedAssets.chars16x16dMountains2Embed_().bitmapData, null, 16, 16, 112, 16, AnimatedChar.DOWN);
				AnimatedChars.add("chars8x8dEncounters", new EmbeddedAssets.chars8x8dEncountersEmbed_().bitmapData, null, 8, 8, 56, 8, AnimatedChar.DOWN);
				AnimatedChars.add("chars8x8rEncounters", new EmbeddedAssets.chars8x8rEncountersEmbed_().bitmapData, null, 8, 8, 56, 8, AnimatedChar.RIGHT);
				AnimatedChars.add("chars16x8dEncounters", new EmbeddedAssets.chars16x8dEncountersEmbed_().bitmapData, null, 16, 8, 112, 8, AnimatedChar.DOWN);
				AnimatedChars.add("chars16x8rEncounters", new EmbeddedAssets.chars16x8rEncountersEmbed_().bitmapData, null, 16, 8, 112, 8, AnimatedChar.DOWN);
				AnimatedChars.add("chars16x16dEncounters", new EmbeddedAssets.chars16x16dEncountersEmbed_().bitmapData, null, 16, 16, 112, 16, AnimatedChar.DOWN);
				AnimatedChars.add("chars16x16dEncounters2", new EmbeddedAssets.chars16x16dEncounters2Embed_().bitmapData, null, 16, 16, 112, 16, AnimatedChar.DOWN);
				AnimatedChars.add("chars16x16rEncounters", new EmbeddedAssets.chars16x16rEncountersEmbed_().bitmapData, null, 16, 16, 112, 16, AnimatedChar.RIGHT);
				AnimatedChars.add("d3Chars8x8rEmbed", new EmbeddedAssets.d3Chars8x8rEmbed_().bitmapData, null, 8, 8, 56, 8, AnimatedChar.RIGHT);
				AnimatedChars.add("d3Chars16x16rEmbed", new EmbeddedAssets.d3Chars16x16rEmbed_().bitmapData, null, 16, 16, 112, 16, AnimatedChar.RIGHT);
				//AnimatedChars.add("d2Chars8x8rEmbed", new EmbeddedAssets.d2Chars8x8rEmbed_().bitmapData, null, 8, 8, 56, 8, AnimatedChar.RIGHT);
				AnimatedChars.add("d2Chars16x16rEmbed", new EmbeddedAssets.d2Chars16x16rEmbed_().bitmapData, null, 16, 16, 112, 16, AnimatedChar.RIGHT);
				AnimatedChars.add("players", new EmbeddedAssets.playersEmbed_().bitmapData, new EmbeddedAssets.playersMaskEmbed_().bitmapData, 8, 8, 56, 24, AnimatedChar.RIGHT);
				AnimatedChars.add("playerskins", new EmbeddedAssets.playersSkinsEmbed_().bitmapData, new EmbeddedAssets.playersSkinsMaskEmbed_().bitmapData, 8, 8, 56, 24, AnimatedChar.RIGHT);
				AnimatedChars.add("chars8x8rPets1", new EmbeddedAssets.chars8x8rPets1Embed_().bitmapData, new EmbeddedAssets.chars8x8rPets1MaskEmbed_().bitmapData, 8, 8, 56, 8, AnimatedChar.RIGHT);
				AnimatedChars.add("chars8x8rPets2", new EmbeddedAssets.chars8x8rPets2Embed_().bitmapData, new EmbeddedAssets.chars8x8rPets1MaskEmbed_().bitmapData, 8, 8, 56, 8, AnimatedChar.RIGHT);
				AnimatedChars.add("petsDivine", new EmbeddedAssets.petsDivineEmbed_().bitmapData, null, 16, 16, 112, 16, AnimatedChar.RIGHT);
				AnimatedChars.add("playerskins16", new EmbeddedAssets.playersSkins16Embed_().bitmapData, new EmbeddedAssets.playersSkins16MaskEmbed_().bitmapData, 16, 16, 112, 48, AnimatedChar.RIGHT);
				AnimatedChars.add("d1chars16x16r", new EmbeddedAssets.d1Chars16x16rEmbed_().bitmapData, null, 16, 16, 112, 16, AnimatedChar.RIGHT);
				AnimatedChars.add("parasiteDenChars8x8", new EmbeddedAssets.parasiteDenChars8x8Embed_().bitmapData, null, 8, 8, 56, 8, AnimatedChar.RIGHT);
				AnimatedChars.add("parasiteDenChars16x16", new EmbeddedAssets.parasiteDenChars16x16Embed_().bitmapData, null, 16, 16, 112, 16, AnimatedChar.RIGHT);
				AnimatedChars.add("stPatricksChars8x8", new EmbeddedAssets.stPatricksChars8x8Embed_().bitmapData, null, 8, 8, 56, 8, AnimatedChar.RIGHT);
				AnimatedChars.add("stPatricksChars16x16", new EmbeddedAssets.stPatricksChars16x16Embed_().bitmapData, null, 16, 16, 112, 16, AnimatedChar.RIGHT);
				AnimatedChars.add("buffedBunnyChars16x16", new EmbeddedAssets.buffedBunnyChars16x16Embed_().bitmapData, null, 16, 16, 112, 16, AnimatedChar.RIGHT);
				AnimatedChars.add("mountainTempleChars8x8", new EmbeddedAssets.mountainTempleChars8x8Embed_().bitmapData, null, 8, 8, 56, 8, AnimatedChar.RIGHT);
				AnimatedChars.add("mountainTempleChars16x16", new EmbeddedAssets.mountainTempleChars16x16Embed_().bitmapData, null, 16, 16, 112, 16, AnimatedChar.RIGHT);
				AnimatedChars.add("oryxHordeChars8x8", new EmbeddedAssets.oryxHordeChars8x8Embed_().bitmapData, null, 8, 8, 56, 8, AnimatedChar.RIGHT);
				AnimatedChars.add("oryxHordeChars16x16", new EmbeddedAssets.oryxHordeChars16x16Embed_().bitmapData, null, 16, 16, 112, 16, AnimatedChar.RIGHT);
				AnimatedChars.add("battleOryxChars8x8", new EmbeddedAssets.battleOryxChars8x8Embed_().bitmapData, null, 8, 8, 56, 8, AnimatedChar.RIGHT);
				AnimatedChars.add("battleOryxChars16x16", new EmbeddedAssets.battleOryxChars16x16Embed_().bitmapData, null, 16, 16, 112, 16, AnimatedChar.RIGHT);
				AnimatedChars.add("santaWorkshopChars8x8", new EmbeddedAssets.santaWorkshopChars8x8Embed_().bitmapData, null, 8, 8, 56, 8, AnimatedChar.RIGHT);
				AnimatedChars.add("santaWorkshopChars16x16", new EmbeddedAssets.santaWorkshopChars16x16Embed_().bitmapData, null, 16, 16, 112, 16, AnimatedChar.RIGHT);
				AnimatedChars.add("Hanami8x8chars", new EmbeddedAssets.Hanami8x8charsEmbed_().bitmapData, null, 8, 8, 64, 8, AnimatedChar.RIGHT);
				AnimatedChars.add("summerNexusChars8x8", new EmbeddedAssets.summerNexusChars8x8Embed_().bitmapData, null, 8, 8, 56, 8, AnimatedChar.RIGHT);
				AnimatedChars.add("summerNexusChars16x16", new EmbeddedAssets.summerNexusChars16x16Embed_().bitmapData, null, 16, 16, 112, 16, AnimatedChar.RIGHT);
				AnimatedChars.add("autumnNexusChars16x16", new EmbeddedAssets.autumnNexusChars16x16Embed_().bitmapData, null, 16, 16, 112, 16, AnimatedChar.RIGHT);
				AnimatedChars.add("autumnNexusChars8x8", new EmbeddedAssets.autumnNexusChars8x8Embed_().bitmapData, null, 8, 8, 56, 8, AnimatedChar.RIGHT);
				AnimatedChars.add("xmasNexusChars8x8", new EmbeddedAssets.xmasNexusChars8x8Embed_().bitmapData, null, 8, 8, 56, 8, AnimatedChar.RIGHT);
				AnimatedChars.add("xmasNexusChars16x16", new EmbeddedAssets.xmasNexusChars16x16Embed_().bitmapData, null, 16, 16, 112, 16, AnimatedChar.RIGHT);
				AnimatedChars.add("epicHiveChars8x8", new EmbeddedAssets.epicHiveChars8x8Embed_().bitmapData, null, 8, 8, 56, 8, AnimatedChar.RIGHT);
				AnimatedChars.add("epicHiveChars16x16", new EmbeddedAssets.epicHiveChars16x16Embed_().bitmapData, null, 16, 16, 112, 16, AnimatedChar.RIGHT);
				AnimatedChars.add("lostHallsChars16x16", new EmbeddedAssets.lostHallsChars16x16Embed_().bitmapData, null, 16, 16, 112, 16, AnimatedChar.RIGHT);
				AnimatedChars.add("lostHallsChars8x8", new EmbeddedAssets.lostHallsChars8x8Embed_().bitmapData, null, 8, 8, 56, 8, AnimatedChar.RIGHT);
				AnimatedChars.add("magicWoodsChars8x8", new EmbeddedAssets.magicWoodsChars8x8Embed_().bitmapData, null, 8, 8, 56, 8, AnimatedChar.RIGHT);
				AnimatedChars.add("magicWoodsChars16x16", new EmbeddedAssets.magicWoodsChars16x16Embed_().bitmapData, null, 16, 16, 112, 16, AnimatedChar.RIGHT);
				AnimatedChars.add("secludedThicketChars8x8", new EmbeddedAssets.secludedThicketChars8x8Embed_().bitmapData, null, 8, 8, 56, 8, AnimatedChar.RIGHT);
				AnimatedChars.add("secludedThicketChars16x16", new EmbeddedAssets.secludedThicketChars16x16Embed_().bitmapData, null, 16, 16, 112, 16, AnimatedChar.RIGHT);
			}

			private function addSoundEffects():void
			{
				SoundEffectLibrary.load("button_click");
				SoundEffectLibrary.load("death_screen");
				SoundEffectLibrary.load("enter_realm");
				SoundEffectLibrary.load("error");
				SoundEffectLibrary.load("inventory_move_item");
				SoundEffectLibrary.load("level_up");
				SoundEffectLibrary.load("loot_appears");
				SoundEffectLibrary.load("no_mana");
				SoundEffectLibrary.load("use_key");
				SoundEffectLibrary.load("use_potion");
			}

			private function parse3DModels():void
			{
				var _local_1:String;
				var _local_2:ByteArray;
				var _local_3:String;
				for (_local_1 in EmbeddedAssets.models_)
				{
					_local_2 = EmbeddedAssets.models_[_local_1];
					_local_3 = _local_2.readUTFBytes(_local_2.length);
					Model3D.parse3DOBJ(_local_1, _local_2);
					Model3D.parseFromOBJ(_local_1, _local_3);
				}
			}

			private function parseParticleEffects():void
			{
				var _local_1:XML = XML(new EmbeddedAssets.particlesEmbed());
				ParticleLibrary.parseFromXML(_local_1);
			}

			private function parseGroundFiles():void
			{
				var _local_1:*;
				for each (_local_1 in EmbeddedData.groundFiles)
				{
					GroundLibrary.parseFromXML(XML(_local_1));
				}
			}

			private function parseObjectFiles():void
			{
				var _local_1:int;
				while (_local_1 < 25)
				{
					currentXmlIsTesting = this.checkIsTestingXML(EmbeddedData.objectFiles[_local_1]);
					ObjectLibrary.parseFromXML(XML(EmbeddedData.objectFiles[_local_1]));
					_local_1++;
				}
				var _local_2:int;
				while (_local_2 < EmbeddedData.objectFiles.length)
				{
					ObjectLibrary.parseDungeonXML(getQualifiedClassName(EmbeddedData.objectFiles[_local_2]), XML(EmbeddedData.objectFiles[_local_2]));
					_local_2++;
				}
				currentXmlIsTesting = false;
			}

			private function parseRegionFiles():void
			{
				var _local_1:*;
				for each (_local_1 in EmbeddedData.regionFiles)
				{
					RegionLibrary.parseFromXML(XML(_local_1));
				}
			}

			private function checkIsTestingXML(_arg_1:*):Boolean
			{
				return (!(getQualifiedClassName(_arg_1).indexOf("TestingCXML", 33) == -1));
			}


		}
	}//package com.company.assembleegameclient.util

