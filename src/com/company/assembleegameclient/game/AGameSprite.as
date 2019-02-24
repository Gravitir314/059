//com.company.assembleegameclient.game.AGameSprite

package com.company.assembleegameclient.game
{
	import com.company.assembleegameclient.map.AbstractMap;
	import com.company.assembleegameclient.map.Camera;
	import com.company.assembleegameclient.objects.GameObject;
	import com.company.assembleegameclient.objects.Player;
	import com.company.assembleegameclient.tutorial.Tutorial;

	import flash.display.Sprite;

	import kabam.rotmg.core.model.PlayerModel;
	import kabam.rotmg.messaging.impl.GameServerConnection;
	import kabam.rotmg.messaging.impl.incoming.MapInfo;
	import kabam.rotmg.ui.view.HUDView;

	import org.osflash.signals.Signal;

	import zfn.Hit;

	public class AGameSprite extends Sprite
	{

		public const closed:Signal = new Signal();

		public var isEditor:Boolean;
		public var tutorial_:Tutorial;
		public var mui_:MapUserInput;
		public var lastUpdate_:int;
		public var moveRecords_:MoveRecords = new MoveRecords();
		public var map:AbstractMap;
		public var model:PlayerModel;
		public var hudView:HUDView;
		public var camera_:Camera = new Camera();
		public var player_:Player;
		public var gsc_:GameServerConnection;

		public var statsStart:int = 0;
		public var statsFrameNumber:int = 0;
		public var statsFPS:int = 0;
		public var hitQueue:Vector.<Hit> = new Vector.<Hit>();

		public function initialize():void
		{
		}

		public function setFocus(_arg_1:GameObject):void
		{
		}

		public function applyMapInfo(_arg_1:MapInfo):void
		{
		}

		public function showDailyLoginCalendar():void
		{
		}

		public function evalIsNotInCombatMapArea():Boolean
		{
			return (false);
		}

	}
}//package com.company.assembleegameclient.game

