//com.company.assembleegameclient.util.ParameterizedHandlerContainer

package com.company.assembleegameclient.util
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;

	public class ParameterizedHandlerContainer
	{

		internal var _handlers:Dictionary;

		public function ParameterizedHandlerContainer()
		{
			this._handlers = new Dictionary(true);
		}

		public function registerHandler(dispatcher:IEventDispatcher, eventType:String, callback:Function, ...rest):Function
		{
			var f:Function = function (_arg_1:Event):void
			{
				rest.unshift(_arg_1);
				callback.apply(null, rest);
			};
			this._handlers[callback] = new HandlerConfig(f, dispatcher);
			dispatcher.addEventListener(eventType, f);
			return (f);
		}

		public function destroyHandler(_arg_1:Function, _arg_2:Event):void
		{
			var _local_3:* = this._handlers[_arg_1];
			if (_local_3)
			{
				_local_3.dispatcher.removeEventListener(_arg_2.type, _local_3.handler);
				delete this._handlers[_arg_1];
			}
		}

	}
}//package com.company.assembleegameclient.util

import flash.events.IEventDispatcher;

class HandlerConfig
{

	public var handler:Function;
	public var dispatcher:IEventDispatcher;

	public function HandlerConfig(_arg_1:Function, _arg_2:IEventDispatcher)
	{
		this.handler = _arg_1;
		this.dispatcher = _arg_2;
	}

}


