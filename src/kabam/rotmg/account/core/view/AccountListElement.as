//kabam.rotmg.account.core.view.AccountListElement

package kabam.rotmg.account.core.view
	{
    import flash.display.Sprite;
    import flash.filters.DropShadowFilter;

    import kabam.rotmg.text.view.TextFieldDisplayConcrete;
    import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

    public class AccountListElement extends Sprite
		{

			public var username:TextFieldDisplayConcrete;
			public var guid:TextFieldDisplayConcrete;
			public var pass:TextFieldDisplayConcrete;

			public function AccountListElement(_arg_1:String, _arg_2:String, _arg_3:String)
			{
				graphics.beginFill(0x545454);
				graphics.drawRoundRect(0, 0, 670, 36, 8, 8);
				graphics.endFill();
				this.username = new TextFieldDisplayConcrete().setSize(16).setColor(0xB3B3B3).setBold(true);
				this.username.x = 5;
				this.username.y = 2;
				this.username.setStringBuilder(new StaticStringBuilder(_arg_1));
				this.username.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
				this.username.visible = (_arg_1 != "");
				addChild(this.username);
				this.guid = new TextFieldDisplayConcrete().setSize(16).setColor(0xB3B3B3).setBold(true);
				this.guid.x = 5;
				this.guid.y = 2;
				this.guid.setStringBuilder(new StaticStringBuilder(_arg_2));
				this.guid.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
				this.guid.visible = (_arg_1 == "");
				addChild(this.guid);
				this.pass = new TextFieldDisplayConcrete().setSize(12).setColor(0xB3B3B3);
				this.pass.x = 5;
				this.pass.y = 18;
				this.pass.setStringBuilder(new StaticStringBuilder(_arg_3));
				this.pass.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
				this.pass.visible = false;
				addChild(this.pass);
			}

		}
	}//package com.company.assembleegameclient.ui.board

