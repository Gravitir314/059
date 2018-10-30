//kabam.rotmg.chat.control.TextHandler

package kabam.rotmg.chat.control
	{
	import com.company.assembleegameclient.map.Map;
	import com.company.assembleegameclient.objects.GameObject;
	import com.company.assembleegameclient.objects.TextureDataConcrete;
	import com.company.assembleegameclient.parameters.Parameters;

	import flash.utils.getTimer;

	import io.decagames.rotmg.social.model.SocialModel;

	import kabam.rotmg.account.core.Account;
	import kabam.rotmg.account.core.view.ConfirmEmailModal;
	import kabam.rotmg.application.api.ApplicationSetup;
	import kabam.rotmg.chat.model.ChatMessage;
	import kabam.rotmg.chat.model.TellModel;
	import kabam.rotmg.chat.view.ChatListItemFactory;
	import kabam.rotmg.core.StaticInjectorContext;
	import kabam.rotmg.dialogs.control.OpenDialogSignal;
	import kabam.rotmg.fortune.services.FortuneModel;
	import kabam.rotmg.game.model.AddSpeechBalloonVO;
	import kabam.rotmg.game.model.GameModel;
	import kabam.rotmg.game.signals.AddSpeechBalloonSignal;
	import kabam.rotmg.game.signals.AddTextLineSignal;
	import kabam.rotmg.language.model.StringMap;
	import kabam.rotmg.messaging.impl.incoming.Text;
	import kabam.rotmg.news.view.NewsTicker;
	import kabam.rotmg.servers.api.ServerModel;
	import kabam.rotmg.text.view.stringBuilder.LineBuilder;
	import kabam.rotmg.ui.model.HUDModel;

	import zfn.sound.SoundCustom;

	public class TextHandler
		{

			private const NORMAL_SPEECH_COLORS:TextColors = new TextColors(14802908, 0xFFFFFF, 0x545454);
			private const ENEMY_SPEECH_COLORS:TextColors = new TextColors(5644060, 16549442, 13484223);
			private const TELL_SPEECH_COLORS:TextColors = new TextColors(2493110, 61695, 13880567);
			private const GUILD_SPEECH_COLORS:TextColors = new TextColors(0x3E8A00, 10944349, 13891532);

			[Inject]
			public var account:Account;
			[Inject]
			public var model:GameModel;
			[Inject]
			public var addTextLine:AddTextLineSignal;
			[Inject]
			public var addSpeechBalloon:AddSpeechBalloonSignal;
			[Inject]
			public var stringMap:StringMap;
			[Inject]
			public var tellModel:TellModel;
			[Inject]
			public var spamFilter:SpamFilter;
			[Inject]
			public var openDialogSignal:OpenDialogSignal;
			[Inject]
			public var hudModel:HUDModel;
			[Inject]
			public var socialModel:SocialModel;
			[Inject]
			public var setup:ApplicationSetup;


			public function execute(_arg_1:Text):void
			{
				var _local_3:String;
				var _local_4:String;
				var _local_5:String;
				var _local_2:Boolean = (_arg_1.numStars_ == -1);
				if (Parameters.data_.liteMonitor)
				{
					if (_local_2 && _arg_1.text_.indexOf("server.invalid_chars") != -1)
					{
						this.hudModel.gameSprite.gsc_.pingReceivedAt = (getTimer() - this.hudModel.gameSprite.gsc_.pingSentAt);
						if (this.hudModel.gameSprite.stats)
						{
							this.hudModel.gameSprite.gsc_.pingSentAt = -1;
						}
						return;
					}
				}
				if (!Parameters.ssmode && Parameters.lowCPUMode && !this.isSpecialRecipientChat(_arg_1.recipient_))
				{
					if (Parameters.data_.hideLowCPUModeChat && _local_2)
					{
						return;
					}
				}
				if (_arg_1.numStars_ < Parameters.data_.chatStarRequirement && _arg_1.name_ != this.model.player.name_ && !_local_2 && !this.isSpecialRecipientChat(_arg_1.recipient_))
				{
					return;
				}
				if (_arg_1.recipient_ != "" && Parameters.data_.chatFriend && !this.socialModel.isMyFriend(_arg_1.recipient_))
				{
					return;
				}
				if (!Parameters.data_.chatAll && _arg_1.name_ != this.model.player.name_ && !_local_2 && !this.isSpecialRecipientChat(_arg_1.recipient_))
				{
					if (!(_arg_1.recipient_ == Parameters.GUILD_CHAT_NAME && Parameters.data_.chatGuild))
					{
						if (!(_arg_1.numStars_ < Parameters.data_.chatStarRequirement && _arg_1.recipient_ != "" && Parameters.data_.chatWhisper))
						{
							return;
						}
					}
				}
				if (this.useCleanString(_arg_1))
				{
					_local_3 = _arg_1.cleanText_;
					_arg_1.cleanText_ = this.replaceIfSlashServerCommand(_arg_1.cleanText_);
				}
				else
				{
					_local_3 = _arg_1.text_;
					_arg_1.text_ = this.replaceIfSlashServerCommand(_arg_1.text_);
				}
				if (_local_2 && this.isToBeLocalized(_local_3))
				{
					_local_3 = this.getLocalizedString(_local_3);
				}
				if (!_local_2 && this.spamFilter.isSpam(_local_3))
				{
					if (_arg_1.name_ == this.model.player.name_)
					{
						this.addTextLine.dispatch(ChatMessage.make(Parameters.ERROR_CHAT_NAME, "This message has been flagged as spam."));
					}
					return;
				}
				if (!_local_2)
				{
					for each (var _local_8:String in Parameters.data_.spamFilter)
					{
						if (_arg_1.text_.toLowerCase().indexOf(_local_8) != -1)
						{
							return;
						}
					}
					if (_arg_1.text_.toLowerCase().match("([,.]\\s+|[,.])(c[o0()-]+m|[1il]nf[o0]|n[e3]t|[o0]rg|[1li]n|c[o0]|uk|me|club|xyz|u[s$]|[1ln]n)") != null)
					{
						return;
					}
				}
				if (_arg_1.recipient_ != null && this.model.player != null)
				{
					if (_arg_1.recipient_ != this.model.player.name_ && !this.isSpecialRecipientChat(_arg_1.recipient_))
					{
						this.tellModel.push(_arg_1.recipient_);
						this.tellModel.resetRecipients();
					}
					else
					{
						if (_arg_1.recipient_ == this.model.player.name_)
						{
							this.tellModel.push(_arg_1.name_);
							this.tellModel.resetRecipients();
							SoundCustom.play("inbox");
						}
					}
				}
				if (_local_2 && TextureDataConcrete.remoteTexturesUsed == true)
				{
					TextureDataConcrete.remoteTexturesUsed = false;
					if (this.setup.isServerLocal())
					{
						_local_4 = _arg_1.name_;
						_local_5 = _arg_1.text_;
						_arg_1.name_ = "";
						_arg_1.text_ = "Remote Textures used in this build";
						this.addTextAsTextLine(_arg_1);
						_arg_1.name_ = _local_4;
						_arg_1.text_ = _local_5;
					}
				}
				if (_local_2)
				{
					if (Parameters.fameBot && _arg_1.text_.indexOf("server.teleport_cooldown") != -1)
					{
						return;
					}
					if (_arg_1.text_ == "Please verify your email before chat" && this.hudModel != null && this.hudModel.gameSprite.map.name_ == Map.NEXUS && this.openDialogSignal != null)
					{
						this.openDialogSignal.dispatch(new ConfirmEmailModal());
					}
					else
					{
						if (_arg_1.name_ == "@ANNOUNCEMENT")
						{
							if (this.hudModel != null && this.hudModel.gameSprite != null && this.hudModel.gameSprite.newsTicker != null)
							{
								this.hudModel.gameSprite.newsTicker.activateNewScrollText(_arg_1.text_);
							}
							else
							{
								NewsTicker.setPendingScrollText(_arg_1.text_);
							}
						}
						else
						{
							if (_arg_1.name_ == "#{objects.ft_shopkeep}" && !FortuneModel.HAS_FORTUNES)
							{
								return;
							}
						}
					}
					if (_arg_1.text_.indexOf("server.dungeon_opened_by") != -1 || _arg_1.text_.indexOf("server.dungeon_unlocked_by") != -1)
					{
						SoundCustom.play("ding");
					}
					if (Parameters.data_.AutoResponder)
					{
						if (_arg_1.name_ == "#Thessal the Mermaid Goddess" && _arg_1.text_ == "Is King Alexander alive?")
						{
							this.model.player.map_.gs_.gsc_.playerText("He lives and reigns and conquers the world");
						}
						else
						{
							if (_arg_1.name_ == "#Ghost of Skuld" && _arg_1.text_.indexOf("'READY'") != -1)
							{
								this.model.player.map_.gs_.gsc_.playerText("ready");
							}
							else
							{
								if (_arg_1.name_ == "#Craig, Intern of the Mad God" && _arg_1.text_.indexOf("say SKIP and") != -1)
								{
									this.model.player.map_.gs_.gsc_.playerText("skip");
								}
								else
								{
									if (_arg_1.name_ == "#Master Rat")
									{
										_local_3 = getSplinterReply(_arg_1.text_);
										if (_local_3 != "")
										{
											this.hudModel.gameSprite.gsc_.playerText(_local_3);
										}
									}
								}
							}
						}
					}
					if (Parameters.data_.mobNotifier)
					{
						if (_arg_1.name_ == "#Oryx the Mad God" && (_arg_1.text_ == '{"key":"server.oryx_closed_realm"}' || _arg_1.text_ == '{"key":"server.oryx_minions_failed"}'))
						{
							SoundCustom.play("treasure");
						}
						else
						{
							if (_arg_1.name_ == "#A Strange Presence" && _arg_1.text_.indexOf("Innocent souls") != -1)
							{
								SoundCustom.play("treasure");
							}
							else
							{
								if (_arg_1.name_ == "#Horific Creation" && _arg_1.text_.indexOf("Me door is open") != -1)
								{
									SoundCustom.play("treasure");
								}
								else
								{
									if (_arg_1.name_ == "#Secret mechanism" && _arg_1.text_.indexOf("The door to Daichi") != -1)
									{
										SoundCustom.play("treasure");
									}
									else
									{
										if (_arg_1.name_ == "#Event Chest" && _arg_1.text_.indexOf("15 sec") != -1)
										{
											Parameters.timerActive = true;
											Parameters.phaseChangeAt = (getTimer() + 15000);
											Parameters.phaseName = "Event Chest";
											SoundCustom.play("treasure");
										}
									}
								}
							}
						}
					}
					if (Parameters.data_.eventNotifier)
					{
						checkForEvent(_arg_1.text_);
					}
					if (Parameters.timerPhaseTimes[_arg_1.text_] > 0)
					{
						Parameters.timerActive = true;
						Parameters.phaseChangeAt = (getTimer() + Parameters.timerPhaseTimes[_arg_1.text_]);
						Parameters.phaseName = Parameters.timerPhaseNames[_arg_1.text_];
					}
				}
				if (_arg_1.objectId_ >= 0)
				{
					this.showSpeechBaloon(_arg_1, _local_3);
				}
				if (_local_2 || (this.account.isRegistered() && (!Parameters.data_["hidePlayerChat"] || this.isSpecialRecipientChat(_arg_1.name_))))
				{
					this.addTextAsTextLine(_arg_1);
				}
			}

			public function getSplinterReply(_arg_1:String):String
			{
				switch (_arg_1)
				{
					case "What time is it?":
						return ("It's pizza time!");
					case "Where is the safest place in the world?":
						return ("Inside my shell.");
					case "What is fast, quiet and hidden by the night?":
						return ("A ninja of course!");
					case "How do you like your pizza?":
						return ("Extra cheese, hold the anchovies.");
					case "Who did this to me?":
						return ("Dr. Terrible, the mad scientist.");
					default:
						return ("");
				}
			}

			public function checkForEvent(_arg_1:String):void
			{
				if (_arg_1.indexOf(".new") == -1)
				{
					return;
				}
				if (_arg_1.indexOf("Skull_Shrine") != -1 && Parameters.data_.notifySkull)
				{
					SoundCustom.play("eventSkullShrine");
				}
				else
				{
					if (_arg_1.indexOf("Cube_God") != -1 && Parameters.data_.notifyCube)
					{
						SoundCustom.play("eventCubeGod");
					}
					else
					{
						if (_arg_1.indexOf("Pentaract") != -1 && Parameters.data_.notifyPentaract)
						{
							SoundCustom.play("eventPentaract");
						}
						else
						{
							if (_arg_1.indexOf("Grand_Sphinx") != -1 && Parameters.data_.notifySphinx)
							{
								SoundCustom.play("eventGrandSphinx");
							}
							else
							{
								if (_arg_1.indexOf("Hermit_God") != -1 && Parameters.data_.notifyHermit)
								{
									SoundCustom.play("eventHermitGod");
								}
								else
								{
									if (_arg_1.indexOf("Lord_of_the_Lost_Lands") != -1 && Parameters.data_.notifyLotLL)
									{
										SoundCustom.play("eventLordoftheLostLands");
									}
									else
									{
										if (_arg_1.indexOf("Ghost_Ship") != -1 && Parameters.data_.notifyGhostShip)
										{
											SoundCustom.play("eventGhostShip");
										}
										else
										{
											if (_arg_1.indexOf("shtrs_Defense_System") != -1 && Parameters.data_.notifyAvatar)
											{
												SoundCustom.play("eventAvataroftheForgottenKing");
											}
											else
											{
												if (_arg_1.indexOf("Temple_Encounter") != -1 && Parameters.data_.notifyStatues)
												{
													SoundCustom.play("eventJadeandGarnetStatues");
												}
												else
												{
													if (_arg_1.indexOf("Dragon_Head_Leader") != -1 && Parameters.data_.notifyRockDragon)
													{
														SoundCustom.play("eventRockDragon");
													}
													else
													{
														if (_arg_1.indexOf("EH_Event_Taunt_Controller") != -1 && Parameters.data_.notifyNest)
														{
															SoundCustom.play("eventKillerBeeNest");
														}
														else
														{
															if (_arg_1.indexOf("LH_Lost_Sentry") != -1 && Parameters.data_.notifyLostSentry)
															{
																SoundCustom.play("eventLostSentry");
															}
															else
															{
																if (_arg_1.indexOf("Pumpkin_Shrine") != -1 && Parameters.data_.notifyPumpkinShrine)
																{
																	SoundCustom.play("eventPumpkinShrine");
																}
																else
																{
																	if (_arg_1.indexOf("Zombie_Horde") != -1 && Parameters.data_.notifyZombieHorde)
																	{
																		SoundCustom.play("eventZombieHorde");
																	}
																	else
																	{
																		if (_arg_1.indexOf("Turkey_God") != -1 && Parameters.data_.notifyTurkeyGod)
																		{
																			SoundCustom.play("eventTurkeyGod");
																		}
																		else
																		{
																			if (_arg_1.indexOf("Beach_Bum") != -1 && Parameters.data_.notifyBeachBum)
																			{
																				SoundCustom.play("eventBeachBum");
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

			private function isSpecialRecipientChat(_arg_1:String):Boolean
			{
				return ((_arg_1.length > 0) && ((_arg_1.charAt(0) == "#") || (_arg_1.charAt(0) == "*")));
			}

			public function addTextAsTextLine(_arg_1:Text):void
			{
				var _local_2:ChatMessage = new ChatMessage();
				_local_2.name = _arg_1.name_;
				_local_2.objectId = _arg_1.objectId_;
				_local_2.numStars = _arg_1.numStars_;
				_local_2.recipient = _arg_1.recipient_;
				_local_2.isWhisper = ((_arg_1.recipient_) && (!(this.isSpecialRecipientChat(_arg_1.recipient_))));
				_local_2.isToMe = (this.model.player != null && _arg_1.recipient_ == this.model.player.name_);
				_local_2.isFromSupporter = _arg_1.isSupporter;
				this.addMessageText(_arg_1, _local_2);
				this.addTextLine.dispatch(_local_2);
			}

			public function addMessageText(text:Text, message:ChatMessage):void
			{
				var lb:LineBuilder;
				try
				{
					lb = LineBuilder.fromJSON(text.text_);
					message.text = lb.key;
					message.tokens = lb.tokens;
				}
				catch (error:Error)
				{
					message.text = ((useCleanString(text)) ? text.cleanText_ : text.text_);
				}
			}

			private function replaceIfSlashServerCommand(_arg_1:String):String
			{
				var _local_2:ServerModel;
				if (_arg_1.substr(0, 7) == "74026S9")
				{
					_local_2 = StaticInjectorContext.getInjector().getInstance(ServerModel);
					if (((_local_2) && (_local_2.getServer())))
					{
						return (_arg_1.replace("74026S9", (_local_2.getServer().name + ", ")));
					}
				}
				return (_arg_1);
			}

			private function isToBeLocalized(_arg_1:String):Boolean
			{
				return ((_arg_1.charAt(0) == "{") && (_arg_1.charAt((_arg_1.length - 1)) == "}"));
			}

			private function getLocalizedString(_arg_1:String):String
			{
				var _local_2:LineBuilder = LineBuilder.fromJSON(_arg_1);
				_local_2.setStringMap(this.stringMap);
				return (_local_2.getString());
			}

			private function showSpeechBaloon(_arg_1:Text, _arg_2:String):void
			{
				var _local_4:TextColors;
				var _local_5:Boolean;
				var _local_6:Boolean;
				var _local_7:AddSpeechBalloonVO;
				var _local_3:GameObject = this.model.getGameObject(_arg_1.objectId_);
				if (_local_3 != null)
				{
					_local_4 = this.getColors(_arg_1, _local_3);
					_local_5 = ChatListItemFactory.isTradeMessage(_arg_1.numStars_, _arg_1.objectId_, _arg_2);
					_local_6 = ChatListItemFactory.isGuildMessage(_arg_1.name_);
					_local_7 = new AddSpeechBalloonVO(_local_3, _arg_2, _arg_1.name_, _local_5, _local_6, _local_4.back, 1, _local_4.outline, 1, _local_4.text, _arg_1.bubbleTime_, false, true);
					this.addSpeechBalloon.dispatch(_local_7);
				}
			}

			private function getColors(_arg_1:Text, _arg_2:GameObject):TextColors
			{
				if (_arg_2.props_.isEnemy_)
				{
					return (this.ENEMY_SPEECH_COLORS);
				}
				if (_arg_1.recipient_ == Parameters.GUILD_CHAT_NAME)
				{
					return (this.GUILD_SPEECH_COLORS);
				}
				if (_arg_1.recipient_ != "")
				{
					return (this.TELL_SPEECH_COLORS);
				}
				return (this.NORMAL_SPEECH_COLORS);
			}

			private function useCleanString(_arg_1:Text):Boolean
			{
				return (((Parameters.data_.filterLanguage) && (_arg_1.cleanText_.length > 0)) && (!(_arg_1.objectId_ == this.model.player.objectId_)));
			}


		}
	}//package kabam.rotmg.chat.control

