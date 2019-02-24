//com.company.assembleegameclient.util.PlayerUtil

package com.company.assembleegameclient.util
	{
    import com.company.assembleegameclient.objects.Player;

    public class PlayerUtil
		{


			public static function getPlayerNameColor(_arg_1:Player):Number
			{
				if (_arg_1.isFellowGuild_)
				{
					return (10944349);
				}
				if (_arg_1.hasSupporterFeature(2))
				{
					return (13395711);
				}
				if (_arg_1.nameChosen_)
				{
					return (0xFCDF00);
				}
				return (0xFFFFFF);
			}


		}
	}//package com.company.assembleegameclient.util

