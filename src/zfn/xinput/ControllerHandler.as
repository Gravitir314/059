//zfn.xinput.ControllerHandler

package zfn.xinput
	{
	import com.company.assembleegameclient.parameters.Parameters;

	import flash.events.EventDispatcher;
	import flash.events.GameInputEvent;
	import flash.ui.GameInput;
	import flash.ui.GameInputDevice;

	public class ControllerHandler extends EventDispatcher
		{

			public static const LSTICK_X_AXIS:String = "AXIS_0";
			public static const LSTICK_Y_AXIS:String = "AXIS_1";
			public static const LSTICK_CLICK:String = "BUTTON_14";
			public static const RSTICK_X_AXIS:String = "AXIS_2";
			public static const RSTICK_Y_AXIS:String = "AXIS_3";
			public static const RSTICK_CLICK:String = "BUTTON_15";
			public static const LTRIG_PULL:String = "BUTTON_10";
			public static const RTRIG_PULL:String = "BUTTON_11";
			public static const LB:String = "BUTTON_8";
			public static const RB:String = "BUTTON_9";
			public static const BACK:String = "BUTTON_12";
			public static const START:String = "BUTTON_13";
			public static const DPAD_UP:String = "BUTTON_16";
			public static const DPAD_DOWN:String = "BUTTON_17";
			public static const DPAD_LEFT:String = "BUTTON_18";
			public static const DPAD_RIGHT:String = "BUTTON_19";
			public static const A:String = "BUTTON_4";
			public static const B:String = "BUTTON_5";
			public static const X:String = "BUTTON_6";
			public static const Y:String = "BUTTON_7";
			public static const LSTICK_X_AXIS_num_0:int = 0;
			public static const LSTICK_Y_AXIS_num_1:int = 1;
			public static const RSTICK_X_AXIS_num_2:int = 2;
			public static const RSTICK_Y_AXIS_num_3:int = 3;
			public static const A_num_4:int = 4;
			public static const B_num_5:int = 5;
			public static const X_num_6:int = 6;
			public static const Y_num_7:int = 7;
			public static const LB_num_8:int = 8;
			public static const RB_num_9:int = 9;
			public static const LTRIG_PULL_num_10:int = 10;
			public static const RTRIG_PULL_num_11:int = 11;
			public static const BACK_num_12:int = 12;
			public static const START_num_13:int = 13;
			public static const LSTICK_CLICK_num_14:int = 14;
			public static const RSTICK_CLICK_num_15:int = 15;
			public static const DPAD_UP_num_16:int = 16;
			public static const DPAD_DOWN_num_17:int = 17;
			public static const DPAD_LEFT_num_18:int = 18;
			public static const DPAD_RIGHT_num_19:int = 19;

			public static var instance:ControllerHandler;

			public const STICK_DEADZONE:Number = 0.2;

			public var gameInput:GameInput;
			public var controller:GameInputDevice;
			public var controls:Vector.<Number>;


			public function inputEvent(_arg_1:int, _arg_2:Number):void
			{
				ROTMG.STAGE.dispatchEvent(new ControllerEvent(ControllerEvent.BUTTON_DOWN, false, false, _arg_1, _arg_2));
			}

			public function deviceAdded(_arg_1:GameInputEvent):void
			{
				var _local_2:GameInputDevice;
				if (GameInput.numDevices > 0)
				{
					_local_2 = GameInput.getDeviceAt(0);
					_local_2.enabled = true;
					trace("device found", _local_2.name);
					if (_local_2.name == "Xbox 360 Controller (XInput STANDARD GAMEPAD)" || Parameters.data_.cNameBypass)
					{
						controller = _local_2;
						controls = new Vector.<Number>(_local_2.numControls, true);
					}
				}
			}

			public function deviceRemoved(_arg_1:GameInputEvent):void
			{
				if (_arg_1.device == controller)
				{
					controller = null;
					controls.length = 0;
				}
			}


		}
	}//package zfn.xinput

