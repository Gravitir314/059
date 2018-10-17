//kabam.rotmg.ui.view.StatMetersView

package kabam.rotmg.ui.view
	{
	import com.company.assembleegameclient.objects.Player;
	import com.company.assembleegameclient.parameters.Parameters;
	import com.company.assembleegameclient.ui.ExperienceBoostTimerPopup;
	import com.company.assembleegameclient.ui.StatusBar;

	import flash.display.Sprite;
	import flash.events.Event;

	import kabam.rotmg.text.model.TextKey;

	public class StatMetersView extends Sprite
		{

			private var expBar_:StatusBar;
			private var fameBar_:StatusBar;
			private var hpBar_:StatusBar;
			public var clientHpBar_:StatusBar;
			private var mpBar_:StatusBar;
			private var areTempXpListenersAdded:Boolean;
			private var curXPBoost:int;
			private var expTimer:ExperienceBoostTimerPopup;

			public function StatMetersView()
			{
				init();
			}

			public function init():void // TODO minimize this
			{
				if (!Parameters.ssmode && Parameters.data_.showCHbar)
				{
					this.expBar_ = new StatusBar(176, 15, 5931045, 0x545454, TextKey.EXP_BAR_LEVEL, false, null, false, true);
					this.fameBar_ = new StatusBar(176, 15, 0xE25F00, 0x545454, TextKey.CURRENCY_FAME, false, null, false, true);
					this.hpBar_ = new StatusBar(176, 15, 14693428, 0x545454, TextKey.STATUS_BAR_HEALTH_POINTS);
					this.clientHpBar_ = new StatusBar(176, 15, 14693428, 0x545454, "CH");
					this.mpBar_ = new StatusBar(176, 15, 6325472, 0x545454, TextKey.STATUS_BAR_MANA_POINTS);
					this.hpBar_.y = 16;
					this.clientHpBar_.y = 32;
					this.mpBar_.y = 48;
					this.expBar_.visible = true;
					this.fameBar_.visible = false;
					this.clientHpBar_.visible = true;
				}
				else
				{
					this.expBar_ = new StatusBar(176, 16, 5931045, 0x545454, TextKey.EXP_BAR_LEVEL, false, null, false, true);
					this.fameBar_ = new StatusBar(176, 16, 0xE25F00, 0x545454, TextKey.CURRENCY_FAME, false, null, false, true);
					this.hpBar_ = new StatusBar(176, 16, 14693428, 0x545454, TextKey.STATUS_BAR_HEALTH_POINTS);
					this.clientHpBar_ = new StatusBar(176, 15, 14693428, 0x545454, "CH");
					this.mpBar_ = new StatusBar(176, 16, 6325472, 0x545454, TextKey.STATUS_BAR_MANA_POINTS);
					this.hpBar_.y = 24;
					this.clientHpBar_.y = 32;
					this.mpBar_.y = 48;
					this.expBar_.visible = true;
					this.fameBar_.visible = false;
					this.clientHpBar_.visible = false;
				}
				addChild(this.expBar_);
				addChild(this.fameBar_);
				addChild(this.hpBar_);
				addChild(this.clientHpBar_);
				addChild(this.mpBar_);
			}

			public function dispose():void
			{
				while (this.numChildren > 0)
				{
					this.removeChildAt(0);
				}
			}

			public function update(_arg_1:Player):void
			{
				this.expBar_.setLabelText(TextKey.EXP_BAR_LEVEL, {"level": _arg_1.level_});
				if (_arg_1.level_ != 20)
				{
					if (this.expTimer)
					{
						this.expTimer.update(_arg_1.xpTimer);
					}
					if (!this.expBar_.visible)
					{
						this.expBar_.visible = true;
						this.fameBar_.visible = false;
					}
					this.expBar_.draw(_arg_1.exp_, _arg_1.nextLevelExp_, 0);
					if (this.curXPBoost != _arg_1.xpBoost_)
					{
						this.curXPBoost = _arg_1.xpBoost_;
						if (this.curXPBoost)
						{
							this.expBar_.showMultiplierText();
						}
						else
						{
							this.expBar_.hideMultiplierText();
						}
					}
					if (_arg_1.xpTimer)
					{
						if (!this.areTempXpListenersAdded)
						{
							this.expBar_.addEventListener("MULTIPLIER_OVER", this.onExpBarOver);
							this.expBar_.addEventListener("MULTIPLIER_OUT", this.onExpBarOut);
							this.areTempXpListenersAdded = true;
						}
					}
					else
					{
						if (this.areTempXpListenersAdded)
						{
							this.expBar_.removeEventListener("MULTIPLIER_OVER", this.onExpBarOver);
							this.expBar_.removeEventListener("MULTIPLIER_OUT", this.onExpBarOut);
							this.areTempXpListenersAdded = false;
						}
						if (((this.expTimer) && (this.expTimer.parent)))
						{
							removeChild(this.expTimer);
							this.expTimer = null;
						}
					}
				}
				else
				{
					if (!this.fameBar_.visible)
					{
						this.fameBar_.visible = true;
						this.expBar_.visible = false;
					}
					this.fameBar_.draw(_arg_1.currFame_, _arg_1.nextClassQuestFame_, 0);
				}
				if (!Parameters.ssmode && Parameters.data_.showCHbar)
				{
					this.clientHpBar_.draw(_arg_1.clientHp, _arg_1.maxHP_, _arg_1.maxHPBoost_, _arg_1.maxHPMax_, _arg_1.level_);
				}
				this.hpBar_.draw(_arg_1.hp_, _arg_1.maxHP_, _arg_1.maxHPBoost_, _arg_1.maxHPMax_, _arg_1.level_);
				this.mpBar_.draw(_arg_1.mp_, _arg_1.maxMP_, _arg_1.maxMPBoost_, _arg_1.maxMPMax_, _arg_1.level_);
			}

			private function onExpBarOver(_arg_1:Event):void
			{
				addChild((this.expTimer = new ExperienceBoostTimerPopup()));
			}

			private function onExpBarOut(_arg_1:Event):void
			{
				if (((this.expTimer) && (this.expTimer.parent)))
				{
					removeChild(this.expTimer);
					this.expTimer = null;
				}
			}


		}
	}//package kabam.rotmg.ui.view

