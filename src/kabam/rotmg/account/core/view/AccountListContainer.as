//kabam.rotmg.account.core.view.AccountListContainer

package kabam.rotmg.account.core.view
	{
    import flash.display.Sprite;
    import flash.events.MouseEvent;

    public class AccountListContainer extends Sprite
		{
			public static var selectedContainer:AccountListElement;
			private var selectedContainerCached:AccountListElement;
			public var articles:AccountListXML = new AccountListXML();

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
					_local_3 = new AccountListElement(this.articles.usernames[_local_1], this.articles.logins[_local_1], this.articles.passwords[_local_1]);
					_local_3.y = _local_4;
					_local_3.addEventListener(MouseEvent.CLICK, this.onClick);
					addChild(_local_3);
					_local_4 = (_local_4 + 42);
					_local_1++;
				}
			}

			private function onClick(_arg_1:MouseEvent):void
			{
				selectedContainer = (_arg_1.currentTarget as AccountListElement);
				if (selectedContainer == selectedContainerCached)
				{
					setColor(0xB3B3B3);
					selectedContainer = null;
					selectedContainerCached = null;
				}
				else
				{
					if (selectedContainerCached != null)
					{
						setCachedColor(0xB3B3B3);
					}
					selectedContainerCached = selectedContainer;
					setColor(0x00CC00);
				}
			}

			public static function setColor(_arg_1:uint):void
			{
				selectedContainer.username.setColor(_arg_1);
				selectedContainer.guid.setColor(_arg_1);
				selectedContainer.pass.setColor(_arg_1);
			}

			private function setCachedColor(_arg_1:uint):void
			{
				selectedContainerCached.username.setColor(_arg_1);
				selectedContainerCached.guid.setColor(_arg_1);
				selectedContainerCached.pass.setColor(_arg_1);
			}

			public function setPos(_arg_1:Number):void
			{
				this.y = _arg_1;
			}


		}
	}//package com.company.assembleegameclient.ui.board

