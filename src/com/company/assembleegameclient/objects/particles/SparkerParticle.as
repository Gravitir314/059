//com.company.assembleegameclient.objects.particles.SparkerParticle

package com.company.assembleegameclient.objects.particles
	{
	import com.company.assembleegameclient.util.RandomUtil;

	import flash.geom.Point;

	public class SparkerParticle extends Particle
		{

			public var lifetime_:int;
			public var timeLeft_:int;
			public var initialSize_:int;
			public var startX_:Number;
			public var startY_:Number;
			public var endX_:Number;
			public var endY_:Number;
			public var dx_:Number;
			public var dy_:Number;
			public var pathX_:Number;
			public var pathY_:Number;

			public function SparkerParticle(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:Point, _arg_5:Point)
			{
				super(_arg_2, 0, _arg_1);
				this.lifetime_ = (this.timeLeft_ = _arg_3);
				this.initialSize_ = _arg_1;
				this.startX_ = _arg_4.x;
				this.startY_ = _arg_4.y;
				this.endX_ = _arg_5.x;
				this.endY_ = _arg_5.y;
				this.dx_ = ((this.endX_ - this.startX_) / this.timeLeft_);
				this.dy_ = ((this.endY_ - this.startY_) / this.timeLeft_);
				this.pathX_ = (x_ = this.startX_);
				this.pathY_ = (y_ = this.startY_);
			}

			override public function update(_arg_1:int, _arg_2:int):Boolean
			{
				this.timeLeft_ = (this.timeLeft_ - _arg_2);
				if (this.timeLeft_ <= 0)
				{
					return (false);
				}
				this.pathX_ = (this.pathX_ + (this.dx_ * _arg_2));
				this.pathY_ = (this.pathY_ + (this.dy_ * _arg_2));
				moveTo(this.pathX_, this.pathY_);
				map_.addObj(new SparkParticle((100 * (z_ + 1)), color_, 600, z_, RandomUtil.plusMinus(1), RandomUtil.plusMinus(1)), this.pathX_, this.pathY_);
				return (true);
			}


		}
	}//package com.company.assembleegameclient.objects.particles

