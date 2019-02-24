//com.company.assembleegameclient.objects.Character

package com.company.assembleegameclient.objects
	{
    import com.company.assembleegameclient.map.Camera;
    import com.company.assembleegameclient.sound.SoundEffectLibrary;

    import flash.display.IGraphicsData;

    public class Character extends GameObject
		{

			public var hurtSound_:String;
			public var deathSound_:String;

			public function Character(_arg_1:XML)
			{
				super(_arg_1);
				this.hurtSound_ = ((_arg_1.hasOwnProperty("HitSound")) ? String(_arg_1.HitSound) : "monster/default_hit");
				SoundEffectLibrary.load(this.hurtSound_);
				this.deathSound_ = ((_arg_1.hasOwnProperty("DeathSound")) ? String(_arg_1.DeathSound) : "monster/default_death");
				SoundEffectLibrary.load(this.deathSound_);
			}

			public static function green2red(_arg_1:int):int
			{
				if (_arg_1 > 50)
				{
					return (0xFF00 + (0x50000 * (100 - _arg_1)));
				}
				return (0xFFFF00 - (0x0500 * (50 - _arg_1)));
			}

			override public function damage(_arg_1:Boolean, _arg_2:int, _arg_3:Vector.<uint>, _arg_4:Boolean, _arg_5:Projectile, _arg_6:Boolean = false):void
			{
				super.damage(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6);
				if (dead_)
				{
					SoundEffectLibrary.play(this.deathSound_);
				}
				else
				{
					if (((_arg_5) || (_arg_2 > 0)))
					{
						SoundEffectLibrary.play(this.hurtSound_);
					}
				}
			}

			override public function draw(_arg_1:Vector.<IGraphicsData>, _arg_2:Camera, _arg_3:int):void
			{
				super.draw(_arg_1, _arg_2, _arg_3);
			}


		}
	}//package com.company.assembleegameclient.objects

