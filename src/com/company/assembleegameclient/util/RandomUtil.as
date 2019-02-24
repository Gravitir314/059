//com.company.assembleegameclient.util.RandomUtil

package com.company.assembleegameclient.util
{
	public class RandomUtil
	{

		public static function plusMinus(_arg_1:Number):Number
		{
			return (((Math.random() * _arg_1) * 2) - _arg_1);
		}

		public static function randomRange(_arg_1:Number, _arg_2:Number):Number
		{
			return (Math.ceil(Math.random() * (_arg_2 - _arg_1)) + _arg_1);
		}

	}
}//package com.company.assembleegameclient.util

