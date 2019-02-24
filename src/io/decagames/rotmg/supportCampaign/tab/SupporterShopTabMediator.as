//io.decagames.rotmg.supportCampaign.tab.SupporterShopTabMediator

package io.decagames.rotmg.supportCampaign.tab
	{
    import com.company.assembleegameclient.objects.Player;
    import com.company.assembleegameclient.ui.tooltip.TextToolTip;

    import flash.events.Event;

    import io.decagames.rotmg.shop.NotEnoughResources;
    import io.decagames.rotmg.supportCampaign.data.SupporterCampaignModel;
    import io.decagames.rotmg.supportCampaign.signals.TierSelectedSignal;
    import io.decagames.rotmg.supportCampaign.signals.UpdateCampaignProgress;
    import io.decagames.rotmg.ui.buttons.BaseButton;
    import io.decagames.rotmg.ui.popups.modal.error.ErrorModal;
    import io.decagames.rotmg.ui.popups.signals.RemoveLockFade;
    import io.decagames.rotmg.ui.popups.signals.ShowLockFade;
    import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;

    import kabam.rotmg.account.core.Account;
    import kabam.rotmg.appengine.api.AppEngineClient;
    import kabam.rotmg.core.model.PlayerModel;
    import kabam.rotmg.core.signals.HideTooltipsSignal;
    import kabam.rotmg.core.signals.ShowTooltipSignal;
    import kabam.rotmg.game.model.GameModel;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;
    import kabam.rotmg.tooltips.HoverTooltipDelegate;
    import kabam.rotmg.ui.model.HUDModel;
    import kabam.rotmg.ui.signals.HUDModelInitialized;

    import robotlegs.bender.bundles.mvcs.Mediator;

    public class SupporterShopTabMediator extends Mediator
		{

			[Inject]
			public var view:SupporterShopTabView;
			[Inject]
			public var model:SupporterCampaignModel;
			[Inject]
			public var gameModel:GameModel;
			[Inject]
			public var playerModel:PlayerModel;
			[Inject]
			public var initHUDModelSignal:HUDModelInitialized;
			[Inject]
			public var hudModel:HUDModel;
			[Inject]
			public var showTooltipSignal:ShowTooltipSignal;
			[Inject]
			public var hideTooltipSignal:HideTooltipsSignal;
			[Inject]
			public var showPopup:ShowPopupSignal;
			[Inject]
			public var showFade:ShowLockFade;
			[Inject]
			public var removeFade:RemoveLockFade;
			[Inject]
			public var client:AppEngineClient;
			[Inject]
			public var account:Account;
			[Inject]
			public var updatePointsSignal:UpdateCampaignProgress;
			[Inject]
			public var selectedSignal:TierSelectedSignal;
			private var toolTip:TextToolTip = null;
			private var hoverTooltipDelegate:HoverTooltipDelegate;


			override public function initialize():void
			{
				this.updatePointsSignal.add(this.onPointsUpdate);
                this.showView();//this.view.show(this.hudModel.getPlayerName(), this.model.isUnlocked, this.model.isStarted, this.model.unlockPrice, this.model.donatePointsRatio, this.model.isEnded);
				if (!this.model.isStarted)
				{
					this.view.addEventListener("enterFrame", this.updateStartCountdown);
				}
				if (this.model.isUnlocked)
				{
					this.updateCampaignInformation();
				}
				if (this.view.unlockButton)
				{
					this.view.unlockButton.clickSignal.add(this.unlockClick);
				}
			}

            private function showView():void
            {
                this.view.show(this.hudModel.getPlayerName(), this.model.isUnlocked, this.model.isStarted, this.model.unlockPrice, this.model.donatePointsRatio, this.model.isEnded);
            }

			private function updateCampaignInformation():void
			{
				this.view.updatePoints(this.model.points, this.model.rank);
				this.view.drawProgress(this.model.points, this.model.rankConfig, this.model.rank, this.model.claimed);
				this.updateTooltip();
                this.showTier();//this.view.showTier(this.model.nextClaimableTier, this.model.ranks, this.model.rank, this.model.claimed);
				this.view.updateTime((this.model.endDate.time - new Date().time));
			}

            private function showTier():void
            {
                this.view.showTier(this.model.nextClaimableTier, this.model.ranks, this.model.rank, this.model.claimed, this.model.getCampaignPictureUrl());
            }

			private function updateStartCountdown(_arg_1:Event):void
			{
				var _local_2:String = this.model.getStartTimeString();
				if (_local_2 == "")
				{
					this.view.removeEventListener("enterFrame", this.updateStartCountdown);
					this.view.unlockButton.disabled = false;
				}
				this.view.updateStartCountdown(_local_2);
			}

			override public function destroy():void
			{
				this.updatePointsSignal.remove(this.onPointsUpdate);
				if (this.view.unlockButton)
				{
					this.view.unlockButton.clickSignal.remove(this.unlockClick);
				}
				this.view.removeEventListener("enterFrame", this.updateStartCountdown);
			}

			private function onPointsUpdate():void
			{
				this.view.updatePoints(this.model.points, this.model.rank);
                this.showTier();//this.view.showTier(this.model.nextClaimableTier, this.model.ranks, this.model.rank, this.model.claimed);
				this.view.drawProgress(this.model.points, this.model.rankConfig, this.model.rank, this.model.claimed);
				this.updateTooltip();
				this.selectedSignal.dispatch(this.model.nextClaimableTier);
				var _local_1:Player = this.gameModel.player;
				if (_local_1.hasSupporterFeature(1))
				{
					_local_1.supporterPoints = this.model.points;
					_local_1.clearTextureCache();
				}
			}

			private function updateTooltip():void
			{
				if (this.view.infoButton)
				{
					if (this.model.rank == 5)
					{
						this.toolTip = new TextToolTip(0x363636, 15585539, (((this.model.rank == 0) ? "No rank" : SupporterCampaignModel.RANKS_NAMES[(this.model.rank - 1)]) + " Supporter"), (((("Thank you for your Support, " + this.hudModel.getPlayerName()) + "!") + "\n\nWe are bringing your favorite bullet-hell MMO to Unity!") + "\n\nYou have unlocked everything we had to offer, we are glad you are joining us on this journey! You can continue to Donate and further help shape the future of Realm of the Mad God."), 220);
					}
					else
					{
						this.toolTip = new TextToolTip(0x363636, 0x9B9B9B, (((this.model.rank == 0) ? "No rank" : SupporterCampaignModel.RANKS_NAMES[(this.model.rank - 1)]) + " Supporter"), "We are bringing your favorite bullet-hell MMO to Unity!\n\nWith each donation you are helping us achieve this goal and additionally unlock some unique gifts.", 220);
					}
					this.hoverTooltipDelegate = new HoverTooltipDelegate();
					this.hoverTooltipDelegate.setShowToolTipSignal(this.showTooltipSignal);
					this.hoverTooltipDelegate.setHideToolTipsSignal(this.hideTooltipSignal);
					this.hoverTooltipDelegate.setDisplayObject(this.view.infoButton);
					this.hoverTooltipDelegate.tooltip = this.toolTip;
				}
			}

			private function unlockClick(_arg_1:BaseButton):void
			{
				if (this.currentGold < this.model.unlockPrice)
				{
					this.showPopup.dispatch(new NotEnoughResources(300, 0));
					return;
				}
				this.showFade.dispatch();
				var _local_2:Object = this.account.getCredentials();
				this.client.sendRequest("/supportCampaign/unlock", _local_2);
				this.client.complete.addOnce(this.onUnlockComplete);
			}

			private function onUnlockComplete(_arg_1:Boolean, _arg_2:*):void
			{
				var _local_4:XML;
				var _local_6:XML;
				var _local_7:String;
				var _local_5:* = _arg_1;
				var _local_3:* = _arg_2;
				this.removeFade.dispatch();
				if (_local_5)
				{
					try
					{
						_local_4 = new XML(_local_3);
						if (_local_4.hasOwnProperty("Gold"))
						{
							this.updateUserGold(_local_4.Gold);
						}
                        this.showView();//this.view.show(null, true, this.model.isStarted, this.model.unlockPrice, this.model.donatePointsRatio, this.model.isEnded);
						this.model.parseUpdateData(_local_4);
						this.updateCampaignInformation();
					}
					catch (e:Error)
					{
						showPopup.dispatch(new ErrorModal(300, "Campaign Error", "General campaign error."));
						//return;
					}
				}
				else
				{
					try
					{
						_local_6 = new XML(_local_3);
						_local_7 = LineBuilder.getLocalizedStringFromKey(_local_6.toString(), {});
						this.showPopup.dispatch(new ErrorModal(300, "Campaign Error", ((_local_7 == "") ? _local_6.toString() : _local_7)));

					}
					catch (e:Error)
					{
						showPopup.dispatch(new ErrorModal(300, "Campaign Error", "General campaign error."));

					}
				}
			}

			private function updateUserGold(_arg_1:int):void
			{
				var _local_2:Player = this.gameModel.player;
				if (_local_2 != null)
				{
					_local_2.setCredits(_arg_1);
				}
				else
				{
					this.playerModel.setCredits(_arg_1);
				}
			}

			private function get currentGold():int
			{
				var _local_1:Player = this.gameModel.player;
				if (_local_1 != null)
				{
					return (_local_1.credits_);
				}
				if (this.playerModel != null)
				{
					return (this.playerModel.getCredits());
				}
				return (0);
			}


		}
	}//package io.decagames.rotmg.supportCampaign.tab

