//zfn.screens.vault.VaultSlot

package zfn.screens.vault
	{
	import com.company.assembleegameclient.objects.ObjectLibrary;
	import com.company.assembleegameclient.parameters.Parameters;
	import com.company.assembleegameclient.util.FilterUtil;
	import com.company.assembleegameclient.util.TierUtil;
	import com.company.util.PointUtil;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;

	import io.decagames.rotmg.ui.labels.UILabel;
	import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
	import io.decagames.rotmg.ui.texture.TextureParser;

	import kabam.rotmg.core.StaticInjectorContext;
	import kabam.rotmg.text.view.BitmapTextFactory;
	import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
	import kabam.rotmg.ui.view.components.PotionSlotView;

	public class VaultSlot extends Sprite
		{

			private static const IDENTITY_MATRIX:Matrix = new Matrix();
			private static const DOSE_MATRIX:Matrix = (function ():Matrix {
				var _local_1:Matrix = new Matrix();
				_local_1.translate(8, 7);
				return (_local_1);
			})();
			public static const WIDTH:int = 45;
			public static const HEIGHT:int = 45;

			private var background:SliceScalingBitmap;
			private var itemBitmap:Bitmap;
			private var bitmapFactory:BitmapTextFactory;
			private var tierText:UILabel;
			private var tagContainer:Sprite;
			public var itemType:int;

			public function VaultSlot(_arg_1:int)
			{
				this.create();
				this.itemType = _arg_1;
				this.itemBitmap = new Bitmap();
				this.bitmapFactory = StaticInjectorContext.getInjector().getInstance(BitmapTextFactory);
				this.drawItem();
				this.setTierTag();
			}

			private function create():void
			{
				this.background = TextureParser.instance.getSliceScalingBitmap("UI", "popup_content_decoration", 45);
				addChild(this.background);
				this.background.height = 45;
			}

			public function drawItem():void
			{
				var _local_2:BitmapData;
				var _local_4:XML;
				var _local_1:BitmapData;
				var _local_3:BitmapData;
				var _local_5:int = this.itemType;
				if (_local_5 != -1)
				{
					if (_local_5 >= 0x9000 && _local_5 < 0xF000)
					{
						_local_5 = 36863;
					}
					_local_2 = ObjectLibrary.getRedrawnTextureFromType(_local_5, 80, true);
					_local_4 = ObjectLibrary.xmlLibrary_[_local_5];
					if (_local_4 && _local_4.hasOwnProperty("Doses") && this.bitmapFactory)
					{
						_local_2 = _local_2.clone();
						_local_1 = this.bitmapFactory.make(new StaticStringBuilder(_local_4.Doses), 12, 0xFFFFFF, false, IDENTITY_MATRIX, false);
						_local_1.applyFilter(_local_1, _local_1.rect, PointUtil.ORIGIN, PotionSlotView.READABILITY_SHADOW_2);
						_local_2.draw(_local_1, DOSE_MATRIX);
					}
					if (_local_4 && _local_4.hasOwnProperty("Quantity") && this.bitmapFactory)
					{
						_local_2 = _local_2.clone();
						_local_3 = this.bitmapFactory.make(new StaticStringBuilder(_local_4.Quantity), 12, 0xFFFFFF, false, IDENTITY_MATRIX, false);
						_local_3.applyFilter(_local_3, _local_3.rect, PointUtil.ORIGIN, PotionSlotView.READABILITY_SHADOW_2);
						_local_2.draw(_local_3, DOSE_MATRIX);
					}
					this.itemBitmap.bitmapData = _local_2;
					this.itemBitmap.x = ((45 / 2) - (_local_2.width / 2));
					this.itemBitmap.y = ((45 / 2) - (_local_2.height / 2));
					addChild(this.itemBitmap);
				}
			}

			public function setTierTag():void
			{
				var _local_1:XML = ObjectLibrary.xmlLibrary_[this.itemType];
				if (_local_1)
				{
					this.tierText = TierUtil.getTierTag(_local_1);
					if (this.tierText)
					{
						if (!this.tagContainer)
						{
							this.tagContainer = new Sprite();
							addChild(this.tagContainer);
						}
						this.tierText.filters = FilterUtil.getTextOutlineFilter();
						this.tierText.x = (45 - this.tierText.width);
						this.tierText.y = 27.5;
						this.toggleTierTag(Parameters.data_.showTierTag);
						this.tagContainer.addChild(this.tierText);
					}
				}
			}

			public function toggleTierTag(_arg_1:Boolean):void
			{
				if (this.tierText)
				{
					this.tierText.visible = _arg_1;
				}
			}


		}
	}//package zfn.screens.vault

