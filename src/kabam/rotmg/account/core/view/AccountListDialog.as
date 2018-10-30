//kabam.rotmg.account.core.view.AccountListDialog

package kabam.rotmg.account.core.view
	{
	import com.company.assembleegameclient.account.ui.Frame;
	import com.company.assembleegameclient.parameters.Parameters;
	import com.company.assembleegameclient.ui.Scrollbar;
	import com.company.rotmg.graphics.DeleteXGraphic;

	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.net.FileReference;

	import kabam.rotmg.account.core.signals.LoginSignal;
	import kabam.rotmg.account.web.model.AccountData;
	import kabam.rotmg.core.StaticInjectorContext;
	import kabam.rotmg.dialogs.control.CloseDialogsSignal;
	import kabam.rotmg.text.view.TextFieldDisplayConcrete;
	import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

	public class AccountListDialog extends Frame
		{
			public var login:LoginSignal;
			private var closeDialogs:CloseDialogsSignal;
			private var deleteButton:Sprite;
			private var scrollBar:Scrollbar;
			private var container:AccountListContainer;
			private var title:TextFieldDisplayConcrete;
			private var file:FileReference;

			public function AccountListDialog()
			{
				super("", "Edit", "Enter");
				this.closeDialogs = StaticInjectorContext.getInjector().getInstance(CloseDialogsSignal);
				this.login = StaticInjectorContext.getInjector().getInstance(LoginSignal);
				w_ = 700;
				h_ = 550;
				leftButton_.x = w_ - 150;
				rightButton_.x = w_ - 50;
				this.container = new AccountListContainer();
				addChild(this.container);
				addEventListener(MouseEvent.RIGHT_CLICK, this.onRightClick);
				rightButton_.addEventListener(MouseEvent.CLICK, this.onRBClick);
				leftButton_.addEventListener(MouseEvent.CLICK, this.onLBClick);
				this.createScrollbar();
				this.makeMask();
				this.makeDeleteButton();
			}

			private function createScrollbar():void
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
				if (AccountListContainer.selectedContainer == null) return;
				var _local_1:AccountData = new AccountData();
				_local_1.username = AccountListContainer.selectedContainer.title.getStringBuilder().getString();
				if (_local_1.username.indexOf("@") != -1)
				{
					_local_1.password = AccountListContainer.selectedContainer.content.getStringBuilder().getString();
					_local_1.secret = "";
				}
				else
				{
					_local_1.password = "";
					_local_1.secret = AccountListContainer.selectedContainer.content.getStringBuilder().getString();
				}
				this.login.dispatch(_local_1);
			}

			private function onLBClick(_arg_1:MouseEvent):void
			{

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
							Parameters.data_.logins.push(match[1]);
							Parameters.data_.passwords.push(match[2]);
						}
					}
				}
			}

			private function onClose(_arg_1:MouseEvent):void
			{
				this.closeDialogs.dispatch();
			}

		}
	}