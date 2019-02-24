//kabam.rotmg.account.core.view.AccountListHelpDialog

package kabam.rotmg.account.core.view
	{
    import com.company.assembleegameclient.account.ui.Frame;

    import flash.events.MouseEvent;
    import flash.filters.DropShadowFilter;

    import kabam.rotmg.core.StaticInjectorContext;
    import kabam.rotmg.dialogs.control.OpenDialogSignal;
    import kabam.rotmg.text.view.TextFieldDisplayConcrete;
    import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

    public class AccountListHelpDialog extends Frame
		{
			private var openDialog:OpenDialogSignal;
			private var title:TextFieldDisplayConcrete;
			private var content:TextFieldDisplayConcrete;

			public function AccountListHelpDialog()
			{
				this.openDialog = StaticInjectorContext.getInjector().getInstance(OpenDialogSignal);
				super("", "", "Close");
				w_ = 475;
				h_ = 135;
				rightButton_.x = w_ - 50;
				rightButton_.addEventListener(MouseEvent.CLICK, onClick);
				this.title = new TextFieldDisplayConcrete().setSize(16).setColor(0xB3B3B3).setBold(true);
				this.title.x = 5;
				this.title.y = 2;
				this.title.setStringBuilder(new StaticStringBuilder("Help"));
				this.title.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
				addChild(this.title);
				this.content = new TextFieldDisplayConcrete().setSize(14).setColor(0xB3B3B3);
				this.content.x = 5;
				this.content.y = 35;
				this.content.setStringBuilder(new StaticStringBuilder("Use right-click to import new accounts in the list.\nYour accounts should be in muledump format in text file.\nTo login, click to the account and then \"Enter\".\nYou can edit your account and add username.\nWhen you login to new account, his data will be saved."));
				this.content.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
				addChild(this.content);
			}

			private function onClick(_arg_1:MouseEvent):void
			{
				this.openDialog.dispatch(new AccountListDialog);
			}
		}

	}