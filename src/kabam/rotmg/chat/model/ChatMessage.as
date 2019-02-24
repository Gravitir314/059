//kabam.rotmg.chat.model.ChatMessage

package kabam.rotmg.chat.model
{
	public class ChatMessage
	{

		public var name:String;
		public var text:String;
		public var objectId:int = -1;
		public var numStars:int = -1;
		public var recipient:String = "";
		public var isToMe:Boolean;
		public var isWhisper:Boolean;
		public var tokens:Object;
		public var isFromSupporter:Boolean;
		public var bad:Boolean;

		public static function make(_arg_1:String, _arg_2:String, _arg_3:Boolean = false, _arg_4:int = -1, _arg_5:int = -1, _arg_6:String = "", _arg_7:Boolean = false, _arg_8:Object = null, _arg_9:Boolean = false, _arg_10:Boolean = false):ChatMessage
		{
			var _local_9:ChatMessage = new (ChatMessage)();
			_local_9.name = _arg_1;
			_local_9.text = _arg_2;
			_local_9.bad = _arg_3;
			_local_9.objectId = _arg_4;
			_local_9.numStars = _arg_5;
			_local_9.recipient = _arg_6;
			_local_9.isToMe = _arg_7;
			_local_9.tokens = ((_arg_8 == null) ? {} : _arg_8);
			_local_9.isWhisper = _arg_9;
			_local_9.isFromSupporter = _arg_10;
			return (_local_9);
		}

	}
}//package kabam.rotmg.chat.model

