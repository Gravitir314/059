//com.company.assembleegameclient.map.HurtOverlay

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

	public class HurtOverlay extends Shape
		{

			private const s:Number = (600 / Math.sin((Math.PI / 4)));
			private var gradientFill_:GraphicsGradientFill = new GraphicsGradientFill(GradientType.RADIAL, [0xFFFFFF, 0xFFFFFF, 0xFFFFFF], [0, 0, 0.92], [0, 155, 0xFF], GraphicsUtil.getGradientMatrix(s, s, 0, ((600 - s) / 2), ((600 - s) / 2)));
			private var gradientPath_:GraphicsPath = GraphicsUtil.getRectPath(0, 0, 600, 600);
			private var gradientGraphicsData_:Vector.<IGraphicsData> = new <IGraphicsData>[gradientFill_, gradientPath_, GraphicsUtil.END_FILL];

			public function HurtOverlay(_arg_1:AGameSprite = null) // TODO need this?
			{
				var _local_8:Number = Parameters.data_.mscale;
				var _local_7:Number = (ROTMG.STAGE.stageWidth / _local_8);
				var _local_6:Number = (ROTMG.STAGE.stageHeight / _local_8);
				var _local_2:Number = 200;
				if (_arg_1 && _arg_1.hudView)
				{
					_local_2 = (_local_7 * (1 - (_arg_1.hudView.x * 0.00125)));
				}
				var _local_3:Number = (_local_7 - _local_2);
				_local_2 = Math.sin((Math.PI / 4));
				var _local_4:Number = (_local_3 / _local_2);
				var _local_5:Number = (_local_6 / _local_2);
				this.gradientFill_ = new GraphicsGradientFill(GradientType.RADIAL, [0xFFFFFF, 0xFFFFFF, 0xFFFFFF], [0, 0, 0.92], [0, 155, 0xFF], GraphicsUtil.getGradientMatrix(_local_4, _local_5, 0, ((_local_3 - _local_4) / 2), ((_local_6 - _local_5) / 2)));
				this.gradientPath_ = GraphicsUtil.getRectPath(0, 0, _local_7, _local_6);
				this.gradientGraphicsData_ = new <IGraphicsData>[gradientFill_, gradientPath_, GraphicsUtil.END_FILL];
				graphics.drawGraphicsData(this.gradientGraphicsData_);
				visible = false;
			}

		}
	}//package com.company.assembleegameclient.map

