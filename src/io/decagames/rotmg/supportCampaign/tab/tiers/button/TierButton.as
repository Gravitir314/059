//io.decagames.rotmg.supportCampaign.tab.tiers.button.TierButton

package io.decagames.rotmg.supportCampaign.tab.tiers.button
	{
    import com.greensock.TimelineMax;
    import com.greensock.TweenMax;
    import com.greensock.easing.Expo;

    import flash.display.Sprite;
    import flash.filters.GlowFilter;

    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import io.decagames.rotmg.ui.labels.UILabel;
    import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
    import io.decagames.rotmg.ui.texture.TextureParser;

    public class TierButton extends Sprite
		{

			private const OUTLINE_FILTER:GlowFilter = new GlowFilter(0xFFFFFF, 1, 3, 3, 16, 3, false, false);
			private const GLOW_FILTER:GlowFilter = new GlowFilter(5439314, 0.4, 2, 2, 16, 3, false, false);

			private var background:SliceScalingBitmap;
			private var _tier:int;
			private var _status:int;
			private var _selected:Boolean;
			private var tierLabel:UILabel;
			private var tierTween:TimelineMax;
			private var claimTween:TimelineMax;

			public function TierButton(_arg_1:int, _arg_2:int)
			{
				this._tier = _arg_1;
				this._status = _arg_2;
				this.tierLabel = new UILabel();
				this.updateStatus(_arg_2);
			}

			private function convertToRoman(num:int):String
			{
				var keys:Object;
				var i:int;
				var roman:String;
				if (num > 9999)
				{
					return ("");
				}
				if (!num)
				{
					return ("");
				}
				var arr:Array = String(num).split("");
				keys = {
					"1": ["", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"],
					"2": ["", "X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC"],
					"3": ["", "C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM"],
					"4": ["", "M", "MM", "MMM", "MMMM", "MMMMM", "MMMMMM", "MMMMMMM", "MMMMMMMM", "MMMMMMMMM"]
				};
				i = arr.length;
				roman = "";
				arr.forEach(function (_arg_1:int, _arg_2:int, _arg_3:Array):void {
					roman = (roman + keys[i][_arg_1]);
					i--;
				});
				return (roman);
			}

			public function updateStatus(_arg_1:int):void
			{
				if (((this.background) && (this.background.parent)))
				{
					removeChild(this.background);
				}
				switch (_arg_1)
				{
					case 0:
						this.background = TextureParser.instance.getSliceScalingBitmap("UI", ("tier_locked_" + this.convertToRoman(this._tier)));
						this.background.y = -3;
						addChildAt(this.background, 0);
						DefaultLabelFormat.createLabelFormat(this.tierLabel, 12, 0x353535, "center", true);
						this.tierLabel.wordWrap = true;
						this.tierLabel.text = this.convertToRoman(this._tier);
						this.tierLabel.width = this.background.width;
						this.tierLabel.y = 6;
						break;
					case 1:
						this.background = TextureParser.instance.getSliceScalingBitmap("UI", "tier_unlocked");
						this.background.y = -5;
						addChildAt(this.background, 0);
						DefaultLabelFormat.createLabelFormat(this.tierLabel, 18, 0xFFFFFF, "center", true);
						this.tierLabel.wordWrap = true;
						this.tierLabel.text = this.convertToRoman(this._tier);
						this.tierLabel.width = this.background.width;
						this.tierLabel.y = 4;
						this.tierLabel.filters = [this.GLOW_FILTER];
						if (!this.claimTween)
						{
							this.claimTween = new TimelineMax({"repeat": -1});
							this.claimTween.add(TweenMax.to(this, 0.2, {
								"tint": null,
								"ease": Expo.easeIn
							}));
							this.claimTween.add(TweenMax.to(this, 0.2, {
								"delay": 0.5,
								"tint": 0xFFFFFF
							}));
							this.claimTween.add(TweenMax.to(this, 0.5, {
								"tint": null,
								"ease": Expo.easeOut
							}));
						}
						else
						{
							this.claimTween.play(0);
						}
						break;
					case 2:
						this.background = TextureParser.instance.getSliceScalingBitmap("UI", "tier_claimed");
						this.background.y = -3;
						addChildAt(this.background, 0);
						DefaultLabelFormat.createLabelFormat(this.tierLabel, 0, 0xFFFFFF, "center", true);
						this.tierLabel.text = "";
						this.tierLabel.y = 6;
						if (this.claimTween)
						{
							this.claimTween.pause(0);
						}
					default:
				}
				addChild(this.tierLabel);
				this.applySelectFilter();
			}

			public function get selected():Boolean
			{
				return (this._selected);
			}

			public function set selected(_arg_1:Boolean):void
			{
				this._selected = _arg_1;
				this.applySelectFilter();
			}

			private function applySelectFilter():void
			{
				if (this._selected)
				{
					this.background.filters = [this.OUTLINE_FILTER];
					if (!this.tierTween)
					{
						this.tierTween = new TimelineMax();
						this.tierTween.add(TweenMax.to(this, 0.05, {
							"scaleX": 0.9,
							"scaleY": 0.9,
							"x": (this.x + ((this.width * 0.1) / 2)),
							"y": (this.y + ((this.height * 0.1) / 2)),
							"tint": 0xFFFFFF
						}));
						this.tierTween.add(TweenMax.to(this, 0.3, {
							"scaleX": 1,
							"scaleY": 1,
							"x": this.x,
							"y": this.y,
							"tint": null,
							"ease": Expo.easeOut
						}));
					}
					else
					{
						this.tierTween.play(0);
					}
				}
				else
				{
					this.background.filters = [];
				}
			}

			public function get label():UILabel
			{
				return (this.tierLabel);
			}

			public function get tier():int
			{
				return (this._tier);
			}


		}
	}//package io.decagames.rotmg.supportCampaign.tab.tiers.button

