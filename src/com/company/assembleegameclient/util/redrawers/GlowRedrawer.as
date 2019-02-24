//com.company.assembleegameclient.util.redrawers.GlowRedrawer

package com.company.assembleegameclient.util.redrawers
{
	import com.company.assembleegameclient.parameters.Parameters;
	import com.company.assembleegameclient.util.TextureRedrawer;
	import com.company.util.PointUtil;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.utils.Dictionary;

	public class GlowRedrawer
	{

		private static const GRADIENT_MAX_SUB:uint = 0x282828;
		private static const GLOW_FILTER:GlowFilter = new GlowFilter(0, 0.3, 12, 12, 2, 1, false, false);
		private static const GLOW_FILTER_ALT:GlowFilter = new GlowFilter(0, 0.5, 16, 16, 3, 1, false, false);
		private static const GLOW_FILTER_SUPPORT:GlowFilter = new GlowFilter(0, 0.3, 12, 12, 3, 1, false, false);
		private static const GLOW_FILTER_SUPPORT_DARK:GlowFilter = new GlowFilter(0, 0.4, 6, 6, 2, 1, false, false);
		private static const GLOW_FILTER_SUPPORT_OUTLINE:GlowFilter = new GlowFilter(0, 1, 2, 2, 0xFF, 1, false, false);
		private static const GLOW_FILTER_SUPPORT_ALT:GlowFilter = new GlowFilter(0, 0.3, 12, 12, 4, 1, false, false);
		private static const GLOW_FILTER_SUPPORT_DARK_ALT:GlowFilter = new GlowFilter(0, 0.4, 6, 6, 2, 1, false, false);
		private static const GLOW_FILTER_SUPPORT_OUTLINE_ALT:GlowFilter = new GlowFilter(0, 1, 2, 2, 0xFF, 1, false, false);

		private static var tempMatrix_:Matrix = new Matrix();
		private static var gradient_:Shape = getGradient();
		private static var glowHashes:Dictionary = new Dictionary();

		public static function outlineGlow(_arg_1:BitmapData, _arg_2:uint, _arg_3:Number = 1.4, _arg_4:Boolean = false, _arg_5:int = 0, _arg_6:Boolean = false):BitmapData
		{
			var _local_9:String = getHash(_arg_2, _arg_3, _arg_5);
			if (((_arg_4) && (isCached(_arg_1, _local_9))))
			{
				return (glowHashes[_arg_1][_local_9]);
			}
			var _local_8:BitmapData = _arg_1.clone();
			tempMatrix_.identity();
			tempMatrix_.scale((_arg_1.width / 0x0100), (_arg_1.height / 0x0100));
			_local_8.draw(gradient_, tempMatrix_, null, "subtract");
			var _local_7:Bitmap = new Bitmap(_arg_1);
			_local_8.draw(_local_7, null, null, "alpha");
			TextureRedrawer.OUTLINE_FILTER.blurX = _arg_3;
			TextureRedrawer.OUTLINE_FILTER.blurY = _arg_3;
			TextureRedrawer.OUTLINE_FILTER.color = 0;
			_local_8.applyFilter(_local_8, _local_8.rect, PointUtil.ORIGIN, TextureRedrawer.OUTLINE_FILTER);
			if (((Parameters.ssmode) || (!(Parameters.data_.evenLowerGraphics))))
			{
				if (_arg_2 != 0xFFFFFFFF)
				{
					if (((Parameters.isGpuRender()) && (!(_arg_2 == 0))))
					{
						if (!_arg_6)
						{
							GLOW_FILTER_ALT.color = _arg_2;
							_local_8.applyFilter(_local_8, _local_8.rect, PointUtil.ORIGIN, GLOW_FILTER_ALT);
						} else
						{
							GLOW_FILTER_SUPPORT_ALT.color = _arg_2;
							GLOW_FILTER_SUPPORT_DARK_ALT.color = (_arg_2 - 0x246600);
							GLOW_FILTER_SUPPORT_OUTLINE_ALT.color = _arg_2;
							_local_8.applyFilter(_local_8, _local_8.rect, PointUtil.ORIGIN, GLOW_FILTER_SUPPORT_OUTLINE_ALT);
							_local_8.applyFilter(_local_8, _local_8.rect, PointUtil.ORIGIN, GLOW_FILTER_SUPPORT_DARK_ALT);
							_local_8.applyFilter(_local_8, _local_8.rect, PointUtil.ORIGIN, GLOW_FILTER_SUPPORT_ALT);
						}
					} else
					{
						if (!_arg_6)
						{
							GLOW_FILTER.color = _arg_2;
							_local_8.applyFilter(_local_8, _local_8.rect, PointUtil.ORIGIN, GLOW_FILTER);
						} else
						{
							GLOW_FILTER_SUPPORT.color = _arg_2;
							GLOW_FILTER_SUPPORT_DARK.color = (_arg_2 - 0x246600);
							GLOW_FILTER_SUPPORT_OUTLINE.color = _arg_2;
							_local_8.applyFilter(_local_8, _local_8.rect, PointUtil.ORIGIN, GLOW_FILTER_SUPPORT_OUTLINE);
							_local_8.applyFilter(_local_8, _local_8.rect, PointUtil.ORIGIN, GLOW_FILTER_SUPPORT_DARK);
							_local_8.applyFilter(_local_8, _local_8.rect, PointUtil.ORIGIN, GLOW_FILTER_SUPPORT);
						}
					}
				}
			}
			if (_arg_4)
			{
				cache(_arg_1, _arg_2, _arg_3, _local_8, _arg_5);
			}
			return (_local_8);
		}

		public static function clearCache():void
		{
			glowHashes.length = 0;
		}

		private static function cache(_arg_1:BitmapData, _arg_2:uint, _arg_3:Number, _arg_4:BitmapData, _arg_5:int):void
		{
			var _local_7:Object;
			var _local_6:String = getHash(_arg_2, _arg_3, _arg_5);
			if ((_arg_1 in glowHashes))
			{
				glowHashes[_arg_1][_local_6] = _arg_4;
			} else
			{
				_local_7 = {};
				_local_7[_local_6] = _arg_4;
				glowHashes[_arg_1] = _local_7;
			}
		}

		private static function isCached(_arg_1:BitmapData, _arg_2:String):Boolean
		{
			var _local_3:Object;
			if ((_arg_1 in glowHashes))
			{
				_local_3 = glowHashes[_arg_1];
				if ((_arg_2 in _local_3))
				{
					return (true);
				}
			}
			return (false);
		}

		private static function getHash(_arg_1:uint, _arg_2:Number, _arg_3:int):String
		{
			return (((_arg_2 * 10).toString() + _arg_1) + _arg_3);
		}

		private static function getGradient():Shape
		{
			var _local_2:Shape = new Shape();
			var _local_1:Matrix = new Matrix();
			_local_1.createGradientBox(0x0100, 0x0100, 1.5707963267949, 0, 0);
			_local_2.graphics.beginGradientFill("linear", [0, 0x282828], [1, 1], [127, 0xFF], _local_1);
			_local_2.graphics.drawRect(0, 0, 0x0100, 0x0100);
			_local_2.graphics.endFill();
			return (_local_2);
		}

	}
}//package com.company.assembleegameclient.util.redrawers

