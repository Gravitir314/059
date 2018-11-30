//com.company.assembleegameclient.screens.ServerBoxes

package com.company.assembleegameclient.screens
	{
	import com.company.assembleegameclient.parameters.Parameters;

	import flash.display.Sprite;
	import flash.events.MouseEvent;

	import kabam.rotmg.servers.api.Server;

	public class ServerBoxes extends Sprite
		{

			private var boxes_:Vector.<ServerBox> = new Vector.<ServerBox>();

			public function ServerBoxes(_arg_1:Vector.<Server>)
			{
				var _local_4:ServerBox;
				var _local_2:int;
				var _local_5:Server;
				_local_4 = new ServerBox(null);
				_local_4.setSelected(true);
				_local_4.x = Parameters.ssmode ? (ServerBox.WIDTH / 2) + 2 : 0;
				_local_4.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
				addChild(_local_4);
				this.boxes_.push(_local_4);
				if (!Parameters.ssmode)
				{
					var _local_3:Server = makeLocalhostServer();
					_local_4 = new ServerBox(_local_3);
					if (_local_3.name == Parameters.data_.preferredServer)
					{
						this.setSelected(_local_4);
					}
					_local_4.x = (ServerBox.WIDTH + 4);
					_local_4.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
					addChild(_local_4);
					this.boxes_.push(_local_4);
				}
				_local_2 = 2;
				for each (_local_5 in _arg_1)
				{
					if (_local_5.address != "127.0.0.1")
					{
						_local_4 = new ServerBox(_local_5);
						if (_local_5.name == Parameters.data_.preferredServer)
						{
							this.setSelected(_local_4);
						}
						_local_4.x = ((_local_2 % 2) * (ServerBox.WIDTH + 4));
						_local_4.y = (int((_local_2 / 2)) * (ServerBox.HEIGHT + 4));
						_local_4.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
						addChild(_local_4);
						this.boxes_.push(_local_4);
						_local_2++;
					}
				}
			}

			public static function makeLocalhostServer():Server
			{
				return (new Server().setName("Proxy").setAddress("127.0.0.1").setPort(Parameters.PORT).setLatLong(Number.MAX_VALUE, Number.MAX_VALUE).setUsage(0).setIsAdminOnly(false));
			}

			private function onMouseDown(_arg_1:MouseEvent):void
			{
				var _local_2:ServerBox = (_arg_1.currentTarget as ServerBox);
				if (_local_2 == null)
				{
					return;
				}
				this.setSelected(_local_2);
				Parameters.data_.preferredServer = _local_2.value_;
				Parameters.save();
			}

			private function setSelected(_arg_1:ServerBox):void
			{
				var _local_2:ServerBox;
				for each (_local_2 in this.boxes_)
				{
					_local_2.setSelected(false);
				}
				_arg_1.setSelected(true);
			}


		}
	}//package com.company.assembleegameclient.screens

