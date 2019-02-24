﻿//io.decagames.rotmg.supportCampaign.tab.SupporterShopTabView

package io.decagames.rotmg.supportCampaign.tab
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.text.TextFormatAlign;

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

		public function show(_arg_1:String, _arg_2:Boolean, _arg_3:Boolean, _arg_4:int, _arg_5:int, _arg_6:Boolean):void
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
				this.drawDonatePanel(_arg_5, _arg_6);
			} else
			{
				this.showUnlockScreen(_arg_3, _arg_4, _arg_5, _arg_6);
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
				DefaultLabelFormat.createLabelFormat(this.pointsInfo, 18, 15585539, TextFormatAlign.CENTER, true);
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
			if (_local_2.totalMilliseconds <= 0)
			{
				_local_3 = "Campaign has ended!";
			} else
			{
				if (_local_2.totalDays == 0)
				{
					_local_3 = (_local_3 + (((((_local_2.hours > 9) ? _local_2.hours.toString() : ("0" + _local_2.hours.toString())) + "h ") + ((_local_2.minutes > 9) ? _local_2.minutes.toString() : ("0" + _local_2.minutes.toString()))) + "m"));
				} else
				{
					_local_3 = (_local_3 + (((((_local_2.days > 9) ? _local_2.days.toString() : ("0" + _local_2.days.toString())) + "d ") + ((_local_2.hours > 9) ? _local_2.hours.toString() : ("0" + _local_2.hours.toString()))) + "h"));
				}
				;
			}
			if (!this.endDateInfo)
			{
				this.endDateInfo = new UILabel();
				DefaultLabelFormat.createLabelFormat(this.endDateInfo, 14, 0xFE9700, TextFormatAlign.CENTER, false);
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

		private function showUnlockScreen(_arg_1:Boolean, _arg_2:int, _arg_3:int, _arg_4:Boolean):void
		{
			var _local_7:UILabel;
			this.unlockScreenContainer = new Sprite();
			this.unlockScreenContainer.x = 30;
			this.unlockScreenContainer.y = 10;
			var _local_5:SliceScalingBitmap = TextureParser.instance.getSliceScalingBitmap("UI", "support_campaign_unlock_screen");
			this.unlockScreenContainer.addChild(_local_5);
			var _local_6:UILabel = new UILabel();
			_local_6.text = (("Welcome to the Unity Support Campaign, " + this.pName) + "!");
			DefaultLabelFormat.createLabelFormat(_local_6, 18, 0xEAEAEA, TextFormatAlign.LEFT, true);
			_local_6.wordWrap = true;
			_local_6.width = (_local_5.width - 20);
			_local_6.y = 10;
			_local_6.x = 10;
			this.unlockScreenContainer.addChild(_local_6);
			_local_7 = new UILabel();
			_local_7.text = (("We are bringing your favorite bullet-hell MMO to Unity and we need your support to make it happen! You can start right here. Join the cause, unlock the campaign and get your name displayed on the Wall of Fame upon release, alongside all our avid supporters from across the globe!\n" + "\n") + "After leaving your lasting mark in the game, you will be able to push onward and claim some unique gifts on top of our heartfelt gratitude. Our greatest supporters will also unlock an exclusive character glow.");
			DefaultLabelFormat.createLabelFormat(_local_7, 14, 0xEAEAEA, TextFormatAlign.JUSTIFY, false);
			_local_7.wordWrap = true;
			_local_7.width = (_local_5.width - 20);
			_local_7.y = (_local_6.y + _local_6.height);
			_local_7.x = 10;
			this.unlockScreenContainer.addChild(_local_7);
			var _local_8:SliceScalingBitmap = new TextureParser().getSliceScalingBitmap("UI", "uniqueGifts", 500);
			this.unlockScreenContainer.addChild(_local_8);
			_local_8.y = ((_local_7.y + _local_7.height) + 5);
			_local_8.x = Math.round(((_local_5.width - _local_8.width) / 2));
			var _local_9:UILabel = new UILabel();
			_local_9.text = "Add Your Name to the Wall of Fame";
			DefaultLabelFormat.createLabelFormat(_local_9, 16, 0xEAEAEA, TextFormatAlign.CENTER, true);
			_local_9.wordWrap = true;
			_local_9.width = _local_5.width;
			_local_9.y = ((_local_7.y + _local_7.height) + 130);
			this.unlockScreenContainer.addChild(_local_9);
			var _local_10:SliceScalingBitmap = new TextureParser().getSliceScalingBitmap("UI", "main_button_decoration_dark", 150);
			this.unlockScreenContainer.addChild(_local_10);
			this._unlockButton = new ShopBuyButton(_arg_2);
			this._unlockButton.width = (_local_10.width - 48);
			this._unlockButton.disabled = ((!(_arg_1)) || (_arg_4));
			this.unlockScreenContainer.addChild(this._unlockButton);
			_local_10.y = (_local_9.y + _local_9.height);
			_local_10.x = Math.round(((_local_5.width - _local_10.width) / 2));
			this._unlockButton.y = (_local_10.y + 6);
			this._unlockButton.x = (_local_10.x + 24);
			if (!_arg_1)
			{
				this._campaignTimer.text = "Supporter campaign will start in:";
				DefaultLabelFormat.createLabelFormat(this._countdown, 18, 0xFE9700, TextFormatAlign.CENTER, true);
				this._countdown.text = "";
				this._countdown.wordWrap = true;
				this._countdown.width = _local_5.width;
				this._countdown.y = ((_local_8.y + _local_8.height) + 20);
				this.unlockScreenContainer.addChild(this._countdown);
			} else
			{
				if (_arg_4)
				{
					this._campaignTimer.text = "Campaign has ended!";
					DefaultLabelFormat.createLabelFormat(this._countdown, 18, 0xFE9700, TextFormatAlign.CENTER, true);
					this._countdown.text = "";
					this._countdown.wordWrap = true;
					this._countdown.width = _local_5.width;
					this._countdown.y = 197;
					this.unlockScreenContainer.addChild(this._countdown);
				}
				;
			}
			;DefaultLabelFormat.createLabelFormat(this._campaignTimer, 14, 0xFE9700, TextFormatAlign.CENTER, false);
			this._campaignTimer.wordWrap = true;
			this._campaignTimer.width = _local_5.width;
			this._campaignTimer.y = ((_local_8.y + _local_8.height) + 5);
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

		private function drawDonatePanel(_arg_1:int, _arg_2:Boolean):void
		{
			var _local_3:DonatePanel = new DonatePanel(_arg_1, _arg_2);
			addChild(_local_3);
			_local_3.x = (this.background.x + Math.round(((this.backgroundWidth - _local_3.width) / 2)));
			_local_3.y = (this.background.height - 55);
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

