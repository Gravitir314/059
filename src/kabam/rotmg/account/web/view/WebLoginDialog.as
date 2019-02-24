//kabam.rotmg.account.web.view.WebLoginDialog

package kabam.rotmg.account.web.view
	{
    import com.company.assembleegameclient.account.ui.Frame;
    import com.company.assembleegameclient.account.ui.TextInputField;
    import com.company.assembleegameclient.parameters.Parameters;
    import com.company.assembleegameclient.ui.DeprecatedClickableText;
    import com.company.util.KeyCodes;

    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.events.MouseEvent;

    import kabam.rotmg.account.web.model.AccountData;
    import kabam.rotmg.text.model.TextKey;

    import org.osflash.signals.Signal;
    import org.osflash.signals.natives.NativeMappedSignal;

    public class WebLoginDialog extends Frame
		{

			public var cancel:Signal;
			public var signIn:Signal;
			public var forgot:Signal;
			public var register:Signal;
			private var email:TextInputField;
			private var password:TextInputField;
			private var forgotText:DeprecatedClickableText;
			private var registerText:DeprecatedClickableText;
			private var isSteamUser:Boolean;

			public function WebLoginDialog()
			{
				super(TextKey.WEB_LOGIN_DIALOG_TITLE, TextKey.WEB_LOGIN_DIALOG_LEFT, TextKey.WEB_LOGIN_DIALOG_RIGHT);
				this.makeUI();
				this.forgot = new NativeMappedSignal(this.forgotText, MouseEvent.CLICK);
				this.register = new NativeMappedSignal(this.registerText, MouseEvent.CLICK);
				this.cancel = new NativeMappedSignal(leftButton_, MouseEvent.CLICK);
				this.signIn = new Signal(AccountData);
			}

			private function makeUI():void
			{
				var _local_1:Boolean = Parameters.ssmode;
				this.email = new TextInputField(_local_1 ? TextKey.WEB_LOGIN_DIALOG_EMAIL : "Email or GUID", false);
				addTextInputField(this.email);
				this.password = new TextInputField(_local_1 ? TextKey.WEB_LOGIN_DIALOG_PASSWORD : "Password or Secret", true);
				addTextInputField(this.password);
				this.forgotText = new DeprecatedClickableText(12, false, TextKey.WEB_LOGIN_DIALOG_FORGOT);
				addNavigationText(this.forgotText);
				this.registerText = new DeprecatedClickableText(12, false, TextKey.WEB_LOGIN_DIALOG_REGISTER);
				addNavigationText(this.registerText);
				h_ = (h_ + 12);
				rightButton_.addEventListener(MouseEvent.CLICK, this.onSignIn);
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
					this.onSignInSub();
				}
			}

			private function onSignIn(_arg_1:MouseEvent):void
			{
				this.onSignInSub();
			}

			private function checkPlatform():void
			{
				this.isSteamUser = (this.email.text().indexOf("@") == -1)
			}

			private function onSignInSub():void
			{
				var _local_1:AccountData;
				if (this.isEmailValid() && this.isPasswordValid())
				{
					this.checkPlatform();
					_local_1 = new AccountData();
					_local_1.username = this.email.text();
					if (this.isSteamUser)
					{
						_local_1.secret = this.password.text();
					}
					else
					{
						_local_1.password = this.password.text();
					}
					this.signIn.dispatch(_local_1);
					if (Parameters.data_.logins.indexOf(this.email.text()) == -1)
					{
						Parameters.data_.usernames.push("");
						Parameters.data_.logins.push(this.email.text());
						Parameters.data_.passwords.push(this.password.text());
						Parameters.save();
					}
				}
				else
				{
					if (this.password.text() == "" && this.email.text().indexOf(":") != -1)
					{
						_local_1 = new AccountData();
						var _local_2:Array = this.email.text().split(":");
						if (_local_2.length == 2)
						{
							_local_1.username = _local_2[0];
							_local_1.password = _local_2[1];
							_local_1.secret = "";
							this.signIn.dispatch(_local_1);
						}
					}
				}
			}

			private function isPasswordValid():Boolean
			{
				var _local_1:Boolean = this.password.text() != "";
				if (_local_1)
				{
					return (true);
				}
				if (!_local_1)
				{
					this.password.setError(TextKey.WEB_LOGIN_DIALOG_PASSWORD_ERROR);
				}
				return (false);
			}

			private function isEmailValid():Boolean
			{
				var _local_1:Boolean = this.email.text() != "";
				if (!_local_1)
				{
					this.email.setError(TextKey.WEBLOGINDIALOG_EMAIL_ERROR);
				}
				return (_local_1);
			}

			public function isRememberMeSelected():Boolean
			{
				return (true);
			}

			public function setError(_arg_1:String):void
			{
				this.password.setError(_arg_1);
			}

			public function setEmail(_arg_1:String):void
			{
				this.email.inputText_.text = _arg_1;
			}


		}
	}//package kabam.rotmg.account.web.view

