//io.decagames.rotmg.supportCampaign.tab.SupporterShopTabView

package io.decagames.rotmg.supportCampaign.tab
	{
	import flash.display.Bitmap;
	import flash.display.Sprite;

	import io.decagames.rotmg.shop.ShopBuyButton;
	import io.decagames.rotmg.supportCampaign.data.vo.RankVO;
	import io.decagames.rotmg.supportCampaign.tab.donate.DonatePanel;
	import io.decagames.rotmg.supportCampaign.tab.tiers.preview.TiersPreview;
	import io.decagames.rotmg.supportCampaign.tab.tiers.progressBar.TiersProgressBar;
	import io.decagames.rotmg.ui.buttons.SliceScalingButton;
	import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
	import io.decagames.rotmg.ui.labels.UILabel;
	import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
	import io.decagames.rotmg.ui.tabs.UITab;
	import io.decagames.rotmg.ui.texture.TextureParser;
	import io.decagames.rotmg.utils.date.TimeSpan;

	public class SupporterShopTabView extends UITab
		{

			private var backgroundWidth:int = 561;
			private var background:SliceScalingBitmap;
			private var _unlockButton:ShopBuyButton;
			private var _countdown:UILabel;
			private var _campaignTimer:UILabel;
			private var unlockScreenContainer:Sprite;
			private var pointsInfo:UILabel;
			private var supportIcon:SliceScalingBitmap;
			private var _infoButton:SliceScalingButton;
			private var fieldBackground:SliceScalingBitmap;
			private var endDateInfo:UILabel;
			private var tiersPreview:TiersPreview;
			private var pointsBitmap:Bitmap;
			private var progressBar:TiersProgressBar;
			private var pName:String;

			public function SupporterShopTabView()
			{
				super("Supporter");
				this._countdown = new UILabel();
				this._campaignTimer = new UILabel();
			}

			public function show(_arg_1:String, _arg_2:Boolean, _arg_3:Boolean, _arg_4:int, _arg_5:int):void
			{
				this.pName = _arg_1;
				this.drawBackground(_arg_2);
				if (_arg_2)
				{
					if (this.unlockScreenContainer != null)
					{
						removeChild(this.unlockScreenContainer);
						this.unlockScreenContainer = null;
					}
					this.drawDonatePanel(_arg_5);
				}
				else
				{
					this.showUnlockScreen(_arg_3, _arg_4, _arg_5);
				}
			}

			public function updateStartCountdown(_arg_1:String):void
			{
				this._countdown.text = _arg_1;
				if (_arg_1 == "")
				{
					this._campaignTimer.text = "";
				}
			}

			public function updatePoints(_arg_1:int, _arg_2:int):void
			{
				if (!this.pointsInfo)
				{
					this.fieldBackground = TextureParser.instance.getSliceScalingBitmap("UI", "bordered_field", 150);
					addChild(this.fieldBackground);
					this.pointsInfo = new UILabel();
					DefaultLabelFormat.createLabelFormat(this.pointsInfo, 18, 15585539, "center", true);
					addChild(this.pointsInfo);
					this.supportIcon = TextureParser.instance.getSliceScalingBitmap("UI", "campaign_Points");
					addChild(this.supportIcon);
					this._infoButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "tier_info"));
					addChild(this._infoButton);
				}
				this.pointsInfo.text = ((_arg_2 == 0) ? "No rank" : _arg_1.toString());
				this.pointsInfo.x = (((this.background.width / 2) - (this.pointsInfo.width / 2)) + 8);
				this.pointsInfo.y = (this.background.y - 8);
				this.fieldBackground.y = (this.pointsInfo.y - 5);
				this.fieldBackground.x = (((this.background.width / 2) - (this.fieldBackground.width / 2)) + 13);
				this.supportIcon.y = (this.pointsInfo.y + 1);
				this.supportIcon.x = (this.pointsInfo.x + this.pointsInfo.width);
				this._infoButton.y = (this.fieldBackground.y + 1);
				this._infoButton.x = (this.fieldBackground.x + 3);
			}

			public function updateTime(_arg_1:Number):void
			{
				var _local_2:TimeSpan = new TimeSpan(_arg_1);
				var _local_3:String = "Supporter campaign will end in: ";
				if (_local_2.totalDays == 0)
				{
					_local_3 = (_local_3 + (((((_local_2.hours > 9) ? _local_2.hours.toString() : ("0" + _local_2.hours.toString())) + "h ") + ((_local_2.minutes > 9) ? _local_2.minutes.toString() : ("0" + _local_2.minutes.toString()))) + "m"));
				}
				else
				{
					_local_3 = (_local_3 + (((((_local_2.days > 9) ? _local_2.days.toString() : ("0" + _local_2.days.toString())) + "d ") + ((_local_2.hours > 9) ? _local_2.hours.toString() : ("0" + _local_2.hours.toString()))) + "h"));
				}
				if (!this.endDateInfo)
				{
					this.endDateInfo = new UILabel();
					DefaultLabelFormat.createLabelFormat(this.endDateInfo, 14, 0xFE9700, "center", false);
					addChild(this.endDateInfo);
				}
				this.endDateInfo.text = _local_3;
				this.endDateInfo.wordWrap = true;
				this.endDateInfo.width = (this.background.width - 13);
				this.endDateInfo.x = (this.background.x + 13);
				this.endDateInfo.y = ((this.background.y + this.background.height) - 115);
			}

			public function showTier(_arg_1:int, _arg_2:Array, _arg_3:int, _arg_4:int):void
			{
				if (!this.tiersPreview)
				{
					this.tiersPreview = new TiersPreview(_arg_1, _arg_2, _arg_3, _arg_4, 530);
					this.tiersPreview.x = (this.background.x + 15);
					this.tiersPreview.y = (this.background.y + 20);
					addChild(this.tiersPreview);
				}
				this.tiersPreview.showTier(_arg_1, _arg_3, _arg_4);
			}

			public function drawProgress(_arg_1:int, _arg_2:Vector.<RankVO>, _arg_3:int, _arg_4:int):void
			{
				if (!this.progressBar)
				{
					this.progressBar = new TiersProgressBar(_arg_2, 530);
					this.progressBar.x = (this.background.x + 15);
					this.progressBar.y = 285;
					addChild(this.progressBar);
				}
				this.progressBar.show(_arg_1, _arg_3, _arg_4);
			}

			private function showUnlockScreen(_arg_1:Boolean, _arg_2:int, _arg_3:int):void
			{
				var _local_4:UILabel;
				this.unlockScreenContainer = new Sprite();
				this.unlockScreenContainer.x = 30;
				this.unlockScreenContainer.y = 10;
				var _local_6:SliceScalingBitmap = TextureParser.instance.getSliceScalingBitmap("UI", "support_campaign_unlock_screen");
				this.unlockScreenContainer.addChild(_local_6);
				var _local_7:UILabel = new UILabel();
				_local_7.text = (("Welcome to the Unity Support Campaign, " + this.pName) + "!");
				DefaultLabelFormat.createLabelFormat(_local_7, 18, 0xEAEAEA, "left", true);
				_local_7.wordWrap = true;
				_local_7.width = (_local_6.width - 20);
				_local_7.y = 10;
				_local_7.x = 10;
				this.unlockScreenContainer.addChild(_local_7);
				_local_4 = new UILabel();
				_local_4.text = "We are bringing your favorite bullet-hell MMO to Unity! Being a small team we need your support to make it happen and you can start right here. Donate 500 Gold to the cause and get your name displayed on the Wall of Fame upon release, alongside all our avid supporters from across the globe!";
				DefaultLabelFormat.createLabelFormat(_local_4, 14, 0xEAEAEA, "justify", false);
				_local_4.wordWrap = true;
				_local_4.width = (_local_6.width - 20);
				_local_4.y = ((_local_7.y + _local_7.height) + 10);
				_local_4.x = 10;
				this.unlockScreenContainer.addChild(_local_4);
				var _local_5:UILabel = new UILabel();
				_local_5.text = "Add Your Name to the Wall of Fame";
				DefaultLabelFormat.createLabelFormat(_local_5, 16, 0xEAEAEA, "center", true);
				_local_5.wordWrap = true;
				_local_5.width = _local_6.width;
				_local_5.y = ((_local_4.y + _local_4.height) + 15);
				this.unlockScreenContainer.addChild(_local_5);
				var _local_8:SliceScalingBitmap = new TextureParser().getSliceScalingBitmap("UI", "main_button_decoration_dark", 150);
				this.unlockScreenContainer.addChild(_local_8);
				this._unlockButton = new ShopBuyButton(_arg_2);
				this._unlockButton.width = (_local_8.width - 48);
				this._unlockButton.disabled = (!(_arg_1));
				this.unlockScreenContainer.addChild(this._unlockButton);
				_local_8.y = ((_local_5.y + _local_5.height) + 3);
				_local_8.x = Math.round(((_local_6.width - _local_8.width) / 2));
				this._unlockButton.y = (_local_8.y + 6);
				this._unlockButton.x = (_local_8.x + 24);
				var _local_9:UILabel = new UILabel();
				_local_9.text = "After leaving your lasting mark on the Realm of the Mad God Wall of Fame, you will be able to donate additional Gold if you so choose. We have placed some unique gifts at certain thresholds on top of our heartfelt gratitude and we hope you will have a lot of fun with them.\n\nWe are excited to have you join us on this journey!\n\nYour Realm Team";
				DefaultLabelFormat.createLabelFormat(_local_9, 14, 0xEAEAEA, "justify", false);
				_local_9.wordWrap = true;
				_local_9.width = (_local_6.width - 20);
				_local_9.y = ((_local_8.y + _local_8.height) + 40);
				_local_9.x = 10;
				this.unlockScreenContainer.addChild(_local_9);
				if (!_arg_1)
				{
					this._campaignTimer.text = "Supporter campaign will start in:";
					DefaultLabelFormat.createLabelFormat(this._countdown, 18, 0xFE9700, "center", true);
					this._countdown.text = "";
					this._countdown.wordWrap = true;
					this._countdown.width = _local_6.width;
					this._countdown.y = 205;
					this.unlockScreenContainer.addChild(this._countdown);
				}
				DefaultLabelFormat.createLabelFormat(this._campaignTimer, 14, 0xFE9700, "center", false);
				this._campaignTimer.wordWrap = true;
				this._campaignTimer.width = _local_6.width;
				this._campaignTimer.y = 190;
				this.unlockScreenContainer.addChild(this._campaignTimer);
				addChild(this.unlockScreenContainer);
			}

			public function updateTimerPosition():void
			{
			}

			private function drawBackground(_arg_1:Boolean):void
			{
				this.background = TextureParser.instance.getSliceScalingBitmap("UI", "shop_box_background", this.backgroundWidth);
				addChild(this.background);
				this.background.height = 375;
				this.background.x = 14;
				this.background.y = 0;
			}

			private function drawDonatePanel(_arg_1:int):void
			{
				var _local_2:DonatePanel = new DonatePanel(_arg_1);
				addChild(_local_2);
				_local_2.x = (this.background.x + Math.round(((this.backgroundWidth - _local_2.width) / 2)));
				_local_2.y = (this.background.height - 55);
			}

			public function get unlockButton():ShopBuyButton
			{
				return (this._unlockButton);
			}

			public function get infoButton():SliceScalingButton
			{
				return (this._infoButton);
			}


		}
	}//package io.decagames.rotmg.supportCampaign.tab

