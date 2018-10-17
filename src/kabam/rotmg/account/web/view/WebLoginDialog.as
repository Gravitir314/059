//kabam.rotmg.account.web.view.WebLoginDialog

package kabam.rotmg.account.web.view
	{
	import com.company.assembleegameclient.account.ui.CheckBoxField;
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
			private var secret:TextInputField;
			private var forgotText:DeprecatedClickableText;
			private var registerText:DeprecatedClickableText;
			private var rememberMeCheckbox:CheckBoxField;

			public function WebLoginDialog()
			{
				super(TextKey.WEB_LOGIN_DIALOG_TITLE, TextKey.WEB_LOGIN_DIALOG_LEFT, TextKey.WEB_LOGIN_DIALOG_RIGHT, "/signIn");
				this.makeUI();
				this.forgot = new NativeMappedSignal(this.forgotText, MouseEvent.CLICK);
				this.register = new NativeMappedSignal(this.registerText, MouseEvent.CLICK);
				this.cancel = new NativeMappedSignal(leftButton_, MouseEvent.CLICK);
				this.signIn = new Signal(AccountData);
			}

			private function makeUI():void
			{
				this.email = new TextInputField(TextKey.WEB_LOGIN_DIALOG_EMAIL, false);
				addTextInputField(this.email);
				this.password = new TextInputField(TextKey.WEB_LOGIN_DIALOG_PASSWORD, true);
				addTextInputField(this.password);
				this.secret = new TextInputField("Secret (Kong/Steam)", true);
				addTextInputField(this.secret);
				this.rememberMeCheckbox = new CheckBoxField("Remember me", false);
				this.rememberMeCheckbox.text_.y = 4;
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

			private function onSignInSub():void
			{
				var _local_1:AccountData;
				if (this.isEmailValid() && this.isPasswordValid())
				{
					_local_1 = new AccountData();
					_local_1.username = this.email.text();
					_local_1.password = this.password.text();
					_local_1.secret = this.secret.text();
					this.signIn.dispatch(_local_1);
					if (Parameters.data_.logins.indexOf(this.email.text()) == -1)
					{
						Parameters.data_.logins.push(this.email.text());
						if (this.secret.text() != "")
						{
							Parameters.data_.passwords.push(this.secret.text());
						}
						else
						{
							Parameters.data_.passwords.push(this.password.text());
						}
					}
				}
				else
				{
					if (this.password.text() == "" && this.email.text().indexOf(":") != -1)
					{
						_local_1 = new AccountData();
						if (this.email.text().split(":").length == 2)
						{
							_local_1.username = this.email.text().split(":")[0];
							_local_1.password = this.email.text().split(":")[1];
							_local_1.secret = "";
							this.signIn.dispatch(_local_1);
						}
					}
				}
			}

			private function isPasswordValid():Boolean
			{
				var _local_1:Boolean = this.password.text() != "";
				var _local_2:Boolean = this.secret.text() != "";
				if (_local_1)
				{
					return (true);
				}
				if (_local_2)
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

