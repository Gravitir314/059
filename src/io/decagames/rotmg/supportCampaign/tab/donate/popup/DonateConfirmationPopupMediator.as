//io.decagames.rotmg.supportCampaign.tab.donate.popup.DonateConfirmationPopupMediator

package io.decagames.rotmg.supportCampaign.tab.donate.popup
	{
    import com.company.assembleegameclient.objects.Player;

    import io.decagames.rotmg.supportCampaign.data.SupporterCampaignModel;
    import io.decagames.rotmg.ui.buttons.BaseButton;
    import io.decagames.rotmg.ui.buttons.SliceScalingButton;
    import io.decagames.rotmg.ui.popups.modal.error.ErrorModal;
    import io.decagames.rotmg.ui.popups.signals.ClosePopupSignal;
    import io.decagames.rotmg.ui.popups.signals.RemoveLockFade;
    import io.decagames.rotmg.ui.popups.signals.ShowLockFade;
    import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
    import io.decagames.rotmg.ui.texture.TextureParser;

    import kabam.rotmg.account.core.Account;
    import kabam.rotmg.appengine.api.AppEngineClient;
    import kabam.rotmg.core.model.PlayerModel;
    import kabam.rotmg.game.model.GameModel;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;

    import robotlegs.bender.bundles.mvcs.Mediator;

    public class DonateConfirmationPopupMediator extends Mediator
		{

			[Inject]
			public var view:DonateConfirmationPopup;
			[Inject]
			public var showFade:ShowLockFade;
			[Inject]
			public var removeFade:RemoveLockFade;
			[Inject]
			public var client:AppEngineClient;
			[Inject]
			public var account:Account;
			[Inject]
			public var closePopupSignal:ClosePopupSignal;
			[Inject]
			public var model:SupporterCampaignModel;
			[Inject]
			public var gameModel:GameModel;
			[Inject]
			public var playerModel:PlayerModel;
			[Inject]
			public var showPopupSignal:ShowPopupSignal;
			private var closeButton:SliceScalingButton;


			override public function initialize():void
			{
				this.view.donateButton.clickSignal.add(this.donateClick);
				this.closeButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "close_button"));
				this.closeButton.clickSignal.addOnce(this.onClose);
				this.view.header.addButton(this.closeButton, "right_button");
			}

			private function onClose(_arg_1:BaseButton):void
			{
				this.closePopupSignal.dispatch(this.view);
			}

			override public function destroy():void
			{
				this.view.donateButton.clickSignal.remove(this.donateClick);
				this.closeButton.clickSignal.remove(this.onClose);
			}

			private function donateClick(_arg_1:BaseButton):void
			{
				this.showFade.dispatch();
				var _local_2:Object = this.account.getCredentials();
				_local_2.amount = this.view.gold;
				this.client.sendRequest("/supportCampaign/donate", _local_2);
				this.client.complete.addOnce(this.onDonateComplete);
			}

			private function onDonateComplete(_arg_1:Boolean, _arg_2:*):void
			{
				var _local_4:XML;
				var _local_6:XML;
				var _local_7:String;
				var _local_5:* = _arg_1;
				var _local_3:* = _arg_2;
				this.removeFade.dispatch();
				this.closePopupSignal.dispatch(this.view);
				if (_local_5)
				{
					try
					{
						_local_4 = new XML(_local_3);
						if (_local_4.hasOwnProperty("Gold"))
						{
							this.updateUserGold(_local_4.Gold);
						}
						this.model.parseUpdateData(_local_4);
					}
					catch (e:Error)
					{
						showPopupSignal.dispatch(new ErrorModal(300, "Campaign Error", "General campaign error."));
					}
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


		}
	}//package io.decagames.rotmg.supportCampaign.tab.donate.popup

