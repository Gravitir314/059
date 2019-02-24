//kabam.rotmg.account.core.view.AccountListDialog

package kabam.rotmg.account.core.view
{
	import com.company.assembleegameclient.account.ui.Frame;
	import com.company.assembleegameclient.parameters.Parameters;
	import com.company.assembleegameclient.ui.DeprecatedClickableText;
	import com.company.assembleegameclient.ui.Scrollbar;
	import com.company.rotmg.graphics.DeleteXGraphic;
	import com.company.util.KeyCodes;
	import com.greensock.plugins.DropShadowFilterPlugin;

	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.net.FileReference;

	import flashx.textLayout.formats.TextAlign;

	import kabam.lib.tasks.Task;
	import kabam.rotmg.account.core.signals.LoginSignal;
	import kabam.rotmg.account.web.model.AccountData;
	import kabam.rotmg.core.StaticInjectorContext;
	import kabam.rotmg.core.signals.TaskErrorSignal;
	import kabam.rotmg.dialogs.control.CloseDialogsSignal;
	import kabam.rotmg.dialogs.control.OpenDialogSignal;
	import kabam.rotmg.text.view.TextFieldDisplayConcrete;
	import kabam.rotmg.text.view.stringBuilder.LineBuilder;
	import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

	import org.swiftsuspenders.Injector;

	public class AccountListDialog extends Frame
	{
		public var login:LoginSignal;
		private var closeDialogs:CloseDialogsSignal;
		private var deleteButton:Sprite;
		private var deleteAccButton:DeprecatedClickableText;
		private var scrollBar:Scrollbar;
		private var container:AccountListContainer;
		private var title:TextFieldDisplayConcrete;
		private var openDialog:OpenDialogSignal;
		private var helpButton:DeprecatedClickableText;
		private var enterButton:DeprecatedClickableText;
		private var editButton:DeprecatedClickableText;
		private var errorText_:TextFieldDisplayConcrete;
		private var loginError:TaskErrorSignal;
		private var dailyButton:DeprecatedClickableText;
		private var file:FileReference;

		public function AccountListDialog()
		{
			super("", "", "");
			this.initialize();
			w_ = 700;
			h_ = 550;
			this.container = new AccountListContainer();
			addChild(this.container);
			addEventListener(MouseEvent.RIGHT_CLICK, this.onRightClick);
			if (this.container.articles.logins.length > 11)
			{
				this.makeScrollbar();
			}
			this.makeMask();
			this.makeDeleteButton();
			this.makeButtons();
			this.loginError.add(this.onLoginError);
			addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
			addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
		}

		private function initialize():void
		{
			var injector:Injector = StaticInjectorContext.getInjector();
			this.closeDialogs = injector.getInstance(CloseDialogsSignal);
			this.login = injector.getInstance(LoginSignal);
			this.openDialog = injector.getInstance(OpenDialogSignal);
			this.loginError = injector.getInstance(TaskErrorSignal);
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
				this.onRBClick(null);
			}
		}

		private function onLoginError(_arg_1:Task):void
		{
			AccountListContainer.setColor(16549442);
			this.errorText_ = new TextFieldDisplayConcrete().setSize(12).setColor(16549442).setHorizontalAlign(TextAlign.RIGHT);
			this.errorText_.setStringBuilder(new LineBuilder().setParams(_arg_1.error));
			this.errorText_.setMultiLine(true);
			this.errorText_.x = AccountListContainer.selectedContainer.x + (w_ - 300);
			this.errorText_.y = AccountListContainer.selectedContainer.y + 3;
			this.errorText_.filters = [DropShadowFilterPlugin.DEFAULT_FILTER];
			addChild(this.errorText_);
		}

		private function makeButtons():void
		{
			this.helpButton = new DeprecatedClickableText(18, true, "Help");
			this.helpButton.buttonMode = true;
			this.helpButton.x = 20;
			this.helpButton.y = (this.h_ - 52);
			this.helpButton.addEventListener(MouseEvent.CLICK, this.onHelpClick);
			addChild(this.helpButton);
			this.dailyButton = new DeprecatedClickableText(18, true, "Daily");
			this.dailyButton.buttonMode = true;
			this.dailyButton.x = w_ - 345;
			this.dailyButton.y = (this.h_ - 52);
			this.dailyButton.addEventListener(MouseEvent.CLICK, this.onDailyClick);
			addChild(this.dailyButton);
			this.deleteAccButton = new DeprecatedClickableText(18, true, "Delete");
			this.deleteAccButton.buttonMode = true;
			this.deleteAccButton.x = w_ - 265;
			this.deleteAccButton.y = (this.h_ - 52);
			this.deleteAccButton.addEventListener(MouseEvent.CLICK, this.onDeleteClick);
			addChild(this.deleteAccButton);
			this.editButton = new DeprecatedClickableText(18, true, "Edit");
			this.editButton.buttonMode = true;
			this.editButton.x = w_ - 175;
			this.editButton.y = (this.h_ - 52);
			this.editButton.addEventListener(MouseEvent.CLICK, this.onLBClick);
			addChild(this.editButton);
			this.enterButton = new DeprecatedClickableText(18, true, "Enter");
			this.enterButton.buttonMode = true;
			this.enterButton.x = w_ - 100;
			this.enterButton.y = (this.h_ - 52);
			this.enterButton.addEventListener(MouseEvent.CLICK, this.onRBClick);
			addChild(this.enterButton);
		}

		private function onDailyClick(_arg_1:MouseEvent):void
		{

		}

		private function onDeleteClick(_arg_1:MouseEvent):void
		{
			if (AccountListContainer.selectedContainer == null)
			{
				return;
			}
			var elem:AccountListElement = AccountListContainer.selectedContainer;
			for (var i:int = 0; i < Parameters.data_.logins.length; i++)
			{
				if (elem.guid.textField.text == Parameters.data_.logins[i])
				{
					Parameters.data_.usernames.splice(i, 1);
					Parameters.data_.logins.splice(i, 1);
					Parameters.data_.passwords.splice(i, 1);
					Parameters.save();
					break;
				}
			}
			this.openDialog.dispatch(new AccountListDialog);
		}

		private function onHelpClick(_arg_1:MouseEvent):void
		{
			AccountListContainer.selectedContainer = null;
			this.openDialog.dispatch(new AccountListHelpDialog);
		}

		private function makeScrollbar():void
		{
			this.scrollBar = new Scrollbar(16, 510);
			this.scrollBar.x = 674;
			this.scrollBar.y = 32;
			this.scrollBar.setIndicatorSize(510, this.container.height);
			this.scrollBar.addEventListener(Event.CHANGE, this.onScrollBarChange);
			addChild(this.scrollBar);
		}

		private function onScrollBarChange(_arg_1:Event):void
		{
			this.container.setPos((-(this.scrollBar.pos()) * (this.container.height - 510)));
		}

		private function makeMask():void
		{
			var _local_1:Shape;
			_local_1 = new Shape();
			_local_1.x = -6;
			_local_1.y = -6;
			var _local_2:Graphics = _local_1.graphics;
			_local_2.beginFill(0);
			_local_2.drawRect(0, 0, 701, 551);
			_local_2.endFill();
			addChild(_local_1);
			mask = _local_1;
			_local_1 = new Shape();
			_local_1.y = 544;
			_local_2 = _local_1.graphics;
			_local_2.beginFill(0xFFFFFF);
			_local_2.drawRect(0, 0, 670, 1);
			_local_2.endFill();
			addChild(_local_1);
			_local_1 = new Shape();
			_local_1.y = -6;
			_local_2 = _local_1.graphics;
			_local_2.beginFill(0xFFFFFF);
			_local_2.drawRect(0, 0, 670, 1);
			_local_2.endFill();
			addChild(_local_1);
			_local_1 = new Shape();
			_local_1.y = 26;
			_local_1.x = -5;
			_local_2 = _local_1.graphics;
			_local_2.beginFill(0, (100 / 0xFF));
			_local_2.drawRect(0, 0, 699, 1);
			_local_2.endFill();
			addChild(_local_1);
			_local_1 = new Shape();
			_local_1.y = 27;
			_local_1.x = -5;
			_local_2 = _local_1.graphics;
			_local_2.beginFill(0, (50 / 0xFF));
			_local_2.drawRect(0, 0, 699, 1);
			_local_2.endFill();
			addChild(_local_1);
			_local_1 = new Shape();
			_local_1.y = 28;
			_local_1.x = -5;
			_local_2 = _local_1.graphics;
			_local_2.beginFill(0, (25 / 0xFF));
			_local_2.drawRect(0, 0, 699, 1);
			_local_2.endFill();
			addChild(_local_1);
			_local_1 = new Shape();
			_local_1.y = -5;
			_local_2 = _local_1.graphics;
			_local_2.beginFill(0x4D4D4D);
			_local_2.drawRect(0, 0, 670, 31);
			_local_2.endFill();
			addChild(_local_1);
		}

		private function makeDeleteButton():void
		{
			this.title = new TextFieldDisplayConcrete().setSize(13).setColor(0xB3B3B3);
			this.title.setStringBuilder(new StaticStringBuilder("Accounts"));
			this.title.filters = [new DropShadowFilter(0, 0, 0)];
			this.title.x = 5;
			this.title.y = 3;
			addChild(this.title);
			this.deleteButton = new DeleteXGraphic();
			this.deleteButton.addEventListener(MouseEvent.CLICK, this.onClose);
			this.deleteButton.x = 668;
			addChild(this.deleteButton);
		}

		private function onRBClick(_arg_1:MouseEvent):void
		{
			if (AccountListContainer.selectedContainer == null)
			{
				return;
			}
			var _local_1:AccountData = new AccountData();
			_local_1.username = AccountListContainer.selectedContainer.guid.getStringBuilder().getString();
			if (_local_1.username.indexOf("@") != -1)
			{
				_local_1.password = AccountListContainer.selectedContainer.pass.getStringBuilder().getString();
				_local_1.secret = "";
			} else
			{
				_local_1.password = "";
				_local_1.secret = AccountListContainer.selectedContainer.pass.getStringBuilder().getString();
			}
			this.login.dispatch(_local_1);
		}

		private function onLBClick(_arg_1:MouseEvent):void
		{
			if (AccountListContainer.selectedContainer != null)
			{
				this.openDialog.dispatch(new AccountListEditDialog);
			}
		}

		public function onRightClick(_arg_1:MouseEvent):void
		{
			file = new FileReference();
			file.addEventListener(Event.SELECT, onFileSelected);
			file.browse();
		}

		public function onFileSelected(evt:Event):void
		{
			file.addEventListener(Event.COMPLETE, onComplete);
			file.load();
		}

		public function onComplete(evt:Event):void
		{
			var matches:Array = file.data.toString().match(new RegExp("[\"\']([\\w-@.]+)[\"\']: [\"\']([\\s\\S]*?)[\"\']", "g"));
			if (matches != null)
			{
				for (var counter:int = 0; counter < matches.length; counter++)
				{
					var match:Array = matches[counter].match("[\"\']([\\w-@.]+)[\"\']: [\"\']([\\s\\S]*?)[\"\']");
					if (Parameters.data_.logins.indexOf(match[1]) == -1)
					{
						Parameters.data_.usernames.push("");
						Parameters.data_.logins.push(match[1]);
						Parameters.data_.passwords.push(match[2]);
					}
				}
			}
			this.openDialog.dispatch(new AccountListDialog);
		}

		private function onClose(_arg_1:MouseEvent):void
		{
			this.closeDialogs.dispatch();
		}

	}
}