//io.decagames.rotmg.nexusShop.NexusShopPopupMediator

package io.decagames.rotmg.nexusShop
	{
    import flash.events.MouseEvent;

    import io.decagames.rotmg.ui.buttons.BaseButton;
    import io.decagames.rotmg.ui.buttons.SliceScalingButton;
    import io.decagames.rotmg.ui.popups.signals.ClosePopupSignal;
    import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
    import io.decagames.rotmg.ui.texture.TextureParser;

    import kabam.rotmg.core.signals.HideTooltipsSignal;
    import kabam.rotmg.core.signals.ShowTooltipSignal;
    import kabam.rotmg.ui.model.HUDModel;

    import org.osflash.signals.natives.NativeSignal;

    import robotlegs.bender.bundles.mvcs.Mediator;

    public class NexusShopPopupMediator extends Mediator
		{

			[Inject]
			public var view:NexusShopPopupView;
			[Inject]
			public var closePopupSignal:ClosePopupSignal;
			[Inject]
			public var showTooltipSignal:ShowTooltipSignal;
			[Inject]
			public var hideTooltipSignal:HideTooltipsSignal;
			[Inject]
			public var hudModel:HUDModel;
			[Inject]
			public var showPopupSignal:ShowPopupSignal;
			private var closeButton:SliceScalingButton;
			private var buyButtonClicked:NativeSignal;


			override public function initialize():void
			{
				this.closeButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "close_button"));
				this.closeButton.clickSignal.addOnce(this.onClose);
				this.view.header.addButton(this.closeButton, "right_button");
				this.buyButtonClicked = new NativeSignal(this.view.getBuyButton, "click", MouseEvent);
				this.buyButtonClicked.add(this.onBuyClick);
			}

			public function onBuyClick(_arg_1:MouseEvent):void
			{
				this.view.getOwner.quantity_ = this.view.getQuantity;
				this.view.getBuyItem.dispatch(this.view.getOwner);
				this.close();
			}

			override public function destroy():void
			{
				this.closeButton.dispose();
			}

			private function onClose(_arg_1:BaseButton):void
			{
				this.closePopupSignal.dispatch(this.view);
			}

			private function close():void
			{
				this.closePopupSignal.dispatch(this.view);
			}


		}
	}//package io.decagames.rotmg.nexusShop

