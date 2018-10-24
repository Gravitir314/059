//com.company.assembleegameclient.parameters.Parameters

package com.company.assembleegameclient.parameters
	{
	import com.company.assembleegameclient.game.events.ReconnectEvent;
	import com.company.assembleegameclient.map.Map;
	import com.company.assembleegameclient.objects.GameObject;
	import com.company.assembleegameclient.objects.ObjectLibrary;
	import com.company.assembleegameclient.objects.ObjectProperties;
	import com.company.assembleegameclient.objects.Portal;
	import com.company.assembleegameclient.ui.options.Options;
	import com.company.util.KeyCodes;
	import com.company.util.MoreDateUtil;

	import flash.display.DisplayObject;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.net.SharedObject;
	import flash.system.Capabilities;
	import flash.utils.Dictionary;

	public class Parameters
		{
			// ObjectLibrary.as
			// Update from X28.0.6 to X30.0.0
			// Fix typo || clean code
			// Finish fullscreen
			// [GetPackagesTask.as, GetMysteryBoxesTask.as, Player.as, MapUserInput.as, GameServerConnectionConcrete.as, ParseChatMessageCommand.as]
			public static const PORT:int = 2050;
			public static const ALLOW_SCREENSHOT_MODE:Boolean = false;
			public static const FELLOW_GUILD_COLOR:uint = 10944349;
			public static const NAME_CHOSEN_COLOR:uint = 0xFCDF00;
			public static var root:DisplayObject;
			public static const PLAYER_ROTATE_SPEED:Number = 0.003;
			public static const BREATH_THRESH:int = 20;
			public static const SERVER_CHAT_NAME:String = "";
			public static const CLIENT_CHAT_NAME:String = "*Client*";
			public static const ERROR_CHAT_NAME:String = "*Error*";
			public static const HELP_CHAT_NAME:String = "*Help*";
			public static const GUILD_CHAT_NAME:String = "*Guild*";
			public static const SYNC_CHAT_NAME:String = "*Sync*";
			public static const ASTRAL_CHAT_NAME:String = "*Astral*";
			public static const NEWS_TIMESTAMP_DEFAULT:Number = 1.1;
			public static const NAME_CHANGE_PRICE:int = 1000;
			public static const GUILD_CREATION_PRICE:int = 1000;
			public static var data_:Object = null;
			public static var GPURenderError:Boolean = false;
			public static var blendType_:int = 1;
			public static var projColorType_:int = 0;
			public static var drawProj_:Boolean = true;
			public static var screenShotMode_:Boolean = false;
			public static var screenShotSlimMode_:Boolean = false;
			public static var sendLogin_:Boolean = true;
			public static const REALM_GAMEID:int = 0;
			public static const TUTORIAL_GAMEID:int = -1;
			public static const NEXUS_GAMEID:int = -2;
			public static const RANDOM_REALM_GAMEID:int = -3;
			public static const VAULT_GAMEID:int = -5;
			public static const MAPTEST_GAMEID:int = -6;
			public static const DAILYQUESTROOM_GAMEID:int = -11;
			public static const MAX_SINK_LEVEL:Number = 18;
			public static const TERMS_OF_USE_URL:String = "http://legal.decagames.com/tos/";
			public static const PRIVACY_POLICY_URL:String = "http://legal.decagames.com/privacy/";
			public static const USER_GENERATED_CONTENT_TERMS:String = "/UGDTermsofUse.html";
			public static const RANDOM1:String = "311f80691451c71b09a13a2a6e";
			public static const RANDOM2:String = "72c5583cafb6818995cbd74b80";
			public static const RSA_PUBLIC_KEY:String = ("-----BEGIN PUBLIC KEY-----\n" + "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDCKFctVrhfF3m2Kes0FBL/JFeO" + "cmNg9eJz8k/hQy1kadD+XFUpluRqa//Uxp2s9W2qE0EoUCu59ugcf/p7lGuL99Uo" + "SGmQEynkBvZct+/M40L0E0rZ4BVgzLOJmIbXMp0J4PnPcb6VLZvxazGcmSfjauC7" + "F3yWYqUbZd/HCBtawwIDAQAB\n" + "-----END PUBLIC KEY-----");
			private static var savedOptions_:SharedObject = null;
			public static const skinTypes16:Vector.<int> = new <int>[1027, 0x0404, 1029, 1030, 10973, 19494, 19531, 6346, 30056, 5505];
			public static const itemTypes16:Vector.<int> = new <int>[5473, 5474, 5475, 5476, 10939, 19494, 19531, 6347, 5506];
			private static var keyNames_:Dictionary = new Dictionary();

			private static var ctrlrInputNames_:Dictionary = new Dictionary();
			public static var fameBotPortalId:int;
			public static var fameBotPortal:Portal;
			public static var fameBotPortalPoint:Point;
			public static var ssmode:Boolean = false;
			public static var ignoringSecurityQuestions:Boolean = false;
			public static var Cache_CHARLIST_valid:Boolean = false;
			public static var Cache_CHARLIST_data:String;
			public static var lowCPUMode:Boolean = false;
			public static var dailyCalendar1RunOnce:Boolean = false;
			public static var dailyCalendar2RunOnce:Boolean = false;
			public static var announcedBags:Vector.<int> = new Vector.<int>(0);
			public static var preload:Boolean = false;
			public static var constructToggle:Boolean = false;
			public static var worldMessage:String = "";
			public static var autoAcceptTrades:Boolean;
			public static var autoDrink:Boolean;
			public static var mystics:Vector.<String> = new Vector.<String>(0);
			public static var fameBot:Boolean = false;
			public static var fameBotWatchingPortal:Boolean = false;
			public static var fpmStart:int = -1;
			public static var fpmGain:int = 0;
			public static var VHS:int = 0;
			public static var VHSRecord:Vector.<Point> = new Vector.<Point>();
			public static var VHSRecordLength:int = -1;
			public static var VHSIndex:int = -1;
			public static var VHSNext:Point = new Point();
			public static var followName:String;
			public static var followPlayer:GameObject;
			public static var followingName:Boolean = false;
			public static var timerActive:Boolean;
			public static var phaseChangeAt:int;
			public static var phaseName:String;
			public static const DefaultAAIgnore:Vector.<int> = new <int>[2312, 0x0909, 2370, 2392, 2393, 2400, 2401, 3413, 3418, 3419, 3420, 3421, 3427, 3454, 3638, 3645, 29594, 29597, 29710, 29711, 29742, 29743, 29746, 29748, 29781, 30001];
			public static const DefaultAAException:Vector.<int> = new <int>[2309, 2310, 2311, 3448, 3449, 3472, 3334, 5952, 2354, 2369, 3368, 3366, 3367, 3391, 3389, 3390, 5920, 2314, 3412, 3639, 3634, 2327, 2335, 2336, 1755, 24582, 24351, 24363, 24135, 24133, 24134, 24132, 24136, 3356, 3357, 3358, 3359, 3360, 3361, 3362, 3363, 3364, 2352, 2330, 28780, 28781, 28795, 28942, 28957, 28988, 28938, 29291, 29018, 29517, 24338, 29580, 29712];
			public static const defaultInclusions:Vector.<int> = new <int>[600, 601, 602, 603, 2295, 2296, 2297, 2298, 2524, 2525, 2526, 2527, 8608, 8609, 8610, 8611, 8615, 8617, 8616, 8618, 8962, 9017, 9015, 9016, 9055, 9054, 9052, 9053, 9059, 9058, 9056, 9057, 9063, 9062, 9060, 9061, 32697, 32698, 32699, 32700, 3004, 3005, 3006, 3007, 3088, 3100, 3096, 3091, 3113, 3114, 3112, 3111, 3032, 3033, 3034, 3035, 3177, 3266];
			public static const defaultExclusions:Vector.<int> = new Vector.<int>(0);
			public static const hpPotions:Vector.<int> = new <int>[0x0707, 2594, 2623, 2632, 2633, 2689, 2836, 2837, 2838, 2839, 2795, 2868, 2870, 2872, 2874, 2876];
			public static const mpPotions:Vector.<int> = new <int>[2595, 2634, 2797, 2798, 2840, 2841, 2842, 2843, 2796, 2869, 2871, 2873, 2875, 2877, 3098];
			public static const lmPotions:Vector.<int> = new <int>[2793, 9070, 5471, 9730, 2794, 9071, 5472, 9731];
			public static const raPotions:Vector.<int> = new <int>[2591, 5465, 9064, 9729, 2592, 5466, 9065, 9727, 2593, 5467, 9066, 9726, 2612, 5468, 9067, 9724, 2613, 5469, 9068, 9725, 2636, 5470, 9069, 0x2600];
			public static var abi:Boolean = true;
			public static var syncFollowing:Boolean = false;
			public static var questFollow:Boolean = false;
			public static var famePoint:Point = new Point(0, 0);
			public static var SPOOKYBOINEAR:Boolean;
			public static var DrownAmount:int = 94;
			public static var reconRealm:ReconnectEvent = null;
			public static var reconDung:ReconnectEvent = null;
			public static var reconVault:ReconnectEvent = null;
			public static var reconNexus:ReconnectEvent = null;
			public static var reconOryx:ReconnectEvent = null;
			public static var reconDaily:ReconnectEvent = null;
			public static var givingPotions:Boolean;
			public static var receivingPots:Boolean;
			public static var potionsToTrade:Vector.<Boolean> = new <Boolean>[false, false, false, false, false, false, false, false, false, false, false, false];
			public static var emptyOffer:Vector.<Boolean> = new <Boolean>[false, false, false, false, false, false, false, false, false, false, false, false];
			public static var recvrName:String;
			public static var dmgCounter:Array = [];
			public static const spamFilter:Vector.<String> = new <String>["oryxsh0p.net", "wh!tebag,net", "wh!tebag.net", "realmshop.info", "rotmgmarket.c", "rotmg.sh0p", "rotmg.shop", "rpgstash,com", "rpgstash.com", "realmitems", "reaimitems", "reaimltems", "realmltems", "realmpower,net", "reaimpower.net", "realmpower.net", "reaimpower,net", "rea!mkings.xyz", "buyrotmg.c", "lifepot. org", "-----|", "rotmg,org", "rotmgmax.me", "rotmgmax,me"];
			public static var lockRecon:Boolean = false;
			public static var usingPortal:Boolean;
			public static var portalID:int;
			public static var portalSpamRate:int = 80;
			public static var watchInv:Boolean;
			public static var famePointOffset:Number = 0;
			public static var needsMapCheck:int = 0;
			public static var needToRecalcDesireables:Boolean = false;
			public static var fameWaitStartTime:int = 0;
			public static var fameWaitNTTime:int = 0;
			public static var fameWalkSleep_toFountainOrHall:int = 0;
			public static var fameWalkSleep_toRealms:int = 0;
			public static var fameWalkSleep2:int = 0;
			public static var fameWalkSleepStart:int = 0;
			public static var realmJoining:Boolean;
			public static var forceCharId:int = -1;
			public static var ignoredShotCount:int = 0;
			public static var statsChar:String = "◘";
			public static var timerPhaseTimes:Dictionary = new Dictionary();
			public static var timerPhaseNames:Dictionary = new Dictionary();
			public static var oldFSmode:String = StageScaleMode.EXACT_FIT;

			public static function setTimerPhases():void
			{
				timerPhaseTimes['{"key":"server.oryx_closed_realm"}'] = 120000;
				timerPhaseTimes['{"key":"server.oryx_minions_failed"}'] = 12000;
				timerPhaseTimes["DIE! DIE! DIE!!!"] = 23000;
				timerPhaseNames['{"key":"server.oryx_closed_realm"}'] = "Realm Closed";
				timerPhaseNames['{"key":"server.oryx_minions_failed"}'] = "Oryx Shake";
				timerPhaseNames["DIE! DIE! DIE!!!"] = "Vulnerable";
			}

			public static function setAutolootDesireables():void
			{
				var _local_1:int;
				var _local_4:int;
				for each (var _local_3:XML in ObjectLibrary.xmlLibrary_)
				{
					_local_4 = int(_local_3.@type);
					var _local_2:ObjectProperties = ObjectLibrary.propsLibrary_[_local_4];
					if (_local_2 != null && _local_2.isItem_)
					{
						_local_2.desiredLoot_ = false;
						if (_local_2.isPotion_ && desiredPotion(_local_4))
						{
							_local_2.desiredLoot_ = true;
						}
						else
						{
							if (Parameters.data_.autoLootWeaponTier != 999 && desiredWeapon(_local_3, _local_4, Parameters.data_.autoLootWeaponTier))
							{
								_local_2.desiredLoot_ = true;
							}
							else
							{
								if (Parameters.data_.autoLootAbilityTier != 999 && desiredAbility(_local_3, _local_4, Parameters.data_.autoLootAbilityTier))
								{
									_local_2.desiredLoot_ = true;
								}
								else
								{
									if (Parameters.data_.autoLootArmorTier != 999 && desiredArmor(_local_3, _local_4, Parameters.data_.autoLootArmorTier))
									{
										_local_2.desiredLoot_ = true;
									}
									else
									{
										if (Parameters.data_.autoLootRingTier != 999 && desiredRing(_local_3, _local_4, Parameters.data_.autoLootRingTier))
										{
											_local_2.desiredLoot_ = true;
										}
										else
										{
											if (Parameters.data_.autoLootUTs && desiredUT(_local_3))
											{
												_local_2.desiredLoot_ = true;
											}
											else
											{
												if (Parameters.data_.autoLootSkins && desiredSkin(_local_3, _local_3.@id))
												{
													_local_2.desiredLoot_ = true;
												}
												else
												{
													if (Parameters.data_.autoLootPetSkins && desiredPetSkin(_local_3, _local_3.@id, int(_local_3.@type)))
													{
														_local_2.desiredLoot_ = true;
													}
													else
													{
														if (Parameters.data_.autoLootKeys && desiredKey(_local_3, _local_3.@id))
														{
															_local_2.desiredLoot_ = true;
														}
														else
														{
															if (Parameters.data_.autoLootMarks && String(_local_3.@id).indexOf("Mark of ") != -1)
															{
																_local_2.desiredLoot_ = true;
															}
															else
															{
																if (Parameters.data_.autoLootConsumables && _local_3.hasOwnProperty("Consumable"))
																{
																	_local_2.desiredLoot_ = true;
																}
																else
																{
																	if (!Parameters.data_.autoLootSoulbound && _local_3.hasOwnProperty("Soulbound"))
																	{
																		_local_2.desiredLoot_ = true;
																	}
																	else
																	{
																		if (Parameters.data_.autoLootEggs != -1 && desiredEgg(_local_3, Parameters.data_.autoLootEggs))
																		{
																			_local_2.desiredLoot_ = true;
																		}
																		else
																		{
																			if (Parameters.data_.autoLootFeedPower != -1 && desiredFeedPower(_local_3, Parameters.data_.autoLootFeedPower))
																			{
																				_local_2.desiredLoot_ = true;
																			}
																			else
																			{
																				if (Parameters.data_.autoLootFameBonus != -1 && desiredFameBonus(_local_3, Parameters.data_.autoLootFameBonus))
																				{
																					_local_2.desiredLoot_ = true;
																				}
																			}
																		}
																	}
																}
															}
														}
													}
												}
											}
										}
									}
								}
							}
						}
					}
				}
				for each (_local_1 in Parameters.data_.autoLootExcludes)
				{
					_local_2 = ObjectLibrary.propsLibrary_[_local_1];
					if (_local_2)
					{
						_local_2.desiredLoot_ = false;
					}
				}
				for each (_local_1 in Parameters.data_.autoLootIncludes)
				{
					_local_2 = ObjectLibrary.propsLibrary_[_local_1];
					if (_local_2)
					{
						_local_2.desiredLoot_ = true;
					}
				}
			}

			public static function handleLootInListCommand():String
			{
				var _local_4:String = "AutoLoot Inclusion List: \n";
				for each (var _local_3:int in Parameters.data_.autoLootIncludes)
				{
					var _local_1:XML = ObjectLibrary.xmlLibrary_[_local_3];
					if (_local_1)
					{
						var _local_2:String;
						if (_local_1.hasOwnProperty("DisplayId"))
						{
							_local_2 = _local_1.DisplayId;
						}
						else
						{
							_local_2 = _local_1.@id;
						}
						_local_4 = (_local_4 + "(" + _local_3 + ") " + _local_2 + ", ");
					}
					else
					{
						_local_4 = (_local_4 + "(" + _local_3 + "), ");
					}
				}
				return (_local_4);
			}

			public static function handleLootInAddCommand(_arg_1:String):String
			{
				var _local_4:int = int(_arg_1);
				var _local_2:XML = ObjectLibrary.xmlLibrary_[_local_4];
				var _local_3:String;
				if (_local_2.hasOwnProperty("DisplayId"))
				{
					_local_3 = _local_2.DisplayId;
				}
				else
				{
					_local_3 = _local_2.@id;
				}
				if ((Parameters.data_.autoLootIncludes as Vector.<int>).indexOf(_local_4) >= 0)
				{
					return (_local_3 + " already in inclusions list");
				}
				(Parameters.data_.autoLootIncludes as Vector.<int>).push(_local_4);
				Parameters.setAutolootDesireables();
				Parameters.save();
				return ("Added " + _local_3 + " to inclusions list");
			}

			public static function handleLootInRemCommand(_arg_1:String):String
			{
				var _local_5:int = int(_arg_1);
				var _local_2:XML = ObjectLibrary.xmlLibrary_[_local_5];
				var _local_3:String;
				if (_local_2.hasOwnProperty("DisplayId"))
				{
					_local_3 = _local_2.DisplayId;
				}
				else
				{
					_local_3 = _local_2.@id;
				}
				var _local_4:int = Parameters.data_.autoLootIncludes.indexOf(_local_5);
				if (_local_4 >= 0)
				{
					Parameters.data_.autoLootIncludes.splice(_local_4, 1);
					Parameters.setAutolootDesireables();
					Parameters.save();
					return (("Removed " + _local_3) + " from inclusions list");
				}
				return (_local_3 + " not in inclusions list");
			}

			public static function handleLootExListCommand():String
			{
				var _local_4:String = "AutoLoot Exclusion List: \n";
				for each (var _local_3:int in Parameters.data_.autoLootExcludes)
				{
					var _local_1:XML = ObjectLibrary.xmlLibrary_[_local_3];
					if (_local_1)
					{
						var _local_2:String;
						if (_local_1.hasOwnProperty("DisplayId"))
						{
							_local_2 = _local_1.DisplayId;
						}
						else
						{
							_local_2 = _local_1.@id;
						}
						_local_4 = (_local_4 + "(" + _local_3 + ") " + _local_2 + ", ");
					}
					else
					{
						_local_4 = (_local_4 + "(" + _local_3 + "), ");
					}
				}
				return (_local_4);
			}

			public static function handleLootExAddCommand(_arg_1:String):String
			{
				var _local_4:int = int(_arg_1);
				var _local_2:XML = ObjectLibrary.xmlLibrary_[_local_4];
				var _local_3:String;
				if (_local_2.hasOwnProperty("DisplayId"))
				{
					_local_3 = _local_2.DisplayId;
				}
				else
				{
					_local_3 = _local_2.@id;
				}
				if (Parameters.data_.autoLootExcludes.indexOf(_local_4) >= 0)
				{
					return (_local_3 + " already in exclusions list");
				}
				Parameters.data_.autoLootExcludes.push(_local_4);
				Parameters.setAutolootDesireables();
				Parameters.save();
				return ("Added " + _local_3 + " to exclusions list");
			}

			public static function handleLootExRemCommand(_arg_1:String):String
			{
				var _local_5:int = int(_arg_1);
				var _local_2:XML = ObjectLibrary.xmlLibrary_[_local_5];
				var _local_3:String;
				if (_local_2.hasOwnProperty("DisplayId"))
				{
					_local_3 = _local_2.DisplayId;
				}
				else
				{
					_local_3 = _local_2.@id;
				}
				var _local_4:int = Parameters.data_.autoLootExcludes.indexOf(_local_5);
				if (_local_4 >= 0)
				{
					Parameters.data_.autoLootExcludes.splice(_local_4, 1);
					Parameters.setAutolootDesireables();
					Parameters.save();
					return ("Removed " + _local_3 + " from exclusions list");
				}
				return (_local_3 + " not in exclusions list");
			}

			public static function desiredPotion(_arg_1:int):Boolean
			{
				if (Parameters.data_.autoLootHPPots)
				{
					if (hpPotions.indexOf(_arg_1) >= 0)
					{
						return (true);
					}
				}
				if (Parameters.data_.autoLootMPPots)
				{
					if (mpPotions.indexOf(_arg_1) >= 0)
					{
						return (true);
					}
				}
				if (Parameters.data_.autoLootLifeManaPots)
				{
					if (lmPotions.indexOf(_arg_1) >= 0)
					{
						return (true);
					}
				}
				if (Parameters.data_.autoLootRainbowPots)
				{
					if (raPotions.indexOf(_arg_1) >= 0)
					{
						return (true);
					}
				}
				return (false);
			}

			public static function desiredWeapon(_arg_1:XML, _arg_2:int, _arg_3:int):Boolean
			{
				if (!(_arg_1.hasOwnProperty("SlotType") && _arg_1.hasOwnProperty("Tier")))
				{
					return (false);
				}
				var _local_4:Vector.<int> = new <int>[3, 2, 24, 17, 1, 8];
				return (_arg_1.Tier >= _arg_3 && _local_4.indexOf(_arg_1.SlotType) != -1);
			}

			public static function desiredAbility(_arg_1:XML, _arg_2:int, _arg_3:int):Boolean
			{
				if (!(_arg_1.hasOwnProperty("SlotType") && _arg_1.hasOwnProperty("Tier")))
				{
					return (false);
				}
				var _local_4:Vector.<int> = new <int>[13, 16, 21, 18, 22, 15, 23, 12, 5, 25, 19, 11, 4, 20];
				return (_arg_1.Tier >= _arg_3 && _local_4.indexOf(_arg_1.SlotType) != -1);
			}

			public static function desiredArmor(_arg_1:XML, _arg_2:int, _arg_3:int):Boolean
			{
				if (!(_arg_1.hasOwnProperty("SlotType") && _arg_1.hasOwnProperty("Tier")))
				{
					return (false);
				}
				var _local_4:Vector.<int> = new <int>[6, 7, 14];
				return (_arg_1.Tier >= _arg_3 && _local_4.indexOf(_arg_1.SlotType) != -1);
			}

			public static function desiredRing(_arg_1:XML, _arg_2:int, _arg_3:int):Boolean
			{
				if (!(_arg_1.hasOwnProperty("SlotType") && _arg_1.hasOwnProperty("Tier")))
				{
					return (false);
				}
				return (_arg_1.Tier >= _arg_3 && _arg_1.SlotType == 9);
			}

			public static function desiredUT(_arg_1:XML):Boolean
			{
				var _local_2:int;
				if (!_arg_1.hasOwnProperty("SlotType"))
				{
					return (false);
				}
				if (_arg_1.hasOwnProperty("BagType"))
				{
					_local_2 = _arg_1.BagType;
				}
				else
				{
					return (false);
				}
				return (_local_2 == 6 || _local_2 == 9);
			}

			public static function desiredSkin(_arg_1:XML, _arg_2:String):Boolean
			{
				if (_arg_1.Activate == "UnlockSkin")
				{
					return (true);
				}
				if (_arg_2.lastIndexOf("Mystery Skin") >= 0)
				{
					return (true);
				}
				return (false);
			}

			public static function desiredPetSkin(_arg_1:XML, _arg_2:String, _arg_3:int):Boolean
			{
				var _local_4:Vector.<int> = new <int>[8973, 8974, 8975];
				if (_arg_2.lastIndexOf("Pet Stone") >= 0)
				{
					return (true);
				}
				if (_local_4.indexOf(_arg_3) >= 0)
				{
					return (true);
				}
				return (false);
			}

			public static function desiredKey(_arg_1:XML, _arg_2:String):Boolean
			{
				if (_arg_1.Activate == "CreatePortal")
				{
					return (true);
				}
				if (_arg_2.indexOf("Mystery Key") >= 0)
				{
					return (true);
				}
				return (false);
			}

			public static function desiredEgg(_arg_1:XML, _arg_2:int):Boolean
			{
				var _local_3:int;
				if (_arg_1.hasOwnProperty("Rarity"))
				{
					if (_arg_1.Rarity == "Common")
					{
						_local_3 = 0;
					}
					else
					{
						if (_arg_1.Rarity == "Uncommon")
						{
							_local_3 = 1;
						}
						else
						{
							if (_arg_1.Rarity == "Rare")
							{
								_local_3 = 2;
							}
							else
							{
								if (_arg_1.Rarity == "Legendary")
								{
									_local_3 = 3;
								}
							}
						}
					}
					return (_local_3 >= _arg_2);
				}
				return (false);
			}

			public static function desiredFeedPower(_arg_1:XML, _arg_2:int):Boolean
			{
				return (_arg_1.hasOwnProperty("feedPower") && _arg_1.feedPower >= _arg_2);
			}

			public static function desiredFameBonus(_arg_1:XML, _arg_2:int):Boolean
			{
				return (_arg_1.hasOwnProperty("FameBonus") && _arg_1.FameBonus >= _arg_2);
			}


			public static function load():void
			{
				try
				{
					savedOptions_ = SharedObject.getLocal("AssembleeGameClientOptions", "/");
					data_ = savedOptions_.data;
				}
				catch (error:Error)
				{
					data_ = {};
				}
				setDefaults();
				setIgnores();
				Options.calculateIgnoreBitmask();
				setTimerPhases();
				setAutolootDesireables();
				save();
			}

			public static function setIgnores():void
			{
				var _local_3:ObjectProperties;
				for each (var _local_1:int in Parameters.data_.AAIgnore)
				{
					if (_local_1 in ObjectLibrary.propsLibrary_)
					{
						_local_3 = ObjectLibrary.propsLibrary_[_local_1];
						_local_3.ignored = true;
					}
					if (_local_1 in ObjectLibrary.xmlLibrary_)
					{
						ObjectLibrary.xmlLibrary_[_local_1].props_.ignored = true;
					}
				}
				for each (var _local_2:int in Parameters.data_.AAException)
				{
					if (_local_2 in ObjectLibrary.propsLibrary_)
					{
						_local_3 = ObjectLibrary.propsLibrary_[_local_2];
						_local_3.excepted = true;
					}
					if (_local_2 in ObjectLibrary.xmlLibrary_)
					{
						ObjectLibrary.xmlLibrary_[_local_2].props_.excepted = true;
					}
				}
			}

			public static function save():void
			{
				try
				{
					if (savedOptions_ != null)
					{
						savedOptions_.flush();
					}
				}
				catch (error:Error)
				{
				}
			}

			private static function setDefaultKey(_arg_1:String, _arg_2:uint):void
			{
				if (!data_.hasOwnProperty(_arg_1))
				{
					data_[_arg_1] = _arg_2;
				}
				keyNames_[_arg_1] = true;
			}

			private static function setDefaultControllerInput(_arg_1:String, _arg_2:uint):void
			{
				if (!data_.hasOwnProperty(_arg_1))
				{
					data_[_arg_1] = _arg_2;
				}
				ctrlrInputNames_[_arg_1] = true;
			}

			public static function setKey(_arg_1:String, _arg_2:uint):void
			{
				var _local_3:String;
				for (_local_3 in keyNames_)
				{
					if (data_[_local_3] == _arg_2)
					{
						data_[_local_3] = KeyCodes.UNSET;
					}
				}
				data_[_arg_1] = _arg_2;
			}

			private static function setDefault(_arg_1:String, _arg_2:*):void
			{
				if (!data_.hasOwnProperty(_arg_1))
				{
					data_[_arg_1] = _arg_2;
				}
			}

			public static function isGpuRender():Boolean
			{
				return (!GPURenderError && data_.GPURender && !Map.forceSoftwareRender);
			}

			public static function clearGpuRenderEvent(_arg_1:Event):void
			{
				clearGpuRender();
			}

			public static function clearGpuRender():void
			{
				GPURenderError = true;
			}

			public static function setDefaults():void
			{
				setDefaultKey("moveLeft", KeyCodes.A);
				setDefaultKey("moveRight", KeyCodes.D);
				setDefaultKey("moveUp", KeyCodes.W);
				setDefaultKey("moveDown", KeyCodes.S);
				setDefaultKey("rotateLeft", KeyCodes.Q);
				setDefaultKey("rotateRight", KeyCodes.E);
				setDefaultKey("useSpecial", KeyCodes.SPACE);
				setDefaultKey("interact", KeyCodes.NUMBER_0);
				setDefaultKey("useInvSlot1", KeyCodes.NUMBER_1);
				setDefaultKey("useInvSlot2", KeyCodes.NUMBER_2);
				setDefaultKey("useInvSlot3", KeyCodes.NUMBER_3);
				setDefaultKey("useInvSlot4", KeyCodes.NUMBER_4);
				setDefaultKey("useInvSlot5", KeyCodes.NUMBER_5);
				setDefaultKey("useInvSlot6", KeyCodes.NUMBER_6);
				setDefaultKey("useInvSlot7", KeyCodes.NUMBER_7);
				setDefaultKey("useInvSlot8", KeyCodes.NUMBER_8);
				setDefaultKey("escapeToNexus2", KeyCodes.F5);
				setDefaultKey("escapeToNexus", KeyCodes.R);
				setDefaultKey("autofireToggle", KeyCodes.I);
				setDefaultKey("scrollChatUp", KeyCodes.PAGE_UP);
				setDefaultKey("scrollChatDown", KeyCodes.PAGE_DOWN);
				setDefaultKey("miniMapZoomOut", KeyCodes.MINUS);
				setDefaultKey("miniMapZoomIn", KeyCodes.EQUAL);
				setDefaultKey("resetToDefaultCameraAngle", KeyCodes.Z);
				setDefaultKey("togglePerformanceStats", KeyCodes.UNSET);
				setDefaultKey("options", KeyCodes.O);
				setDefaultKey("toggleCentering", KeyCodes.X);
				setDefaultKey("chat", KeyCodes.ENTER);
				setDefaultKey("chatCommand", KeyCodes.SLASH);
				setDefaultKey("tell", KeyCodes.TAB);
				setDefaultKey("guildChat", KeyCodes.G);
				setDefaultKey("testOne", KeyCodes.PERIOD);
				setDefaultKey("toggleFullscreen", KeyCodes.UNSET);
				setDefaultKey("useHealthPotion", KeyCodes.F);
				setDefaultKey("GPURenderToggle", KeyCodes.UNSET);
				setDefaultKey("friendList", KeyCodes.UNSET);
				setDefaultKey("useMagicPotion", KeyCodes.V);
				setDefaultKey("switchTabs", KeyCodes.B);
				setDefaultKey("particleEffect", KeyCodes.P);
				setDefaultKey("toggleHPBar", KeyCodes.H);
				setDefaultKey("toggleProjectiles", KeyCodes.N);
				setDefaultKey("toggleMasterParticles", KeyCodes.M);
				setDefault("playerObjectType", 782);
				setDefault("playMusic", true);
				setDefault("playSFX", true);
				setDefault("playPewPew", true);
				setDefault("centerOnPlayer", true);
				setDefault("preferredServer", null);
				setDefault("bestServer", null);
				setDefault("needsTutorial", false);
				setDefault("needsRandomRealm", false);
				setDefault("cameraAngle", 0);
				setDefault("defaultCameraAngle", 0);
				setDefault("showQuestPortraits", false);
				setDefault("fullscreenMode", false);
				setDefault("showProtips", true);
				setDefault("protipIndex", 0);
				setDefault("joinDate", MoreDateUtil.getDayStringInPT());
				setDefault("lastDailyAnalytics", null);
				setDefault("allowRotation", true);
				setDefault("allowMiniMapRotation", false);
				setDefault("charIdUseMap", {});
				setDefault("drawShadows", true);
				setDefault("textBubbles", true);
				setDefault("showTradePopup", true);
				setDefault("paymentMethod", null);
				setDefault("filterLanguage", true);
				setDefault("showGuildInvitePopup", true);
				setDefault("showBeginnersOffer", false);
				setDefault("beginnersOfferTimeLeft", 0);
				setDefault("beginnersOfferShowNow", false);
				setDefault("beginnersOfferShowNowTime", 0);
				setDefault("watchForTutorialExit", false);
				setDefault("clickForGold", false);
				setDefault("contextualPotionBuy", false);
				setDefault("inventorySwap", true);
				setDefault("particleEffect", false);
				setDefault("uiQuality", true);
				setDefault("disableEnemyParticles", false);
				setDefault("disableAllyShoot", 0);
				setDefault("disablePlayersHitParticles", false);
				setDefault("cursorSelect", "4");
				if (Capabilities.playerType == "Desktop")
				{
					setDefault("GPURender", false);
				}
				else
				{
					setDefault("GPURender", false);
				}
				setDefault("forceChatQuality", false);
				setDefault("hidePlayerChat", false);
				setDefault("chatStarRequirement", 2);
				setDefault("chatAll", true);
				setDefault("chatWhisper", true);
				setDefault("chatGuild", true);
				setDefault("chatTrade", true);
				setDefault("toggleBarText", 0);
				setDefault("toggleToMaxText", false);
				setDefault("particleEffect", true);
				if (data_.hasOwnProperty("playMusic") && data_.playMusic == true)
				{
					setDefault("musicVolume", 1);
				}
				else
				{
					setDefault("musicVolume", 0);
				}
				if (data_.hasOwnProperty("playSFX") && data_.playMusic == true)
				{
					setDefault("SFXVolume", 1);
				}
				else
				{
					setDefault("SFXVolume", 0);
				}
				setDefault("friendList", KeyCodes.UNSET);
				setDefault("tradeWithFriends", false);
				setDefault("chatFriend", false);
				setDefault("friendStarRequirement", 0);
				setDefault("HPBar", 1);
				setDefault("newMiniMapColors", false);
				setDefault("noParticlesMaster", false);
				setDefault("noAllyNotifications", false);
				setDefault("noAllyDamage", false);
				setDefault("noEnemyDamage", false);
				setDefault("forceEXP", 0);
				setDefault("showFameGain", false);
				setDefault("curseIndication", false);
				setDefault("showTierTag", true);
				setDefault("characterGlow", 0);
				setDefault("gravestones", 0);
				setDefault("chatNameColor", 0);
				if (!data_.hasOwnProperty("needsSurvey"))
				{
					data_.needsSurvey = data_.needsTutorial;
					switch (int((Math.random() * 5)))
					{
						case 0:
							data_.surveyDate = 0;
							data_.playTimeLeftTillSurvey = (5 * 60);
							data_.surveyGroup = "5MinPlaytime";
							return;
						case 1:
							data_.surveyDate = 0;
							data_.playTimeLeftTillSurvey = (10 * 60);
							data_.surveyGroup = "10MinPlaytime";
							return;
						case 2:
							data_.surveyDate = 0;
							data_.playTimeLeftTillSurvey = (30 * 60);
							data_.surveyGroup = "30MinPlaytime";
							return;
						case 3:
							data_.surveyDate = (new Date().time + ((((1000 * 60) * 60) * 24) * 7));
							data_.playTimeLeftTillSurvey = (2 * 60);
							data_.surveyGroup = "1WeekRealtime";
							return;
						case 4:
							data_.surveyDate = (new Date().time + ((((1000 * 60) * 60) * 24) * 14));
							data_.playTimeLeftTillSurvey = (2 * 60);
							data_.surveyGroup = "2WeekRealtime";
							return;
					}
				}
				setDefault("gameVersion", "X30.0.0");
				setDefault("lastTab", "Options.Controls");
				setDefault("ssdebuffBitmask", 0);
				setDefault("ssdebuffBitmask2", 0);
				setDefault("ccdebuffBitmask", 0);
				setDefault("spamFilter", spamFilter);
				setDefault("AutoLootOn", false);
				setDefault("AutoHealPercentage", 99);
				setDefault("AAOn", false);
				setDefault("AATargetLead", true);
				setDefault("AABoundingDist", 4);
				setDefault("aimMode", 2);
				setDefault("AutoAbilityOn", false);
				setDefault("AutoNexus", 25);
				setDefault("AutoHeal", 65);
				setDefault("autoHPPercent", 40);
				setDefault("TombCycleBoss", 3368);
				setDefault("XYZdistance", 1);
				setDefaultKey("XYZleftHotkey", KeyCodes.UNSET);
				setDefaultKey("XYZupHotkey", KeyCodes.UNSET);
				setDefaultKey("XYZdownHotkey", KeyCodes.UNSET);
				setDefaultKey("XYZrightHotkey", KeyCodes.UNSET);
				setDefaultKey("TombCycleKey", KeyCodes.UNSET);
				setDefaultKey("anchorTeleport", KeyCodes.UNSET);
				setDefaultKey("DrinkAllHotkey", KeyCodes.UNSET);
				setDefaultKey("SelfTPHotkey", KeyCodes.UNSET);
				setDefaultKey("syncLeadHotkey", KeyCodes.UNSET);
				setDefaultKey("syncFollowHotkey", KeyCodes.UNSET);
				setDefault("AutoResponder", false);
				setDefault("FocusFPS", false);
				setDefault("bgFPS", 10);
				setDefault("fgFPS", 60);
				setDefault("hideLockList", false);
				setDefault("hidePets", false);
				setDefault("hideOtherDamage", false);
				setDefault("mscale", 1);
				setDefault("stageScale", StageScaleMode.NO_SCALE);
				setDefault("uiscale", true);
				setDefault("offsetVoidBow", false);
				setDefault("offsetColossus", false);
				setDefault("coloOffset", 0.225);
				setDefault("ethDisable", false);
				setDefault("cultiststaffDisable", false);
				setDefault("alphaOnOthers", false);
				setDefault("alphaMan", 0.4);
				setDefault("lootPreview", true);
				setDefaultKey("tradeNearestPlayerKey", KeyCodes.UNSET);
				setDefaultKey("LowCPUModeHotKey", KeyCodes.UNSET);
				setDefaultKey("Cam45DegInc", KeyCodes.UNSET);
				setDefaultKey("Cam45DegDec", KeyCodes.UNSET);
				setDefaultKey("QuestTeleport", KeyCodes.UNSET);
				setDefaultKey("ReconRealm", KeyCodes.P);
				setDefaultKey("RandomRealm", KeyCodes.LEFTBRACKET);
				setDefaultKey("ReconVault", KeyCodes.RIGHTBRACKET);
				setDefaultKey("ReconDaily", KeyCodes.UNSET);
				setDefaultKey("PassesCoverHotkey", KeyCodes.UNSET);
				setDefaultKey("AAHotkey", KeyCodes.UNSET);
				setDefaultKey("AAModeHotkey", KeyCodes.UNSET);
				setDefaultKey("AutoAbilityHotkey", KeyCodes.UNSET);
				setDefaultKey("AutoLootHotkey", KeyCodes.UNSET);
				setDefault("requestHealPercent", 55);
				setDefault("damageIgnored", false);
				setDefault("AntiSpookiBoiDecoi", false);
				setDefault("ignoreIce", false);
				setDefaultKey("TextCem", KeyCodes.F1);
				setDefaultKey("TextPause", KeyCodes.F2);
				setDefaultKey("TextThessal", KeyCodes.F3);
				setDefaultKey("TextDraconis", KeyCodes.F4);
				setDefault("AAException", DefaultAAException);
				setDefault("AAIgnore", DefaultAAIgnore);
				setDefault("passThroughInvuln", false);
				setDefault("autoaimAtInvulnerable", false);
				setDefault("showDamageOnEnemy", false);
				setDefault("fameBlockTP", false);
				setDefault("fameBlockAbility", false);
				setDefault("fameBlockCubes", false);
				setDefault("fameBlockGodsOnly", false);
				setDefault("fameBlockThirsty", false);
				setDefault("spellbombHPThreshold", 3000);
				setDefault("skullHPThreshold", 800);
				setDefault("skullTargets", 5);
				setDefault("liteMonitor", false);
				setDefaultKey("TogglePlayerFollow", KeyCodes.F9);
				setDefaultKey("resetClientHP", KeyCodes.UNSET);
				setDefaultKey("famebotToggleHotkey", KeyCodes.UNSET);
				setDefault("addMoveRecPoint", false);
				setDefault("trainOffset", 500);
				setDefault("densityThreshold", 625);
				setDefault("teleDistance", 64);
				setDefault("WalkAroundRocks", false);
				setDefault("famebotContinue", 0);
				setDefault("fameTpCdTime", 5000);
				setDefault("famePointOffset", 1.5);
				setDefault("skipPopups", false);
				setDefault("autoClaimCalendar", true);
				setDefault("TradeDelay", true);
				setDefault("traceMessage", false);
				setDefault("showHPBarOnAlly", true);
				setDefault("showEXPFameOnAlly", true);
				setDefault("showClientStat", false);
				setDefault("liteParticle", false);
				setDefault("onlyAimAtExcepted", false);
				setDefault("ignoreStatusText", false);
				setDefault("ignoreQuiet", false);
				setDefault("ignoreWeak", false);
				setDefault("ignoreSlowed", false);
				setDefault("ignoreSick", false);
				setDefault("ignoreDazed", false);
				setDefault("ignoreStunned", false);
				setDefault("ignoreParalyzed", false);
				setDefault("ignoreBleeding", false);
				setDefault("ignoreArmorBroken", false);
				setDefault("ignorePetStasis", false);
				setDefault("ignorePetrified", false);
				setDefault("ignoreSilenced", false);
				setDefault("ignoreBlind", true);
				setDefault("ignoreHallucinating", true);
				setDefault("ignoreDrunk", true);
				setDefault("ignoreConfused", true);
				setDefault("ignoreUnstable", false);
				setDefault("ignoreDarkness", true);
				setDefault("autoDecrementHP", false);
				setDefault("bigLootBags", false);
				setDefault("AutoSyncClientHP", false);
				setDefault("extraPlayerMenu", true);
				setDefault("safeWalk", false);
				setDefault("evenLowerGraphics", false);
				setDefault("showCHbar", true);
				setDefault("rightClickOption", 0);
				setDefaultKey("sskey", KeyCodes.DELETE);
				setDefault("dynamicHPcolor", true);
				setDefault("uiTextSize", 15);
				setDefault("mobNotifier", true);
				setDefault("showMobInfo", false);
				setDefault("questHUD", true);
				setDefault("newHUD", false);
				setDefault("aaDistance", 1);
				setDefault("hideLowCPUModeChat", false);
				setDefault("fameOryx", false);
				setDefault("tiltCam", false);
				setDefault("showBG", true);
				setDefault("BossPriority", true);
				setDefault("offsetWeapon", false);
				setDefault("customMessage1", "We are impervious to non-mystic attacks!");
				setDefault("customMessage2", "Forget this... run for it!");
				setDefault("customMessage3", "Engaging Super-Mode!!!");
				setDefault("logins", ["Use Right-Click"]);
				setDefault("passwords", ["To add new accounts"]);
				setDefault("autoLootExcludes", Parameters.defaultExclusions);
				setDefault("autoLootIncludes", Parameters.defaultInclusions);
				setDefault("autoLootUpgrades", false);
				setDefault("autoLootWeaponTier", 11);
				setDefault("autoLootAbilityTier", 5);
				setDefault("autoLootArmorTier", 12);
				setDefault("autoLootRingTier", 5);
				setDefault("autoLootSkins", true);
				setDefault("autoLootPetSkins", true);
				setDefault("autoLootKeys", true);
				setDefault("autoLootHPPots", true);
				setDefault("autoLootMPPots", true);
				setDefault("autoLootHPPotsInv", true);
				setDefault("autoLootMPPotsInv", false);
				setDefault("autoLootLifeManaPots", true);
				setDefault("autoLootRainbowPots", true);
				setDefault("autoLootUTs", true);
				setDefault("autoLootFameBonus", 5);
				setDefault("autoLootFeedPower", -1);
				setDefault("autoLootMarks", false);
				setDefault("autoLootConsumables", false);
				setDefault("autoLootSoulbound", false);
				setDefault("autoLootEggs", 1);
				setDefault("showFameGoldRealms", false);
				setDefault("showEnemyCounter", true);
				setDefault("showTimers", true);
				setDefault("showAOGuildies", false);
				setDefault("autoDrinkFromBags", false);
				setDefault("cacheCharList", false);
				setDefault("PassesCover", false);
				setDefault("chatLength", 10);
				setDefault("autohpPotDelay", 400);
				setDefault("mapHack", false);
				setDefault("fixTabHotkeys", true);
				setDefault("noRotate", false);
				setDefault("customSounds", true);
				setDefault("customVolume", 1);
				setDefault("followIntoPortals", false);
				setDefault("spamPrism", false);
				setDefault("instaNexus", true);
				/*setDefaultControllerInput("ctrlEnterPortal", ControllerHandler.A_num_4);
				setDefaultControllerInput("ctrlTeleQuest", ControllerHandler.Y_num_7);
				setDefaultControllerInput("ctrlNexus", ControllerHandler.B_num_5);
				setDefaultControllerInput("ctrlAbility", ControllerHandler.X_num_6);
				setDefaultControllerInput("ctrlItemMenu", ControllerHandler.LSTICK_CLICK_num_14);*/
				setDefault("allowController", true);
				setDefault("useControllerNumber", 0);
				setDefault("selectedItemColor", 0);
				setDefault("cNameBypass", false);
				setDefault("eventNotifier", false);
				setDefault("eventNotifierVolume", 1);
				setDefault("notifySkull", true);
				setDefault("notifyCube", true);
				setDefault("notifyPentaract", true);
				setDefault("notifySphinx", true);
				setDefault("notifyHermit", true);
				setDefault("notifyLotLL", true);
				setDefault("notifyGhostShip", false);
				setDefault("notifyAvatar", false);
				setDefault("notifyStatues", false);
				setDefault("notifyRockDragon", false);
				setDefault("notifyNest", false);
				setDefault("notifyLostSentry", false);
				setDefault("notifyPumpkinShrine", false);
				setDefault("notifyZombieHorde", false);
				setDefault("notifyTurkeyGod", false);
				setDefault("notifyBeachBum", true);
			}


		}
	}//package com.company.assembleegameclient.parameters

