//kabam.rotmg.account.core.view.AccountListHelpDialog

package kabam.rotmg.account.core.view
{
	import com.company.assembleegameclient.account.ui.Frame;
	import com.company.assembleegameclient.account.ui.TextInputField;
	import com.company.assembleegameclient.parameters.Parameters;
	import com.company.util.KeyCodes;

	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;

	import kabam.rotmg.core.StaticInjectorContext;
	import kabam.rotmg.dialogs.control.OpenDialogSignal;
	import kabam.rotmg.text.view.TextFieldDisplayConcrete;
	import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

	public class AccountListEditDialog extends Frame
	{
		private var openDialog:OpenDialogSignal;
		private var title:TextFieldDisplayConcrete;

		private var cachedUsername:String;
		private var cachedEmail:String;
		private var cachedPassword:String;

		private var username:TextInputField;
		private var email:TextInputField;
		private var password:TextInputField;

		public function AccountListEditDialog()
		{
			this.openDialog = StaticInjectorContext.getInjector().getInstance(OpenDialogSignal);
			super("", "Close", "Save");
			this.title = new TextFieldDisplayConcrete().setSize(16).setColor(0xB3B3B3).setBold(true);
			this.title.x = 5;
			this.title.y = 2;
			this.title.setStringBuilder(new StaticStringBuilder("Edit"));
			this.title.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
			addChild(this.title);
			rightButton_.addEventListener(MouseEvent.CLICK, onSave);
			leftButton_.addEventListener(MouseEvent.CLICK, onClose);
			this.makeUI();
			addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
			addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
		}

		private function onRemovedFromStage(_arg_1:Event):void
		{
			removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
			removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
		}

		private function onKeyDown(_arg_1:KeyboardEvent):void
		{
			if (_arg_1.keyCode == KeyCodes.ENTER)
			{
				this.onSave(null);
			}
		}

		private function makeUI():void
		{
			var selected:AccountListElement = AccountListContainer.selectedContainer;
			this.cachedUsername = selected.username.textField.text;
			this.cachedEmail = selected.guid.textField.text;
			this.cachedPassword = selected.pass.textField.text;
			this.username = new TextInputField("Name", false);
			this.username.inputText_.setText(selected.username.textField.text);
			addTextInputField(this.username);
			this.email = new TextInputField("Email/GUID", false);
			this.email.inputText_.setText(selected.guid.textField.text);
			addTextInputField(this.email);
			this.password = new TextInputField("Password/Secret", false);
			this.password.inputText_.setText(selected.pass.textField.text);
			addTextInputField(this.password);
		}

		private function onClose(_arg_1:MouseEvent):void
		{
			AccountListContainer.selectedContainer = null;
			this.openDialog.dispatch(new AccountListDialog);
		}

		private function onSave(_arg_1:MouseEvent):void
		{
			var counter:int;
			if (cachedUsername != this.username.inputText_.text)
			{
				for (counter = 0; counter < Parameters.data_.usernames.length; counter++)
				{
					if (Parameters.data_.logins[counter] == cachedEmail)
					{
						Parameters.data_.usernames[counter] = this.username.inputText_.text;
						cachedUsername = this.username.inputText_.text;
					}
				}
			}
			if (cachedEmail != this.email.inputText_.text)
			{
				for (counter = 0; counter < Parameters.data_.logins.length; counter++)
				{
					if (Parameters.data_.logins[counter] == cachedEmail)
					{
						Parameters.data_.logins[counter] = this.email.inputText_.text;
						cachedEmail = this.email.inputText_.text;
					}
				}
			}
			if (cachedPassword != this.password.inputText_.text)
			{
				for (counter = 0; counter < Parameters.data_.passwords.length; counter++)
				{
					if (Parameters.data_.passwords[counter] == cachedPassword)
					{
						Parameters.data_.passwords[counter] = this.password.inputText_.text;
						cachedPassword = this.password.inputText_.text;
					}
				}
			}
			AccountListContainer.selectedContainer = null;
			this.openDialog.dispatch(new AccountListDialog);
		}
	}

}