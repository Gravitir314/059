//io.decagames.rotmg.supportCampaign.tab.tiers.preview.TiersPreview

package io.decagames.rotmg.supportCampaign.tab.tiers.preview
{
	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;

	import io.decagames.rotmg.ui.buttons.SliceScalingButton;
	import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
	import io.decagames.rotmg.ui.labels.UILabel;
	import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
	import io.decagames.rotmg.ui.texture.TextureParser;

	import kabam.display.Loader.LoaderProxy;
	import kabam.display.Loader.LoaderProxyConcrete;

	public class TiersPreview extends Sprite
	{
		private var background:DisplayObject;
		//private var background:SliceScalingBitmap;
		private var _loader:LoaderProxy = new LoaderProxyConcrete();
		private var _tier:int;
		private var _currentRank:int;
		private var _claimed:int;
		private var _leftArrow:SliceScalingButton;
		private var _rightArrow:SliceScalingButton;
		private var _startTier:int;
		private var _claimButton:SliceScalingButton;
		private var supportIcon:SliceScalingBitmap;
		private var donateButtonBackground:SliceScalingBitmap;
		private var componentWidth:int;
		private var requiredPointsContainer:Sprite;
		private var ranks:Array;
		private var selectTween:TimelineMax;

		public function TiersPreview(_arg_1:int, _arg_2:Array, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:String)
		{
			this._startTier = _arg_1;
			this.ranks = _arg_2;
			this.componentWidth = _arg_5;
			this._claimButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "generic_green_button"));
			this._claimButton.setLabel("Claim", DefaultLabelFormat.defaultButtonLabel);
			this.showTier(_arg_1, _arg_3, _arg_4, _arg_6);
			//this.showTier(_arg_1, _arg_3, _arg_4)
			this._rightArrow = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "tier_arrow"));
			addChild(this._rightArrow);
			this._rightArrow.x = 533;
			this._rightArrow.y = 103;
			this._leftArrow = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "tier_arrow"));
			this._leftArrow.rotation = 180;
			this._leftArrow.x = -3;
			this._leftArrow.y = 133;
			addChild(this._leftArrow);
		}

		public function showTier(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String):void
		{
			/*var _local_5:*/
			this._tier = _arg_1; //_tier
			/*var _local_4:**/
			this._currentRank = _arg_2; //_currentRank
			/*var _local_6:**/
			this._claimed = _arg_3; //_claimed
			if (_arg_4)
			{
				if (((this.background) && (this.background.parent)))
				{
					removeChild(this.background);
				}
				;this.loadPictureFromUrl(_arg_4);
			}
			if (((this.background) && (this.background.parent)))
			{
				removeChild(this.background);
			}

		}

		private function renderButtons(_arg_1:int, _arg_2:int, _arg_3:int):void
		{
			var _local_4:UILabel;
			var _local_5:UILabel;
			if (((this.donateButtonBackground) && (this.donateButtonBackground.parent)))
			{
				removeChild(this.donateButtonBackground);
			}
			if (((this._claimButton) && (this._claimButton.parent)))
			{
				removeChild(this._claimButton);
			}
			if (((this.requiredPointsContainer) && (this.requiredPointsContainer.parent)))
			{
				removeChild(this.requiredPointsContainer);
			}
			if (((_arg_1 > _arg_3) && (!(_arg_1 == (this.ranks.length + 1)))))
			{
				this.donateButtonBackground = TextureParser.instance.getSliceScalingBitmap("UI", "main_button_decoration_dark", 160);
				this.donateButtonBackground.x = Math.round(((this.componentWidth - this.donateButtonBackground.width) / 2));
				this.donateButtonBackground.y = 178;
				addChild(this.donateButtonBackground);
				if (_arg_2 >= _arg_1)
				{
					this._claimButton.width = (this.donateButtonBackground.width - 48);
					this._claimButton.y = (this.donateButtonBackground.y + 6);
					this._claimButton.x = (this.donateButtonBackground.x + 24);
					addChild(this._claimButton);
				} else
				{
					this.requiredPointsContainer = new Sprite();
					_local_4 = new UILabel();
					DefaultLabelFormat.createLabelFormat(_local_4, 22, 15585539, "center", true);
					this.requiredPointsContainer.addChild(_local_4);
					this.supportIcon = TextureParser.instance.getSliceScalingBitmap("UI", "campaign_Points");
					this.requiredPointsContainer.addChild(this.supportIcon);
					_local_4.text = this.ranks[(_arg_1 - 1)].toString();
					_local_4.x = ((this.donateButtonBackground.x + Math.round(((this.donateButtonBackground.width - _local_4.width) / 2))) - 10);
					_local_4.y = (this.donateButtonBackground.y + 13);
					this.supportIcon.y = (_local_4.y + 3);
					this.supportIcon.x = (_local_4.x + _local_4.width);
					addChild(this.requiredPointsContainer);
				}
			} else
			{
				if (_arg_3)
				{
					this.requiredPointsContainer = new Sprite();
					_local_5 = new UILabel();
					DefaultLabelFormat.createLabelFormat(_local_5, 22, 0x4BA800, "center", true);
					this.requiredPointsContainer.addChild(_local_5);
					_local_5.text = "Claimed";
					_local_5.x = (this.background.x + Math.round(((this.background.width - _local_5.width) / 2)));
					_local_5.y = 190;
					addChild(this.requiredPointsContainer);
				}
			}
		}

		public function selectAnimation():void
		{
			if (!this.selectTween)
			{
				this.selectTween = new TimelineMax();
				this.selectTween.add(TweenMax.to(this, 0.05, {"tint": 0xFFFFFF}));
				this.selectTween.add(TweenMax.to(this, 0.3, {
					"tint": null, "ease": Expo.easeOut
				}));
			} else
			{
				this.selectTween.play(0);
			}
		}

		private function loadPictureFromUrl(_arg_1:String):void
		{
			((this._loader) && (this._loader.unload()));
			this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onComplete);
			this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onError);
			this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.DISK_ERROR, this.onError);
			this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.NETWORK_ERROR, this.onError);
			this._loader.load(new URLRequest(_arg_1));
		}

		private function onError(_arg_1:IOErrorEvent):void
		{
		}

		private function onComplete(_arg_1:Event):void
		{
			this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onComplete);
			this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onError);
			this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.DISK_ERROR, this.onError);
			this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.NETWORK_ERROR, this.onError);
			this.background = this._loader.content;
			addChildAt(this.background, 0);
			this.renderButtons(this._tier, this._currentRank, this._claimed);
		}

		public function get leftArrow():SliceScalingButton
		{
			return (this._leftArrow);
		}

		public function get rightArrow():SliceScalingButton
		{
			return (this._rightArrow);
		}

		public function get startTier():int
		{
			return (this._startTier);
		}

		public function get claimButton():SliceScalingButton
		{
			return (this._claimButton);
		}

	}
}//package io.decagames.rotmg.supportCampaign.tab.tiers.preview

