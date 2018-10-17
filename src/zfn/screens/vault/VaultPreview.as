//zfn.screens.vault.VaultPreview

package zfn.screens.vault
	{
	import com.company.assembleegameclient.constants.InventoryOwnerTypes;
	import com.company.assembleegameclient.ui.tooltip.EquipmentToolTip;
	import com.company.assembleegameclient.ui.tooltip.TextToolTip;
	import com.company.assembleegameclient.ui.tooltip.ToolTip;

	import flash.display.Sprite;
	import flash.events.MouseEvent;

	import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
	import io.decagames.rotmg.ui.texture.TextureParser;

	import kabam.rotmg.core.StaticInjectorContext;
	import kabam.rotmg.core.signals.ShowTooltipSignal;
	import kabam.rotmg.text.model.TextKey;
	import kabam.rotmg.tooltips.HoverTooltipDelegate;

	public class VaultPreview extends Sprite
		{

			private const padding:uint = 4;
			private const rowLength:uint = 4;
			private const BACKGROUND_WIDTH:int = 200;
			private const BACKGROUND_HEIGHT:int = 100;

			private var tooltipFocusSlot:VaultSlot;
			private var tooltip:ToolTip;
			private var hoverTooltipDelegate:HoverTooltipDelegate;
			private var background:SliceScalingBitmap;
			public var slots:Vector.<VaultSlot>;
			public var showTooltipSignal:ShowTooltipSignal;

			public function VaultPreview(_arg_1:Vector.<VaultSlot>)
			{
				this.slots = _arg_1;
				this.setBackground("popup_background_simple");
				this.showTooltipSignal = StaticInjectorContext.getInjector().getInstance(ShowTooltipSignal);
				this.hoverTooltipDelegate = new HoverTooltipDelegate();
				this.hoverTooltipDelegate.setShowToolTipSignal(this.showTooltipSignal);
				this.hoverTooltipDelegate.tooltip = this.tooltip;
				this.createGrid();
			}

			public function createGrid():void
			{
				var _local_3:VaultSlot;
				var _local_2:int;
				var _local_1:int = slots.length;
				_local_2 = 0;
				while (_local_2 < _local_1)
				{
					_local_3 = slots[_local_2];
					_local_3.addEventListener(MouseEvent.ROLL_OVER, this.onTileHover);
					_local_3.x = (((_local_2 % rowLength) * (45 + rowLength)) + padding);
					_local_3.y = ((int((_local_2 / rowLength)) * (45 + rowLength)) + padding);
					addChild(_local_3);
					_local_2++;
				}
			}

			private function setBackground(_arg_1:String):void
			{
				this.background = TextureParser.instance.getSliceScalingBitmap("UI", _arg_1);
				this.background.width = BACKGROUND_WIDTH;
				this.background.height = BACKGROUND_HEIGHT;
				super.addChildAt(this.background, 0);
			}

			private function onTileHover(_arg_1:MouseEvent):void
			{
				if (!stage)
				{
					return;
				}
				var _local_2:VaultSlot = (_arg_1.currentTarget as VaultSlot);
				this.addTooltipToSlot(_local_2);
				this.tooltipFocusSlot = _local_2;
			}

			private function addTooltipToSlot(_arg_1:VaultSlot):void
			{
				var _local_2:String;
				if (_arg_1.itemType > 0)
				{
					this.tooltip = new EquipmentToolTip(_arg_1.itemType, null, -1, InventoryOwnerTypes.NPC);
				}
				else
				{
					_local_2 = TextKey.ITEM;
					this.tooltip = new TextToolTip(0x363636, 0x9B9B9B, null, TextKey.ITEM_EMPTY_SLOT, BACKGROUND_WIDTH, {"itemType": TextKey.wrapForTokenResolution(_local_2)});
				}
				this.tooltip.attachToTarget(_arg_1);
				this.showTooltipSignal.dispatch(this.tooltip);
			}


		}
	}//package zfn.screens.vault

