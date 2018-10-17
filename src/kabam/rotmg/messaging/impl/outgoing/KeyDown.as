//kabam.rotmg.messaging.impl.outgoing.KeyDown

package kabam.rotmg.messaging.impl.outgoing
	{
	import flash.utils.IDataOutput;

	public class KeyDown extends OutgoingMessage
		{

			public var key_:int;

			public function KeyDown(_arg_1:uint, _arg_2:Function)
			{
				super(_arg_1, _arg_2);
			}

			override public function writeToOutput(_arg_1:IDataOutput):void
			{
				_arg_1.writeInt(this.key_)
			}

			override public function toString():String
			{
				return (formatToString("KEYDOWNMSG", "key_"));
			}


		}
	}//package kabam.rotmg.messaging.impl.outgoing

