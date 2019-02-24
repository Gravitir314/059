//com.company.assembleegameclient.map.DarknessOverlay

package com.company.assembleegameclient.map
{
	import com.company.assembleegameclient.game.AGameSprite;
	import com.company.assembleegameclient.parameters.Parameters;
	import com.company.util.GraphicsUtil;

	import flash.display.GradientType;
	import flash.display.GraphicsGradientFill;
	import flash.display.GraphicsPath;
	import flash.display.IGraphicsData;
	import flash.display.Shape;

	public class DarknessOverlay extends Shape
	{

		private var graphicsData:Vector.<IGraphicsData>;

		public function DarknessOverlay(_arg_1:AGameSprite = null)
		{
			var _local_10:Number = Parameters.data_.mscale;
			var _local_8:Number = (ROTMG.STAGE.stageWidth / _local_10);
			var _local_7:Number = (ROTMG.STAGE.stageHeight / _local_10);
			var _local_6:Number = 350;
			var _local_2:Number = 200;
			if (_arg_1 != null && _arg_1.hudView != null)
			{
				_local_2 = (_local_8 * (1 - (_arg_1.hudView.x * 0.00125)));
			}
			var _local_3:Number = (_local_8 - _local_2);
			var _local_9:GraphicsGradientFill = new GraphicsGradientFill(GradientType.RADIAL, [0, 0], [0.3, 0.9], [0, 0xFF], GraphicsUtil.getGradientMatrix(_local_6, _local_6, 0, ((_local_3 - _local_6) / 2), (((_local_7 - _local_6) / 2) + ((_local_7 * 5) / 24))));
			var _local_5:GraphicsPath = GraphicsUtil.getRectPath(0, 0, _local_8, ((_local_7 * 29) / 24));
			this.graphicsData = new <IGraphicsData>[_local_9, _local_5, GraphicsUtil.END_FILL];
			graphics.drawGraphicsData(this.graphicsData);
			visible = false;
		}

	}
}//package com.company.assembleegameclient.map

