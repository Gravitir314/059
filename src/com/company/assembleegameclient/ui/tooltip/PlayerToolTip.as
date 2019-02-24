//com.company.assembleegameclient.ui.tooltip.PlayerToolTip

package com.company.assembleegameclient.ui.tooltip
{
	import com.company.assembleegameclient.objects.Player;
	import com.company.assembleegameclient.parameters.Parameters;
	import com.company.assembleegameclient.ui.GameObjectListItem;
	import com.company.assembleegameclient.ui.GuildText;
	import com.company.assembleegameclient.ui.RankText;
	import com.company.assembleegameclient.ui.StatusBar;
	import com.company.assembleegameclient.ui.panels.itemgrids.EquippedGrid;
	import com.company.assembleegameclient.ui.panels.itemgrids.InventoryGrid;
	import com.greensock.plugins.DropShadowFilterPlugin;

	import flash.text.TextFieldAutoSize;

	import kabam.rotmg.game.view.components.StatsView;
	import kabam.rotmg.text.model.TextKey;
	import kabam.rotmg.text.view.TextFieldDisplayConcrete;
	import kabam.rotmg.text.view.stringBuilder.LineBuilder;

	public class PlayerToolTip extends ToolTip
	{

		public var player_:Player;
		private var playerPanel_:GameObjectListItem;
		private var rankText_:RankText;
		private var guildText_:GuildText;
		private var hpBar_:StatusBar;
		private var mpBar_:StatusBar;
		private var clickMessage_:TextFieldDisplayConcrete;
		private var eGrid:EquippedGrid;

		private var fameBar_:StatusBar;
		private var expBar_:StatusBar;
		private var stats:StatsView;
		private var inv1:InventoryGrid;
		private var inv2:InventoryGrid;

		public function PlayerToolTip(_arg_1:Player) // TODO minimize this
		{
			var _local_2:int;
			super(0x363636, 0.5, 0xFFFFFF, 1);
			if (Parameters.ssmode)
			{
				this.player_ = _arg_1;
				this.playerPanel_ = new GameObjectListItem(0xB3B3B3, true, this.player_);
				addChild(this.playerPanel_);
				_local_2 = 34;
				this.rankText_ = new RankText(this.player_.numStars_, false, true);
				this.rankText_.x = 6;
				this.rankText_.y = _local_2;
				addChild(this.rankText_);
				_local_2 = (_local_2 + 30);
				if (_arg_1.guildName_ != null && _arg_1.guildName_ != "")
				{
					this.guildText_ = new GuildText(this.player_.guildName_, this.player_.guildRank_, 136);
					this.guildText_.x = 6;
					this.guildText_.y = (_local_2 - 2);
					addChild(this.guildText_);
					_local_2 = (_local_2 + 30);
				}
				this.hpBar_ = new StatusBar(176, 16, 14693428, 0x545454, TextKey.STATUS_BAR_HEALTH_POINTS);
				this.hpBar_.x = 6;
				this.hpBar_.y = _local_2;
				addChild(this.hpBar_);
				_local_2 = (_local_2 + 24);
				this.mpBar_ = new StatusBar(176, 16, 6325472, 0x545454, TextKey.STATUS_BAR_MANA_POINTS);
				this.mpBar_.x = 6;
				this.mpBar_.y = _local_2;
				addChild(this.mpBar_);
				_local_2 = (_local_2 + 24);
				this.eGrid = new EquippedGrid(null, this.player_.slotTypes_, this.player_);
				this.eGrid.x = 8;
				this.eGrid.y = _local_2;
				addChild(this.eGrid);
				_local_2 = (_local_2 + 52);
				this.clickMessage_ = new TextFieldDisplayConcrete().setSize(12).setColor(0xB3B3B3);
				this.clickMessage_.setAutoSize(TextFieldAutoSize.CENTER);
				this.clickMessage_.setStringBuilder(new LineBuilder().setParams(TextKey.PLAYER_TOOL_TIP_CLICK_MESSAGE));
				this.clickMessage_.filters = [DropShadowFilterPlugin.DEFAULT_FILTER];
				this.clickMessage_.x = (width / 2);
				this.clickMessage_.y = _local_2;
				waiter.push(this.clickMessage_.textChanged);
				addChild(this.clickMessage_);
			} else
			{
				this.player_ = _arg_1;
				this.playerPanel_ = new GameObjectListItem(0xB3B3B3, true, this.player_);
				addChild(this.playerPanel_);
				_local_2 = 34;
				this.rankText_ = new RankText(this.player_.numStars_, false, true);
				this.rankText_.x = 6;
				this.rankText_.y = _local_2;
				addChild(this.rankText_);
				_local_2 = (_local_2 + 30);
				if (((!(_arg_1.guildName_ == null)) && (!(_arg_1.guildName_ == ""))))
				{
					this.guildText_ = new GuildText(this.player_.guildName_, this.player_.guildRank_, 136);
					this.guildText_.x = 6;
					this.guildText_.y = (_local_2 - 2);
					addChild(this.guildText_);
					_local_2 = (_local_2 + 30);
				}
				if (this.player_.level_ != 20)
				{
					this.expBar_ = new StatusBar(176, 16, 5931045, 0x545454, TextKey.EXP_BAR_LEVEL);
					this.expBar_.x = 6;
					this.expBar_.y = _local_2;
					addChild(this.expBar_);
				} else
				{
					this.fameBar_ = new StatusBar(176, 16, 0xE25F00, 0x545454, TextKey.CURRENCY_FAME);
					this.fameBar_.x = 6;
					this.fameBar_.y = _local_2;
					addChild(this.fameBar_);
				}
				_local_2 = (_local_2 + 24);
				this.hpBar_ = new StatusBar(176, 16, 14693428, 0x545454, TextKey.STATUS_BAR_HEALTH_POINTS);
				this.hpBar_.x = 6;
				this.hpBar_.y = _local_2;
				addChild(this.hpBar_);
				_local_2 = (_local_2 + 24);
				this.mpBar_ = new StatusBar(176, 16, 6325472, 0x545454, TextKey.STATUS_BAR_MANA_POINTS);
				this.mpBar_.x = 6;
				this.mpBar_.y = _local_2;
				addChild(this.mpBar_);
				_local_2 = (_local_2 + 24);
				this.stats = new StatsView();
				this.stats.scaleX = 0.89;
				this.stats.x = 6;
				this.stats.y = _local_2;
				this.stats.altPlayer = _arg_1;
				this.stats.myPlayer = false;
				addChild(this.stats);
				_local_2 = (_local_2 + 52);
				this.eGrid = new EquippedGrid(null, this.player_.slotTypes_, this.player_);
				this.eGrid.x = 8;
				this.eGrid.y = _local_2;
				addChild(this.eGrid);
				_local_2 = ((_local_2 + this.eGrid.height) + 5);
				this.inv1 = new InventoryGrid(this.player_, this.player_, 4);
				this.inv1.x = 8;
				this.inv1.y = (_local_2 - 1);
				addChild(this.inv1);
				if (this.player_.hasBackpack_)
				{
					this.inv2 = new InventoryGrid(this.player_, this.player_, 12);
					this.inv2.x = 8;
					this.inv2.y = ((this.eGrid.y + this.eGrid.height) + 92);
					addChild(inv2);
				}
				_local_2 = ((_local_2 + this.player_.hasBackpack_) ? (this.inv1.height * 2) : (this.inv1.height + 5));
				_local_2 = (_local_2 + 52);
				if (Parameters.ssmode)
				{
					this.clickMessage_ = new TextFieldDisplayConcrete().setSize(12).setColor(0xB3B3B3);
					this.clickMessage_.setAutoSize(TextFieldAutoSize.CENTER);
					this.clickMessage_.setStringBuilder(new LineBuilder().setParams(TextKey.PLAYER_TOOL_TIP_CLICK_MESSAGE));
					this.clickMessage_.filters = [DropShadowFilterPlugin.DEFAULT_FILTER];
					this.clickMessage_.x = (width * 0.5);
					this.clickMessage_.y = _local_2;
					waiter.push(this.clickMessage_.textChanged);
					addChild(this.clickMessage_);
				}
			}
		}

		override public function draw():void
		{
			if (Parameters.ssmode)
			{
				this.hpBar_.draw(this.player_.hp_, this.player_.maxHP_, this.player_.maxHPBoost_, this.player_.maxHPMax_);
				this.mpBar_.draw(this.player_.mp_, this.player_.maxMP_, this.player_.maxMPBoost_, this.player_.maxMPMax_);
				this.eGrid.setItems(this.player_.equipment_);
				this.rankText_.draw(this.player_.numStars_);
				super.draw();
			} else
			{
				if (this.player_.level_ != 20)
				{
					if (this.expBar_)
					{
						this.expBar_.setLabelText(TextKey.EXP_BAR_LEVEL, {"level": this.player_.level_});
						this.expBar_.draw(this.player_.exp_, this.player_.nextLevelExp_, 0);
					}
				} else
				{
					if (this.fameBar_)
					{
						this.fameBar_.draw(this.player_.currFame_, this.player_.nextClassQuestFame_, 0);
					}
				}
				this.hpBar_.draw(this.player_.hp_, this.player_.maxHP_, this.player_.maxHPBoost_, this.player_.maxHPMax_);
				this.mpBar_.draw(this.player_.mp_, this.player_.maxMP_, this.player_.maxMPBoost_, this.player_.maxMPMax_);
				this.eGrid.setItems(this.player_.equipment_);
				this.rankText_.draw(this.player_.numStars_);
				super.draw();
			}
		}

	}
}//package com.company.assembleegameclient.ui.tooltip

