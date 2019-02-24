//com.company.assembleegameclient.map.Quest

package com.company.assembleegameclient.map
	{
    import com.company.assembleegameclient.objects.GameObject;
    import com.company.assembleegameclient.objects.Player;
    import com.company.util.PointUtil;

    import flash.utils.getTimer;

    public class Quest
		{

			public var map_:Map;
			public var objectId_:int = -1;
			private var questAvailableAt_:int = 0;
			private var questOldAt_:int = 0;

			public function Quest(_arg_1:Map)
			{
				this.map_ = _arg_1;
			}

			public function setObject(_arg_1:int):void
			{
				if (this.objectId_ == -1 && _arg_1 != -1)
				{
					this.questAvailableAt_ = (getTimer() + 200);
					this.questOldAt_ = this.questAvailableAt_;
				}
				this.objectId_ = _arg_1;
			}

			public function completed():void
			{
				this.questAvailableAt_ = (getTimer() + 200);
				this.questOldAt_ = this.questAvailableAt_;
			}

			public function getObject():GameObject
			{
				return (this.map_.goDict_[this.objectId_]);
			}

			public function isNew(_arg_1:int):Boolean
			{
				return (_arg_1 < this.questOldAt_);
			}

			public function closestPlayer():GameObject
			{
				var _local_1:GameObject = this.getObject();
				var _local_2:GameObject;
				var _local_3:int;
				var _local_4:int = int.MAX_VALUE;
				var _local_5:GameObject;
				if (_local_1 != null)
				{
					for each (_local_2 in this.map_.goDict_)
					{
						if (_local_2 is Player)
						{
							_local_3 = PointUtil.distanceSquaredXY(_local_1.x_, _local_1.y_, _local_2.x_, _local_2.y_);
							if (_local_3 < _local_4)
							{
								_local_4 = _local_3;
								_local_5 = _local_2;
							}
						}
					}
				}
				return (_local_5);
			}


		}
	}//package com.company.assembleegameclient.map

