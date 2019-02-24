//com.company.assembleegameclient.util.ParseUtils

package com.company.assembleegameclient.util
{

	public class ParseUtils
	{

		public static function parseIntList(_arg_1:String):Vector.<int>
		{
			var _local_3:int;
			var _local_4:Array = _arg_1.split(",");
			var _local_2:int = _local_4.length;
			if (_arg_1.length <= 0)
			{
				return (null);
			}
			var _local_5:Vector.<int> = new Vector.<int>(_local_2, true);
			_local_3 = 0;
			while (_local_3 < _local_2)
			{
				_local_5[_local_3] = _local_4[_local_3];
				_local_3++;
			}
			return (_local_5);
		}

	}
}//package com.company.assembleegameclient.util

