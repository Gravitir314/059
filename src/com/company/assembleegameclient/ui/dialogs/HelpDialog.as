//com.company.assembleegameclient.ui.dialogs.HelpDialog

package com.company.assembleegameclient.ui.dialogs
	{
	import com.company.assembleegameclient.account.ui.Frame;
	import com.company.assembleegameclient.ui.Scrollbar;
	import com.company.rotmg.graphics.DeleteXGraphic;

	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;

	import kabam.rotmg.core.StaticInjectorContext;
	import kabam.rotmg.dialogs.control.CloseDialogsSignal;
	import kabam.rotmg.text.view.TextFieldDisplayConcrete;
	import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

	public class HelpDialog extends Frame
		{

			private var closeDialogs:CloseDialogsSignal;
			private var deleteButton:Sprite;
			private var scrollBar:Scrollbar;
			private var container:HelpContainer;
			private var title:TextFieldDisplayConcrete;

			public function HelpDialog()
			{
				super("", "", "");
				this.closeDialogs = StaticInjectorContext.getInjector().getInstance(CloseDialogsSignal);
				w_ = 700;
				h_ = 550;
				this.container = new HelpContainer();
				addChild(this.container);
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
				this.title.setStringBuilder(new StaticStringBuilder("Commands"));
				this.title.filters = [new DropShadowFilter(0, 0, 0)];
				this.title.x = 5;
				this.title.y = 3;
				addChild(this.title);
				this.deleteButton = new DeleteXGraphic();
				this.deleteButton.addEventListener(MouseEvent.CLICK, this.onClose);
				this.deleteButton.x = 668;
				addChild(this.deleteButton);
			}

			private function onClose(_arg_1:MouseEvent):void
			{
				this.closeDialogs.dispatch();
			}


		}
	}//package com.company.assembleegameclient.ui.board

import flash.display.Sprite;
import flash.filters.DropShadowFilter;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;

import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

class HelpContainer extends Sprite
	{
		private var articles:HelpXML = new HelpXML();

		public function HelpContainer()
		{
			this.makeContent();
		}

		private function makeContent():void
		{
			var _local_1:int;
			var _local_2:int;
			var _local_3:HelpElement;
			var _local_4:int = 32;
			_local_1 = 0;
			while (_local_1 < this.articles.commands.length)
			{
				_local_2 = this.count(this.articles.explanations[_local_1], "\n");
				_local_3 = new HelpElement(this.articles.commands[_local_1], this.articles.explanations[_local_1], _local_2);
				_local_3.y = _local_4;
				addChild(_local_3);
				_local_4 = (_local_4 + (42 + (_local_2 * 12)));
				_local_1++;
			}
		}

		private function count(_arg_1:String, _arg_2:String):int
		{
			return (_arg_1.match(new RegExp(_arg_2, "g")).length);
		}

		public function setPos(_arg_1:Number):void
		{
			this.y = _arg_1;
		}
	}

class HelpElement extends Sprite
	{

		private var title:TextFieldDisplayConcrete;
		private var content:TextFieldDisplayConcrete;

		public function HelpElement(_arg_1:String, _arg_2:String, _arg_3:int)
		{
			graphics.beginFill(0x545454);
			graphics.drawRoundRect(0, 0, 670, (36 + (_arg_3 * 12)), 8, 8);
			graphics.endFill();
			this.title = new TextFieldDisplayConcrete().setSize(16).setColor(0x55abec).setBold(true);
			this.title.x = 5;
			this.title.y = 2;
			this.title.setStringBuilder(new StaticStringBuilder(_arg_1));
			this.title.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
			addChild(this.title);
			this.content = new TextFieldDisplayConcrete().setSize(12).setColor(0x55abec);
			this.content.x = 5;
			this.content.y = 18;
			this.content.setStringBuilder(new StaticStringBuilder(_arg_2));
			this.content.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
			addChild(this.content);
		}

	}

class HelpXML
	{

		[Embed(source="EmbeddedHelp.dat", mimeType="application/octet-stream")]
		public static var protipsXML:Class;

		public var commands:Vector.<String> = new Vector.<String>(0);
		public var explanations:Vector.<String> = new Vector.<String>(0);

		public function HelpXML()
		{
			this.makeTipsVector();
		}

		private function makeTipsVector():void
		{
			var _local_1:String;
			var _local_2:XML = XML(new protipsXML());
			for (_local_1 in _local_2.Article)
			{
				this.commands.push(_local_2.Article.Command[_local_1]);
				this.explanations.push(_local_2.Article.Explanation[_local_1]);
			}
		}


	}