//kabam.rotmg.chat.control.ParseChatMessageCommand

package kabam.rotmg.chat.control
{
	import com.company.assembleegameclient.appengine.SavedCharacter;
	import com.company.assembleegameclient.game.MapUserInput;
	import com.company.assembleegameclient.game.events.ReconnectEvent;
	import com.company.assembleegameclient.map.Map;
	import com.company.assembleegameclient.objects.GameObject;
	import com.company.assembleegameclient.objects.ObjectLibrary;
	import com.company.assembleegameclient.objects.Player;
	import com.company.assembleegameclient.parameters.Parameters;
	import com.company.assembleegameclient.screens.charrects.CurrentCharacterRect;
	import com.company.assembleegameclient.ui.dialogs.HelpDialog;
	import com.company.util.MoreObjectUtil;

	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;

	import kabam.rotmg.account.core.Account;
	import kabam.rotmg.appengine.api.AppEngineClient;
	import kabam.rotmg.assets.EmbeddedData;
	import kabam.rotmg.build.api.BuildData;
	import kabam.rotmg.chat.model.ChatMessage;
	import kabam.rotmg.core.model.PlayerModel;
	import kabam.rotmg.dailyLogin.model.DailyLoginModel;
	import kabam.rotmg.dialogs.control.OpenDialogSignal;
	import kabam.rotmg.dialogs.model.PopupNamesConfig;
	import kabam.rotmg.game.commands.PlayGameCommand;
	import kabam.rotmg.game.model.GameInitData;
	import kabam.rotmg.game.signals.AddTextLineSignal;
	import kabam.rotmg.game.signals.PlayGameSignal;
	import kabam.rotmg.messaging.impl.GameServerConnection;
	import kabam.rotmg.servers.api.Server;
	import kabam.rotmg.servers.api.ServerModel;
	import kabam.rotmg.text.model.TextKey;
	import kabam.rotmg.ui.model.HUDModel;
	import kabam.rotmg.ui.signals.EnterGameSignal;

	import zfn.sound.SoundCustom;

	public class ParseChatMessageCommand
	{

		[Inject]
		public var data:String;
		[Inject]
		public var hudModel:HUDModel;
		[Inject]
		public var addTextLine:AddTextLineSignal;
		[Inject]
		public var client:AppEngineClient;
		[Inject]
		public var account:Account;
		[Inject]
		public var buildData:BuildData;
		[Inject]
		public var dailyLoginModel:DailyLoginModel;
		[Inject]
		public var player:PlayerModel;
		[Inject]
		public var enterGame:EnterGameSignal;
		[Inject]
		public var playGame:PlayGameSignal;
		[Inject]
		public var serverModel:ServerModel;
		[Inject]
		public var openDialog:OpenDialogSignal;

		private function cheatCommands():Boolean
		{
			var command:Array;
			var player:Player = this.hudModel.gameSprite.map.player_;
			var gsc:GameServerConnection = this.hudModel.gameSprite.gsc_;
			var object:GameObject;
			var array:Array;
			var counter:int;
			switch (this.data.toLowerCase())
			{
				case "/getcredentials":
					if (this.account.getUserId().indexOf("@") == -1)
					{
						new FileReference().save("GUID: " + this.account.getUserId() + "\nSecret: " + this.account.getSecret(), "steam.txt");
					} else
					{
						this.addTextLine.dispatch(ChatMessage.make(Parameters.SERVER_CHAT_NAME, "You are not steam user.", true));
					}
					return (true);
				case "/l2m":
				case "/left":
				case "/lefttomax":
					var output:String = "You need ";
					var maxed:Boolean = true;
					var statsValues:Array = [int(((((player.maxHPMax_ - player.maxHP_) + player.maxHPBoost_) / 5) + (((((player.maxHPMax_ - player.maxHP_) + player.maxHPBoost_) % 5) > 0) ? 1 : 0))), int(((((player.maxMPMax_ - player.maxMP_) + player.maxMPBoost_) / 5) + (((((player.maxMPMax_ - player.maxMP_) + player.maxMPBoost_) % 5) > 0) ? 1 : 0))), ((player.attackMax_ - player.attack_) + player.attackBoost_), ((player.defenseMax_ - player.defense_) + player.defenseBoost_), ((player.speedMax_ - player.speed_) + player.speedBoost_), ((player.dexterityMax_ - player.dexterity_) + player.dexterityBoost_), ((player.vitalityMax_ - player.vitality_) + player.vitalityBoost_), ((player.wisdomMax_ - player.wisdom_) + player.wisdomBoost_)];
					var stats:Array = ["LIFE", "MANA", "ATT", "DEF", "SPD", "DEX", "VIT", "WIS"];
					counter = 0;
					while (counter < statsValues.length)
					{
						if (statsValues[counter] > 0)
						{
							output = (output + (((statsValues[counter] + " ") + stats[counter]) + ", "));
							maxed = false;
						}
						counter++;
					}
					output = ((maxed) ? "Already maxed" : (output.substr(0, (output.length - 2)) + " to be maxed"));
					this.addTextLine.dispatch(ChatMessage.make(Parameters.SYNC_CHAT_NAME, output, true));
					return (true);
				case "/constructs":
					Parameters.constructToggle = !Parameters.constructToggle;
					if (Parameters.constructToggle)
					{
						MapUserInput.addIgnore(2309);
						MapUserInput.addIgnore(2310);
						MapUserInput.addIgnore(2311);
						this.addTextLine.dispatch(ChatMessage.make(Parameters.SERVER_CHAT_NAME, "Constructs Ignored", true));
					} else
					{
						MapUserInput.remIgnore(2309);
						MapUserInput.remIgnore(2310);
						MapUserInput.remIgnore(2311);
						this.addTextLine.dispatch(ChatMessage.make(Parameters.SERVER_CHAT_NAME, "Constructs Unignored", true));
					}
					Parameters.save();
					return (true);
				case "/bg":
					Parameters.data_.showBG = !Parameters.data_.showBG;
					this.addTextLine.dispatch(ChatMessage.make(Parameters.SERVER_CHAT_NAME, ("Showing Backgrounds: " + Parameters.data_.showBG), true));
					return (true);
				case "/mserver":
					this.hudModel.gameSprite.gsc_.playerText("/t mreyeball server");
					return (true);
				case "/private":
					this.hudModel.gameSprite.gsc_.playerText("/t mreyeball private profile");
					return (true);
				case "/gwho":
				case "/mates":
					this.hudModel.gameSprite.gsc_.playerText("/t mreyeball mates");
					return (true);
				case "/gquit":
					this.hudModel.gameSprite.gsc_.guildRemove(this.hudModel.gameSprite.map.player_.name_);
					return (true);
				case "/bgfps":
					this.addTextLine.dispatch(ChatMessage.make(Parameters.SERVER_CHAT_NAME, ("Background framerate is " + Parameters.data_.bgFPS), true));
					return (true);
				case "/fgfps":
					this.addTextLine.dispatch(ChatMessage.make(Parameters.SERVER_CHAT_NAME, ("Foreground framerate is " + Parameters.data_.fgFPS), true));
					return (true);
				case "/ip":
					this.addTextLine.dispatch(ChatMessage.make(Parameters.SERVER_CHAT_NAME, ((this.hudModel.gameSprite.gsc_.server_.name + ": ") + this.hudModel.gameSprite.gsc_.server_.address), true));
					return (true);
				case "/loc":
					this.addTextLine.dispatch(ChatMessage.make("Location", ((("x: " + this.hudModel.gameSprite.map.player_.x_) + ", y: ") + this.hudModel.gameSprite.map.player_.y_), true));
					return (true);
				case "/l":
					this.addTextLine.dispatch(ChatMessage.make("Location", ((("x: " + ((this.hudModel.gameSprite.map.player_.x_ * 100) * 0.01)) + ", y: ") + ((this.hudModel.gameSprite.map.player_.y_ * 100) * 0.01)), true));
					return (true);
				case "/lf":
				case "/lockfilter":
					Parameters.data_.hideLockList = !Parameters.data_.hideLockList;
					this.addTextLine.dispatch(ChatMessage.make(Parameters.SERVER_CHAT_NAME, ((Parameters.data_.hideLockList) ? "Only showing locked players" : "Showing all players"), true));
					return (true);
				case "/pets":
				case "/hidepets":
					Parameters.data_.hidePets = !Parameters.data_.hidePets;
					this.addTextLine.dispatch(ChatMessage.make(Parameters.SERVER_CHAT_NAME, ((Parameters.data_.hidePets) ? "Hiding pets" : "Showing pets"), true));
					return (true);
				case "/world":
					this.addTextLine.dispatch(ChatMessage.make(Parameters.SYNC_CHAT_NAME, Parameters.worldMessage, true));
					return (true);
				case "/mscale":
					this.addTextLine.dispatch(ChatMessage.make(Parameters.SERVER_CHAT_NAME, "Map Scale: " + Parameters.data_.mscale, true));
					return (true);
				case "/fs":
				case "/fullscreen":
					if (Parameters.root.stage.scaleMode == StageScaleMode.EXACT_FIT)
					{
						Parameters.root.stage.scaleMode = StageScaleMode.NO_SCALE;
						Parameters.data_.stageScale = StageScaleMode.NO_SCALE;
					} else
					{
						Parameters.root.stage.scaleMode = StageScaleMode.EXACT_FIT;
						Parameters.data_.stageScale = StageScaleMode.EXACT_FIT;
					}
					Parameters.save();
					Parameters.root.dispatchEvent(new Event(Event.RESIZE));
					return (true);
				case "/scui":
				case "/scaleui":
					Parameters.data_.uiscale = !Parameters.data_.uiscale;
					Parameters.root.dispatchEvent(new Event(Event.RESIZE));
					Parameters.save();
					return (true);
				case "/cstat":
				case "/clientstat":
					Parameters.data_.showClientStat = !Parameters.data_.showClientStat;
					return (true);
				case "/an":
					this.hudModel.gameSprite.map.player_.textNotification((((("Nexusing at: " + Parameters.data_.AutoNexus) + "% (") + this.hudModel.gameSprite.map.player_.autoNexusNumber) + ")"));
					return (true);
				case "/ah":
					this.hudModel.gameSprite.map.player_.textNotification((((("Healing at: " + Parameters.data_.AutoHealPercentage) + "% (") + this.hudModel.gameSprite.map.player_.autoHealNumber) + ")"));
					return (true);
				case "/ap":
					this.hudModel.gameSprite.map.player_.textNotification((((("Drinking HP Pot at: " + Parameters.data_.autoHPPercent) + "% (") + this.hudModel.gameSprite.map.player_.autoHpPotNumber) + ")"));
					return (true);
				case "/ao":
					Parameters.data_.alphaOnOthers = !Parameters.data_.alphaOnOthers;
					this.addTextLine.dispatch(ChatMessage.make(Parameters.SERVER_CHAT_NAME, ("Alpha: " + Parameters.data_.alphaOnOthers), true));
					return (true);
				case "/savemaptxt":
					this.hudModel.gameSprite.map.saveMap(true);
					return (true);
				case "/savemappng":
					this.hudModel.gameSprite.map.saveMap(false);
					return (true);
				case "/skipcontrollername":
					Parameters.data_.cNameBypass = !Parameters.data_.cNameBypass;
					this.addTextLine.dispatch(ChatMessage.make(Parameters.SERVER_CHAT_NAME, ("Ignoring GamePad name: " + Parameters.data_.cNameBypass), true));
					return (true);
				case "/slide":
				case "/push":
					Parameters.data_.ignoreIce = !Parameters.data_.ignoreIce;
					this.hudModel.gameSprite.map.player_.textNotification(("Ignoring Ice: " + Parameters.data_.ignoreIce));
					return (true);
				case "/f":
				case "/follow":
					Parameters.followingName = !Parameters.followingName;
					this.hudModel.gameSprite.map.player_.textNotification(("Following: " + Parameters.data_.followingName));
					return (true);
				case "/tut":
					this.hudModel.gameSprite.gsc_.playerText("/tutorial");
					return (true);
				case "/nt":
					this.hudModel.gameSprite.gsc_.playerText("/nexustutorial");
					return (true);
				case "/dodbot":
					player.dodCounter = 0;
					Parameters.data_.dodBot = !Parameters.data_.dodBot;
					return (true);
				case "/hide":
					gsc.playerText("/tell mreyeball hide me");
					return (true);
				case "/friends":
				case "/fr":
					gsc.playerText("/tell mreyeball friends");
					return (true);
				case "/stats":
				case "/roll":
					gsc.playerText("/tell mreyeball stats");
					return (true);
				case "/mates":
					gsc.playerText("/tell mreyeball mates");
					return (true);
				case "/mobinfo":
					Parameters.data_.showMobInfo = !Parameters.data_.showMobInfo;
					this.addTextLine.dispatch(ChatMessage.make(Parameters.SERVER_CHAT_NAME, ("Show mob info: " + Parameters.data_.showMobInfo), true));
					if (!Parameters.data_.showMobInfo && this.hudModel.gameSprite.map.mapOverlay_)
					{
						this.hudModel.gameSprite.map.mapOverlay_.removeChildren(0);
					}
					return (true);
				case "/autotrade":
					Parameters.autoAcceptTrades = !Parameters.autoAcceptTrades;
					this.addTextLine.dispatch(ChatMessage.make(Parameters.SERVER_CHAT_NAME, ("Auto accepting trades: " + Parameters.autoAcceptTrades), true));
					return (true);
				case "/automax":
					Parameters.autoDrink = !Parameters.autoDrink;
					this.addTextLine.dispatch(ChatMessage.make(Parameters.SERVER_CHAT_NAME, ("Auto drinking potions: " + Parameters.autoDrink), true));
					return (true);
				case "/mystic":
					output = "Mystics in train: ";
					for each (object in hudModel.gameSprite.map.goDict_)
					{
						if (object.objectType_ == 803)
						{
							output = (output + (object.name_ + ", "));
						}
					}
					output = output.substring(0, (output.length - 2));
					this.addTextLine.dispatch(ChatMessage.make("", output, true));
					output = "Mystics with > 0 and < max MP: ";
					for each (object in hudModel.gameSprite.map.goDict_)
					{
						if (object.objectType_ == 803)
						{
							var objectPlayer:Player = (object as Player);
							if (((objectPlayer.mp_ > 0) && (objectPlayer.mp_ < objectPlayer.maxMP_)))
							{
								output = (output + (object.name_ + ", "));
							}
						}
					}
					output = output.substring(0, (output.length - 2));
					this.addTextLine.dispatch(ChatMessage.make("", output, true));
					output = "Mystics stasised: ";
					var timer:int = getTimer();
					for each (var _local_23:String in Parameters.mystics)
					{
						output = (output + _local_23.split(" ")[0] + " stasised " + (timer - parseInt(_local_23.split(" ")[1]) / 1000) + " seconds ago, ");
					}
					output = output.substring(0, (output.length - 2));
					this.addTextLine.dispatch(ChatMessage.make("", output, true));
					return (true);
				case "/famebot":
					Parameters.fameBot = !Parameters.fameBot;
					Parameters.fameBotWatchingPortal = false;
					if (Parameters.fameBot)
					{
						if (Parameters.fpmStart == -1)
						{
							Parameters.fpmStart = getTimer();
							Parameters.fpmGain = 0;
						}
						this.hudModel.gameSprite.map.player_.textNotification("Famebot On", 0xFFB000);
					} else
					{
						this.hudModel.gameSprite.map.player_.textNotification("Famebot Off", 0xFFB000);
					}
					return (true);
				case "/fameportal":
					Parameters.fameBotWatchingPortal = true;
					this.hudModel.gameSprite.map.player_.textNotification("Setting fame train portal to the next realm portal you enter!", 0xFFB000);
					return (true);
				case "/moverec":
					if (Parameters.VHS == 0)
					{
						Parameters.VHSRecord = new Vector.<Point>();
						Parameters.VHS = 1;
						this.hudModel.gameSprite.map.player_.clearTextureCache();
						this.hudModel.gameSprite.map.player_.textNotification("Recording movement", 7798535);
					} else
					{
						if (Parameters.VHS == 1)
						{
							this.hudModel.gameSprite.map.player_.textNotification("Already recording", 7798535);
						} else
						{
							if (Parameters.VHS == 2)
							{
								this.hudModel.gameSprite.map.player_.textNotification("Can't record while playing", 7798535);
							}
						}
					}
					return (true);
				case "/movestop":
					if (Parameters.VHS == 1)
					{
						Parameters.VHS = 0;
						Parameters.VHSRecordLength = Parameters.VHSRecord.length;
						this.hudModel.gameSprite.map.player_.clearTextureCache();
						this.hudModel.gameSprite.map.player_.textNotification((("Recorded " + Parameters.VHSRecordLength) + " points"), 7798535);
					} else
					{
						if (Parameters.VHS == 2)
						{
							Parameters.VHS = 0;
							player = this.hudModel.gameSprite.map.player_;
							player.clearTextureCache();
							player.followPos.x = 0;
							player.followPos.y = 0;
							player.followLanded = true;
							player.setRelativeMovement(0, 0, 0);
						}
					}
					return (true);
				case "/moveplay":
					if (Parameters.VHSRecordLength > 0)
					{
						Parameters.VHS = 2;
						Parameters.VHSIndex = 0;
						Parameters.VHSNext = Parameters.VHSRecord[Parameters.VHSIndex];
						player.followPos.x = Parameters.VHSNext.x;
						player.followPos.y = Parameters.VHSNext.y;
						player.clearTextureCache();
					}
					return (true);
				case "/blend":
					Parameters.blendType_ = (Parameters.blendType_ == 0 ? 1 : 0);
					this.addTextLine.dispatch(ChatMessage.make("BlendType", Parameters.blendType_.toString(), true));
					return (true);
				case "/abi":
					Parameters.abi = !Parameters.abi;
					this.addTextLine.dispatch(ChatMessage.make("@Auto Ability", ((Parameters.abi) ? "On" : "Off"), true));
					return (true);
				case "/lowcpu":
					Parameters.lowCPUMode = !Parameters.lowCPUMode;
					player.textNotification(((Parameters.lowCPUMode) ? "Low CPU on" : "Low CPU off"));
					return (true);
				case "/name":
					Parameters.data_.fakeName = null;
					this.hudModel.gameSprite.hudView.characterDetails.setName(player.name_);
					return (true);
				case "/trace":
					Parameters.data_.traceMessage = !Parameters.data_.traceMessage;
					player.textNotification(((Parameters.data_.traceMessage) ? "Tracing message" : "Tracing disabled"));
					return (true);
				case "/s":
				case "/switch":
				case "/swap":
					if (player.hasBackpack_)
					{
						player.findSlots();
					} else
					{
						this.addTextLine.dispatch(ChatMessage.make(Parameters.HELP_CHAT_NAME, "Whoa, that was close! Your items almost disappeared.", true));
					}
					return (true);
				case "/tile":
					this.addTextLine.dispatch(ChatMessage.make(Parameters.HELP_CHAT_NAME, player.square_.tileType_.toString(), true));
					return (true);
				case "/commands":
					this.openDialog.dispatch(new HelpDialog());
					return (true);
				default:
					command = this.data.toLowerCase().match("^/skin (.+)$");
					if (command != null)
					{
						if (command[1] == "none")
						{
							Parameters.data_.nsetSkin[0] = "";
							Parameters.data_.nsetSkin[1] = -1;
							Parameters.save();
							player.size_ = 100;
							gsc.setPlayerSkinTemplate(player, Parameters.playerSkin);
						} else
						{
							Parameters.data_.nsetSkin = this.findSkinIndex(command[1]);
							Parameters.save();
							player.size_ = 100;
							gsc.setPlayerSkinTemplate(player, Parameters.data_.nsetSkin[1]);
						}
						return (true);
					}
					command = this.data.match("^/recondelay (\\d+)");
					if (command != null)
					{
						Parameters.data_.reconDelay = parseInt(command[1]);
						return (true);
					}
					command = this.data.toLowerCase().match("^/realm (\\w+)");
					if (command != null)
					{
						Parameters.realmJoining = true;
						Parameters.realmName = command[1];
						this.hudModel.gameSprite.dispatchEvent(new ReconnectEvent(Parameters.reconNexus.server_, Parameters.RANDOM_REALM_GAMEID, false, this.hudModel.gameSprite.gsc_.charId_, -1, null, false));
					}
					command = (this.data.match("^/tp (\\w+)") || this.data.match("^/teleport (\\w+)"));
					if (command != null)
					{
						if (Parameters.data_.fameBlockTP)
						{
							this.hudModel.gameSprite.map.player_.textNotification("Ignored teleport, Boots on the Ground enabled", 0xE25F00);
						} else
						{
							this.hudModel.gameSprite.gsc_.teleport(player.getPlayer(this.data).objectId_);
						}
						return (true);
					}
					command = this.data.toLowerCase().match("^/buy (\\w+) ?(\\w*)$");
					if (command != null)
					{
						if (command[2] == "")
						{
							navigateToURL(new URLRequest((("https://www.realmeye.com/offers-to/sell/" + this.findMatch2(command[1])) + "/2793")), "_blank");
						} else
						{
							navigateToURL(new URLRequest(((("https://www.realmeye.com/offers-to/sell/" + this.findMatch2(command[1])) + "/") + this.findMatch2(command[2]))), "_blank");
						}
						return (true);
					}
					command = this.data.toLowerCase().match("^/sell (\\w+) ?(\\w*)$");
					if (command != null)
					{
						if (command[2] == "")
						{
							navigateToURL(new URLRequest((("https://www.realmeye.com/offers-to/buy/" + this.findMatch2(command[1])) + "/2793")), "_blank");
						} else
						{
							navigateToURL(new URLRequest(((("https://www.realmeye.com/offers-to/buy/" + this.findMatch2(command[1])) + "/") + this.findMatch2(command[2]))), "_blank");
						}
						return (true);
					}
					command = this.data.toLowerCase().match("^/player (\\w+)$");
					if (command != null)
					{
						navigateToURL(new URLRequest(("https://www.realmeye.com/player/" + command[1])), "_blank");
						return (true);
					}
					command = this.data.match("^/chatlength (\\d+)");
					if (command != null)
					{
						Parameters.data_.chatLength = command[1];
						this.hudModel.gameSprite.chatBox_.list.setVisibleItemCount();
						this.hudModel.gameSprite.chatBox_.list.removeOldestExcessVisible();
						this.hudModel.gameSprite.chatBox_.model.setVisibleItemCount();
						return (true);
					}
					command = this.data.match("^/grank (\\w+) (\\d+)");
					if (command != null)
					{
						this.hudModel.gameSprite.gsc_.changeGuildRank(command[1], command[2]);
						return (true);
					}
					command = this.data.match("^/gmake (\\w+)");
					if (command != null)
					{
						this.hudModel.gameSprite.gsc_.createGuild(command[1]);
						return (true);
					}
					command = this.data.match("^/gkick (\\w+)");
					if (command != null)
					{
						this.hudModel.gameSprite.gsc_.guildRemove(command[1]);
						return (true);
					}
					command = this.data.match("^/bgfps (\\d+)");
					if (command != null)
					{
						Parameters.data_.bgFPS = command[1];
						this.addTextLine.dispatch(ChatMessage.make("", ("Background framerate set to " + Parameters.data_.bgFPS), true));
						return (true);
					}
					command = this.data.match("^/fgfps (\\d+)");
					if (command != null)
					{
						Parameters.data_.fgFPS = command[1];
						this.addTextLine.dispatch(ChatMessage.make("", ("Foreground framerate set to " + Parameters.data_.fgFPS), true));
						return (true);
					}
					command = this.data.match("^/fps (\\d+)");
					if (command != null)
					{
						ROTMG.STAGE.frameRate = command[1];
						this.addTextLine.dispatch(ChatMessage.make(Parameters.SERVER_CHAT_NAME, ("Framerate set to " + ROTMG.STAGE.frameRate), true));
						return (true);
					}
					command = this.data.match("^/goto ([0-9.]+)");
					if (command != null)
					{
						this.jumpToIP(command[1]);
						return (true);
					}
					command = this.data.match("^/camloc (\\d+) (\\d+)");
					if (command != null)
					{
						this.hudModel.gameSprite.camera_.x_ = command[1];
						this.hudModel.gameSprite.camera_.y_ = command[2];
						return (true);
					}
					command = this.data.match("/fake (\\d+)");
					if (command != null)
					{
						var data:XML = ObjectLibrary.getXMLfromId(command[1]);
						if (data != null)
						{
							object = new GameObject(data);
							if (object != null)
							{
								object.objectId_ = (int.MIN_VALUE + getTimer());
								object.props_.showName_ = true;
								object.name_ = object.props_.displayId_;
								this.hudModel.gameSprite.map.addObj(object, this.hudModel.gameSprite.map.player_.x_, this.hudModel.gameSprite.map.player_.y_);
							}
						}
						return (true);
					}
					command = this.data.match("^/mscale (\\d*\\.*\\d+)");
					if (command != null)
					{
						Parameters.data_.mscale = command[1];
						Parameters.save();
						Parameters.root.dispatchEvent(new Event(Event.RESIZE));
						this.addTextLine.dispatch(ChatMessage.make(Parameters.HELP_CHAT_NAME, "Map Scale: " + Parameters.data_.mscale, true));
						return (true);
					}
					command = this.data.match("^/an (\\d+)");
					if (command != null)
					{
						Parameters.data_.AutoNexus = command[1];
						if (this.hudModel.gameSprite.map.player_)
						{
							this.hudModel.gameSprite.map.player_.calcHealthPercent();
						}
						if (Parameters.data_.AutoNexus == 0)
						{
							this.hudModel.gameSprite.map.player_.textNotification("Autonexus 0% (OFF)");
						} else
						{
							this.hudModel.gameSprite.map.player_.textNotification((((("Nexusing at: " + Parameters.data_.AutoNexus) + "% (") + this.hudModel.gameSprite.map.player_.autoNexusNumber) + ")"));
						}
						return (true);
					}
					command = this.data..toLowerCase().match("^/dye([1-2])? ([\\w ]+)");
					if (command != null)
					{
						switch (parseInt(command[1]))
						{
							case 1:
								if (command[2] == "none")
								{
									Parameters.data_.setTex1 = -1;
									Parameters.save();
									player.setTex1(Parameters.PlayerTex1);
								} else
								{
									Parameters.data_.setTex1 = this.getTex1(this.findMatch2((command[2] + " cloth")));
									Parameters.save();
									player.setTex1(Parameters.data_.setTex1);
								}
								break;
							case 2:
								if (command[2] == "none")
								{
									Parameters.data_.setTex2 = -1;
									Parameters.save();
									player.setTex2(Parameters.PlayerTex2);
								} else
								{
									Parameters.data_.setTex2 = this.getTex1(this.findMatch2((command[2] + " cloth")));
									Parameters.save();
									player.setTex2(Parameters.data_.setTex2);
								}
								break;
							default:
								if (command[2] == "none")
								{
									Parameters.data_.setTex1 = -1;
									Parameters.data_.setTex2 = -1;
									Parameters.save();
									player.setTex1(Parameters.PlayerTex1);
									player.setTex2(Parameters.PlayerTex2);
								} else
								{
									command[2] = this.getTex1(this.findMatch2((command[2] + " cloth")));
									Parameters.data_.setTex1 = command[2];
									Parameters.data_.setTex2 = command[2];
									Parameters.save();
									player.setTex1(Parameters.data_.setTex1);
									player.setTex2(Parameters.data_.setTex2);
								}
						}
						return (true);
					}
					command = this.data.match("^/ah (\\d+)");
					if (command != null)
					{
						Parameters.data_.AutoHealPercentage = command[1];
						if (this.hudModel.gameSprite.map.player_)
						{
							this.hudModel.gameSprite.map.player_.calcHealthPercent();
						}
						if (Parameters.data_.AutoHealPercentage == 0)
						{
							this.hudModel.gameSprite.map.player_.textNotification("Auto Heal 0% (OFF)");
						} else
						{
							this.hudModel.gameSprite.map.player_.textNotification((((("Healing at: " + Parameters.data_.AutoHealPercentage) + "% (") + this.hudModel.gameSprite.map.player_.autoHealNumber) + ")"));
						}
						return (true);
					}
					command = this.data.match("^/ap (\\d+)");
					if (command != null)
					{
						Parameters.data_.autoHPPercent = command[1];
						if (this.hudModel.gameSprite.map.player_)
						{
							this.hudModel.gameSprite.map.player_.calcHealthPercent();
						}
						if (Parameters.data_.autoHPPercent == 0)
						{
							this.hudModel.gameSprite.map.player_.textNotification("Auto HP Pot 0% (OFF)");
						} else
						{
							this.hudModel.gameSprite.map.player_.textNotification((((("Drinking HP Pot at: " + Parameters.data_.autoHPPercent) + "% (") + this.hudModel.gameSprite.map.player_.autoHpPotNumber) + ")"));
						}
						return (true);
					}
					command = this.data.match("^/alpha (\\d*\\.*\\d+)");
					if (command != null)
					{
						Parameters.data_.alphaMan = command[1];
						Parameters.save();
						this.addTextLine.dispatch(ChatMessage.make(Parameters.SERVER_CHAT_NAME, "Alpha set to: " + Parameters.data_.alphaMan, true));
						return (true);
					}
					command = this.data.match("^/glow (\\d+)");
					if (command != null)
					{
						this.hudModel.gameSprite.map.player_.clearTextureCache();
						Parameters.data_.glowColor = command[1];
						Parameters.save();
						this.hudModel.gameSprite.map.player_.textNotification("Selected color: " + command[1]);
						return (true);
					}
					command = this.data.match("^/glow (\\w+)");
					if (command != null)
					{
						this.hudModel.gameSprite.map.player_.clearTextureCache();
						switch (command[1])
						{
							case "red":
								Parameters.data_.glowColor = 0xFF0000;
								this.hudModel.gameSprite.map.player_.textNotification("Selected red color.");
								break;
							case "blue":
								Parameters.data_.glowColor = 0x0000FF;
								this.hudModel.gameSprite.map.player_.textNotification("Selected blue color.");
								break;
							case "green":
								Parameters.data_.glowColor = 0x00FF00;
								this.hudModel.gameSprite.map.player_.textNotification("Selected green color.");
								break;
							case "pink":
								Parameters.data_.glowColor = 0xFF00FF;
								this.hudModel.gameSprite.map.player_.textNotification("Selected pink color.");
								break;
							case "violet":
								Parameters.data_.glowColor = 0x9900FF;
								this.hudModel.gameSprite.map.player_.textNotification("Selected violet color.");
								break;
							case "yellow":
								Parameters.data_.glowColor = 0xFFFF00;
								this.hudModel.gameSprite.map.player_.textNotification("Selected yellow color.");
								break;
							case "aqua":
								Parameters.data_.glowColor = 0x00FFFF;
								this.hudModel.gameSprite.map.player_.textNotification("Selected aqua color.");
								break;
							case "white":
								Parameters.data_.glowColor = 0xFFFFFF;
								this.hudModel.gameSprite.map.player_.textNotification("Selected white color.");
								break;
							case "black":
								Parameters.data_.glowColor = 0x010000;
								this.hudModel.gameSprite.map.player_.textNotification("Selected black color.");
								break;
							default:
								Parameters.data_.glowColor = 0;
								this.hudModel.gameSprite.map.player_.textNotification("Glow disabled.");
								break;
						}
						Parameters.save();
						return (true);
					}
					command = (this.data.match("^/follow (\\w+)") || this.data.match("/f (\\w+)"));
					if (command != null)
					{
						object = player.getPlayer(command[1]);
						if (object != null)
						{
							Parameters.followPlayer = object;
							Parameters.followName = object.name_;
							Parameters.followingName = true;
							this.hudModel.gameSprite.map.player_.textNotification("Following to " + object.name_);
						} else
						{
							this.addTextLine.dispatch(ChatMessage.make(Parameters.SERVER_CHAT_NAME, "Player with name \"" + command[1] + "\" not found.", true));
						}
						return (true);
					}
					command = this.data.match("^/timer ([\\d:]+)");
					if (command != null)
					{
						Parameters.timerActive = true;
						if (command[1].indexOf(":") != -1)
						{
							command = command[1].split(":");
							Parameters.phaseChangeAt = getTimer() + (command[0] * (60 * 1000)) + (command[1] * 1000);
							Parameters.phaseName = "Timer";
						} else
						{
							Parameters.phaseChangeAt = getTimer() + (command[1] * 1000);
							Parameters.phaseName = "Timer";
						}
						return (true);
					}
					command = this.data.match("^/anchor (\\w+)");
					if (command != null)
					{
						object = player.getPlayer(command[1]);
						if (object != null)
						{
							this.addTextLine.dispatch(ChatMessage.make(Parameters.SERVER_CHAT_NAME, "Player with name \"" + object.name_ + "\" are anchored.", true));
							Parameters.data_.anchorName = object.name_;
							Parameters.save();
						} else
						{
							this.addTextLine.dispatch(ChatMessage.make(Parameters.SERVER_CHAT_NAME, "Player with name \"" + command[1] + "\" not found.", true));
						}
						return (true);
					}
					command = this.data.match("^/offset (\\d+)");
					if (command != null)
					{
						Parameters.data_.trainOffset = command[1];
						this.addTextLine.dispatch(ChatMessage.make(Parameters.SERVER_CHAT_NAME, "Offset: " + Parameters.data_.trainOffset, true));
						return (true);
					}
					command = this.data.match("^/name (\\w+)");
					if (command != null)
					{
						Parameters.data_.fakeName = command[1];
						this.hudModel.gameSprite.hudView.characterDetails.setName(Parameters.data_.fakeName);
						return (true);
					}
					command = this.data.match("^/tdist (\\d+)");
					if (command != null)
					{
						Parameters.data_.teleDistance = Math.sqrt(command[1]);
						this.addTextLine.dispatch(ChatMessage.make("Teleport Distance", Parameters.data_.teleDistance, true));
						return (true);
					}
					command = this.data.match("/sbthreshold (\\d+)");
					if (command != null)
					{
						Parameters.data_.spellbombHPThreshold = command[1];
						this.addTextLine.dispatch(ChatMessage.make("Spellbomb Threshold", Parameters.data_.spellbombHPThreshold, true));
						return (true);
					}
					command = this.data.match("^/aathreshold (\\d+)");
					if (command != null)
					{
						Parameters.data_.skullHPThreshold = command[1];
						this.addTextLine.dispatch(ChatMessage.make("Skull Threshold", Parameters.data_.skullHPThreshold, true));
						return (true);
					}
					command = this.data.match("^/aatargets (\\d+)");
					if (command != null)
					{
						Parameters.data_.skullTargets = command[1];
						this.addTextLine.dispatch(ChatMessage.make("Skull Targets", Parameters.data_.skullTargets, true));
						return (true);
					}
					command = this.data.match("^/vol (\\d+)");
					if (command != null)
					{
						Parameters.data_.SFXVolume = command[1];
						Parameters.save();
						this.addTextLine.dispatch(ChatMessage.make("@Volume", Parameters.data_.SFXVolume, true));
						return (true);
					}
					command = (this.data.match("^/spd (\\d+)") || this.data.match("^/setspd (\\d+)"));
					if (command != null)
					{
						this.hudModel.gameSprite.map.player_.speed_ = command[1];
						return (true);
					}
					command = this.data.match("^/play (\\w+)");
					if (command != null)
					{
						SoundCustom.play(command[1]);
						return (true);
					}
					command = this.data.toLowerCase().match("^/con ?(\\w*) ?(\\w*) ?(\\w*)");
					if (command != null)
					{
						var realm:Array;
						var isRealm:Boolean;
						var needServer:Boolean;
						var server:Server;
						var gameId:int = Parameters.NEXUS_GAMEID;
						var charId:int = this.player.currentCharId;
						var abbreviations:Vector.<String> = this.serverModel.getAbbreviations();
						var servers:Vector.<Server> = this.serverModel.getServers();
						var argumentCounter:int = 1;
						while (argumentCounter < 4)
						{
							var argument:* = command[argumentCounter];
							if (argument != "")
							{
								if (argumentCounter > 1)
								{
									needServer = false;
								}
								if (argument.substr(0, 1) == "v")
								{
									gameId = Parameters.VAULT_GAMEID;
								} else
								{
									if (argument.substr(0, 1) == "p")
									{
										Parameters.data_.preferredServer = "Proxy";
										Parameters.save();
									} else
									{
										if (abbreviations.toString().toLowerCase().indexOf(argument) != -1)
										{
											counter = 0;
											while (counter < abbreviations.length)
											{
												if (argument == abbreviations[counter].toLowerCase())
												{
													Parameters.data_.preferredServer = servers[counter].name;
													Parameters.save();
													needServer = false;
													break;
												}
												counter++;
											}
										} else
										{
											counter = 0;
											while (counter < CurrentCharacterRect.charnames.length)
											{
												var characters:String = CurrentCharacterRect.charnames[counter];
												if (argument.substr(argument.length - 1, 1) == "2" && characters.substr(characters.length - 1, 1) == "2")
												{
													if (characters.substring(0, (argument.length - 1)) == argument.substr(0, (argument.length - 1)))
													{
														argument = CurrentCharacterRect.charids[counter];
														break;
													}
												} else
												{
													if (characters.substring(0, argument.length) == argument)
													{
														argument = CurrentCharacterRect.charids[counter];
														break;
													}
												}
												counter++;
											}
											if (parseInt(argument) > 0)
											{
												charId = parseInt(argument);
												if (argumentCounter == 1)
												{
													needServer = true;
												}
											} else
											{
												counter = 0;
												while (counter < Map.REALMS.length)
												{
													if (argument == Map.REALMS[counter].substring(0, argument.length).toLowerCase())
													{
														for each (var visited:String in PlayGameCommand.visited)
														{
															realm = visited.split(" ");
															if (realm[1] == Parameters.data_.preferredServer && realm[2] == Map.REALMS[counter])
															{
																gameId = Parameters.REALM_GAMEID;
																isRealm = true;
																break;
															}
														}
														break;
													}
													counter++;
												}
											}
										}
									}
								}
							}
							argumentCounter++;
						}
						if (needServer)
						{
							server = new Server();
							server.name = "";
							server.address = PlayGameCommand.curip;
							server.port = Parameters.PORT;
							gameId = Parameters.REALM_GAMEID;
						} else
						{
							if (!isRealm)
							{
								server = this.serverModel.getServerByName(Parameters.data_.preferredServer);
							} else
							{
								server = new Server();
								server.name = realm[1] + " " + realm[2];
								server.address = realm[0];
								server.port = Parameters.PORT;
							}
						}
						this.hudModel.gameSprite.gsc_.gs_.dispatchEvent(new ReconnectEvent(server, gameId, false, charId, -1, new ByteArray(), false));
						return (true);
					}
					return (false);
			}
		}

		private function listCommands():Boolean
		{
			var command:Array;
			var output:String;
			var value:int;
			command = this.data.match("^/sfadd ([\\w\\d]+)");
			if (command != null)
			{
				Parameters.data_.spamFilter.push(command[1]);
				this.addTextLine.dispatch(ChatMessage.make(Parameters.HELP_CHAT_NAME, ("Adding to spam text: " + command[1]), true));
				return (true);
			}
			command = this.data.match("^/sflist");
			if (command != null)
			{
				output = "List of filtered words: ";
				for each (var _local_28:String in Parameters.data_.spamFilter)
				{
					output = (output + (_local_28 + ", "));
				}
				this.addTextLine.dispatch(ChatMessage.make(Parameters.HELP_CHAT_NAME, (output.substring(0, (output.length - 2))), true));
				return (true);
			}
			command = this.data.match("^/sfclear");
			if (command != null)
			{
				Parameters.data_.spamFilter = new Vector.<String>();
				this.addTextLine.dispatch(ChatMessage.make(Parameters.HELP_CHAT_NAME, "Spam text cleared", true));
				return (true);
			}
			command = this.data.match("^/sfdefault");
			if (command != null)
			{
				Parameters.data_.spamFilter = Parameters.spamFilter;
				return (true);
			}
			command = this.data.match("^/iglist");
			if (command != null)
			{
				output = "Ignore List: ";
				for each (value in Parameters.data_.AAIgnore)
				{
					if (ObjectLibrary.xmlLibrary_[value])
					{
						output = (output + "(" + value + ") " + ObjectLibrary.xmlLibrary_[value].@id + ", ");
					} else
					{
						output = (output + "(" + value + "), ");
					}
				}
				this.addTextLine.dispatch(ChatMessage.make(Parameters.HELP_CHAT_NAME, output.substring(0, (output.length - 2)), true));
				return (true);
			}
			command = this.data.match("^/igclear");
			if (command != null)
			{
				Parameters.data_.AAIgnore.length = 0;
				Parameters.save();
				this.addTextLine.dispatch(ChatMessage.make(Parameters.HELP_CHAT_NAME, "Auto Aim Ignore List cleared", true));
				return (true);
			}
			command = this.data.match("^/exlist");
			if (command != null)
			{
				output = "Exception List: ";
				for each (value in Parameters.data_.AAException)
				{
					if (ObjectLibrary.xmlLibrary_[value])
					{
						output = (output + "(" + value + ") " + ObjectLibrary.xmlLibrary_[value].@id + ", ");
					} else
					{
						output = (output + "(" + value + "), ");
					}
				}
				this.addTextLine.dispatch(ChatMessage.make(Parameters.HELP_CHAT_NAME, output.substring(0, (output.length - 2)), true));
				return (true);
			}
			command = this.data.match("^/exclear");
			if (command != null)
			{
				Parameters.data_.AAException.length = 0;
				Parameters.save();
				this.addTextLine.dispatch(ChatMessage.make(Parameters.HELP_CHAT_NAME, "Auto Aim Exception List cleared", true));
				return (true);
			}
			command = this.data.match("^/igdefault");
			if (command != null)
			{
				Parameters.data_.AAIgnore = Parameters.DefaultAAIgnore;
				Parameters.save();
				this.addTextLine.dispatch(ChatMessage.make(Parameters.HELP_CHAT_NAME, "Auto Aim Ignore List set to default", true));
				return (true);
			}
			command = this.data.match("^/exdefault");
			if (command != null)
			{
				Parameters.data_.AAException = Parameters.DefaultAAException;
				Parameters.save();
				this.addTextLine.dispatch(ChatMessage.make(Parameters.HELP_CHAT_NAME, "Auto Aim Exception List set to default", true));
				return (true);
			}
			command = this.data.match("^/aig (\\d+)");
			if (command != null)
			{
				this.addTextLine.dispatch(ChatMessage.make("*Help*", MapUserInput.addIgnore(command[1]), true));
				return (true);
			}
			command = this.data.match("^/rig (\\d+)");
			if (command != null)
			{
				this.addTextLine.dispatch(ChatMessage.make("*Help*", MapUserInput.remIgnore(command[1]), true));
				return (true);
			}
			command = this.data.match("^/aex (\\d+)");
			if (command != null)
			{
				this.addTextLine.dispatch(ChatMessage.make("*Help*", MapUserInput.addException(command[1]), true));
				return (true);
			}
			command = this.data.match("^/rex (\\d+)");
			if (command != null)
			{
				this.addTextLine.dispatch(ChatMessage.make("*Help*", MapUserInput.remException(command[1]), true));
				return (true);
			}
			command = (this.data.match("^/lid") || this.data.match("^/lootindefault"));
			if (command != null)
			{
				Parameters.data_.autoLootIncludes = Parameters.defaultInclusions;
				this.addTextLine.dispatch(ChatMessage.make("AutoLoot", "Reset inclusions to default", true));
				Parameters.setAutolootDesireables();
				Parameters.save();
				return (true);
			}
			command = (this.data.match("^/lil") || this.data.match("^/lootinlist"));
			if (command != null)
			{
				this.addTextLine.dispatch(ChatMessage.make("AutoLoot", Parameters.handleLootInListCommand(), true));
				return (true);
			}
			command = (this.data.match("^/lia (\\w+)") || this.data.match("^/lootinadd (\\w+)"));
			if (command != null)
			{
				this.addTextLine.dispatch(ChatMessage.make("AutoLoot", Parameters.handleLootInAddCommand(command[1]), true));
				return (true);
			}
			command = (this.data.match("^/lir (\\w+)") || this.data.match("/^lootinrem (\\w+)"));
			if (command != null)
			{
				this.addTextLine.dispatch(ChatMessage.make("AutoLoot", Parameters.handleLootInRemCommand(command[1]), true));
				return (true);
			}
			command = (this.data.match("/led") || this.data.match("/lootexdefault"));
			if (command != null)
			{
				Parameters.data_.autoLootExcludes = Parameters.defaultExclusions;
				this.addTextLine.dispatch(ChatMessage.make("AutoLoot", "Reset exclusions to default", true));
				Parameters.setAutolootDesireables();
				Parameters.save();
				return (true);
			}
			command = (this.data.match("^/lel") || this.data.match("^/lootexlist"));
			if (command != null)
			{
				this.addTextLine.dispatch(ChatMessage.make("AutoLoot", Parameters.handleLootExListCommand(), true));
				return (true);
			}
			command = (this.data.match("^/lea (\\w+)") || this.data.match("^lootexadd (\\w+)"));
			if (command != null)
			{
				this.addTextLine.dispatch(ChatMessage.make("AutoLoot", Parameters.handleLootExAddCommand(command[1]), true));
				return (true);
			}
			command = (this.data.match("^/ler (\\w+)") || this.data.match("^/lootexrem (\\w+)"));
			if (command != null)
			{
				this.addTextLine.dispatch(ChatMessage.make("AutoLoot", Parameters.handleLootExRemCommand(command[1]), true));
				return (true);
			}
			return (false);
		}

		private function custMessages():Boolean
		{
			var _local_1:Array = this.data.match("^/setmsg (\\d) (.+)$");
			if (_local_1 == null)
			{
				return (false);
			}
			var _local_2:int = parseInt(_local_1[1]);
			var _local_3:String = "msg" + _local_1[1];
			if (_local_2 > 0 && _local_2 <= 9)
			{
				Parameters.data_[_local_3] = _local_1[2];
			}
			this.addTextLine.dispatch(ChatMessage.make(Parameters.HELP_CHAT_NAME, "Message #" + _local_1[1] + ' set to "' + _local_1[2] + '"', true));
			Parameters.save();
			return (true);
		}

		public function jumpToIP(_arg_1:String):void
		{
			this.enterGame.dispatch();
			var _local_3:SavedCharacter = this.player.getCharacterById(this.player.currentCharId);
			var _local_2:GameInitData = new GameInitData();
			_local_2.server = new Server();
			_local_2.server.port = Parameters.PORT;
			_local_2.server.setName(_arg_1);
			_local_2.server.address = _arg_1;
			_local_2.createCharacter = false;
			_local_2.charId = _local_3.charId();
			_local_2.isNewGame = true;
			this.playGame.dispatch(_local_2);
		}

		private function findSkinIndex(_arg_1:String):Array
		{
			var _local_2:Array;
			var _local_3:XML;
			var _local_4:int;
			var _local_5:String;
			var _local_6:String;
			var _local_7:XML;
			var _local_8:XMLList;
			var _local_9:Array = _arg_1.split(" ");
			var _local_10:int = int.MAX_VALUE;
			_local_7 = EmbeddedData.skinsXML;
			_local_8 = _local_7.children();
			for each (_local_3 in _local_8)
			{
				_local_2 = _local_3.@id.toLowerCase().split(" ");
				_local_4 = this.scoredMatch(_local_3.@id.toString().length, _local_9, _local_2);
				if (_local_4 < _local_10)
				{
					_local_10 = _local_4;
					_local_5 = _local_3.AnimatedTexture.File;
					_local_6 = _local_3.AnimatedTexture.Index;
				}
			}
			return ([_local_5, _local_6]);
		}

		private function getTex1(_arg_1:int):uint
		{
			var _local_2:XML = ObjectLibrary.xmlLibrary_[_arg_1];
			return (_local_2.Tex1);
		}

		private function findMatch2(_arg_1:String):int
		{
			var _local_2:Array;
			var _local_3:String;
			var _local_4:int;
			var _local_5:String;
			var _local_8:int;
			var _local_6:Vector.<String> = new <String>["def", "att", "spd", "dex", "vit", "wis", "ubhp"];
			var _local_7:Vector.<int> = new <int>[2592, 2591, 2593, 2636, 2612, 2613, 2985];
			while (_local_8 < _local_6.length)
			{
				if (_arg_1 == _local_6[_local_8])
				{
					return (_local_7[_local_8]);
				}
				_local_8++;
			}
			var _local_9:Array = _arg_1.split(" ");
			var _local_10:int = int.MAX_VALUE;
			for each (_local_3 in ObjectLibrary.itemLib)
			{
				_local_2 = _local_3.toLowerCase().split(" ");
				_local_4 = this.scoredMatch(_local_3.length, _local_9, _local_2);
				if (_local_4 < _local_10)
				{
					_local_10 = _local_4;
					_local_5 = _local_3;
				}
			}
			return (ObjectLibrary.idToType_[_local_5]);
		}

		private function scoredMatch(_arg_1:int, _arg_2:Array, _arg_3:Array):int
		{
			var _local_4:String;
			var _local_5:String;
			for each (_local_4 in _arg_3)
			{
				for each (_local_5 in _arg_2)
				{
					if (_local_4.substr(0, _local_5.length) == _local_5)
					{
						_arg_1 = (_arg_1 - (_local_5.length * 10));
					}
				}
			}
			return (_arg_1);
		}

		public function execute():void
		{
			var _local_1:Object;
			var _local_2:Object;
			var _local_3:uint;
			var _local_4:GameObject;
			var _local_5:String;
			var _local_6:String;
			if (!Parameters.ssmode)
			{
				if (this.cheatCommands())
				{
					return;
				}
				if (this.listCommands())
				{
					return;
				}
				if (this.custMessages())
				{
					return;
				}
			}
			switch (this.data)
			{
				case "/resetDailyQuests":
					if (this.player.isAdmin())
					{
						_local_1 = {};
						MoreObjectUtil.addToObject(_local_1, this.account.getCredentials());
						this.client.sendRequest("/dailyquest/resetDailyQuests", _local_1);
						this.addTextLine.dispatch(ChatMessage.make(Parameters.SERVER_CHAT_NAME, "Restarting daily quests. Please refresh game."));
					}
					return;
				case "/resetPackagePopup":
					Parameters.data_[PopupNamesConfig.PACKAGES_OFFER_POPUP] = null;
					return;
				case "/h":
				case "/help":
					this.addTextLine.dispatch(ChatMessage.make(Parameters.HELP_CHAT_NAME, TextKey.HELP_COMMAND));
					return;
				case "/c":
				case "/class":
				case "/classes":
					_local_2 = {};
					_local_3 = 0;
					for each (_local_4 in this.hudModel.gameSprite.map.goDict_)
					{
						if (_local_4.props_.isPlayer_)
						{
							_local_2[_local_4.objectType_] = ((_local_2[_local_4.objectType_] != undefined) ? (_local_2[_local_4.objectType_] + 1) : uint(1));
							_local_3++;
						}
					}
					_local_5 = "";
					for (_local_6 in _local_2)
					{
						_local_5 = (_local_5 + (((" " + ObjectLibrary.typeToDisplayId_[_local_6]) + ": ") + _local_2[_local_6]));
					}
					this.addTextLine.dispatch(ChatMessage.make("", "Classes online (" + _local_3 + "):" + _local_5));
					return;
				default:
					this.hudModel.gameSprite.gsc_.playerText(this.data);
			}
		}

	}
}//package kabam.rotmg.chat.control

