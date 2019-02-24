//com.company.assembleegameclient.objects.Container

package com.company.assembleegameclient.objects
{
	import com.company.assembleegameclient.game.GameSprite;
	import com.company.assembleegameclient.map.Camera;
	import com.company.assembleegameclient.map.Map;
	import com.company.assembleegameclient.parameters.Parameters;
	import com.company.assembleegameclient.sound.SoundEffectLibrary;
	import com.company.assembleegameclient.ui.panels.Panel;
	import com.company.assembleegameclient.ui.panels.itemgrids.ContainerGrid;
	import com.company.util.GraphicsUtil;
	import com.company.util.PointUtil;

	import flash.display.BitmapData;
	import flash.display.GraphicsBitmapFill;
	import flash.display.GraphicsPath;
	import flash.display.IGraphicsData;
	import flash.geom.Matrix;

	public class Container extends GameObject implements IInteractiveObject
	{

		public var isLoot_:Boolean;
		public var canHaveSoulbound_:Boolean;
		public var ownerId_:String;

		public var drawMeBig_:Boolean;
		private var lastEquips:Vector.<int> = new <int>[0, 0, 0, 0, 0, 0, 0, 0];
		private var icons_:Vector.<BitmapData> = null;
		private var iconFills_:Vector.<GraphicsBitmapFill> = null;
		private var iconPaths_:Vector.<GraphicsPath> = null;

		public function Container(_arg_1:XML)
		{
			super(_arg_1);
			isInteractive_ = true;
			this.isLoot_ = _arg_1.hasOwnProperty("Loot");
			this.canHaveSoulbound_ = _arg_1.hasOwnProperty("CanPutSoulboundObjects");
			this.ownerId_ = "";
		}

		public function setOwnerId(_arg_1:String):void
		{
			this.ownerId_ = _arg_1;
			isInteractive_ = ((this.ownerId_ == "") || (this.isBoundToCurrentAccount()));
		}

		public function isBoundToCurrentAccount():Boolean
		{
			return (map_.player_.accountId_ == this.ownerId_);
		}

		override public function addTo(_arg_1:Map, _arg_2:Number, _arg_3:Number):Boolean
		{
			if (!super.addTo(_arg_1, _arg_2, _arg_3))
			{
				return (false);
			}
			if (map_.player_ == null)
			{
				return (true);
			}
			var _local_4:Number = PointUtil.distanceXY(map_.player_.x_, map_.player_.y_, _arg_2, _arg_3);
			if (this.isLoot_)
			{
				if (this.isWhiteBag(this.objectType_) && Parameters.announcedBags.indexOf(this.objectId_) == -1)
				{
					this.map_.player_.textNotification("White Bag!", 0xFFFFFF, 2000, true);
				}
				if (_local_4 < 25)
				{
					SoundEffectLibrary.play("loot_appears");
				}
				if (shouldSendBag(this.objectType_))
				{
					this.drawMeBig_ = true;
				}
			}
			return (true);
		}

		override public function removeFromMap():void
		{
			super.removeFromMap();
		}

		private function shouldSendBag(_arg_1:int):Boolean
		{
			return (_arg_1 >= 1287 && _arg_1 <= 1289 || _arg_1 == 1291 || _arg_1 == 1292 || _arg_1 >= 1294 && _arg_1 <= 1296 || _arg_1 == 1708 || _arg_1 >= 1722 && _arg_1 <= 1728);
		}

		private function isWhiteBag(_arg_1:int):Boolean
		{
			return ((_arg_1 == 1292) || (_arg_1 == 1296));
		}

		public function getPanel(_arg_1:GameSprite):Panel
		{
			var _local_2:Player = (((_arg_1) && (_arg_1.map)) ? _arg_1.map.player_ : null);
			return (new ContainerGrid(this, _local_2));
		}

		override public function draw(_arg_1:Vector.<IGraphicsData>, _arg_2:Camera, _arg_3:int):void
		{
			super.draw(_arg_1, _arg_2, _arg_3);
			if (!Parameters.ssmode && (Parameters.data_.lootPreview == "vault" && this.map_.name_ == Map.VAULT || Parameters.data_.lootPreview == "everywhere"))
			{
				drawItems(_arg_1, _arg_2, _arg_3);
			}
		}

		public function updateItemSprites(_arg_1:Vector.<BitmapData>):void
		{
			var _local_5:int;
			while (_local_5 < this.equipment_.length)
			{
				var _local_3:int = this.equipment_[_local_5];
				if (_local_3 != -1)
				{
					var _local_2:BitmapData = ObjectLibrary.getItemIcon(_local_3);
					_arg_1.push(_local_2);
				}
				_local_5++;
			}
		}

		public function vectorsAreEqual(_arg_1:Vector.<int>):Boolean
		{
			return (_arg_1[0] == lastEquips[0] && _arg_1[1] == lastEquips[1] && _arg_1[2] == lastEquips[2] && _arg_1[3] == lastEquips[3] && _arg_1[4] == lastEquips[4] && _arg_1[5] == lastEquips[5] && _arg_1[6] == lastEquips[6] && _arg_1[7] == lastEquips[7]);
		}

		public function drawItems(_arg_1:Vector.<IGraphicsData>, _arg_2:Camera, _arg_3:int):void
		{
			var _local_13:Number;
			var _local_14:Number;
			var _local_5:int;
			if (this.icons_ == null)
			{
				this.icons_ = new Vector.<BitmapData>();
				this.iconFills_ = new Vector.<GraphicsBitmapFill>();
				this.iconPaths_ = new Vector.<GraphicsPath>();
				this.icons_.length = 0;
				updateItemSprites(this.icons_);
			} else
			{
				if (!vectorsAreEqual(equipment_))
				{
					this.icons_.length = 0;
					lastEquips[0] = equipment_[0];
					lastEquips[1] = equipment_[1];
					lastEquips[2] = equipment_[2];
					lastEquips[3] = equipment_[3];
					lastEquips[4] = equipment_[4];
					lastEquips[5] = equipment_[5];
					lastEquips[6] = equipment_[6];
					lastEquips[7] = equipment_[7];
					updateItemSprites(this.icons_);
				}
			}
			var _local_6:Number = posS_[3];
			var _local_4:Number = this.vS_[1];
			var _local_12:int = this.icons_.length;
			var _local_8:int;
			while (_local_8 < _local_12)
			{
				var _local_7:BitmapData = this.icons_[_local_8];
				if (_local_8 >= this.iconFills_.length)
				{
					this.iconFills_.push(new GraphicsBitmapFill(null, new Matrix(), false, false));
					this.iconPaths_.push(new GraphicsPath(GraphicsUtil.QUAD_COMMANDS, new Vector.<Number>()));
				}
				var _local_9:GraphicsBitmapFill = this.iconFills_[_local_8];
				var _local_11:GraphicsPath = this.iconPaths_[_local_8];
				_local_9.bitmapData = _local_7;
				_local_5 = (_local_8 * 0.25);
				_local_13 = ((_local_6 - (_local_7.width * 2)) + ((_local_8 % 4) * _local_7.width));
				_local_14 = (((_local_4 - (_local_7.height * 0.5)) + (_local_5 * (_local_7.height + 5))) - ((_local_5 * 5) + 20));
				_local_11.data.length = 0;
				(_local_11.data as Vector.<Number>).push(_local_13, _local_14, (_local_13 + _local_7.width), _local_14, (_local_13 + _local_7.width), (_local_14 + _local_7.height), _local_13, (_local_14 + _local_7.height));
				var _local_10:Matrix = _local_9.matrix;
				_local_10.identity();
				_local_10.translate(_local_13, _local_14);
				_arg_1.push(_local_9);
				_arg_1.push(_local_11);
				_arg_1.push(GraphicsUtil.END_FILL);
				_local_8++;
			}
		}

	}
}//package com.company.assembleegameclient.objects

