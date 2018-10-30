//kabam.rotmg.account.core.view.AccountListContainer

package kabam.rotmg.account.core.view
	{
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class AccountListContainer extends Sprite
		{
			public static var selectedContainer:AccountListElement;
			private var articles:AccountListXML = new AccountListXML();

			public function AccountListContainer()
			{
				this.makeContent();
			}

			private function makeContent():void
			{
				var _local_1:int;
				var _local_3:AccountListElement;
				var _local_4:int = 32;
				_local_1 = 0;
				while (_local_1 < this.articles.logins.length)
				{
					_local_3 = new AccountListElement(this.articles.logins[_local_1], this.articles.passwords[_local_1]);
					_local_3.y = _local_4;
					_local_3.addEventListener(MouseEvent.CLICK, this.onClick);
					addChild(_local_3);
					_local_4 = (_local_4 + 42);
					_local_1++;
				}
			}

			public function setError(_arg_1:String):void
			{

			}

			private function onClick(_arg_1:MouseEvent):void
			{
				selectedContainer = (_arg_1.currentTarget as AccountListElement);
			}

			public function setPos(_arg_1:Number):void
			{
				this.y = _arg_1;
			}


		}
	}//package com.company.assembleegameclient.ui.board

