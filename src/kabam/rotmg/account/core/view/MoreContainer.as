//kabam.rotmg.account.core.view.MoreContainer

package kabam.rotmg.account.core.view
	{
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	import kabam.rotmg.account.web.model.AccountData;

	import org.osflash.signals.Signal;

	public class MoreContainer extends Sprite
		{

			private var articles:MoreXML = new MoreXML();
			public var signIn:Signal;

			public function MoreContainer()
			{
				this.signIn = new Signal(AccountData);
				this.makeContent();
			}

			private function makeContent():void
			{
				var _local_1:int;
				var _local_3:MoreElement;
				var _local_4:int = 32;
				_local_1 = 0;
				while (_local_1 < this.articles.logins.length)
				{
					_local_3 = new MoreElement(this.articles.logins[_local_1], this.articles.passwords[_local_1]);
					_local_3.y = _local_4;
					_local_3.addEventListener(MouseEvent.CLICK, this.onClick);
					_local_3.addEventListener(MouseEvent.CLICK, this.onMiddleClick);
					addChild(_local_3);
					_local_4 = (_local_4 + 42);
					_local_1++;
				}
			}

			public function setError(_arg_1:String):void
			{

			}

			private function onMiddleClick(_arg_1:MouseEvent):void
			{

			}

			private function onClick(_arg_1:MouseEvent):void
			{
				var _local_2:MoreElement = (_arg_1.currentTarget as MoreElement);
				var _local_1:AccountData = new AccountData();
				_local_1.username = _local_2.title.getStringBuilder().getString();
				if (_local_1.username.indexOf("@") != -1)
				{
					_local_1.password = _local_2.content.getStringBuilder().getString();
					_local_1.secret = "";
				}
				else
				{
					_local_1.password = "";
					_local_1.secret = _local_2.content.getStringBuilder().getString();
				}
				this.signIn.dispatch(_local_1);
			}

			public function setPos(_arg_1:Number):void
			{
				this.y = _arg_1;
			}


		}
	}//package com.company.assembleegameclient.ui.board

