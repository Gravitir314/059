//io.decagames.rotmg.supportCampaign.tab.tiers.preview.TiersPreviewMediator

package io.decagames.rotmg.supportCampaign.tab.tiers.preview
	{
    import com.company.assembleegameclient.ui.tooltip.TextToolTip;
    import com.company.assembleegameclient.ui.tooltip.ToolTip;

    import io.decagames.rotmg.shop.PurchaseInProgressModal;
    import io.decagames.rotmg.supportCampaign.data.SupporterCampaignModel;
    import io.decagames.rotmg.supportCampaign.signals.TierSelectedSignal;
    import io.decagames.rotmg.supportCampaign.tab.tiers.popups.ClaimCompleteModal;
    import io.decagames.rotmg.ui.buttons.BaseButton;
    import io.decagames.rotmg.ui.popups.modal.error.ErrorModal;
    import io.decagames.rotmg.ui.popups.signals.ClosePopupSignal;
    import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;

    import kabam.rotmg.account.core.Account;
    import kabam.rotmg.appengine.api.AppEngineClient;
    import kabam.rotmg.core.signals.HideTooltipsSignal;
    import kabam.rotmg.core.signals.ShowTooltipSignal;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;
    import kabam.rotmg.tooltips.HoverTooltipDelegate;

    import robotlegs.bender.bundles.mvcs.Mediator;

    public class TiersPreviewMediator extends Mediator
		{

			[Inject]
			public var view:TiersPreview;
			[Inject]
			public var selectedSignal:TierSelectedSignal;
			[Inject]
			public var model:SupporterCampaignModel;
			[Inject]
			public var showPopupSignal:ShowPopupSignal;
			[Inject]
			public var account:Account;
			[Inject]
			public var client:AppEngineClient;
			[Inject]
			public var closePopupSignal:ClosePopupSignal;
			[Inject]
			public var showTooltipSignal:ShowTooltipSignal;
			[Inject]
			public var hideTooltipSignal:HideTooltipsSignal;
			private var displayedTier:int;
			private var inProgressModal:PurchaseInProgressModal;
			private var toolTip:ToolTip;
			private var hoverTooltipDelegate:HoverTooltipDelegate;


			override public function initialize():void
			{
				this.toolTip = new TextToolTip(0x363636, 1, "", "You must claim previous Tiers rewards first!", 200);
				this.hoverTooltipDelegate = new HoverTooltipDelegate();
				this.hoverTooltipDelegate.setShowToolTipSignal(this.showTooltipSignal);
				this.hoverTooltipDelegate.setHideToolTipsSignal(this.hideTooltipSignal);
				this.hoverTooltipDelegate.tooltip = this.toolTip;
				this.onTierSelected(this.view.startTier);
				this.view.leftArrow.clickSignal.add(this.onLeftClick);
				this.view.rightArrow.clickSignal.add(this.onRightClick);
				this.selectedSignal.add(this.onTierSelected);
				this.view.claimButton.clickSignal.add(this.onClaimClick);
				this.checkClaimedTiers();
			}

			override public function destroy():void
			{
				this.view.leftArrow.clickSignal.remove(this.onLeftClick);
				this.view.rightArrow.clickSignal.remove(this.onRightClick);
				this.selectedSignal.remove(this.onTierSelected);
			}

			private function onClaimClick(_arg_1:BaseButton):void
			{
				if (this.model.claimed < this.model.rank)
				{
					this.inProgressModal = new PurchaseInProgressModal();
					this.showPopupSignal.dispatch(this.inProgressModal);
					this.sendClaimRequest();
				}
			}

			private function sendClaimRequest():void
			{
				var _local_1:Object = this.account.getCredentials();
				this.client.sendRequest("/supportCampaign/claim", _local_1);
				this.client.complete.addOnce(this.onClaimRequestComplete);
			}

			private function onClaimRequestComplete(_arg_1:Boolean, _arg_2:*):void
			{
				var _local_4:XML;
				var _local_6:XML;
				var _local_7:String;
				var _local_5:* = _arg_1;
				var _local_3:* = _arg_2;
				this.closePopupSignal.dispatch(this.inProgressModal);
				if (_local_5)
				{
					try
					{
						_local_4 = new XML(_local_3);
						this.model.parseUpdateData(_local_4);
					}
					catch (e:Error)
					{
						showPopupSignal.dispatch(new ErrorModal(300, "Campaign Error", "General campaign error."));
						return;
					}
					this.showPopupSignal.dispatch(new ClaimCompleteModal());
				}
				else
				{
					try
					{
						_local_6 = new XML(_local_3);
						_local_7 = LineBuilder.getLocalizedStringFromKey(_local_6.toString(), {});
						this.showPopupSignal.dispatch(new ErrorModal(300, "Campaign Error", ((_local_7 == "") ? _local_6.toString() : _local_7)));

					}
					catch (e:Error)
					{
						showPopupSignal.dispatch(new ErrorModal(300, "Campaign Error", "General campaign error."));

					}
				}
			}

			private function onTierSelected(_arg_1:int):void
			{
				this.displayedTier = _arg_1;
				this.view.rightArrow.disabled = false;
				this.view.rightArrow.alpha = 1;
				this.view.leftArrow.disabled = false;
				this.view.leftArrow.alpha = 1;
				if (this.displayedTier == 1)
				{
					this.view.leftArrow.disabled = true;
					this.view.leftArrow.alpha = 0.2;
				}
				if (this.displayedTier == this.model.ranks.length)
				{
					this.view.rightArrow.disabled = true;
					this.view.rightArrow.alpha = 0.2;
				}
                this.showTier(_arg_1);
				//this.view.showTier(_arg_1, this.model.rank, this.model.claimed);
				this.view.selectAnimation();
				this.checkClaimedTiers();
			}

            private function showTier(_arg_1:int):void
            {
                this.view.showTier(_arg_1, this.model.rank, this.model.claimed, this.model.getCampaignPictureUrl());
            }

			private function onLeftClick(_arg_1:BaseButton):void
			{
				this.displayedTier--;
				this.view.rightArrow.disabled = false;
				this.view.rightArrow.alpha = 1;
				if (this.displayedTier <= 1)
				{
					this.displayedTier = 1;
				}
				if (this.displayedTier == 1)
				{
					this.view.leftArrow.disabled = true;
					this.view.leftArrow.alpha = 0.2;
				}
                this.showTier(this.displayedTier);//this.view.showTier(this.displayedTier, this.model.rank, this.model.claimed);
				this.view.selectAnimation();
				this.checkClaimedTiers();
				this.selectedSignal.dispatch(this.displayedTier);
			}

			private function onRightClick(_arg_1:BaseButton):void
			{
				this.displayedTier++;
				this.view.leftArrow.disabled = false;
				this.view.leftArrow.alpha = 1;
				if (this.displayedTier > this.model.ranks.length)
				{
					this.displayedTier = this.model.ranks.length;
				}
				if (this.displayedTier == this.model.ranks.length)
				{
					this.view.rightArrow.disabled = true;
					this.view.rightArrow.alpha = 0.2;
				}
                this.showTier(this.displayedTier);//this.view.showTier(this.displayedTier, this.model.rank, this.model.claimed);
				this.view.selectAnimation();
				this.checkClaimedTiers();
				this.selectedSignal.dispatch(this.displayedTier);
			}

			private function checkClaimedTiers():void
			{
				if ((this.displayedTier - this.model.claimed) > 1)
				{
					this.view.claimButton.disabled = true;
					this.hoverTooltipDelegate.setDisplayObject(this.view.claimButton);
				}
				else
				{
					this.view.claimButton.disabled = false;
					this.hoverTooltipDelegate.removeDisplayObject();
				}
			}


		}
	}//package io.decagames.rotmg.supportCampaign.tab.tiers.preview

