﻿//com.company.assembleegameclient.game.GameSprite

package com.company.assembleegameclient.game
{
	import com.company.assembleegameclient.game.events.MoneyChangedEvent;
	import com.company.assembleegameclient.map.Map;
	import com.company.assembleegameclient.objects.GameObject;
	import com.company.assembleegameclient.objects.IInteractiveObject;
	import com.company.assembleegameclient.objects.Pet;
	import com.company.assembleegameclient.objects.Player;
	import com.company.assembleegameclient.objects.Projectile;
	import com.company.assembleegameclient.parameters.Parameters;
	import com.company.assembleegameclient.tutorial.Tutorial;
	import com.company.assembleegameclient.ui.GuildText;
	import com.company.assembleegameclient.ui.RankText;
	import com.company.assembleegameclient.ui.menu.PlayerMenu;
	import com.company.assembleegameclient.util.AssetLoader;
	import com.company.assembleegameclient.util.RandomUtil;
	import com.company.assembleegameclient.util.TextureRedrawer;
	import com.company.util.CachingColorTransformer;
	import com.company.util.MoreColorUtil;
	import com.company.util.PointUtil;
	import com.greensock.plugins.DropShadowFilterPlugin;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import flash.system.System;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;

	import kabam.lib.loopedprocs.LoopedCallback;
	import kabam.lib.loopedprocs.LoopedProcess;
	import kabam.rotmg.arena.view.ArenaTimer;
	import kabam.rotmg.arena.view.ArenaWaveCounter;
	import kabam.rotmg.chat.view.Chat;
	import kabam.rotmg.constants.GeneralConstants;
	import kabam.rotmg.core.StaticInjectorContext;
	import kabam.rotmg.core.model.MapModel;
	import kabam.rotmg.core.model.PlayerModel;
	import kabam.rotmg.core.view.Layers;
	import kabam.rotmg.dailyLogin.signal.ShowDailyCalendarPopupSignal;
	import kabam.rotmg.dailyLogin.view.DailyLoginModal;
	import kabam.rotmg.dialogs.control.AddPopupToStartupQueueSignal;
	import kabam.rotmg.dialogs.control.FlushPopupStartupQueueSignal;
	import kabam.rotmg.dialogs.control.OpenDialogSignal;
	import kabam.rotmg.dialogs.model.DialogsModel;
	import kabam.rotmg.dialogs.model.PopupNamesConfig;
	import kabam.rotmg.game.model.QuestModel;
	import kabam.rotmg.game.view.CreditDisplay;
	import kabam.rotmg.game.view.GiftStatusDisplay;
	import kabam.rotmg.game.view.NewsModalButton;
	import kabam.rotmg.game.view.RealmQuestsDisplay;
	import kabam.rotmg.game.view.ShopDisplay;
	import kabam.rotmg.maploading.signals.HideMapLoadingSignal;
	import kabam.rotmg.maploading.signals.MapLoadedSignal;
	import kabam.rotmg.messaging.impl.GameServerConnectionConcrete;
	import kabam.rotmg.messaging.impl.incoming.MapInfo;
	import kabam.rotmg.news.model.NewsModel;
	import kabam.rotmg.news.view.NewsTicker;
	import kabam.rotmg.packages.services.PackageModel;
	import kabam.rotmg.promotions.model.BeginnersPackageModel;
	import kabam.rotmg.promotions.signals.ShowBeginnersPackageSignal;
	import kabam.rotmg.promotions.view.BeginnersPackageButton;
	import kabam.rotmg.promotions.view.SpecialOfferButton;
	import kabam.rotmg.protip.signals.ShowProTipSignal;
	import kabam.rotmg.servers.api.Server;
	import kabam.rotmg.stage3D.Renderer;
	import kabam.rotmg.text.view.TextFieldDisplayConcrete;
	import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
	import kabam.rotmg.ui.UIUtils;
	import kabam.rotmg.ui.signals.ShowHideKeyUISignal;
	import kabam.rotmg.ui.view.HUDView;
	import kabam.rotmg.ui.view.QuestHealthBar;

	import org.osflash.signals.Signal;

	import robotlegs.bender.framework.api.ILogger;

	import zfn.Hit;

	public class GameSprite extends AGameSprite
	{

		public static const NON_COMBAT_MAPS:Vector.<String> = new <String>[Map.NEXUS, Map.VAULT, Map.GUILD_HALL, Map.CLOTH_BAZAAR, Map.NEXUS_EXPLANATION, Map.DAILY_QUEST_ROOM];
		public static const DISPLAY_AREA_Y_SPACE:int = 32;
		protected static const PAUSED_FILTER:ColorMatrixFilter = new ColorMatrixFilter(MoreColorUtil.greyscaleFilterMatrix);

		public const monitor:Signal = new Signal(String, int);
		public const modelInitialized:Signal = new Signal();
		public const drawCharacterWindow:Signal = new Signal(Player);

		public var chatBox_:Chat;
		public var isNexus_:Boolean = false;
		public var idleWatcher_:IdleWatcher;
		public var rankText_:RankText;
		public var guildText_:GuildText;
		public var shopDisplay:ShopDisplay;
		public var creditDisplay_:CreditDisplay;
		public var realmQuestsDisplay:RealmQuestsDisplay;
		public var giftStatusDisplay:GiftStatusDisplay;
		public var newsModalButton:NewsModalButton;
		public var newsTicker:NewsTicker;
		public var arenaTimer:ArenaTimer;
		public var arenaWaveCounter:ArenaWaveCounter;
		public var mapModel:MapModel;
		public var beginnersPackageModel:BeginnersPackageModel;
		public var dialogsModel:DialogsModel;
		public var showBeginnersPackage:ShowBeginnersPackageSignal;
		public var openDailyCalendarPopupSignal:ShowDailyCalendarPopupSignal;
		public var openDialog:OpenDialogSignal;
		public var showPackage:Signal = new Signal();
		public var packageModel:PackageModel;
		public var addToQueueSignal:AddPopupToStartupQueueSignal;
		public var flushQueueSignal:FlushPopupStartupQueueSignal;
		public var showHideKeyUISignal:ShowHideKeyUISignal;
		private var focus:GameObject;
		private var frameTimeSum_:int = 0;
		private var frameTimeCount_:int = 0;
		private var isGameStarted:Boolean;
		private var displaysPosY:uint = 4;
		private var currentPackage:DisplayObject = new Sprite();
		private var packageY:Number;
		public var chatPlayerMenu:PlayerMenu;
		private var specialOfferButton:SpecialOfferButton;
		private var questModel:QuestModel;
		private var mapName:String;

		private var timerCounter:TextFieldDisplayConcrete;
		private var timerCounterStringBuilder:StaticStringBuilder;
		private var vialList:TextFieldDisplayConcrete;
		private var vialListStringBuilder:StaticStringBuilder;
		public var stats:TextFieldDisplayConcrete;
		public var statsStringBuilder:StaticStringBuilder;
		public var packageOffer:BeginnersPackageButton;
		private var lastUpdateInteractiveTime:int = 0;
		private var lastCalcTime:int = int.MIN_VALUE;
		public var questBar:QuestHealthBar;
		public const nexusFountains:Point = new Point(129.5, 116.5);
		public const nexusRealms:Point = new Point(nexusFountains.x, (nexusFountains.y - 18));
		public const nexusHallway:Point = new Point(nexusFountains.x, (nexusFountains.y - 10));
		public const vaultFountain:Point = new Point(56, 67.1);

		public function GameSprite(_arg_1:Server, _arg_2:int, _arg_3:Boolean, _arg_4:int, _arg_5:int, _arg_6:ByteArray, _arg_7:PlayerModel, _arg_8:String, _arg_9:Boolean)
		{
			this.model = _arg_7;
			map = new Map(this);
			addChild(map);
			gsc_ = new GameServerConnectionConcrete(this, _arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_8, _arg_9);
			mui_ = new MapUserInput(this);
			this.chatBox_ = new Chat();
			this.chatBox_.list.addEventListener(MouseEvent.MOUSE_DOWN, this.onChatDown);
			this.chatBox_.list.addEventListener(MouseEvent.MOUSE_UP, this.onChatUp);
			addChild(this.chatBox_);
			this.hitQueue.length = 0;
			this.idleWatcher_ = new IdleWatcher();
		}

		public static function dispatchMapLoaded(_arg_1:MapInfo):void
		{
			var _local_2:MapLoadedSignal = StaticInjectorContext.getInjector().getInstance(MapLoadedSignal);
			((_local_2) && (_local_2.dispatch(_arg_1)));
		}

		private static function hidePreloader():void
		{
			var _local_1:HideMapLoadingSignal = StaticInjectorContext.getInjector().getInstance(HideMapLoadingSignal);
			((_local_1) && (_local_1.dispatch()));
		}

		public static function toTimeCode(_arg_1:Number):String
		{
			var _local_2:int = Math.floor(((_arg_1 * 0.001) % 60));
			var _local_3:String = ((_local_2 < 10) ? ("0" + _local_2) : String(_local_2));
			var _local_4:int = Math.round(Math.floor(((_arg_1 * 0.001) * 0.0166666666666667)));
			var _local_5:String = String(_local_4);
			var _local_6:String = ((_local_5 + ":") + _local_3);
			return (_local_6);
		}

		public function onChatDown(_arg_1:MouseEvent):void
		{
			if (this.chatPlayerMenu != null)
			{
				this.removeChatPlayerMenu();
			}
			mui_.onMouseDown(_arg_1);
		}

		public function onChatUp(_arg_1:MouseEvent):void
		{
			mui_.onMouseUp(_arg_1);
		}

		override public function setFocus(_arg_1:GameObject):void
		{
			_arg_1 = ((_arg_1) || (map.player_));
			this.focus = _arg_1;
		}

		public function addChatPlayerMenu(_arg_1:Player, _arg_2:Number, _arg_3:Number, _arg_4:String = null, _arg_5:Boolean = false, _arg_6:Boolean = false):void
		{
			this.removeChatPlayerMenu();
			this.chatPlayerMenu = new PlayerMenu();
			if (_arg_4 == null)
			{
				this.chatPlayerMenu.init(this, _arg_1);
			} else
			{
				if (_arg_6)
				{
					this.chatPlayerMenu.initDifferentServer(this, _arg_4, _arg_5, _arg_6);
				} else
				{
					if (((_arg_4.length > 0) && (((_arg_4.charAt(0) == "#") || (_arg_4.charAt(0) == "*")) || (_arg_4.charAt(0) == "@"))))
					{
						return;
					}
					this.chatPlayerMenu.initDifferentServer(this, _arg_4, _arg_5);
				}
			}
			addChild(this.chatPlayerMenu);
			chatMenuPositionFixed();
		}

		public function removeChatPlayerMenu():void
		{
			if (this.chatPlayerMenu != null && this.chatPlayerMenu.parent != null)
			{
				removeChild(this.chatPlayerMenu);
				this.chatPlayerMenu = null;
			}
		}

		override public function applyMapInfo(_arg_1:MapInfo):void
		{
			map.setProps(_arg_1.width_, _arg_1.height_, _arg_1.name_, _arg_1.background_, _arg_1.allowPlayerTeleport_, _arg_1.showDisplays_);
			dispatchMapLoaded(_arg_1);
		}

		public function hudModelInitialized():void
		{
			if (hudView != null)
			{
				hudView.dispose();
			}
			hudView = new HUDView();
			hudView.x = 600;
			addChild(hudView);
			if (!Parameters.data_.mapHack)
			{
				return;
			}
			if (Parameters.needsMapCheck == 2)
			{
				this.hudView.miniMap.setFullMap(this.map.name_);
			}
			switch (map.name_)
			{
				case "Nexus":
					hudView.miniMap.hackmapData = AssetLoader.nexusMap;
					return;
				case "Vault":
					hudView.miniMap.hackmapData = AssetLoader.vaultMap;
					return;
				case "Oryx's Castle":
					hudView.miniMap.hackmapData = AssetLoader.castleMap;
					return;
				case "Oryx's Chamber":
					hudView.miniMap.hackmapData = AssetLoader.chamberMap;
					return;
				case "Wine Cellar":
					hudView.miniMap.hackmapData = AssetLoader.wcMap;
					return;
			}
		}

		private function addTimer():void
		{
			if (this.timerCounter == null)
			{
				this.timerCounter = new TextFieldDisplayConcrete().setSize(15).setColor(0xFFFFFF);
				this.timerCounter.mouseChildren = false;
				this.timerCounter.mouseEnabled = false;
				this.timerCounter.setBold(true);
				this.timerCounterStringBuilder = new StaticStringBuilder("0:00");
				this.timerCounter.setStringBuilder(this.timerCounterStringBuilder);
				this.timerCounter.filters = [DropShadowFilterPlugin.DEFAULT_FILTER];
				this.timerCounter.x = 3;
				this.timerCounter.y = 180;
				addChild(this.timerCounter);
			}
		}

		private function addVialList():void
		{
			if (this.vialList == null)
			{
				this.vialList = new TextFieldDisplayConcrete().setSize(15).setColor(0xFFFFFF);
				this.vialList.mouseChildren = false;
				this.vialList.mouseEnabled = false;
				this.vialList.setBold(true);
				this.vialListStringBuilder = new StaticStringBuilder();
				this.vialList.setStringBuilder(this.vialListStringBuilder);
				this.vialList.filters = [DropShadowFilterPlugin.DEFAULT_FILTER];
				this.vialList.x = 3;
				this.vialList.y = 240;
				this.vialList.visible = false;
				addChild(this.vialList);
			}
		}

		public function addStats():void
		{
			if (this.stats == null)
			{
				this.stats = new TextFieldDisplayConcrete().setSize(14).setColor(0xFFFFFF);
				this.stats.mouseChildren = false;
				this.stats.mouseEnabled = false;
				this.statsStringBuilder = new StaticStringBuilder("FPS -1\nLAT -1\nMEM -1");
				this.stats.setStringBuilder(this.statsStringBuilder);
				this.stats.filters = [DropShadowFilterPlugin.DEFAULT_FILTER];
				this.stats.setBold(true);
				this.stats.x = 5;
				this.stats.y = 5;
				addChild(this.stats);
				if (this.map.player_ != null)
				{
					this.gsc_.playerText(Parameters.statsChar);
					this.gsc_.pingSentAt = this.lastUpdate_;
				}
			}
		}

		public function updateStats(_arg_1:int):void
		{
			statsFrameNumber++;
			var _local_2:int = (_arg_1 - statsStart);
			if (_local_2 >= 1000)
			{
				statsFPS = (Math.floor(((statsFrameNumber / (0.001 * _local_2)) * 10)) * 0.1);
				statsStart = _arg_1;
				statsFrameNumber = 0;
				if (this.gsc_.pingSentAt == -1)
				{
					this.gsc_.playerText(Parameters.statsChar);
					this.gsc_.pingSentAt = _arg_1;
				}
				this.stats.visible = true;
				this.stats.setText(((((("FPS " + statsFPS) + "\nLAT ") + this.gsc_.pingReceivedAt) + "\nMEM ") + (1E-6 * System.totalMemoryNumber)));
			}
		}

		private function updateTimer(_arg_1:int):void
		{
			if (_arg_1 < 3000)
			{
				this.timerCounter.setColor(this.fadeRed((Parameters.phaseChangeAt - _arg_1) / 3000));
			}
			this.timerCounter.visible = true;
			this.timerCounter.setText(((Parameters.phaseName + "\n") + toTimeCode((Parameters.phaseChangeAt - _arg_1))));
		}

		public function vialFind():void
		{
			var _local_5:int;
			var _local_7:int;
			var name:String;
			for each (var _local_1:GameObject in this.map.goDict_)
			{
				if (_local_1 is Player)
				{
					if (Parameters.vialHolders.indexOf(_local_1.name_) != -1)
					{
						break;
					}
					_local_5 = 0;
					while (_local_5 < ((_local_1 as Player).hasBackpack_ ? 20 : 12))
					{
						_local_7 = _local_1.equipment_[_local_5];
						if (_local_7 == 0x0247)
						{
							Parameters.vialHolders.push(_local_1.name_);
							break;
						}
						_local_5++;
					}

				}
			}
			var output:String = "";
			for each (name in Parameters.vialHolders)
			{
				output += name + "\n"
			}
			this.vialList.visible = (Parameters.vialHolders.length > 0);
			this.vialList.setText("Vial Holders:\n" + output);
		}

		private function fadeRed(_arg_1:Number):uint
		{
			if (_arg_1 > 100)
			{
				_arg_1 = 100;
			}
			var _local_5:uint = (0xFF * _arg_1);
			var _local_4:uint = (_local_5 << 8);
			return (0xFF0000 | _local_4 | _local_5);
		}

		override public function initialize():void
		{
			var _local_4:ShowProTipSignal;

			this.questModel = StaticInjectorContext.getInjector().getInstance(QuestModel);
			map.initialize();
			this.modelInitialized.dispatch();
			this.mapName = this.map.name_;
			this.showHideKeyUISignal.dispatch((mapName == "Davy Jones' Locker"));
			this.isNexus_ = (mapName == Map.NEXUS);
			this.map.isTrench = (mapName == "Ocean Trench");
			this.map.isRealm = (mapName == "Realm of the Mad God");
			this.map.isVault = (mapName == "Vault");
			if (this.evalIsNotInCombatMapArea())
			{
				this.showSafeAreaDisplays();
				if (Parameters.dailyCalendar1RunOnce)
				{
					this.gsc_.gotoQuestRoom();
					Parameters.dailyCalendar1RunOnce = false;
				}
			}
			if (mapName == "Arena")
			{
				this.showTimer();
				this.showWaveCounter();
			}
			this.questBar = new QuestHealthBar();
			this.questBar.x = 4;
			this.questBar.y = 16;
			addChild(this.questBar);
			if (isNexus_)
			{
				this.addToQueueSignal.dispatch(PopupNamesConfig.DAILY_LOGIN_POPUP, this.openDailyCalendarPopupSignal, -1, null);
				if (this.beginnersPackageModel.status == BeginnersPackageModel.STATUS_CAN_BUY_SHOW_POP_UP)
				{
					this.addToQueueSignal.dispatch(PopupNamesConfig.BEGINNERS_OFFER_POPUP, this.showBeginnersPackage, 1, null);
				} else
				{
					this.addToQueueSignal.dispatch(PopupNamesConfig.PACKAGES_OFFER_POPUP, this.showPackage, 1, null);
				}
				this.flushQueueSignal.dispatch();
			}
			if (this.isNexus_ || mapName == Map.DAILY_QUEST_ROOM)
			{
				this.creditDisplay_ = new CreditDisplay(this, true, true);
			} else
			{
				this.creditDisplay_ = new CreditDisplay(this);
			}
			this.creditDisplay_.x = 594;
			addChild(this.creditDisplay_);
			if (!this.evalIsNotInCombatMapArea() && this.canShowRealmQuestDisplay(this.mapName))
			{
				this.realmQuestsDisplay = new RealmQuestsDisplay(map);

				this.realmQuestsDisplay.x = 10;
				this.realmQuestsDisplay.y = (Parameters.ssmode ? 10 : 40);
				addChild(this.realmQuestsDisplay);
				gsc_.playerText("/server");
			} else
			{
				this.questModel.previousRealm = "";
			}
			if (mapName == Map.DAILY_QUEST_ROOM)
			{
				gsc_.questFetch();
			} else
			{
				if (mapName == Map.CLOTH_BAZAAR)
				{
					Parameters.timerActive = true;
					Parameters.phaseName = "Portal Entry";
					Parameters.phaseChangeAt = (getTimer() + 30000);
				}
			}
			map.setHitAreaProps(map.width, map.height);
			Parameters.save();
			hidePreloader();
			this.parent.parent.setChildIndex((this.parent.parent as Layers).top, 2);
			stage.dispatchEvent(new Event(Event.RESIZE));
		}

		private function canShowRealmQuestDisplay(_arg_1:String):Boolean
		{
			var _local_2:Boolean;
			if (_arg_1 == Map.REALM)
			{
				this.questModel.previousRealm = _arg_1;
				this.questModel.requirementsStates[QuestModel.REMAINING_HEROES_REQUIREMENT] = false;
				this.questModel.remainingHeroes = -1;
				if (this.questModel.hasOryxBeenKilled)
				{
					this.questModel.hasOryxBeenKilled = false;
					this.questModel.resetRequirementsStates();
				}
				_local_2 = true;
			} else
			{
				if (this.questModel.previousRealm == Map.REALM && _arg_1.indexOf("Oryx") != -1)
				{
					this.questModel.requirementsStates[QuestModel.REMAINING_HEROES_REQUIREMENT] = true;
					this.questModel.remainingHeroes = 0;
					_local_2 = true;
				}
			}
			return (_local_2);
		}

		public function chatMenuPositionFixed():void
		{
			var _local_1:Number = ((((stage.mouseX + (stage.stageWidth >> 1)) - 400) / stage.stageWidth) * 800);
			var _local_2:Number = ((((stage.mouseY + (stage.stageHeight >> 1)) - 300) / stage.stageHeight) * 600);
			this.chatPlayerMenu.x = _local_1;
			this.chatPlayerMenu.y = (_local_2 - this.chatPlayerMenu.height);
		}

		public function onScreenResize(_arg_1:Event):void
		{
			var _local_5:Number;
			var _local_2:Boolean = (!Parameters.ssmode && Parameters.data_.uiscale);
			var _local_3:Number = (800 / stage.stageWidth);
			var _local_6:Number = (600 / stage.stageHeight);
			var _local_7:Number = (_local_3 / _local_6);
			if (this.map)
			{
				_local_5 = ((stage.scaleMode != StageScaleMode.EXACT_FIT) ? Parameters.data_.mscale : 1);
				this.map.scaleX = (_local_3 * _local_5);
				this.map.scaleY = (_local_6 * _local_5);
			}
			if (this.timerCounter != null)
			{
				if (_local_2)
				{
					this.timerCounter.scaleX = _local_7;
					this.timerCounter.scaleY = 1;
					this.timerCounter.y = 180;
				} else
				{
					this.timerCounter.scaleX = _local_3;
					this.timerCounter.scaleY = _local_6;
				}
			}
			if (this.questBar != null)
			{
				if (_local_2)
				{
					this.questBar.scaleX = _local_7;
					this.questBar.scaleY = 1;
				} else
				{
					this.questBar.scaleX = _local_3;
					this.questBar.scaleY = _local_6;
				}
			}
			if (this.stats != null)
			{
				if (_local_2)
				{
					this.stats.scaleX = _local_7;
					this.stats.scaleY = 1;
					this.stats.y = 5;
				} else
				{
					this.stats.scaleX = _local_3;
					this.stats.scaleY = _local_6;
				}
				this.stats.x = (5 * this.stats.scaleX);
				this.stats.y = (5 * this.stats.scaleY);
			}
			if (this.hudView != null)
			{
				if (_local_2)
				{
					this.hudView.scaleX = _local_7;
					this.hudView.scaleY = 1;
					this.hudView.y = 0;
				} else
				{
					this.hudView.scaleX = _local_3;
					this.hudView.scaleY = _local_6;
					this.hudView.y = (300 * (1 - _local_6));
				}
				this.hudView.x = (800 - (200 * this.hudView.scaleX));
				if (this.creditDisplay_ != null)
				{
					this.creditDisplay_.x = (this.hudView.x - (6 * this.creditDisplay_.scaleX));
				}
			}
			if (this.chatBox_ != null)
			{
				if (_local_2)
				{
					this.chatBox_.scaleX = _local_7;
					this.chatBox_.scaleY = 1;
				} else
				{
					this.chatBox_.scaleX = _local_3;
					this.chatBox_.scaleY = _local_6;
				}
				this.chatBox_.y = (300 + (300 * (1 - this.chatBox_.scaleY)));
			}
			if (this.rankText_ != null)
			{
				if (_local_2)
				{
					this.rankText_.scaleX = _local_7;
					this.rankText_.scaleY = 1;
				} else
				{
					this.rankText_.scaleX = _local_3;
					this.rankText_.scaleY = _local_6;
				}
				this.rankText_.x = (8 * this.rankText_.scaleX);
				this.rankText_.y = (2 * this.rankText_.scaleY);
			}
			if (this.guildText_ != null)
			{
				if (_local_2)
				{
					this.guildText_.scaleX = _local_7;
					this.guildText_.scaleY = 1;
				} else
				{
					this.guildText_.scaleX = _local_3;
					this.guildText_.scaleY = _local_6;
				}
				this.guildText_.x = (64 * this.guildText_.scaleX);
				this.guildText_.y = (2 * this.guildText_.scaleY);
			}
			if (this.realmQuestsDisplay != null)
			{
				if (_local_2)
				{
					this.realmQuestsDisplay.scaleX = _local_7;
					this.realmQuestsDisplay.scaleY = 1;
				} else
				{
					this.realmQuestsDisplay.scaleX = _local_3;
					this.realmQuestsDisplay.scaleY = _local_6;
				}
			}
			if (this.creditDisplay_ != null)
			{
				if (_local_2)
				{
					this.creditDisplay_.scaleX = _local_7;
					this.creditDisplay_.scaleY = 1;
				} else
				{
					this.creditDisplay_.scaleX = _local_3;
					this.creditDisplay_.scaleY = _local_6;
				}
			}
			if (this.shopDisplay != null)
			{
				if (_local_2)
				{
					this.shopDisplay.scaleX = _local_7;
					this.shopDisplay.scaleY = 1;
				} else
				{
					this.shopDisplay.scaleX = _local_3;
					this.shopDisplay.scaleY = _local_6;
				}
				this.shopDisplay.x = (6 * this.shopDisplay.scaleX);
				this.shopDisplay.y = (34 * this.shopDisplay.scaleY);
			}
			if (this.packageOffer != null)
			{
				if (_local_2)
				{
					this.packageOffer.scaleX = _local_7;
					this.packageOffer.scaleY = 1;
				} else
				{
					this.packageOffer.scaleX = _local_3;
					this.packageOffer.scaleY = _local_6;
				}
				this.packageOffer.x = (6 * this.packageOffer.scaleX);
				this.packageOffer.y = (31 * this.packageOffer.scaleY);
			}
			if (this.giftStatusDisplay != null)
			{
				if (_local_2)
				{
					this.giftStatusDisplay.scaleX = _local_7;
					this.giftStatusDisplay.scaleY = 1;
				} else
				{
					this.giftStatusDisplay.scaleX = _local_3;
					this.giftStatusDisplay.scaleY = _local_6;
				}
				this.giftStatusDisplay.x = (6 * this.giftStatusDisplay.scaleX);
				this.giftStatusDisplay.y = (66 * this.giftStatusDisplay.scaleY);
			}
			var _local_4:int = 98;
			if (this.newsModalButton != null)
			{
				if (_local_2)
				{
					this.newsModalButton.scaleX = _local_7;
					this.newsModalButton.scaleY = 1;
				} else
				{
					this.newsModalButton.scaleX = _local_3;
					this.newsModalButton.scaleY = _local_6;
				}
				this.newsModalButton.x = (6 * this.newsModalButton.scaleX);
				this.newsModalButton.y = (_local_4 * this.newsModalButton.scaleY);
				_local_4 = 130;
			}
			if (this.specialOfferButton != null)
			{
				if (_local_2)
				{
					this.specialOfferButton.scaleX = _local_7;
					this.specialOfferButton.scaleY = 1;
				} else
				{
					this.specialOfferButton.scaleX = _local_3;
					this.specialOfferButton.scaleY = _local_6;
				}
				this.specialOfferButton.x = (6 * this.specialOfferButton.scaleX);
				this.specialOfferButton.y = (_local_4 * this.specialOfferButton.scaleY);
			}
			if (map)
			{
				map.resetOverlays();
			}
		}

		private function showSafeAreaDisplays():void
		{
			this.showRankText();
			this.showGuildText();
			this.showShopDisplay();
			this.setYAndPositionPackage();
			this.showGiftStatusDisplay();
			this.showNewsUpdate();
			this.showNewsTicker();
		}

		private function setDisplayPosY(_arg_1:Number):void
		{
			var _local_2:Number = (UIUtils.NOTIFICATION_SPACE * _arg_1);
			if (_arg_1 != 0)
			{
				this.displaysPosY = (4 + _local_2);
			} else
			{
				this.displaysPosY = 2;
			}
		}

		public function positionDynamicDisplays():void
		{
			var _local_1:NewsModel = StaticInjectorContext.getInjector().getInstance(NewsModel);
			var _local_2:int = 66;
			if (this.giftStatusDisplay && this.giftStatusDisplay.isOpen)
			{
				this.giftStatusDisplay.y = _local_2;
				_local_2 = (_local_2 + DISPLAY_AREA_Y_SPACE);
			}
			if (this.newsModalButton && (NewsModalButton.showsHasUpdate || _local_1.hasValidModalNews()))
			{
				this.newsModalButton.y = _local_2;
				_local_2 = (_local_2 + DISPLAY_AREA_Y_SPACE);
			}
			if (this.newsTicker && this.newsTicker.visible)
			{
				this.newsTicker.y = _local_2;
				_local_2 = (_local_2 + DISPLAY_AREA_Y_SPACE);
			}
			if (this.specialOfferButton && this.specialOfferButton.isSpecialOfferAvailable)
			{
				this.specialOfferButton.y = _local_2;
			}
			this.onScreenResize(null);
		}

		private function showTimer():void
		{
			this.arenaTimer = new ArenaTimer();
			this.arenaTimer.y = 5;
			addChild(this.arenaTimer);
		}

		private function showWaveCounter():void
		{
			this.arenaWaveCounter = new ArenaWaveCounter();
			this.arenaWaveCounter.y = 5;
			this.arenaWaveCounter.x = 5;
			addChild(this.arenaWaveCounter);
		}

		private function showNewsTicker():void
		{
			this.newsTicker = new NewsTicker();
			this.newsTicker.x = (300 - (this.newsTicker.width / 2));
			addChild(this.newsTicker);
			this.positionDynamicDisplays();
		}

		private function showGiftStatusDisplay():void
		{
			this.giftStatusDisplay = new GiftStatusDisplay();
			this.giftStatusDisplay.x = 6;
			addChild(this.giftStatusDisplay);
			this.positionDynamicDisplays();
		}

		private function showShopDisplay():void
		{
			this.shopDisplay = new ShopDisplay((map.name_ == Map.NEXUS));
			this.shopDisplay.x = 6;
			this.shopDisplay.y = 34;
			addChild(this.shopDisplay);
		}

		private function showNewsUpdate(_arg_1:Boolean = true):void
		{
			var _local_4:NewsModalButton;
			var _local_2:ILogger = StaticInjectorContext.getInjector().getInstance(ILogger);
			var _local_3:NewsModel = StaticInjectorContext.getInjector().getInstance(NewsModel);
			_local_2.debug("NEWS UPDATE -- making button");
			if (_local_3.hasValidModalNews())
			{
				_local_2.debug("NEWS UPDATE -- making button - ok");
				_local_4 = new NewsModalButton();
				if (this.newsModalButton != null)
				{
					removeChild(this.newsModalButton);
				}
				_local_4.x = 6;
				this.newsModalButton = _local_4;
				addChild(this.newsModalButton);
				stage.dispatchEvent(new Event(Event.RESIZE));
			}
		}

		public function refreshNewsUpdateButton():void
		{
			var _local_1:ILogger = StaticInjectorContext.getInjector().getInstance(ILogger);
			_local_1.debug("NEWS UPDATE -- refreshing button, update noticed");
			this.showNewsUpdate(false);
		}

		private function setYAndPositionPackage():void
		{
			this.packageY = (this.displaysPosY + 2);
			this.displaysPosY = (this.displaysPosY + UIUtils.NOTIFICATION_SPACE);
			this.positionPackage();
		}

		public function showSpecialOfferIfSafe():void
		{
			if (this.evalIsNotInCombatMapArea())
			{
				this.specialOfferButton = new SpecialOfferButton();
				this.specialOfferButton.x = 6;
				addChild(this.specialOfferButton);
				this.positionDynamicDisplays();
			}
		}

		public function showPackageButtonIfSafe():void
		{
			if (this.evalIsNotInCombatMapArea())
			{
			}
		}

		private function addAndPositionPackage(_arg_1:DisplayObject):void
		{
			this.currentPackage = _arg_1;
			addChild(this.currentPackage);
			this.positionPackage();
		}

		private function positionPackage():void
		{
			this.currentPackage.x = 80;
			this.setDisplayPosY(1);
			this.currentPackage.y = this.displaysPosY;
		}

		private function showGuildText():void
		{
			this.guildText_ = new GuildText("", -1);
			this.guildText_.x = 64;
			this.setDisplayPosY(0);
			this.guildText_.y = this.displaysPosY;
			addChild(this.guildText_);
		}

		private function showRankText():void
		{
			this.rankText_ = new RankText(-1, true, false);
			this.rankText_.x = 8;
			this.setDisplayPosY(0);
			addChild(this.rankText_);
		}

		private function startTutorial():void
		{
			tutorial_ = new Tutorial(this);
			addChild(tutorial_);
		}

		private function updateNearestInteractive():void
		{
			var _local_4:Number;
			var _local_7:GameObject;
			var _local_8:IInteractiveObject;
			if (!map || !map.player_)
			{
				return;
			}
			var _local_1:Player = map.player_;
			var _local_2:Number = GeneralConstants.MAXIMUM_INTERACTION_DISTANCE;
			var _local_3:IInteractiveObject;
			var _local_5:Number = _local_1.x_;
			var _local_6:Number = _local_1.y_;
			for each (_local_7 in map.goDict_)
			{
				_local_8 = (_local_7 as IInteractiveObject);
				if (_local_8 && (!(_local_8 is Pet) || this.map.isPetYard))
				{
					if (((Math.abs((_local_5 - _local_7.x_)) < GeneralConstants.MAXIMUM_INTERACTION_DISTANCE) || (Math.abs((_local_6 - _local_7.y_)) < GeneralConstants.MAXIMUM_INTERACTION_DISTANCE)))
					{
						_local_4 = PointUtil.distanceXY(_local_7.x_, _local_7.y_, _local_5, _local_6);
						if (((_local_4 < GeneralConstants.MAXIMUM_INTERACTION_DISTANCE) && (_local_4 < _local_2)))
						{
							_local_2 = _local_4;
							_local_3 = _local_8;
						}
					}
				}
			}
			this.mapModel.currentInteractiveTarget = _local_3;
			if (_local_8 == null)
			{
				this.mapModel.currentInteractiveTargetObjectId = -1;
			} else
			{
				this.mapModel.currentInteractiveTargetObjectId = _local_7.objectId_;
			}
		}

		private function isPetMap():Boolean
		{
			return (true);
		}

		public function connect():void
		{
			if (!this.isGameStarted)
			{
				this.isGameStarted = true;
				Renderer.inGame = true;
				this.newsModalButton = null;
				gsc_.connect();
				this.idleWatcher_.start(this);
				lastUpdate_ = getTimer();
				statsStart = -1;
				statsFrameNumber = -1;
				stage.addEventListener(MoneyChangedEvent.MONEY_CHANGED, this.onMoneyChanged);
				stage.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
				LoopedProcess.addProcess(new LoopedCallback(100, this.updateNearestInteractive));
				stage.addEventListener(Event.ACTIVATE, this.onFocusIn);
				stage.addEventListener(Event.DEACTIVATE, this.onFocusOut);
				this.parent.parent.setChildIndex((this.parent.parent as Layers).top, 0);
				stage.scaleMode = Parameters.data_ == null ? StageScaleMode.NO_SCALE : Parameters.data_.stageScale;
				stage.addEventListener(Event.RESIZE, this.onScreenResize);
				stage.dispatchEvent(new Event(Event.RESIZE));
			}
		}

		public function disconnect():void
		{
			if (this.isGameStarted)
			{
				this.isGameStarted = false;
				Renderer.inGame = false;
				this.idleWatcher_.stop();
				stage.removeEventListener(MoneyChangedEvent.MONEY_CHANGED, this.onMoneyChanged);
				stage.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
				stage.removeEventListener(Event.ACTIVATE, this.onFocusIn);
				stage.removeEventListener(Event.DEACTIVATE, this.onFocusOut);
				stage.removeEventListener(Event.RESIZE, this.onScreenResize);
				LoopedProcess.destroyAll();
				((contains(map)) && (removeChild(map)));
				if (hudView != null)
				{
					hudView.dispose();
					questBar.dispose();
				}
				if (player_ != null)
				{
					player_.questMob = null;
					player_.questMob1 = null;
					player_.questMob2 = null;
					player_.questMob3 = null;
				}
				map.dispose();
				CachingColorTransformer.clear();
				TextureRedrawer.clearCache();
				Projectile.dispose();
				this.newsModalButton = null;
				if (this.timerCounter != null && Parameters.phaseName != "Realm Closed" && Parameters.phaseName != "Oryx Shake")
				{
					Parameters.timerActive = false;
					this.timerCounter.visible = false;
					this.timerCounter = null;
				}
				Parameters.followPlayer = null;
				gsc_.disconnect();
				System.pauseForGCIfCollectionImminent(0);
				System.pauseForGCIfCollectionImminent(0);
			}
		}

		private function onFocusOut(_arg_1:Event):void
		{
			if (Parameters.data_.FocusFPS)
			{
				stage.frameRate = Parameters.data_.bgFPS;
			}
		}

		private function onFocusIn(_arg_1:Event):void
		{
			if (Parameters.data_.FocusFPS)
			{
				stage.frameRate = Parameters.data_.fgFPS;
			}
		}

		private function onMoneyChanged(_arg_1:Event):void
		{
			gsc_.checkCredits();
		}

		override public function evalIsNotInCombatMapArea():Boolean
		{
			return (!(NON_COMBAT_MAPS.indexOf(map.name_) == -1));
		}

		private function onEnterFrame(_arg_1:Event):void
		{
			var _local_5:int;
			var _local_6:int;
			var _local_3:Number;
			var _local_7:int = getTimer();
			var _local_2:int = (_local_7 - lastUpdate_);
			if (mui_.held)
			{
				_local_5 = (ROTMG.STAGE.mouseX - mui_.heldX);
				Parameters.data_.cameraAngle = (mui_.heldAngle + (_local_5 * (Math.PI / 180)));
				if (!Parameters.ssmode && Parameters.data_.tiltCam)
				{
					_local_6 = (ROTMG.STAGE.mouseY - mui_.heldY);
					mui_.heldY = ROTMG.STAGE.mouseY;
					this.camera_.nonPPMatrix_.appendRotation(_local_6, Vector3D.X_AXIS, null);
				}
			}
			if ((_local_7 - this.lastUpdateInteractiveTime) > 100)
			{
				this.lastUpdateInteractiveTime = _local_7;
				this.updateNearestInteractive();
			}
			this.map.update(_local_7, _local_2);
			for each (var _local_4:Hit in this.hitQueue)
			{
				this.gsc_.playerHit(_local_4.bulletId, _local_4.objectId);
			}
			this.hitQueue.length = 0;
			this.camera_.update(_local_2);
			if (Parameters.timerActive && !Parameters.ssmode)
			{
				if (this.timerCounter == null)
				{
					this.addTimer();
				}
				if (_local_7 >= Parameters.phaseChangeAt)
				{
					Parameters.phaseChangeAt = int.MAX_VALUE;
					Parameters.timerActive = false;
					this.timerCounter.visible = false;
				} else
				{
					updateTimer(_local_7);
				}
			} else
			{
				if (this.timerCounter != null)
				{
					this.timerCounter.visible = false;
				}
			}
			if (Parameters.data_.liteMonitor && !Parameters.ssmode)
			{
				if (this.stats != null)
				{
					this.updateStats(_local_7);
				}
			} else
			{
				if (this.stats != null)
				{
					this.stats.visible = false;
				}
			}
			if (Parameters.data_.vialChecker && !Parameters.ssmode)
			{
				if (this.vialList == null)
				{
					this.addVialList();
				}
				if (this.vialList != null)
				{
					this.vialFind();
				}
			} else
			{
				if (this.vialList != null)
				{
					this.vialList.visible = false;
				}
			}
			var _local_8:Player = map.player_;
			if (this.focus)
			{
				camera_.configureCamera(this.focus, ((Parameters.ssmode) && (_local_8.isHallucinating)));
				map.draw(camera_, _local_7);
			}
			if (_local_8)
			{
				if (Parameters.fameBot)
				{
					if (map.name_ == Map.NEXUS)
					{
						if (Parameters.data_.famebotContinue == 2)
						{
							if (Parameters.fameWalkSleep_toFountainOrHall == 0)
							{
								Parameters.fameWalkSleep_toFountainOrHall = (5000 + RandomUtil.randomRange(-2500, 5000));
							}
							if (Parameters.fameWalkSleep_toRealms == 0)
							{
								Parameters.fameWalkSleep_toRealms = ((Parameters.fameWalkSleep_toFountainOrHall + 1000) + RandomUtil.randomRange(0, 2000));
							}
							if (Parameters.fameWalkSleep2 == 0)
							{
								Parameters.fameWalkSleep2 = ((Parameters.fameWalkSleep_toRealms + 5000) + RandomUtil.randomRange(-2500, 5000));
							}
							if (Parameters.fameWalkSleepStart == 0)
							{
								Parameters.fameWalkSleepStart = _local_7;
							}
							if (_local_8.hp_ < _local_8.maxHP_)
							{
								if ((_local_7 - Parameters.fameWalkSleepStart) > Parameters.fameWalkSleep_toFountainOrHall)
								{
									_local_8.followPos.x = (nexusFountains.x + (Math.cos((_local_7 << 4)) * 1.9));
									_local_8.followPos.y = (nexusFountains.y + Math.sin((_local_7 << 2)));
								}
							} else
							{
								if (_local_8.y_ > ((nexusRealms.y + 7) + (Math.sin((_local_7 / 100)) * 3)))
								{
									_local_8.followPos.x = (nexusRealms.x + (Math.cos((_local_7 / 100)) * 1.6));
									_local_8.followPos.y = (nexusRealms.y + (Math.sin((_local_7 / 100)) * 2.6));
								} else
								{
									if (Parameters.fameBotPortal)
									{
										_local_3 = PointUtil.distanceSquaredXY(_local_8.x_, _local_8.y_, Parameters.fameBotPortal.x_, Parameters.fameBotPortal.y_);
										if (((_local_3 <= 1) && (Parameters.fameBotPortal.active_)))
										{
											this.gsc_.usePortal(Parameters.fameBotPortalId);
										} else
										{
											if (_local_3 <= 100)
											{
												_local_8.followPos.x = Parameters.fameBotPortalPoint.x;
												_local_8.followPos.y = Parameters.fameBotPortalPoint.y;
											}
										}
									} else
									{
										if ((_local_7 - Parameters.fameWalkSleepStart) > Parameters.fameWalkSleep_toFountainOrHall)
										{
											if (PointUtil.distanceSquaredXY(_local_8.x_, _local_8.y_, _local_8.followPos.x, _local_8.followPos.y) >= 29)
											{
												_local_8.followPos.x = (nexusHallway.x + (Math.cos((_local_7 << 4)) * 1.5));
												_local_8.followPos.y = (nexusHallway.y + (Math.sin((_local_7 << 2)) * 5));
											} else
											{
												Parameters.fameWalkSleep_toFountainOrHall = int.MAX_VALUE;
											}
										} else
										{
											if ((_local_7 - Parameters.fameWalkSleepStart) > Parameters.fameWalkSleep_toRealms)
											{
												if (PointUtil.distanceSquaredXY(_local_8.x_, _local_8.y_, _local_8.followPos.x, _local_8.followPos.y) >= 1)
												{
													_local_8.followPos.x = (nexusRealms.x + Math.cos((_local_7 << 4)));
													_local_8.followPos.y = (nexusRealms.y + Math.sin((_local_7 << 2)));
												} else
												{
													Parameters.fameWalkSleep_toFountainOrHall = int.MAX_VALUE;
													_local_8.textNotification("Pick a Realm!", 0xFF0000, 0);
												}
											}
										}
									}
								}
							}
						} else
						{
							if (((Parameters.data_.famebotContinue == 1) && (_local_8.hp_ < _local_8.maxHP_)))
							{
								_local_8.followPos.x = (nexusFountains.x + Math.cos((_local_7 << 4)));
								_local_8.followPos.y = nexusFountains.y;
							} else
							{
								if (((Parameters.data_.famebotContinue == 1) && (this.gsc_.lastTickId_ > 2)))
								{
									if (Parameters.reconRealm)
									{
										this.dispatchEvent(Parameters.reconRealm);
									} else
									{
										Parameters.reconNexus.gameId_ = -3;
										this.dispatchEvent(Parameters.reconNexus);
										Parameters.reconNexus.gameId_ = -2;
									}
									return;
								}
							}
						}
					} else
					{
						if (map.name_ == "Vault")
						{
							if (_local_8.hp_ < _local_8.maxHP_)
							{
								_local_8.followPos.x = vaultFountain.x;
								_local_8.followPos.y = vaultFountain.y;
							} else
							{
								if (Parameters.data_.famebotContinue == 2)
								{
									if (Parameters.data_.disableNexus)
									{
										if (Parameters.fameWaitNTTime == 0)
										{
											Parameters.fameWaitNTTime = (60000 + RandomUtil.randomRange(-5000, 34000));
										}
										if (Parameters.fameWaitStartTime == 0)
										{
											Parameters.fameWaitStartTime = _local_7;
										}
										_local_8.textNotification((("Waiting " + int((Parameters.fameWaitNTTime / 1000))) + ' seconds to "/nexustutorial"'), 3158271, 0);
										if ((_local_7 - Parameters.fameWaitStartTime) > Parameters.fameWaitNTTime)
										{
											this.dispatchEvent(Parameters.reconRealm);
											Parameters.fameWaitNTTime = 0;
											Parameters.fameWaitStartTime = 0;
										}
									} else
									{
										this.dispatchEvent(Parameters.reconNexus);
									}
								} else
								{
									if (((Parameters.data_.famebotContinue == 1) && (this.gsc_.lastTickId_ > 2)))
									{
										this.dispatchEvent(Parameters.reconRealm);
										return;
									}
								}
							}
						} else
						{
							if ((_local_7 - lastCalcTime) >= 50)
							{
								_local_8.followPos = _local_8.calcFollowPos();
								lastCalcTime = _local_7;
							}
							if (Parameters.warnDensity)
							{
								_local_8.textNotification("Not enough players!", 0xFF0000, 0);
							}
							if ((((_local_7 - _local_8.lastTpTime_) > Parameters.data_.fameTpCdTime) && (PointUtil.distanceSquaredXY(_local_8.x_, _local_8.y_, _local_8.followPos.x, _local_8.followPos.y) > Parameters.data_.teleDistance)))
							{
								_local_8.lastTpTime_ = _local_7;
								_local_8.teleToClosestPoint(_local_8.followPos);
							}
						}
					}
				} else
				{
					if (Parameters.followPlayer)
					{
						_local_8.followPos.x = Parameters.followPlayer.x_;
						_local_8.followPos.y = Parameters.followPlayer.y_;
					}
				}
				if (this.creditDisplay_ != null)
				{
					this.creditDisplay_.draw(_local_8.credits_, _local_8.fame_, _local_8.tokens_);
				}
				this.drawCharacterWindow.dispatch(_local_8);
				if (this.evalIsNotInCombatMapArea())
				{
					this.rankText_.draw(_local_8.numStars_);
					this.guildText_.draw(_local_8.guildName_, _local_8.guildRank_);
				}
				if (_local_8.isPaused)
				{
					if (Parameters.ssmode)
					{
						map.filters = [PAUSED_FILTER];
					}
					map.mouseEnabled = false;
					map.mouseChildren = false;
					hudView.filters = [PAUSED_FILTER];
					hudView.mouseEnabled = false;
					hudView.mouseChildren = false;
				} else
				{
					if (map.filters.length > 0 || hudView.filters.length > 0)
					{
						map.filters = [];
						map.mouseEnabled = true;
						map.mouseChildren = true;
						hudView.filters = [];
						hudView.mouseEnabled = true;
						hudView.mouseChildren = true;
					}
				}
				moveRecords_.addRecord(_local_7, _local_8.x_, _local_8.y_);
			}
			lastUpdate_ = _local_7;
		}

		public function showPetToolTip(_arg_1:Boolean):void
		{
		}

		override public function showDailyLoginCalendar():void
		{
			this.openDialog.dispatch(new DailyLoginModal());
		}

	}
}//package com.company.assembleegameclient.game

