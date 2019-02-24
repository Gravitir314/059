//com.company.assembleegameclient.ui.options.Options

package com.company.assembleegameclient.ui.options
	{
    import com.company.assembleegameclient.game.GameSprite;
    import com.company.assembleegameclient.objects.Player;
    import com.company.assembleegameclient.parameters.Parameters;
    import com.company.assembleegameclient.screens.TitleMenuOption;
    import com.company.assembleegameclient.sound.Music;
    import com.company.assembleegameclient.sound.SFX;
    import com.company.assembleegameclient.ui.StatusBar;
    import com.company.assembleegameclient.util.TextureRedrawer;
    import com.company.assembleegameclient.util.redrawers.GlowRedrawer;
    import com.company.rotmg.graphics.ScreenGraphic;
    import com.company.util.AssetLibrary;
    import com.company.util.KeyCodes;
    import com.greensock.plugins.DropShadowFilterPlugin;

    import flash.display.BitmapData;
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.display.StageDisplayState;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.events.MouseEvent;
    import flash.geom.Point;
    import flash.net.URLRequest;
    import flash.net.URLRequestMethod;
    import flash.net.navigateToURL;
    import flash.system.Capabilities;
    import flash.text.TextFieldAutoSize;
    import flash.ui.Mouse;
    import flash.ui.MouseCursor;
    import flash.ui.MouseCursorData;

    import io.decagames.rotmg.ui.scroll.UIScrollbar;

    import kabam.rotmg.core.StaticInjectorContext;
    import kabam.rotmg.dialogs.control.CloseDialogsSignal;
    import kabam.rotmg.game.view.components.StatView;
    import kabam.rotmg.text.model.TextKey;
    import kabam.rotmg.text.view.TextFieldDisplayConcrete;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;
    import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
    import kabam.rotmg.text.view.stringBuilder.StringBuilder;
    import kabam.rotmg.ui.UIUtils;
    import kabam.rotmg.ui.signals.ToggleShowTierTagSignal;

    public class Options extends Sprite
		{
			public static const Y_POSITION:int = 550;
            public static const SCROLL_HEIGHT:int = 420;
            public static const SCROLL_Y_OFFSET:int = 102;
			public static const CHAT_COMMAND:String = "chatCommand";
			public static const CHAT:String = "chat";
			public static const TELL:String = "tell";
			public static const GUILD_CHAT:String = "guildChat";
			public static const SCROLL_CHAT_UP:String = "scrollChatUp";
			public static const SCROLL_CHAT_DOWN:String = "scrollChatDown";
            private static const TABS:Vector.<String> = new <String>[TextKey.OPTIONS_CONTROLS, TextKey.OPTIONS_HOTKEYS, TextKey.OPTIONS_CHAT, TextKey.OPTIONS_GRAPHICS, TextKey.OPTIONS_SOUND, TextKey.OPTIONS_FRIEND, TextKey.OPTIONS_MISC];
			private static var registeredCursors:Vector.<String> = new Vector.<String>(0);

			private var gs_:GameSprite;
			private var continueButton_:TitleMenuOption;
			private var resetToDefaultsButton_:TitleMenuOption;
			private var homeButton_:TitleMenuOption;
			private var tabs_:Vector.<OptionsTabTitle> = new Vector.<OptionsTabTitle>();
			private var selected_:OptionsTabTitle;
			private var options_:Vector.<Sprite> = new Vector.<Sprite>();
            private var scroll:UIScrollbar;
            private var scrollContainer:Sprite;
            private var scrollContainerBottom:Shape;
			private var defaultTab_:OptionsTabTitle;

			public function Options(_arg_1:GameSprite)
			{
				var TABS:Vector.<String>;
				var _local_2:TextFieldDisplayConcrete;
				var _local_6:OptionsTabTitle;
				var _local_7:OptionsTabTitle;
				if (Parameters.ssmode)
				{
					if (UIUtils.SHOW_EXPERIMENTAL_MENU)
					{
						TABS = new <String>[TextKey.OPTIONS_CONTROLS, TextKey.OPTIONS_HOTKEYS, TextKey.OPTIONS_CHAT, TextKey.OPTIONS_GRAPHICS, TextKey.OPTIONS_SOUND, TextKey.OPTIONS_FRIEND, TextKey.OPTIONS_MISC, "Experimental"];
					}
					else
					{
						TABS = new <String>[TextKey.OPTIONS_CONTROLS, TextKey.OPTIONS_HOTKEYS, TextKey.OPTIONS_CHAT, TextKey.OPTIONS_GRAPHICS, TextKey.OPTIONS_SOUND, TextKey.OPTIONS_FRIEND, TextKey.OPTIONS_MISC];
					}
				}
				else
				{
					TABS = new <String>[TextKey.OPTIONS_CONTROLS, TextKey.OPTIONS_HOTKEYS, TextKey.OPTIONS_CHAT, TextKey.OPTIONS_GRAPHICS, TextKey.OPTIONS_SOUND, TextKey.OPTIONS_FRIEND, "Event", "Experimental", "Debuffs", "Auto", "Loot", "World", "Recon|Msg", "Visual", "Fame", "Other"];
				}
				super();
				this.gs_ = _arg_1;
				graphics.clear();
				graphics.beginFill(0x2B2B2B, 0.8);
				graphics.drawRect(0, 0, 800, 600);
				graphics.endFill();
				graphics.lineStyle(1, 0x5E5E5E);
				graphics.moveTo(0, 100);
				graphics.lineTo(800, 100);
				graphics.lineStyle();
				_local_2 = new TextFieldDisplayConcrete().setSize(36).setColor(0xFFFFFF);
				_local_2.setBold(true);
				_local_2.setStringBuilder(new LineBuilder().setParams(TextKey.OPTIONS_TITLE));
				_local_2.setAutoSize(TextFieldAutoSize.CENTER);
				_local_2.filters = [DropShadowFilterPlugin.DEFAULT_FILTER];
				_local_2.x = ((800 / 2) - (_local_2.width / 2));
				_local_2.y = 8;
				addChild(_local_2);
				addChild(new ScreenGraphic());
				this.continueButton_ = new TitleMenuOption(TextKey.OPTIONS_CONTINUE_BUTTON, 36, false);
				this.continueButton_.setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
				this.continueButton_.setAutoSize(TextFieldAutoSize.CENTER);
				this.continueButton_.addEventListener(MouseEvent.CLICK, this.onContinueClick);
				addChild(this.continueButton_);
				this.resetToDefaultsButton_ = new TitleMenuOption(TextKey.OPTIONS_RESET_TO_DEFAULTS_BUTTON, 22, false);
				this.resetToDefaultsButton_.setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
				this.resetToDefaultsButton_.setAutoSize(TextFieldAutoSize.LEFT);
				this.resetToDefaultsButton_.addEventListener(MouseEvent.CLICK, this.onResetToDefaultsClick);
				addChild(this.resetToDefaultsButton_);
				this.homeButton_ = new TitleMenuOption(TextKey.OPTIONS_HOME_BUTTON, 22, false);
				this.homeButton_.setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
				this.homeButton_.setAutoSize(TextFieldAutoSize.RIGHT);
				this.homeButton_.addEventListener(MouseEvent.CLICK, this.onHomeClick);
				addChild(this.homeButton_);
				var _local_3:int = 14;
				var _local_4:int;
				while (_local_4 < TABS.length)
				{
					_local_7 = new OptionsTabTitle(TABS[_local_4]);
					_local_7.x = _local_3;
					if (Parameters.ssmode)
					{
						_local_7.y = 70;
						_local_3 = (_local_3 + ((UIUtils.SHOW_EXPERIMENTAL_MENU) ? 90 : 108));
					}
					else
					{
						_local_7.y = (50 + (25 * int((_local_4 / 8))));
						if ((_local_4 % 8) == 0)
						{
							_local_3 = 14;
							_local_7.x = _local_3;
						}
						_local_3 = (_local_3 + 94);
						if (_local_7.text_ == Parameters.data_.lastTab)
						{
							_local_6 = _local_7;
						}
					}
					addChild(_local_7);
					_local_7.addEventListener(MouseEvent.CLICK, this.onTabClick);
					this.tabs_.push(_local_7);
					_local_4++;
				}
				if (_local_6 != null)
				{
					this.defaultTab_ = _local_6;
				}
				else
				{
					this.defaultTab_ = this.tabs_[0];
				}
				addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
				addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
				var _local_5:CloseDialogsSignal = StaticInjectorContext.getInjector().getInstance(CloseDialogsSignal);
				_local_5.dispatch();
                this.createScrollWindow();
			}

			private static function makePotionBuy():ChoiceOption
			{
				return (new ChoiceOption("contextualPotionBuy", makeOnOffLabels(), [true, false], TextKey.OPTIONS_CONTEXTUAL_POTION_BUY, TextKey.OPTIONS_CONTEXTUAL_POTION_BUY_DESC, null));
			}

			private static function makeOnOffLabels():Vector.<StringBuilder>
			{
				return (new <StringBuilder>[makeLineBuilder(TextKey.OPTIONS_ON), makeLineBuilder(TextKey.OPTIONS_OFF)]);
			}

			private static function makeHighLowLabels():Vector.<StringBuilder>
			{
				return (new <StringBuilder>[new StaticStringBuilder("High"), new StaticStringBuilder("Low")]);
			}

			private static function makeHpBarLabels():Vector.<StringBuilder>
			{
				return (new <StringBuilder>[new StaticStringBuilder("Off"), new StaticStringBuilder("All"), new StaticStringBuilder("Enemy"), new StaticStringBuilder("Self & En."), new StaticStringBuilder("Self"), new StaticStringBuilder("Ally")]);
			}

			private static function makeForceExpLabels():Vector.<StringBuilder>
			{
				return (new <StringBuilder>[new StaticStringBuilder("Off"), new StaticStringBuilder("On"), new StaticStringBuilder("Self")]);
			}

			private static function makeAllyShootLabels():Vector.<StringBuilder>
			{
				return (new <StringBuilder>[new StaticStringBuilder("Off"), new StaticStringBuilder("All"), new StaticStringBuilder("Proj")]);
			}

			private static function makeBarTextLabels():Vector.<StringBuilder>
			{
				return (new <StringBuilder>[new StaticStringBuilder("Off"), new StaticStringBuilder("All"), new StaticStringBuilder("Fame"), new StaticStringBuilder("HP/MP")]);
			}

			private static function makeStarSelectLabels():Vector.<StringBuilder>
			{
				return (new <StringBuilder>[new StaticStringBuilder("Off"), new StaticStringBuilder("1"), new StaticStringBuilder("2"), new StaticStringBuilder("3"), new StaticStringBuilder("5"), new StaticStringBuilder("10")]);
			}

			private static function makeSupportLabels():Vector.<StringBuilder>
			{
				return (new <StringBuilder>[new StaticStringBuilder("Default"), new StaticStringBuilder("Blue"), new StaticStringBuilder("Purple"), new StaticStringBuilder("Orange")]);
			}

			private static function makeCursorSelectLabels():Vector.<StringBuilder>
			{
				return (new <StringBuilder>[new StaticStringBuilder("Off"), new StaticStringBuilder("ProX"), new StaticStringBuilder("X2"), new StaticStringBuilder("X3"), new StaticStringBuilder("X4"), new StaticStringBuilder("Corner1"), new StaticStringBuilder("Corner2"), new StaticStringBuilder("Symb"), new StaticStringBuilder("Alien"), new StaticStringBuilder("Xhair"), new StaticStringBuilder("Chusto1"), new StaticStringBuilder("Chusto2")]);
			}

			private static function makeLineBuilder(_arg_1:String):LineBuilder
			{
				return (new LineBuilder().setParams(_arg_1));
			}

			private static function makeClickForGold():ChoiceOption
			{
				return (new ChoiceOption("clickForGold", makeOnOffLabels(), [true, false], TextKey.OPTIONS_CLICK_FOR_GOLD, TextKey.OPTIONS_CLICK_FOR_GOLD_DESC, null));
			}

			private static function onUIQualityToggle():void
			{
				UIUtils.toggleQuality(Parameters.data_.uiQuality);
			}

			private static function onBarTextToggle():void
			{
				StatusBar.barTextSignal.dispatch(Parameters.data_.toggleBarText);
			}

			private static function onToMaxTextToggle():void
			{
				StatusBar.barTextSignal.dispatch(Parameters.data_.toggleBarText);
				StatView.toMaxTextSignal.dispatch(Parameters.data_.toggleToMaxText);
			}

			public static function refreshCursor():void
			{
				var _local_1:MouseCursorData;
				var _local_2:Vector.<BitmapData>;
				if (Parameters.data_.cursorSelect != MouseCursor.AUTO && registeredCursors.indexOf(Parameters.data_.cursorSelect) == -1)
				{
					_local_1 = new MouseCursorData();
					_local_1.hotSpot = new Point(15, 15);
					_local_2 = new Vector.<BitmapData>(1, true);
					_local_2[0] = AssetLibrary.getImageFromSet("cursorsEmbed", int(Parameters.data_.cursorSelect));
					_local_1.data = _local_2;
					Mouse.registerCursor(Parameters.data_.cursorSelect, _local_1);
					registeredCursors.push(Parameters.data_.cursorSelect);
				}
				Mouse.cursor = Parameters.data_.cursorSelect;
			}

			private static function makeDegreeOptions():Vector.<StringBuilder>
			{
				return (new <StringBuilder>[new StaticStringBuilder("45°"), new StaticStringBuilder("0°")]);
			}

			private static function onDefaultCameraAngleChange():void
			{
				Parameters.data_.cameraAngle = Parameters.data_.defaultCameraAngle;
				Parameters.save();
			}

			public static function calculateIgnoreBitmask():void
			{
				var _local_1:uint;
				var _local_2:uint;
				var _local_3:uint;
				if (Parameters.data_.ignoreQuiet)
				{
					_local_1 = (_local_1 | (1 << 2));
				}
				if (Parameters.data_.ignoreWeak)
				{
					_local_1 = (_local_1 | (1 << 3));
				}
				if (Parameters.data_.ignoreSlowed)
				{
					_local_1 = (_local_1 | (1 << 4));
				}
				if (Parameters.data_.ignoreSick)
				{
					_local_1 = (_local_1 | (1 << 5));
				}
				if (Parameters.data_.ignoreDazed)
				{
					_local_1 = (_local_1 | (1 << 6));
				}
				if (Parameters.data_.ignoreStunned)
				{
					_local_1 = (_local_1 | (1 << 7));
				}
				if (Parameters.data_.ignoreParalyzed)
				{
					_local_1 = (_local_1 | (1 << 14));
				}
				if (Parameters.data_.ignoreBleeding)
				{
					_local_1 = (_local_1 | (1 << 16));
				}
				if (Parameters.data_.ignoreArmorBroken)
				{
					_local_1 = (_local_1 | (1 << 27));
				}
				if (Parameters.data_.ignorePetStasis)
				{
					_local_1 = (_local_1 | (1 << 22));
				}
				if (Parameters.data_.ignorePetrified)
				{
					_local_2 = (_local_2 | 0x08);
				}
				if (Parameters.data_.ignoreSilenced)
				{
					_local_2 = (_local_2 | 0x010000);
				}
				if (Parameters.data_.ignoreBlind)
				{
					_local_3 = (_local_3 | (1 << 8));
				}
				if (Parameters.data_.ignoreHallucinating)
				{
					_local_3 = (_local_3 | (1 << 9));
				}
				if (Parameters.data_.ignoreDrunk)
				{
					_local_3 = (_local_3 | (1 << 10));
				}
				if (Parameters.data_.ignoreConfused)
				{
					_local_3 = (_local_3 | (1 << 11));
				}
				if (Parameters.data_.ignoreUnstable)
				{
					_local_3 = (_local_3 | (1 << 30));
				}
				if (Parameters.data_.ignoreDarkness)
				{
					_local_3 = (_local_3 | (1 << 31));
				}
				Parameters.data_.ssdebuffBitmask = _local_1;
				Parameters.data_.ssdebuffBitmask2 = _local_2;
				Parameters.data_.ccdebuffBitmask = _local_3;
			}

			private static function chatLengthLabels():Vector.<StringBuilder>
			{
				return (new <StringBuilder>[new StaticStringBuilder("1"), new StaticStringBuilder("2"), new StaticStringBuilder("3"), new StaticStringBuilder("4"), new StaticStringBuilder("5"), new StaticStringBuilder("6"), new StaticStringBuilder("7"), new StaticStringBuilder("8"), new StaticStringBuilder("9"), new StaticStringBuilder("10"), new StaticStringBuilder("11"), new StaticStringBuilder("12"), new StaticStringBuilder("13"), new StaticStringBuilder("14"), new StaticStringBuilder("15"), new StaticStringBuilder("16"), new StaticStringBuilder("17"), new StaticStringBuilder("18"), new StaticStringBuilder("19"), new StaticStringBuilder("20")]);
			}

			private static function makeRightClickOptions():Vector.<StringBuilder>
			{
				return (new <StringBuilder>[new StaticStringBuilder("Off"), new StaticStringBuilder("Quest"), new StaticStringBuilder("Ability"), new StaticStringBuilder("Camera")]);
			}

			private function AutoNexusValues():Vector.<StringBuilder>
			{
				return (new <StringBuilder>[new StaticStringBuilder("Off"), new StaticStringBuilder("5%"), new StaticStringBuilder("10%"), new StaticStringBuilder("15%"), new StaticStringBuilder("20%"), new StaticStringBuilder("25%"), new StaticStringBuilder("30%"), new StaticStringBuilder("35%"), new StaticStringBuilder("40%"), new StaticStringBuilder("45%"), new StaticStringBuilder("50%"), new StaticStringBuilder("60%")]);
			}

			private function stopWalkValues():Vector.<StringBuilder>
			{
				return (null);
			}

			private function reqHealValues():Vector.<StringBuilder>
			{
				return (new <StringBuilder>[new StaticStringBuilder("20%"), new StaticStringBuilder("25%"), new StaticStringBuilder("30%"), new StaticStringBuilder("35%"), new StaticStringBuilder("40%"), new StaticStringBuilder("45%"), new StaticStringBuilder("50%"), new StaticStringBuilder("55%"), new StaticStringBuilder("60%"), new StaticStringBuilder("65%"), new StaticStringBuilder("70%"), new StaticStringBuilder("75%"), new StaticStringBuilder("80%"), new StaticStringBuilder("85%"), new StaticStringBuilder("90%"), new StaticStringBuilder("95%"), new StaticStringBuilder("100%")]);
			}

			private function fbContinueValues():Vector.<StringBuilder>
			{
				return (new <StringBuilder>[new StaticStringBuilder("Off"), new StaticStringBuilder("Recon"), new StaticStringBuilder("Walk")]);
			}

            private function createScrollWindow():void
            {
                this.scrollContainerBottom = new Shape();
                this.scrollContainerBottom.graphics.beginFill(0xCCFF00, 0);
                this.scrollContainerBottom.graphics.drawRect(0, 0, 800, 60);
                var _local_1:Shape = new Shape();
                _local_1.graphics.beginFill(0xCCFF00, 0.6);
                _local_1.graphics.drawRect(0, SCROLL_Y_OFFSET, 800, SCROLL_HEIGHT);
                addChild(_local_1);
                this.scrollContainer = new Sprite();
                this.scrollContainer.mask = _local_1;
                addChild(this.scrollContainer);
                this.scroll = new UIScrollbar(SCROLL_HEIGHT);
                this.scroll.mouseRollSpeedFactor = 1.5;
                this.scroll.content = this.scrollContainer;
                this.scroll.x = 780;
                this.scroll.y = SCROLL_Y_OFFSET;
                this.scroll.visible = false;
                addChild(this.scroll);
            }

			private function onContinueClick(_arg_1:MouseEvent):void
			{
				this.close();
			}

			private function onResetToDefaultsClick(_arg_1:MouseEvent):void
			{
				var _local_3:BaseOption;
				var _local_2:int;
				while (_local_2 < this.options_.length)
				{
					_local_3 = (this.options_[_local_2] as BaseOption);
					if (_local_3 != null)
					{
						delete Parameters.data_[_local_3.paramName_];
					}
					_local_2++;
				}
				Parameters.setDefaults();
				Parameters.save();
				this.refresh();
			}

			private function onHomeClick(_arg_1:MouseEvent):void
			{
				this.close();
				Parameters.fameBot = false;
				this.gs_.closed.dispatch();
			}

			private function onTabClick(_arg_1:MouseEvent):void
			{
				var _local_2:OptionsTabTitle = (_arg_1.currentTarget as OptionsTabTitle);
				Parameters.data_.lastTab = _local_2.text_;
				this.setSelected(_local_2);
			}

			private function setSelected(_arg_1:OptionsTabTitle):void
			{
				if (_arg_1 == this.selected_)
				{
					return;
				}
				if (this.selected_ != null)
				{
					this.selected_.setSelected(false);
				}
				this.selected_ = _arg_1;
				this.selected_.setSelected(true);
				this.removeOptions();
                this.scrollContainer.y = 0;
				switch (this.selected_.text_)
				{
					case TextKey.OPTIONS_CONTROLS:
						this.addControlsOptions();
						break;
					case TextKey.OPTIONS_HOTKEYS:
						this.addHotKeysOptions();
                        break;
					case TextKey.OPTIONS_CHAT:
						this.addChatOptions();
                        break;
					case TextKey.OPTIONS_GRAPHICS:
						this.addGraphicsOptions();
                        break;
					case TextKey.OPTIONS_SOUND:
						this.addSoundOptions();
                        break;
					case TextKey.OPTIONS_MISC:
						this.addMiscOptions();
                        break;
					case TextKey.OPTIONS_FRIEND:
						this.addFriendOptions();
                        break;
					case "Experimental":
						this.addExperimentalOptions();
                        break;
					case "Event":
						this.addEventOptions();
                        break;
					case "Debuffs":
						this.addDebuffsOptions();
                        break;
					case "Auto":
						this.addAutoOptions();
                        break;
					case "Loot":
						this.addAutoLootOptions();
                        break;
					case "World":
						this.addWorldOptions();
                        break;
					case "Recon|Msg":
						this.addReconAndMessageOptions();
                        break;
					case "Visual":
						this.addVisualOptions();
                        break;
					case "Fame":
						this.addFameOptions();
                        break;
					case "Other":
						this.addOtherOptions();
                        break;
				}
                this.checkForScroll();
			}

            private function checkForScroll():void
            {
                if (this.scrollContainer.height >= SCROLL_HEIGHT)
                {
                    this.scrollContainerBottom.y = (SCROLL_Y_OFFSET + this.scrollContainer.height);
                    this.scrollContainer.addChild(this.scrollContainerBottom);
                    this.scroll.visible = true;
                }
                else
                {
                    this.scroll.visible = false;
                };
            }


            private function addDebuffsOptions():void
			{
				this.addOptionAndPosition(new ChoiceOption("ignoreQuiet", makeOnOffLabels(), [true, false], "Ignore Quiet", "Server Sided, can DC, On means ignoring shot", calculateIgnoreBitmask, 0xFF0000), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("ignoreWeak", makeOnOffLabels(), [true, false], "Ignore Weak", "Server Sided, can DC, On means ignoring shot", calculateIgnoreBitmask, 0xFF0000), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("ignoreSlowed", makeOnOffLabels(), [true, false], "Ignore Slowed", "Server Sided, can DC, On means ignoring shot", calculateIgnoreBitmask, 0xFF0000), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("ignoreSick", makeOnOffLabels(), [true, false], "Ignore Sick", "Server Sided, can DC, On means ignoring shot", calculateIgnoreBitmask, 0xFF0000), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("ignoreDazed", makeOnOffLabels(), [true, false], "Ignore Dazed", "Server Sided, can DC, On means ignoring shot", calculateIgnoreBitmask, 0xFF0000), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("ignoreStunned", makeOnOffLabels(), [true, false], "Ignore Stunned", "Server Sided, can DC, On means ignoring shot", calculateIgnoreBitmask, 0xFF0000), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("ignoreParalyzed", makeOnOffLabels(), [true, false], "Ignore Paralyzed", "Server Sided, can DC, On means ignoring shot", calculateIgnoreBitmask, 0xFF0000), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("ignoreBleeding", makeOnOffLabels(), [true, false], "Ignore Bleeding", "Server Sided, can DC, On means ignoring shot", calculateIgnoreBitmask, 0xFF0000), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("ignoreArmorBroken", makeOnOffLabels(), [true, false], "Ignore Armor Broken", "Server Sided, can DC, On means ignoring shot", calculateIgnoreBitmask, 0xFF0000), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("ignorePetStasis", makeOnOffLabels(), [true, false], "Ignore Pet Stasis", "Server Sided, can DC, On means ignoring shot", calculateIgnoreBitmask, 0xFF0000), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("ignorePetrified", makeOnOffLabels(), [true, false], "Ignore Petrified", "Server Sided, can DC, On means ignoring shot", calculateIgnoreBitmask, 0xFF0000), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("ignoreSilenced", makeOnOffLabels(), [true, false], "Ignore Silence", "Server Sided, can DC, On means ignoring shot", calculateIgnoreBitmask, 0xFF0000), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("ignoreBlind", makeOnOffLabels(), [true, false], "Ignore Blind", "Client Sided, safe to ignore", calculateIgnoreBitmask), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("ignoreHallucinating", makeOnOffLabels(), [true, false], "Ignore Hallucinating", "Client Sided, safe to ignore", calculateIgnoreBitmask), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("ignoreDrunk", makeOnOffLabels(), [true, false], "Ignore Drunk", "Client Sided, safe to ignore", calculateIgnoreBitmask), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("ignoreConfused", makeOnOffLabels(), [true, false], "Ignore Confused", "Client Sided, safe to ignore", calculateIgnoreBitmask), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("ignoreUnstable", makeOnOffLabels(), [true, false], "Ignore Unstable", "Client Sided, safe to ignore", calculateIgnoreBitmask), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("ignoreDarkness", makeOnOffLabels(), [true, false], "Ignore Darkness", "Client Sided, safe to ignore", calculateIgnoreBitmask), 0, 0, true);
			}

			public function addAutoOptions():void
			{
				this.addOptionAndPosition(new KeyMapper("AAHotkey", "AutoAim Hotkey", "Toggle AutoAim"), 0, 0, true);
				this.addOptionAndPosition(new KeyMapper("AAModeHotkey", "AimMode Hotkey", "Switch AutoAim's aim mode"), 0, 0, true);
				this.addOptionAndPosition(new KeyMapper("AutoAbilityHotkey", "Auto Ability Hotkey", "Toggle Auto Ability"), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("AAOn", makeOnOffLabels(), [true, false], "AutoAim", "Automatically aim at enemies", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("AutoNexus", this.AutoNexusValues(), [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 60], "Autonexus Percent", "The percent of health at which to autonexus at", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("AutoSyncClientHP", makeOnOffLabels(), [true, false], "AutoSync ClientHP", "Automatically sets your clientHP to your server HP if the difference between them is more than 60 hp for 600ms [WARNING, you can die with this on]", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("AATargetLead", makeOnOffLabels(), [true, false], "AutoAim Target Lead", "Projectile deflection, makes autoaim shoot ahead of enemies so the projectile will collide with the enemy", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("autoDecrementHP", makeOnOffLabels(), [true, false], "Remove HP when dealing damage", "Decreases an enemy's health when you deal damage to them, this allows you to one shot enemies with spellbombs", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("shootAtWalls", makeOnOffLabels(), [true, false], "Shoot at Walls", "Make AutoAim aim at stuff like Walls and Davy barrels", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("autoaimAtInvulnerable", makeOnOffLabels(), [true, false], "Aim at Invulnerable", "Make AutoAim aim at invulnerable enemies or not", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("AABoundingDist", this.BoundingDistValues(), [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 20, 30, 50], "Bounding Distance", "Restrict AutoAim to see only as far as the bounding distance from the mouse cursor in closest to cursor aim mode", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("onlyAimAtExcepted", makeOnOffLabels(), [true, false], "Only Aim at Excepted", "Only AutoAims at the enemies in your exception list", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("AutoHealPercentage", this.AutoHealValues(), [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 99, 100], "Autoheal Threshold", "Sets the health percentage at which to heal", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("autoHPPercent", this.AutoHPPotValues(), [0, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75], "Auto HP Pot Threshold", "Sets the health percentage at which to use an HP potion", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("autohpPotDelay", this.AutoHPPotDelayValues(), [100, 200, 300, 400, 500, 600, 700, 800, 900, 1000], "Auto HP Pot Delay", "Sets the delay between drinking HP pots", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("spellbombHPThreshold", this.spellbombThresholdValues(), [0, 1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000, 10000, 15000, 20000], "AutoAbility Health Threshold", "Sets the enemy current health value at which Auto Ability will target enemies (ie, if it is set to 5000, then the auto ability will only attempt to shoot at enemies with greater than 5000 health), use /sbthreshold to set a specific value", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("skullHPThreshold", this.skullThresholdValues(), [0, 100, 250, 500, 800, 1000, 2000, 4000, 8000], "AOE AutoAbility Health Threshold", "Sets the enemy current health value at which Auto Ability will target enemies for AOE abilities like Necro, Assassin, Huntress, Sorc, (ie, if it is set to 1000, then the Auto Ability will only attempt to shoot at enemies with greater than 1000 health), use /aathreshold to set a specific value", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("skullTargets", this.skullTargetsValues(), [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10], "Min AOE AutoAbility Targets", "Sets the amount of enemies required in your AOE ability's radius before using the ability, use /aatargets to set a specific value", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("AutoResponder", makeOnOffLabels(), [true, false], "AutoResponder", "Automatically replies to Thessal/Cem/Sewer text", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("autoClaimCalendar", makeOnOffLabels(), [true, false], "Auto Claim Calendar", "Automatically claims Daily Login Calendar items upon logging in", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("BossPriority", makeOnOffLabels(), [true, false], "Boss Priority", 'Makes AutoAim prioritize Boss enemies over everything else - "bosses" includes all Quests and certain dungeon bosses which are not quests, such as the Shatters bosses', null), 0, 0, true);
			}

			private function volumeValues():Vector.<StringBuilder>
			{
				return (new <StringBuilder>[new StaticStringBuilder("0.1"), new StaticStringBuilder("0.2"), new StaticStringBuilder("0.3"), new StaticStringBuilder("0.4"), new StaticStringBuilder("0.5"), new StaticStringBuilder("0.6"), new StaticStringBuilder("0.7"), new StaticStringBuilder("0.8"), new StaticStringBuilder("0.9"), new StaticStringBuilder("1.0"), new StaticStringBuilder("1.1"), new StaticStringBuilder("1.2"), new StaticStringBuilder("1.3"), new StaticStringBuilder("1.4"), new StaticStringBuilder("1.5"), new StaticStringBuilder("1.6"), new StaticStringBuilder("1.7"), new StaticStringBuilder("1.8"), new StaticStringBuilder("1.9"), new StaticStringBuilder("2.0")]);
			}

			public function addEventOptions():void
			{
				this.addOptionAndPosition(new ChoiceOption("eventNotifier", makeOnOffLabels(), [true, false], "Event Notification", "Plays a sound when a specific event spawns in the Realm you are currently in, all other event notifications need this option to be on for the rest to work", null, 0xFF00), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("eventNotifierVolume", volumeValues(), [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1, 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2], "Notification Volume", "Volume for the notification", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("notifySkull", makeOnOffLabels(), [true, false], "Notify Skull Shrine", "Plays a sound for when Skull Shrine spawns", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("notifyCube", makeOnOffLabels(), [true, false], "Notify Cube God", "Plays a sound for when Cube God spawns", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("notifyPentaract", makeOnOffLabels(), [true, false], "Notify Pentaract", "Plays a sound for when Notify Pentaract spawns", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("notifySphinx", makeOnOffLabels(), [true, false], "Notify Grand Sphinx", "Plays a sound for when Grand Sphinx spawns", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("notifyHermit", makeOnOffLabels(), [true, false], "Notify Hermit God", "Plays a sound for when Hermit God spawns", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("notifyLotLL", makeOnOffLabels(), [true, false], "Notify Lord of the Lost Lands", "Plays a sound for when Lord of the Lost Lands spawns", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("notifyGhostShip", makeOnOffLabels(), [true, false], "Notify Ghost Ship", "Plays a sound for when Ghost Ship spawns", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("notifyAvatar", makeOnOffLabels(), [true, false], "Notify Avatar of the Forgotten King", "Plays a sound for when Avatar of the Forgotten King spawns", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("notifyStatues", makeOnOffLabels(), [true, false], "Notify Jade and Garnet Statues", "Plays a sound for when Jade and Garnet Statues spawn", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("notifyRockDragon", makeOnOffLabels(), [true, false], "Notify Rock Dragon", "Plays a sound for when Rock Dragon spawns", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("notifyNest", makeOnOffLabels(), [true, false], "Notify Killer Bee Nest", "Plays a sound for when Killer Bee Nest spawns", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("notifyLostSentry", makeOnOffLabels(), [true, false], "Notify Lost Sentry", "Plays a sound for when Lost Sentry spawns", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("notifyPumpkinShrine", makeOnOffLabels(), [true, false], "Notify Pumpkin Shrine", "Plays a sound for when Pumpkin Shrine spawns", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("notifyZombieHorde", makeOnOffLabels(), [true, false], "Notify Zombie Horde", "Plays a sound for when Zombie Horde spawns", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("notifyTurkeyGod", makeOnOffLabels(), [true, false], "Notify Turkey God", "Plays a sound for when Turkey God spawns", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("notifyBeachBum", makeOnOffLabels(), [true, false], "Notify Beach Bum", "Plays a sound for when Beach Bum spawns", null), 0, 0, true);
			}

			public function addControllerOptions():void
			{
				this.addOptionAndPosition(new ChoiceOption("allowController", makeOnOffLabels(), [true, false], "Use Controller", "Enables usage of a Xbox 360 controller", this.toggleControllerOptions));
			}

			private function make1to8labels():Vector.<StringBuilder>
			{
				return (new <StringBuilder>[new StaticStringBuilder("#0"), new StaticStringBuilder("#1"), new StaticStringBuilder("#2"), new StaticStringBuilder("#3"), new StaticStringBuilder("#4"), new StaticStringBuilder("#5"), new StaticStringBuilder("#6"), new StaticStringBuilder("#7"), new StaticStringBuilder("#8")]);
			}

			public function toggleControllerOptions():void
			{
				if (this.gs_.mui_ != null)
				{
					this.gs_.mui_.setController();
				}
			}

			public function setControllerOptions():void
			{
				if (this.gs_.mui_ != null)
				{
					this.gs_.mui_.setController();
				}
			}

			public function addAutoLootOptions():void
			{
				this.addOptionAndPosition(new KeyMapper("AutoLootHotkey", "Auto Loot", "Toggles Auto Loot which automatically loots nearby items based on customizable criteria"), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("autoLootUpgrades", makeOnOffLabels(), [true, false], "Loot Upgrades", "Pick up items with a higher tier than your current equips (UTs and STs are excluded)", updateWanted), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("autoLootWeaponTier", this.ZeroThirteen(), [999, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13], "Min Weapon Tier", "Minimum tier required for AutoLoot of tiered Weapons", this.updateWanted), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("autoLootAbilityTier", this.ZeroSix(), [999, 0, 1, 2, 3, 4, 5, 6], "Min Ability Tier", "Minimum tier required for AutoLoot of tiered Abilities", this.updateWanted), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("autoLootArmorTier", this.ZeroFourteen(), [999, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "Min Armor Tier", "Minimum tier required for AutoLoot of tiered Armors", this.updateWanted), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("autoLootRingTier", this.ZeroSix(), [999, 0, 1, 2, 3, 4, 5, 6], "Min Ring Tier", "Minimum tier required for AutoLoot of tiered Rings", this.updateWanted), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("autoLootFameBonus", alFBValues(), [-1, 1, 2, 3, 4, 5, 6, 7], "Min Fame Bonus", "Loot all items with a feed power equal to or above the specified amount", updateWanted), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("autoLootFeedPower", alFPValues(), [-1, 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1200, 1400, 1600, 1800, 2000], "Min Feed Power", "Loot all items with a fame bonus equal to or above the specified amount", updateWanted), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("autoLootHPPots", makeOnOffLabels(), [true, false], "Loot HP Potions", "Loot all HP potions", updateWanted), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("autoLootMPPots", makeOnOffLabels(), [true, false], "Loot MP Potions", "Loot all MP potions", updateWanted), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("autoLootHPPotsInv", makeOnOffLabels(), [true, false], "Loot HP Potions to Inventory", "Loot excess HP potions to inventory", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("autoLootMPPotsInv", makeOnOffLabels(), [true, false], "Loot MP Potions to Inventory", "Loot excess MP potions to inventory", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("autoLootLifeManaPots", makeOnOffLabels(), [true, false], "Loot Life/Mana Potions", "Loot all Life and Mana potions", updateWanted), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("autoLootRainbowPots", makeOnOffLabels(), [true, false], "Loot Rainbow Potions", "Loot all Atk/Def/Spd/Dex/Vit/Wis potions", updateWanted), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("autoLootSkins", makeOnOffLabels(), [true, false], "Loot Skins", "Loot all skins", updateWanted), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("autoLootKeys", makeOnOffLabels(), [true, false], "Loot Keys", "Loot all keys", updateWanted), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("autoLootPetSkins", makeOnOffLabels(), [true, false], "Loot Pet Skins", "Loot all pet skins", updateWanted), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("autoLootUTs", makeOnOffLabels(), [true, false], "Loot UT Items", "Loots White Bag and ST items", updateWanted), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("autoLootMarks", makeOnOffLabels(), [true, false], "Loot Marks", "Loot all Dungeon Quest Marks", updateWanted), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("autoLootEggs", makeEggLabels(), [-1, 0, 1, 2, 3], "Loot Pet Eggs", "Loot all Pet Eggs above the specified level", updateWanted), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("autoLootConsumables", makeOnOffLabels(), [true, false], "Loot Consumables", "Loot all Consumables, which includes (but not limited to) Tinctures, Effusions, Pet Stones, Skins", updateWanted), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("autoLootSoulbound", makeOnOffLabels(), [true, false], "Loot Soulbound Items", "Loot everything Soulbound", updateWanted), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("autoDrinkFromBags", makeOnOffLabels(), [true, false], "Auto Drink From Bags", "Drinks needed potions from nearby bags", updateWanted), 0, 0, true);
			}

			public function updateWanted():void
			{
				Parameters.needToRecalcDesireables = true;
			}

			private function makeEggLabels():Vector.<StringBuilder>
			{
				return (new <StringBuilder>[new StaticStringBuilder("Off"), new StaticStringBuilder("Common"), new StaticStringBuilder("Uncommon"), new StaticStringBuilder("Rare"), new StaticStringBuilder("Legendary")]);
			}

			private function alFBValues():Vector.<StringBuilder>
			{
				return (new <StringBuilder>[new StaticStringBuilder("Off"), new StaticStringBuilder("1%"), new StaticStringBuilder("2%"), new StaticStringBuilder("3%"), new StaticStringBuilder("4%"), new StaticStringBuilder("5%"), new StaticStringBuilder("6%"), new StaticStringBuilder("7%")]);
			}

			private function alFPValues():Vector.<StringBuilder>
			{
				return (new <StringBuilder>[new StaticStringBuilder("Off"), new StaticStringBuilder("100 FP"), new StaticStringBuilder("200 FP"), new StaticStringBuilder("300 FP"), new StaticStringBuilder("400 FP"), new StaticStringBuilder("500 FP"), new StaticStringBuilder("600 FP"), new StaticStringBuilder("700 FP"), new StaticStringBuilder("800 FP"), new StaticStringBuilder("900 FP"), new StaticStringBuilder("1000 FP"), new StaticStringBuilder("1200 FP"), new StaticStringBuilder("1400 FP"), new StaticStringBuilder("1600 FP"), new StaticStringBuilder("1800 FP"), new StaticStringBuilder("2000 FP")]);
			}

			private function BoundingDistValues():Vector.<StringBuilder>
			{
				return (new <StringBuilder>[new StaticStringBuilder("1"), new StaticStringBuilder("2"), new StaticStringBuilder("3"), new StaticStringBuilder("4"), new StaticStringBuilder("5"), new StaticStringBuilder("6"), new StaticStringBuilder("7"), new StaticStringBuilder("8"), new StaticStringBuilder("9"), new StaticStringBuilder("10"), new StaticStringBuilder("15"), new StaticStringBuilder("20"), new StaticStringBuilder("30"), new StaticStringBuilder("50")]);
			}

			private function AutoHealValues():Vector.<StringBuilder>
			{
				return (new <StringBuilder>[new StaticStringBuilder("Off"), new StaticStringBuilder("5%"), new StaticStringBuilder("10%"), new StaticStringBuilder("15%"), new StaticStringBuilder("20%"), new StaticStringBuilder("25%"), new StaticStringBuilder("30%"), new StaticStringBuilder("35%"), new StaticStringBuilder("40%"), new StaticStringBuilder("45%"), new StaticStringBuilder("50%"), new StaticStringBuilder("55%"), new StaticStringBuilder("60%"), new StaticStringBuilder("65%"), new StaticStringBuilder("70%"), new StaticStringBuilder("75%"), new StaticStringBuilder("80%"), new StaticStringBuilder("85%"), new StaticStringBuilder("90%"), new StaticStringBuilder("99%"), new StaticStringBuilder("100%")]);
			}

			private function AutoHPPotValues():Vector.<StringBuilder>
			{
				return (new <StringBuilder>[new StaticStringBuilder("Off"), new StaticStringBuilder("20%"), new StaticStringBuilder("25%"), new StaticStringBuilder("30%"), new StaticStringBuilder("35%"), new StaticStringBuilder("40%"), new StaticStringBuilder("45%"), new StaticStringBuilder("50%"), new StaticStringBuilder("55%"), new StaticStringBuilder("60%"), new StaticStringBuilder("65%"), new StaticStringBuilder("70%"), new StaticStringBuilder("75%")]);
			}

			private function AutoHPPotDelayValues():Vector.<StringBuilder>
			{
				return (new <StringBuilder>[new StaticStringBuilder("100ms"), new StaticStringBuilder("200ms"), new StaticStringBuilder("300ms"), new StaticStringBuilder("400ms"), new StaticStringBuilder("500ms"), new StaticStringBuilder("600ms"), new StaticStringBuilder("700ms"), new StaticStringBuilder("800ms"), new StaticStringBuilder("900ms"), new StaticStringBuilder("1000ms")]);
			}

			private function spellbombThresholdValues():Vector.<StringBuilder>
			{
				return (new <StringBuilder>[new StaticStringBuilder("Off"), new StaticStringBuilder("1000 HP"), new StaticStringBuilder("2000 HP"), new StaticStringBuilder("3000 HP"), new StaticStringBuilder("4000 HP"), new StaticStringBuilder("5000 HP"), new StaticStringBuilder("6000 HP"), new StaticStringBuilder("7000 HP"), new StaticStringBuilder("8000 HP"), new StaticStringBuilder("9000 HP"), new StaticStringBuilder("10000 HP"), new StaticStringBuilder("15000 HP"), new StaticStringBuilder("20000 HP")]);
			}

			private function skullThresholdValues():Vector.<StringBuilder>
			{
				return (new <StringBuilder>[new StaticStringBuilder("Off"), new StaticStringBuilder("100 HP"), new StaticStringBuilder("250 HP"), new StaticStringBuilder("500 HP"), new StaticStringBuilder("800 HP"), new StaticStringBuilder("1000 HP"), new StaticStringBuilder("2000 HP"), new StaticStringBuilder("4000 HP"), new StaticStringBuilder("8000 HP")]);
			}

			private function skullTargetsValues():Vector.<StringBuilder>
			{
				return (new <StringBuilder>[new StaticStringBuilder("Off"), new StaticStringBuilder("1"), new StaticStringBuilder("2"), new StaticStringBuilder("3"), new StaticStringBuilder("4"), new StaticStringBuilder("5"), new StaticStringBuilder("6"), new StaticStringBuilder("7"), new StaticStringBuilder("8"), new StaticStringBuilder("9"), new StaticStringBuilder("10")]);
			}

			public function ZeroSix():Vector.<StringBuilder>
			{
				return (new <StringBuilder>[new StaticStringBuilder("Off"), new StaticStringBuilder("0"), new StaticStringBuilder("1"), new StaticStringBuilder("2"), new StaticStringBuilder("3"), new StaticStringBuilder("4"), new StaticStringBuilder("5"), new StaticStringBuilder("6")]);
			}

			public function ZeroThirteen():Vector.<StringBuilder>
			{
				return (new <StringBuilder>[new StaticStringBuilder("Off"), new StaticStringBuilder("0"), new StaticStringBuilder("1"), new StaticStringBuilder("2"), new StaticStringBuilder("3"), new StaticStringBuilder("4"), new StaticStringBuilder("5"), new StaticStringBuilder("6"), new StaticStringBuilder("7"), new StaticStringBuilder("8"), new StaticStringBuilder("9"), new StaticStringBuilder("10"), new StaticStringBuilder("11"), new StaticStringBuilder("12"), new StaticStringBuilder("13")]);
			}

			public function ZeroFourteen():Vector.<StringBuilder>
			{
				return (new <StringBuilder>[new StaticStringBuilder("Off"), new StaticStringBuilder("0"), new StaticStringBuilder("1"), new StaticStringBuilder("2"), new StaticStringBuilder("3"), new StaticStringBuilder("4"), new StaticStringBuilder("5"), new StaticStringBuilder("6"), new StaticStringBuilder("7"), new StaticStringBuilder("8"), new StaticStringBuilder("9"), new StaticStringBuilder("10"), new StaticStringBuilder("11"), new StaticStringBuilder("12"), new StaticStringBuilder("13"), new StaticStringBuilder("14")]);
			}

			public function HighestDpsTexts():Vector.<StringBuilder>
			{
				return (new <StringBuilder>[new StaticStringBuilder("Off"), new StaticStringBuilder("All"), new StaticStringBuilder("Quest")]);
			}

			public function lootPreviewTexts():Vector.<StringBuilder>
			{
				return (new <StringBuilder>[new StaticStringBuilder("Off"), new StaticStringBuilder("Vault"), new StaticStringBuilder("Everywhere")]);
			}

			public function showDamageAndHPTexts():Vector.<StringBuilder>
			{
				return (new <StringBuilder>[new StaticStringBuilder("Off"), new StaticStringBuilder("Percent"), new StaticStringBuilder("Base"), new StaticStringBuilder("With HP"), new StaticStringBuilder("All")]);
			}

			public function addWorldOptions():void
			{
				this.addOptionAndPosition(new ChoiceOption("offsetWeapon", makeOnOffLabels(), [true, false], "Offset Weapons", "Offsets your firing angle if you have an Etherite/Cultist Staff/Void Bow/Colossus Sword equipped to make it so your shots are in a straight line", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("damageIgnored", makeOnOffLabels(), [true, false], "Damage Ignored Enemies", "Prevents your shots from damaging enemies that are ignored", null), 0, 0, true);
				this.addOptionAndPosition(new KeyMapper("anchorTeleport", "Teleport to Anchor", "Teleports you to the player you have anchored (set via /anchor <name> or the player menu)"), 0, 0, true);
				this.addOptionAndPosition(new KeyMapper("QuestTeleport", "Teleport to Quest", "Teleports to the player closest to your quest"), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("ignoreIce", makeOnOffLabels(), [true, false], "Ignore Ice and Push", "Disables the slidy ice tiles and sprite world pushing tiles", null), 0, 0, true);
				this.addOptionAndPosition(new KeyMapper("tradeNearestPlayerKey", "Trade Nearest Player", "Sends a trade request to the nearest player"), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("passThroughInvuln", makeOnOffLabels(), [true, false], "Pass Through Invuln", "Makes your projectiles not hit things that are invulnerable (unless your projectile would inflict a status effect), THIS INCLUDES TUTORIAL TURRETS, TURN IT OFF WHEN ACCURACY FARMING", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("safeWalk", makeOnOffLabels(), [true, false], "Safe Walk", "Makes lava tiles act as if they were unwalkable.", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("vialChecker", makeOnOffLabels(), [true, false], "Vial Checker", "Check players inventories and add him to the list if vial found.", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("instaTradeSelect", makeOnOffLabels(), [true, false], "Instantly Select All Items", "When turned on, a right click on the trade window will select all your items instantly. When turned off, selects only items of the same type, smoothly, like an actual player.", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("multiBox", makeOnOffLabels(), [true, false], "Multi Box", "Make sure you have activated server.", null), 0, 0, true);
			}

			public function addReconAndMessageOptions():void
			{
				this.addOptionAndPosition(new KeyMapper("ReconRealm", "Recon Realm", "Key that connects the user to the last realm in."));
				this.addOptionAndPosition(new KeyMapper("RandomRealm", "Random Realm", "Key that connects the user to a random realm in the current server."));
				this.addOptionAndPosition(new KeyMapper("ReconVault", "Recon Vault", "Key that connects the user to their vault."));
				this.addOptionAndPosition(new KeyMapper("ReconDaily", "Recon Daily", "Key that connects the user to their daily quest room."));
				this.addOptionAndPosition(new NullOption());
				this.addOptionAndPosition(new NullOption());
				this.addOptionAndPosition(new KeyMapper("msg1key", "Custom Message 1", (('Currently set to "' + Parameters.data_.msg1) + '". Use /setmsg 1 <message> to replace this message.')));
				this.addOptionAndPosition(new KeyMapper("msg2key", "Custom Message 2", (('Currently set to "' + Parameters.data_.msg2) + '". Use /setmsg 2 <message> to replace this message.')));
				this.addOptionAndPosition(new KeyMapper("msg3key", "Custom Message 3", (('Currently set to "' + Parameters.data_.msg3) + '". Use /setmsg 3 <message> to replace this message.')));
				this.addOptionAndPosition(new KeyMapper("msg4key", "Custom Message 4", (('Currently set to "' + Parameters.data_.msg4) + '". Use /setmsg 4 <message> to replace this message.')));
				this.addOptionAndPosition(new KeyMapper("msg5key", "Custom Message 5", (('Currently set to "' + Parameters.data_.msg5) + '". Use /setmsg 5 <message> to replace this message.')));
				this.addOptionAndPosition(new KeyMapper("msg6key", "Custom Message 6", (('Currently set to "' + Parameters.data_.msg6) + '". Use /setmsg 6 <message> to replace this message.')));
				this.addOptionAndPosition(new KeyMapper("msg7key", "Custom Message 7", (('Currently set to "' + Parameters.data_.msg7) + '". Use /setmsg 7 <message> to replace this message.')));
				this.addOptionAndPosition(new KeyMapper("msg8key", "Custom Message 8", (('Currently set to "' + Parameters.data_.msg8) + '". Use /setmsg 8 <message> to replace this message.')));
				this.addOptionAndPosition(new KeyMapper("msg9key", "Custom Message 9", (('Currently set to "' + Parameters.data_.msg9) + '". Use /setmsg 9 <message> to replace this message.')));
			}

			public function addVisualOptions():void
			{
				this.addOptionAndPosition(new KeyMapper("LowCPUModeHotKey", "Low CPU Mode", "Disables a lot of rendering and stuff"), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("hideLowCPUModeChat", makeOnOffLabels(), [true, false], "Hide Chat in Low CPU Mode", "Controls whether normal chat is shown in Low CPU Mode", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("hideLockList", makeOnOffLabels(), [true, false], "Hide Nonlocked", "Hide non locked players", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("hidePets", makeOnOffLabels(), [true, false], "Hide Pets", "Hide all pets", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("lootPreview", lootPreviewTexts(), ["off", "vault", "everywhere"], "Loot Preview", "Shows previews of equipment over bags", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("showDamageAndHP", showDamageAndHPTexts(), ["off", "percent", "base", "total", "all"], "Show Damage and HP", "Shows the % of projectile damage you've done to an enemy, below that enemy. Show total health points of player and enemies as they take damage.", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("showDamageAndHPColorized", makeOnOffLabels(), [true, false], "Colorized Show Damage and HP", "Changes the status text color based on the percentage of health the player or enemy has.", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("showMobInfo", makeOnOffLabels(), [true, false], "Show Mob Info", "Shows the object itemType above mobs", this.onShowMobInfo), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("liteMonitor", makeOnOffLabels(), [true, false], "Lite Stats Monitor", 'Replaces the Net Jitter stats monitor with a "lite" one that also measures ping', null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("showClientStat", makeOnOffLabels(), [true, false], "Show ClientStat", "Output when you get a ClientStat packet, which shows when things like TilesSeen, GodsKilled, DungeonsCompleted, etc changes", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("liteParticle", makeOnOffLabels(), [true, false], "Reduced Particles", "Shows only Bombs/Poisons/Traps/Vents", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("ignoreStatusText", makeOnOffLabels(), [true, false], "Ignore Status Effect Text", "Don't draw Dazed/Status/Cursed/etc Status Text above enemies", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("bigLootBags", makeOnOffLabels(), [true, false], "Big Loot Bags", "Makes soulbound loot bags twice as big", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("evenLowerGraphics", makeOnOffLabels(), [true, false], "Even Lower Graphics Mode", "[NOT COMPATIBLE WITH SCREENSHOT MODE] Makes the graphics worse in an attempt to reduce lag. Warning: dye items are red/green and don't show their proper pattern", this.onN64Mode), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("showCHbar", makeOnOffLabels(), [true, false], "Show Client HP Bar", "Displays the extra client HP bar or not", this.toggleBars), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("showDyes", makeOnOffLabels(), [true, false], "Show Dyes", "Makes every player use the default dye.", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("alphaOnOthers", makeOnOffLabels(), [true, false], "Make Other Players Transparent", "Makes nonlocked players and their pets transparent, toggleable with /ao and transparency level customizable with /alpha 0.2", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("showSkins", makeOnOffLabels(), [true, false], "Show Skins", "Forces default skin to everyone when turned off.", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("questHUD", makeOnOffLabels(), [true, false], "Quest Bar", "Quest Bar.", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("mapHack", makeOnOffLabels(), [true, false], "Map Hack", "Shows entire map when entering a realm. Loading in for the first time will take longer.", mapHackChange), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("noRotate", makeOnOffLabels(), [true, false], "Disable Shot Rotation", "Makes Shots not have their rotation effect, which prevents a lot of lag especially in Lost Halls", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("showHighestDps", HighestDpsTexts(), ["off", "all", "quest"], "Show Highest DPS", "Shows the highest DPS weapon under an enemy.", null), 0, 0, true);
			}

			public function mapHackChange():void
			{
				if (gs_ != null && gs_.map != null)
				{
					gs_.hudView.miniMap.hackmapData = new BitmapData(gs_.hudView.miniMap.maxWH_.x, gs_.hudView.miniMap.maxWH_.y, false, 0);
					Parameters.needsMapCheck = gs_.map.needsMapHack(gs_.map.name_);
				}
			}

			public function toggleBars():void
			{
				this.gs_.hudView.statMeters.dispose();
				this.gs_.hudView.statMeters.init();
			}

			public function onN64Mode():void
			{
				TextureRedrawer.clearCache();
				TextureRedrawer.clearCache2();
				GlowRedrawer.clearCache();
			}

			public function addFameOptions():void
			{
				this.addOptionAndPosition(new KeyMapper("famebotToggleHotkey", "Toggle Famebot", "Toggle famebot mode (WARNING: I AM NOT RESPONSIBLE IF YOU GET BANNED USING THIS, IT IS POSSIBLE AND IT HAS HAPPENED)"));
				this.addOptionAndPosition(new KeyMapper("addMoveRecPoint", "Add Move Point", "Adds the current position to the movement record playback list"));
				this.addOptionAndPosition(new ChoiceOption("trainOffset", makeOffsetLabels(), [0, 500, 1000, 1500], "Offset from Center", "Set the distance from the center to walk (Middle = center of pack, Further = slightly ahead of center, Far = near front, Furthest = spearheading)", null));
				this.addOptionAndPosition(new ChoiceOption("densityThreshold", makeDistThreshLabels(), [5, 6, 7, 8, 9, 10, 15, 20, 25, 30, 35, 40], "Distance Threshold", "Sets the threshold for calculating the most dense center point of players (for each player, check all players within this threshold around that player, whoever has the most players within that threshold becomes the center)", null));
				this.addOptionAndPosition(new ChoiceOption("teleDistance", this.BoundingDistValues(), [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 20, 30], "Tele Distance", "The distance away from the center at which you teleport", null));
				this.addOptionAndPosition(new ChoiceOption("famePointOffset", makePointOffsetLabels(), [0.1, 0.2, 0.3, 0.4, 0.5, 0.75, 1, 1.5, 2, 2.5, 3, 3.5], "Fame Point Offset", "How far away the point randomization is offset by, this helps you walk around rocks if you're lucky", null));
				this.addOptionAndPosition(new ChoiceOption("famebotContinue", fbContinueValues(), [0, 1, 2], "Rejoin Train Continuously", "If Off, it will stop when nexused; if set to On, when you nexus, it will immediately reconnect back to the realm; if set to On+Walk, when you nexus, you instead walk up to the realms in a legit looking way and not reconnect back in a hacky way", null));
				this.addOptionAndPosition(new ChoiceOption("fameTpCdTime", makeFameTpCdLabels(), [1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000, 10000], "Teleport Attempt Cooldown", "Change the self imposed cooldown on requesting a teleport", null));
				this.addOptionAndPosition(new KeyMapper("TogglePlayerFollow", "Toggle Player Follow", "Set with /follow <name>, press this hotkey to toggle on and off"));
				this.addOptionAndPosition(new ChoiceOption("fameOryx", makeOnOffLabels(), [true, false], "Nexus After Oryx", "If On, will nexus instead of going to Oryx's Castle, otherwise it will be disabled in Oryx's Castle", null));
				this.addOptionAndPosition(new ChoiceOption("fameBlockTP", makeOnOffLabels(), [true, false], "Boots on the Ground", "Block all teleporting", null, 0xE25F00));
				this.addOptionAndPosition(new ChoiceOption("fameBlockAbility", makeOnOffLabels(), [true, false], "Mundane", "Block all ability usage", null, 0xE25F00));
				this.addOptionAndPosition(new ChoiceOption("fameBlockCubes", makeOnOffLabels(), [true, false], "Friend of the Cubes", "Block all cubes from being hit by you", null, 0xE25F00));
				this.addOptionAndPosition(new ChoiceOption("fameBlockGodsOnly", makeOnOffLabels(), [true, false], "Slayer of the Gods", "Have shots only hit Gods", null, 0xE25F00));
				this.addOptionAndPosition(new ChoiceOption("fameBlockThirsty", makeOnOffLabels(), [true, false], "Thirsty", "Block all potions from being drunk, except from bags", null, 0xE25F00));
			}

			private function makeFameTpCdLabels():Vector.<StringBuilder>
			{
				return (new <StringBuilder>[new StaticStringBuilder("1000"), new StaticStringBuilder("2000"), new StaticStringBuilder("3000"), new StaticStringBuilder("4000"), new StaticStringBuilder("5000"), new StaticStringBuilder("6000"), new StaticStringBuilder("7000"), new StaticStringBuilder("8000"), new StaticStringBuilder("9000"), new StaticStringBuilder("10000")]);
			}

			private function makePointOffsetLabels():Vector.<StringBuilder>
			{
				return (new <StringBuilder>[new StaticStringBuilder("0.1"), new StaticStringBuilder("0.2"), new StaticStringBuilder("0.3"), new StaticStringBuilder("0.4"), new StaticStringBuilder("0.5"), new StaticStringBuilder("0.75"), new StaticStringBuilder("1.0"), new StaticStringBuilder("1.5"), new StaticStringBuilder("2.0"), new StaticStringBuilder("2.5"), new StaticStringBuilder("3.0"), new StaticStringBuilder("3.5")]);
			}

			private function makeTeleDistLabels():Vector.<StringBuilder>
			{
				return (new <StringBuilder>[new StaticStringBuilder("1"), new StaticStringBuilder("2"), new StaticStringBuilder("4"), new StaticStringBuilder("8"), new StaticStringBuilder("16"), new StaticStringBuilder("32"), new StaticStringBuilder("64")]);
			}

			private function makeDistThreshLabels():Vector.<StringBuilder>
			{
				return (new <StringBuilder>[new StaticStringBuilder("5"), new StaticStringBuilder("6"), new StaticStringBuilder("7"), new StaticStringBuilder("8"), new StaticStringBuilder("9"), new StaticStringBuilder("10"), new StaticStringBuilder("15"), new StaticStringBuilder("20"), new StaticStringBuilder("25"), new StaticStringBuilder("30"), new StaticStringBuilder("35"), new StaticStringBuilder("40")]);
			}

			private function makeOffsetLabels():Vector.<StringBuilder>
			{
				return (new <StringBuilder>[new StaticStringBuilder("Middle"), new StaticStringBuilder("Further"), new StaticStringBuilder("Front"), new StaticStringBuilder("Furthest")]);
			}

			public function onShowMobInfo():void
			{
				if (!Parameters.ssmode && !Parameters.data_.showMobInfo && this.gs_.map.mapOverlay_ != null)
				{
					this.gs_.map.mapOverlay_.removeChildren(0);
				}
			}

			public function addOtherOptions():void
			{
				this.addOptionAndPosition(new KeyMapper("Cam45DegInc", "Rotate 45 Degrees", "Rotates your camera angle by 45 degrees"), 0, 0, true);
				this.addOptionAndPosition(new KeyMapper("Cam45DegDec", "Rotate -45 Degrees", "Rotates your camera angle by -45 degrees"), 0, 0, true);
				this.addOptionAndPosition(new KeyMapper("aimAtQuest", "Aim at Quest", "Sets your camera angle in the direction of your quest"), 0, 0, true);
				this.addOptionAndPosition(new KeyMapper("resetClientHP", "Reset Client HP", "Sets your Client HP to your Server HP, if you need to manually sync Health"), 0, 0, true);
				this.addOptionAndPosition(new KeyMapper("SelfTPHotkey", "Tele Self", "Teleports you to yourself for a free second of invicibility"), 0, 0, true);
				this.addOptionAndPosition(new KeyMapper("PassesCoverHotkey", "Projectile Noclip", "Toggle allowing projectiles to pass through solid objects like trees and walls"), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("TradeDelay", makeOnOffLabels(), [true, false], "No Trade Delay", "Remove the 3 second trade delay", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("skipPopups", makeOnOffLabels(), [true, false], "Ignore Startup Popups", "Hides all popups when you first load the client", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("extraPlayerMenu", makeOnOffLabels(), [true, false], "Extended Player Menu", "Show extra options on player menus when you click in chat or in the party list", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("mobNotifier", makeOnOffLabels(), [true, false], "Treasure Room Notifier", "Plays a sound when a Troom is opened", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("rightClickOption", makeRightClickOptions(), ["Off", "Quest", "Ability", "Camera"], "Right Click Option", "Select the functionality you want on right click: none, quest follow (hold down right click to walk towards your quest), spellbomb/ability assist (uses your ability at the enemy closest to your cursor), camera (rotates your camera when holding right click)", null), 0, 0, true);
				this.addOptionAndPosition(new KeyMapper("sskey", "Screenshot Mode [READ THIS PLEASE]", "(NOT SAFE FOR RECORDING!!!!!!)         Hides every visual modification, please note that there could potentially be some hacks that are not hidden, but have not been discovered, if you find something missing then post on the MPGH thread please!", false, 3596312), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("customUI", makeOnOffLabels(), [true, false], "Custom UI", "Toggle UI to better view.", this.toggleUI), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("tiltCam", makeOnOffLabels(), [true, false], "Tilt Camera X Axis", "Allows the Right Click Option, when on Camera, to rotate the X Axis of the Camera's perspective", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("cacheCharList", makeOnOffLabels(), [true, false], "Cache Character List", 'Makes the main menu reload when you go back to it, instead of using the cached version which avoids the 10 minute "Internal Error" timeout', null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("chatLength", chatLengthLabels(), [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], "Chat Length", "Determines the number of lines chat shows (5 is the standard, previously it was 10)", this.onChatLengthChange), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("allowController", makeOnOffLabels(), [true, false], "Use Controller", "Enables usage of an Xbox 360 controller", this.toggleControllerOptions), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("FocusFPS", makeOnOffLabels(), [true, false], "Background FPS", "Lower FPS when the client loses focus (alt tabbing, minimizing, etc), set the background values with /bgfps # and foreground with /fgfps #", null), 0, 0, true);
				this.addOptionAndPosition(new ChoiceOption("portalQuest", makeOnOffLabels(), [true, false], "Quest to Portal", "Add quest-pointer to portals in nexus.", null), 0, 0, true);
			}

			private function toggleUI():void
			{
				this.gs_.hudView.toggleUI();
			}

			private function onChatLengthChange():void
			{
				this.gs_.chatBox_.list.setVisibleItemCount();
				this.gs_.chatBox_.list.removeOldestExcessVisible();
				this.gs_.chatBox_.model.setVisibleItemCount();
			}

			private function onAddedToStage(_arg_1:Event):void
			{
				this.continueButton_.x = 400;
				this.continueButton_.y = Y_POSITION;
				this.resetToDefaultsButton_.x = 20;
				this.resetToDefaultsButton_.y = Y_POSITION;
				this.homeButton_.x = 780;
				this.homeButton_.y = Y_POSITION;
				if (Capabilities.playerType == "Desktop")
				{
					Parameters.data_.fullscreenMode = (stage.displayState == StageDisplayState.FULL_SCREEN_INTERACTIVE);
					Parameters.save();
				}
				this.setSelected(this.defaultTab_);
				stage.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown, false, 1);
				stage.addEventListener(KeyboardEvent.KEY_UP, this.onKeyUp, false, 1);
			}

			private function onRemovedFromStage(_arg_1:Event):void
			{
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown, false);
				stage.removeEventListener(KeyboardEvent.KEY_UP, this.onKeyUp, false);
			}

			private function onKeyDown(_arg_1:KeyboardEvent):void
			{
				if (Capabilities.playerType == "Desktop" && _arg_1.keyCode == KeyCodes.ESCAPE)
				{
					Parameters.data_.fullscreenMode = false;
					Parameters.save();
					this.refresh();
				}
				if (_arg_1.keyCode == Parameters.data_.options)
				{
					this.close();
				}
				_arg_1.stopImmediatePropagation();
			}

			private function close():void
			{
				stage.focus = null;
				parent.removeChild(this);
				if (Parameters.needToRecalcDesireables)
				{
					Parameters.setAutolootDesireables();
					Parameters.needToRecalcDesireables = false;
				}
			}

			private function onKeyUp(_arg_1:KeyboardEvent):void
			{
				_arg_1.stopImmediatePropagation();
			}

			private function removeOptions():void
			{
				var _local_1:Sprite;
                if (this.scrollContainer.contains(this.scrollContainerBottom))
                {
                    this.scrollContainer.removeChild(this.scrollContainerBottom);
                };
				for each (_local_1 in this.options_)
				{
                    this.scrollContainer.removeChild(_local_1);
				}
				this.options_.length = 0;
			}

			private function addControlsOptions():void
			{
				this.addOptionAndPosition(new KeyMapper("moveUp", TextKey.OPTIONS_MOVE_UP, TextKey.OPTIONS_MOVE_UP_DESC));
				this.addOptionAndPosition(new KeyMapper("moveLeft", TextKey.OPTIONS_MOVE_LEFT, TextKey.OPTIONS_MOVE_LEFT_DESC));
				this.addOptionAndPosition(new KeyMapper("moveDown", TextKey.OPTIONS_MOVE_DOWN, TextKey.OPTIONS_MOVE_DOWN_DESC));
				this.addOptionAndPosition(new KeyMapper("moveRight", TextKey.OPTIONS_MOVE_RIGHT, TextKey.OPTIONS_MOVE_RIGHT_DESC));
				this.addOptionAndPosition(this.makeAllowCameraRotation());
				this.addOptionAndPosition(this.makeAllowMiniMapRotation());
				this.addOptionAndPosition(new KeyMapper("rotateLeft", TextKey.OPTIONS_ROTATE_LEFT, TextKey.OPTIONS_ROTATE_LEFT_DESC, (!(Parameters.data_.allowRotation))));
				this.addOptionAndPosition(new KeyMapper("rotateRight", TextKey.OPTIONS_ROTATE_RIGHT, TextKey.OPTIONS_ROTATE_RIGHT_DESC, (!(Parameters.data_.allowRotation))));
				this.addOptionAndPosition(new KeyMapper("useSpecial", TextKey.OPTIONS_USE_SPECIAL_ABILITY, TextKey.OPTIONS_USE_SPECIAL_ABILITY_DESC));
				this.addOptionAndPosition(new KeyMapper("autofireToggle", TextKey.OPTIONS_AUTOFIRE_TOGGLE, TextKey.OPTIONS_AUTOFIRE_TOGGLE_DESC));
				this.addOptionAndPosition(new KeyMapper("toggleHPBar", TextKey.OPTIONS_TOGGLE_HPBAR, TextKey.OPTIONS_TOGGLE_HPBAR_DESC));
				this.addOptionAndPosition(new KeyMapper("resetToDefaultCameraAngle", TextKey.OPTIONS_RESET_CAMERA, TextKey.OPTIONS_RESET_CAMERA_DESC));
				this.addOptionAndPosition(new KeyMapper("togglePerformanceStats", TextKey.OPTIONS_TOGGLE_PERFORMANCE_STATS, TextKey.OPTIONS_TOGGLE_PERFORMANCE_STATS_DESC));
				this.addOptionAndPosition(new KeyMapper("toggleCentering", TextKey.OPTIONS_TOGGLE_CENTERING, TextKey.OPTIONS_TOGGLE_CENTERING_DESC));
				this.addOptionAndPosition(new KeyMapper("interact", TextKey.OPTIONS_INTERACT_OR_BUY, TextKey.OPTIONS_INTERACT_OR_BUY_DESC));
				this.addOptionAndPosition(makeClickForGold());
				this.addOptionAndPosition(makePotionBuy());
			}

			private function makeAllowCameraRotation():ChoiceOption
			{
				return (new ChoiceOption("allowRotation", makeOnOffLabels(), [true, false], TextKey.OPTIONS_ALLOW_ROTATION, TextKey.OPTIONS_ALLOW_ROTATION_DESC, this.onAllowRotationChange));
			}

			private function makeAllowMiniMapRotation():ChoiceOption
			{
				return (new ChoiceOption("allowMiniMapRotation", makeOnOffLabels(), [true, false], TextKey.OPTIONS_ALLOW_MINIMAP_ROTATION, TextKey.OPTIONS_ALLOW_MINIMAP_ROTATION_DESC, null));
			}

			private function onAllowRotationChange():void
			{
				var _local_2:KeyMapper;
				var _local_1:int;
				while (_local_1 < this.options_.length)
				{
					_local_2 = (this.options_[_local_1] as KeyMapper);
					if (_local_2 != null)
					{
						if (((_local_2.paramName_ == "rotateLeft") || (_local_2.paramName_ == "rotateRight")))
						{
							_local_2.setDisabled((!(Parameters.data_.allowRotation)));
						}
					}
					_local_1++;
				}
			}

			private function addHotKeysOptions():void
			{
				this.addOptionAndPosition(new KeyMapper("useHealthPotion", TextKey.OPTIONS_USE_BUY_HEALTH, TextKey.OPTIONS_USE_BUY_HEALTH_DESC));
				this.addOptionAndPosition(new KeyMapper("useMagicPotion", TextKey.OPTIONS_USE_BUY_MAGIC, TextKey.OPTIONS_USE_BUY_MAGIC_DESC));
				this.addInventoryOptions();
				this.addOptionAndPosition(new KeyMapper("miniMapZoomIn", TextKey.OPTIONS_MINI_MAP_ZOOM_IN, TextKey.OPTIONS_MINI_MAP_ZOOM_IN_DESC));
				this.addOptionAndPosition(new KeyMapper("miniMapZoomOut", TextKey.OPTIONS_MINI_MAP_ZOOM_OUT, TextKey.OPTIONS_MINI_MAP_ZOOM_OUT_DESC));
				this.addOptionAndPosition(new KeyMapper("escapeToNexus", TextKey.OPTIONS_ESCAPE_TO_NEXUS, TextKey.OPTIONS_ESCAPE_TO_NEXUS_DESC));
				this.addOptionAndPosition(new KeyMapper("options", TextKey.OPTIONS_SHOW_OPTIONS, TextKey.OPTIONS_SHOW_OPTIONS_DESC));
				this.addOptionAndPosition(new KeyMapper("switchTabs", TextKey.OPTIONS_SWITCH_TABS, TextKey.OPTIONS_SWITCH_TABS_DESC));
				this.addOptionAndPosition(new KeyMapper("GPURenderToggle", TextKey.OPTIONS_HARDWARE_ACC_HOTKEY_TITLE, TextKey.OPTIONS_HARDWARE_ACC_HOTKEY_DESC));
				this.addOptionAndPosition(new KeyMapper("toggleRealmQuestDisplay", "Toggle Realm Quests Display", "Toggle Expand/Collapse of the Realm Quests Display")); // TODO change to TextKey
				this.addOptionsChoiceOption();
				if (this.isAirApplication())
				{
					this.addOptionAndPosition(new KeyMapper("toggleFullscreen", TextKey.OPTIONS_TOGGLE_FULLSCREEN, TextKey.OPTIONS_TOGGLE_FULLSCREEN_DESC));
				}
			}

			public function isAirApplication():Boolean
			{
				return (Capabilities.playerType == "Desktop");
			}

			public function addOptionsChoiceOption():void
			{
				var _local_1:String = ((Capabilities.os.split(" ")[0] == "Mac") ? "Command" : "Ctrl");
				var _local_2:ChoiceOption = new ChoiceOption("inventorySwap", makeOnOffLabels(), [true, false], TextKey.OPTIONS_SWITCH_ITEM_IN_BACKPACK, "", null);
				_local_2.setTooltipText(new LineBuilder().setParams(TextKey.OPTIONS_SWITCH_ITEM_IN_BACKPACK_DESC, {"key": _local_1}));
				this.addOptionAndPosition(_local_2);
			}

			public function addInventoryOptions():void
			{
				var _local_2:KeyMapper;
				var _local_1:int = 1;
				while (_local_1 <= 8)
				{
					_local_2 = new KeyMapper(("useInvSlot" + _local_1), "", "");
					_local_2.setDescription(new LineBuilder().setParams(TextKey.OPTIONS_INVENTORY_SLOT_N, {"n": _local_1}));
					_local_2.setTooltipText(new LineBuilder().setParams(TextKey.OPTIONS_INVENTORY_SLOT_N_DESC, {"n": _local_1}));
					this.addOptionAndPosition(_local_2);
					_local_1++;
				}
			}

			private function addChatOptions():void
			{
				this.addOptionAndPosition(new KeyMapper(CHAT, TextKey.OPTIONS_ACTIVATE_CHAT, TextKey.OPTIONS_ACTIVATE_CHAT_DESC));
				this.addOptionAndPosition(new KeyMapper(CHAT_COMMAND, TextKey.OPTIONS_START_CHAT, TextKey.OPTIONS_START_CHAT_DESC));
				this.addOptionAndPosition(new KeyMapper(TELL, TextKey.OPTIONS_BEGIN_TELL, TextKey.OPTIONS_BEGIN_TELL_DESC));
				this.addOptionAndPosition(new KeyMapper(GUILD_CHAT, TextKey.OPTIONS_BEGIN_GUILD_CHAT, TextKey.OPTIONS_BEGIN_GUILD_CHAT_DESC));
				this.addOptionAndPosition(new ChoiceOption("filterLanguage", makeOnOffLabels(), [true, false], TextKey.OPTIONS_FILTER_OFFENSIVE_LANGUAGE, TextKey.OPTIONS_FILTER_OFFENSIVE_LANGUAGE_DESC, null));
				this.addOptionAndPosition(new KeyMapper(SCROLL_CHAT_UP, TextKey.OPTIONS_SCROLL_CHAT_UP, TextKey.OPTIONS_SCROLL_CHAT_UP_DESC));
				this.addOptionAndPosition(new KeyMapper(SCROLL_CHAT_DOWN, TextKey.OPTIONS_SCROLL_CHAT_DOWN, TextKey.OPTIONS_SCROLL_CHAT_DOWN_DESC));
				this.addOptionAndPosition(new ChoiceOption("forceChatQuality", makeOnOffLabels(), [true, false], TextKey.OPTIONS_FORCE_CHAT_QUALITY, TextKey.OPTIONS_FORCE_CHAT_QUALITY_DESC, null));
				this.addOptionAndPosition(new ChoiceOption("hidePlayerChat", makeOnOffLabels(), [true, false], TextKey.OPTIONS_HIDE_PLAYER_CHAT, TextKey.OPTIONS_HIDE_PLAYER_CHAT_DESC, null));
				this.addOptionAndPosition(new ChoiceOption("chatStarRequirement", makeStarSelectLabels(), [0, 1, 2, 3, 5, 10], TextKey.OPTIONS_STAR_REQ, TextKey.OPTIONS_CHAT_STAR_REQ_DESC, null));
				this.addOptionAndPosition(new ChoiceOption("chatAll", makeOnOffLabels(), [true, false], TextKey.OPTIONS_CHAT_ALL, TextKey.OPTIONS_CHAT_ALL_DESC, this.onAllChatEnabled));
				this.addOptionAndPosition(new ChoiceOption("chatWhisper", makeOnOffLabels(), [true, false], TextKey.OPTIONS_CHAT_WHISPER, TextKey.OPTIONS_CHAT_WHISPER_DESC, this.onAllChatDisabled));
				this.addOptionAndPosition(new ChoiceOption("chatGuild", makeOnOffLabels(), [true, false], TextKey.OPTIONS_CHAT_GUILD, TextKey.OPTIONS_CHAT_GUILD_DESC, this.onAllChatDisabled));
				this.addOptionAndPosition(new ChoiceOption("chatTrade", makeOnOffLabels(), [true, false], TextKey.OPTIONS_CHAT_TRADE, TextKey.OPTIONS_CHAT_TRADE_DESC, null));
			}

			private function onAllChatDisabled():void
			{
				var _local_2:ChoiceOption;
				Parameters.data_.chatAll = false;
				var _local_1:int;
				while (_local_1 < this.options_.length)
				{
					_local_2 = (this.options_[_local_1] as ChoiceOption);
					if (_local_2 != null)
					{
						switch (_local_2.paramName_)
						{
							case "chatAll":
								_local_2.refreshNoCallback();
								break;
						}
					}
					_local_1++;
				}
			}

			private function onAllChatEnabled():void
			{
				var _local_2:ChoiceOption;
				Parameters.data_.hidePlayerChat = false;
				Parameters.data_.chatWhisper = true;
				Parameters.data_.chatGuild = true;
				Parameters.data_.chatFriend = false;
				var _local_1:int;
				while (_local_1 < this.options_.length)
				{
					_local_2 = (this.options_[_local_1] as ChoiceOption);
					if (_local_2 != null)
					{
						switch (_local_2.paramName_)
						{
							case "hidePlayerChat":
							case "chatWhisper":
							case "chatGuild":
							case "chatFriend":
								_local_2.refreshNoCallback();
								break;
						}
					}
					_local_1++;
				}
			}

			private function addExperimentalOptions():void
			{
				this.addOptionAndPosition(new ChoiceOption("disableEnemyParticles", makeOnOffLabels(), [true, false], "Disable Enemy Particles", "Disable enemy hit and death particles.", null));
				this.addOptionAndPosition(new ChoiceOption("disableAllyShoot", makeAllyShootLabels(), [0, 1, 2], "Disable Ally Shoot", "Disable showing shooting animations and projectiles shot by allies or only projectiles.", null));
				this.addOptionAndPosition(new ChoiceOption("disablePlayersHitParticles", makeOnOffLabels(), [true, false], "Disable Players Hit Particles", "Disable player and ally hit particles.", null));
				this.addOptionAndPosition(new ChoiceOption("toggleToMaxText", makeOnOffLabels(), [true, false], TextKey.OPTIONS_TOGGLE_TOMAXTEXT, TextKey.OPTIONS_TOGGLE_TOMAXTEXT_DESC, onToMaxTextToggle));
				this.addOptionAndPosition(new ChoiceOption("newMiniMapColors", makeOnOffLabels(), [true, false], TextKey.OPTIONS_TOGGLE_NEWMINIMAPCOLORS, TextKey.OPTIONS_TOGGLE_NEWMINIMAPCOLORS_DESC, null));
				this.addOptionAndPosition(new ChoiceOption("noParticlesMaster", makeOnOffLabels(), [true, false], "Disable Particles Master", "Disable all nonessential particles besides enemy and ally hits. Throw, Area and certain other effects will remain.", null));
				this.addOptionAndPosition(new ChoiceOption("noAllyNotifications", makeOnOffLabels(), [true, false], "Disable Ally Notifications", "Disable text notifications above allies.", null));
				this.addOptionAndPosition(new ChoiceOption("noEnemyDamage", makeOnOffLabels(), [true, false], "Disable Enemy Damage Text", "Disable damage from other players above enemies.", null));
				this.addOptionAndPosition(new ChoiceOption("noAllyDamage", makeOnOffLabels(), [true, false], "Disable Ally Damage Text", "Disable damage above allies.", null));
				this.addOptionAndPosition(new ChoiceOption("forceEXP", makeForceExpLabels(), [0, 1, 2], "Always Show EXP", "Show EXP notifications even when level 20.", null));
				this.addOptionAndPosition(new ChoiceOption("showFameGain", makeOnOffLabels(), [true, false], "Show Fame Gain", "Shows notifications for each fame gained.", null));
				this.addOptionAndPosition(new ChoiceOption("curseIndication", makeOnOffLabels(), [true, false], "Curse Indication", "Makes enemies inflicted by Curse glow red.", null));
			}

			private function addGraphicsOptions():void
			{
				var _local_1:String;
				var _local_2:Number;
				this.addOptionAndPosition(new ChoiceOption("defaultCameraAngle", makeDegreeOptions(), [((7 * Math.PI) / 4), 0], TextKey.OPTIONS_DEFAULT_CAMERA_ANGLE, TextKey.OPTIONS_DEFAULT_CAMERA_ANGLE_DESC, onDefaultCameraAngleChange));
				this.addOptionAndPosition(new ChoiceOption("centerOnPlayer", makeOnOffLabels(), [true, false], TextKey.OPTIONS_CENTER_ON_PLAYER, TextKey.OPTIONS_CENTER_ON_PLAYER_DESC, null));
				this.addOptionAndPosition(new ChoiceOption("showQuestPortraits", makeOnOffLabels(), [true, false], TextKey.OPTIONS_SHOW_QUEST_PORTRAITS, TextKey.OPTIONS_SHOW_QUEST_PORTRAITS_DESC, this.onShowQuestPortraitsChange));
				this.addOptionAndPosition(new ChoiceOption("showProtips", makeOnOffLabels(), [true, false], TextKey.OPTIONS_SHOW_TIPS, TextKey.OPTIONS_SHOW_TIPS_DESC, null));
				this.addOptionAndPosition(new ChoiceOption("drawShadows", makeOnOffLabels(), [true, false], TextKey.OPTIONS_DRAW_SHADOWS, TextKey.OPTIONS_DRAW_SHADOWS_DESC, null));
				this.addOptionAndPosition(new ChoiceOption("textBubbles", makeOnOffLabels(), [true, false], TextKey.OPTIONS_DRAW_TEXT_BUBBLES, TextKey.OPTIONS_DRAW_TEXT_BUBBLES_DESC, null));
				this.addOptionAndPosition(new ChoiceOption("showTradePopup", makeOnOffLabels(), [true, false], TextKey.OPTIONS_SHOW_TRADE_REQUEST_PANEL, TextKey.OPTIONS_SHOW_TRADE_REQUEST_PANEL_DESC, null));
				this.addOptionAndPosition(new ChoiceOption("showGuildInvitePopup", makeOnOffLabels(), [true, false], TextKey.OPTIONS_SHOW_GUILD_INVITE_PANEL, TextKey.OPTIONS_SHOW_GUILD_INVITE_PANEL_DESC, null));
				this.addOptionAndPosition(new ChoiceOption("cursorSelect", makeCursorSelectLabels(), [MouseCursor.AUTO, "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11"], "Custom Cursor", "Click here to change the mouse cursor. May help with aiming.", refreshCursor));
				if (!Parameters.GPURenderError)
				{
					_local_1 = TextKey.OPTIONS_HARDWARE_ACC_DESC;
					_local_2 = 0xFFFFFF;
				}
				else
				{
					_local_1 = TextKey.OPTIONS_HARDWARE_ACC_DESC_ERROR;
					_local_2 = 16724787;
				}
				this.addOptionAndPosition(new ChoiceOption("GPURender", makeOnOffLabels(), [true, false], TextKey.OPTIONS_HARDWARE_ACC_TITLE, _local_1, null, _local_2));
				if (Capabilities.playerType == "Desktop")
				{
					this.addOptionAndPosition(new ChoiceOption("fullscreenMode", makeOnOffLabels(), [true, false], TextKey.OPTIONS_FULLSCREEN_MODE, TextKey.OPTIONS_FULLSCREEN_MODE_DESC, this.onFullscreenChange));
				}
				this.addOptionAndPosition(new ChoiceOption("toggleBarText", makeBarTextLabels(), [0, 1, 2, 3], "Toggle Fame and HP/MP Text", "Always show text value for Fame, remaining HP/MP, or both", onBarTextToggle));
				this.addOptionAndPosition(new ChoiceOption("particleEffect", makeHighLowLabels(), [true, false], TextKey.OPTIONS_TOGGLE_PARTICLE_EFFECT, TextKey.OPTIONS_TOGGLE_PARTICLE_EFFECT_DESC, null));
				this.addOptionAndPosition(new ChoiceOption("uiQuality", makeHighLowLabels(), [true, false], TextKey.OPTIONS_TOGGLE_UI_QUALITY, TextKey.OPTIONS_TOGGLE_UI_QUALITY_DESC, onUIQualityToggle));
				this.addOptionAndPosition(new ChoiceOption("HPBar", makeHpBarLabels(), [0, 1, 2, 3, 4, 5], TextKey.OPTIONS_HPBAR, TextKey.OPTIONS_HPBAR_DESC, null));
				this.addOptionAndPosition(new ChoiceOption("showTierTag", makeOnOffLabels(), [true, false], "Show Tier level", "Show Tier level on gear", this.onToggleTierTag));
				this.addOptionAndPosition(new KeyMapper("toggleProjectiles", "Toggle Ally Projectiles", "This key will toggle rendering of friendly projectiles"));
				this.addOptionAndPosition(new KeyMapper("toggleMasterParticles", "Toggle Particles", "This key will toggle rendering of nonessential particles (Particles Master option)"));
                this.addOptionAndPosition(new ChoiceOption("expandRealmQuestsDisplay", makeOnOffLabels(), [true, false], "Expand Realm Quests", "Expand the Realm Quests Display when entering the realm", null));
			}

			private function onToggleTierTag():void
			{
				StaticInjectorContext.getInjector().getInstance(ToggleShowTierTagSignal).dispatch(Parameters.data_.showTierTag);
			}

			private function onCharacterGlow():void
			{
				var _local_1:Player = this.gs_.map.player_;
				if (_local_1.hasSupporterFeature(1))
				{
					_local_1.clearTextureCache();
				}
			}

			private function onShowQuestPortraitsChange():void
			{
				if (((((!(this.gs_ == null)) && (!(this.gs_.map == null))) && (!(this.gs_.map.partyOverlay_ == null))) && (!(this.gs_.map.partyOverlay_.questArrow_ == null))))
				{
					this.gs_.map.partyOverlay_.questArrow_.refreshToolTip();
				}
			}

			private function onFullscreenChange():void
			{
				stage.displayState = ((Parameters.data_.fullscreenMode) ? StageDisplayState.FULL_SCREEN_INTERACTIVE : StageDisplayState.NORMAL);
			}

			private function addSoundOptions():void
			{
				this.addOptionAndPosition(new ChoiceOption("playMusic", makeOnOffLabels(), [true, false], TextKey.OPTIONS_PLAY_MUSIC, TextKey.OPTIONS_PLAY_MUSIC_DESC, this.onPlayMusicChange));
				this.addOptionAndPosition(new SliderOption("musicVolume", this.onMusicVolumeChange), -120, 15);
				this.addOptionAndPosition(new ChoiceOption("playSFX", makeOnOffLabels(), [true, false], TextKey.OPTIONS_PLAY_SOUND_EFFECTS, TextKey.OPTIONS_PLAY_SOUND_EFFECTS_DESC, this.onPlaySoundEffectsChange));
				this.addOptionAndPosition(new SliderOption("SFXVolume", this.onSoundEffectsVolumeChange), -120, 34);
				this.addOptionAndPosition(new ChoiceOption("playPewPew", makeOnOffLabels(), [true, false], TextKey.OPTIONS_PLAY_WEAPON_SOUNDS, TextKey.OPTIONS_PLAY_WEAPON_SOUNDS_DESC, null));
				if (!Parameters.ssmode)
				{
					this.addOptionAndPosition(new NullOption());
					this.addOptionAndPosition(new ChoiceOption("customSounds", makeOnOffLabels(), [true, false], "Custom Sounds", "Play custom sound effects", this.onCustomSFXVolumeChange));
					this.addOptionAndPosition(new SliderOption("customVolume", this.onCustomSFXVolumeChange), -120, 15);
				}
			}

			private function addMiscOptions():void
			{
				this.addOptionAndPosition(new ChoiceOption("showProtips", new <StringBuilder>[makeLineBuilder(TextKey.OPTIONS_LEGAL_VIEW), makeLineBuilder(TextKey.OPTIONS_LEGAL_VIEW)], [Parameters.data_.showProtips, Parameters.data_.showProtips], TextKey.OPTIONS_LEGAL_PRIVACY, TextKey.OPTIONS_LEGAL_PRIVACY_DESC, this.onLegalPrivacyClick));
				this.addOptionAndPosition(new NullOption());
				this.addOptionAndPosition(new ChoiceOption("showProtips", new <StringBuilder>[makeLineBuilder(TextKey.OPTIONS_LEGAL_VIEW), makeLineBuilder(TextKey.OPTIONS_LEGAL_VIEW)], [Parameters.data_.showProtips, Parameters.data_.showProtips], TextKey.OPTIONS_LEGAL_TOS, TextKey.OPTIONS_LEGAL_TOS_DESC, this.onLegalTOSClick));
				this.addOptionAndPosition(new NullOption());
			}

			private function addFriendOptions():void
			{
				this.addOptionAndPosition(new ChoiceOption("tradeWithFriends", makeOnOffLabels(), [true, false], TextKey.OPTIONS_TRADE_FRIEND, TextKey.OPTIONS_TRADE_FRIEND_DESC, this.onPlaySoundEffectsChange));
				this.addOptionAndPosition(new KeyMapper("friendList", TextKey.OPTIONS_SHOW_FRIEND_LIST, TextKey.OPTIONS_SHOW_FRIEND_LIST_DESC));
				this.addOptionAndPosition(new ChoiceOption("chatFriend", makeOnOffLabels(), [true, false], TextKey.OPTIONS_CHAT_FRIEND, TextKey.OPTIONS_CHAT_FRIEND_DESC, null));
				this.addOptionAndPosition(new ChoiceOption("friendStarRequirement", makeStarSelectLabels(), [0, 1, 2, 3, 5, 10], TextKey.OPTIONS_STAR_REQ, TextKey.OPTIONS_FRIEND_STAR_REQ_DESC, null));
			}

			private function onPlayMusicChange():void
			{
				Music.setPlayMusic(Parameters.data_.playMusic);
				if (Parameters.data_.playMusic)
				{
					Music.setMusicVolume(1);
				}
				else
				{
					Music.setMusicVolume(0);
				}
				this.refresh();
			}

			private function onPlaySoundEffectsChange():void
			{
				SFX.setPlaySFX(Parameters.data_.playSFX);
				if (((Parameters.data_.playSFX) || (Parameters.data_.playPewPew)))
				{
					SFX.setSFXVolume(1);
				}
				else
				{
					SFX.setSFXVolume(0);
				}
				this.refresh();
			}

			private function onPlayCustomSoundEffectsChange():void
			{
				SFX.setPlayCustomSFX(Parameters.data_.customSounds);
				if (Parameters.data_.customSounds)
				{
					SFX.setSFXVolume(Parameters.data_.customVolume);
				}
				else
				{
					SFX.setSFXVolume(0);
				}
				this.refresh();
			}

			private function onMusicVolumeChange(_arg_1:Number):void
			{
				Music.setMusicVolume(_arg_1);
			}

			private function onSoundEffectsVolumeChange(_arg_1:Number):void
			{
				SFX.setSFXVolume(_arg_1);
			}

			private function onCustomSFXVolumeChange(_arg_1:Number):void
			{
				SFX.setCustomSFXVolume(_arg_1);
			}

			private function onLegalPrivacyClick():void
			{
				var _local_1:URLRequest = new URLRequest();
				_local_1.url = Parameters.PRIVACY_POLICY_URL;
				_local_1.method = URLRequestMethod.GET;
				navigateToURL(_local_1, "_blank");
			}

			private function onLegalTOSClick():void
			{
				var _local_1:URLRequest = new URLRequest();
				_local_1.url = Parameters.TERMS_OF_USE_URL;
				_local_1.method = URLRequestMethod.GET;
				navigateToURL(_local_1, "_blank");
			}

			private function addOptionAndPosition(option:Option, offsetX:Number = 0, offsetY:Number = 0, smaller:Boolean = false):void
			{
				var positionOption:Function;
				positionOption = function ():void {
					option.x = ((((options_.length % 2) == 0) ? 20 : 415) + offsetX);
					option.y = (((int((options_.length / 2)) * ((smaller) ? 34 : 44)) + ((smaller) ? 109 : 122)) + offsetY);
				};
				option.textChanged.addOnce(positionOption);
				this.addOption(option);
			}

			private function addOption(_arg_1:Option):void
			{
                this.scrollContainer.addChild(_arg_1);
				_arg_1.addEventListener(Event.CHANGE, this.onChange);
				this.options_.push(_arg_1);
			}

			private function onChange(_arg_1:Event):void
			{
				this.refresh();
			}

			private function refresh():void
			{
				var _local_2:BaseOption;
				var _local_1:int;
				while (_local_1 < this.options_.length)
				{
					_local_2 = (this.options_[_local_1] as BaseOption);
					if (_local_2 != null)
					{
						_local_2.refresh();
					}
					_local_1++;
				}
			}


		}
	}//package com.company.assembleegameclient.ui.options

