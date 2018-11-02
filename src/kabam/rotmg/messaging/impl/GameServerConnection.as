//kabam.rotmg.messaging.impl.GameServerConnection

package kabam.rotmg.messaging.impl
	{
	import com.company.assembleegameclient.game.AGameSprite;
	import com.company.assembleegameclient.objects.GameObject;
	import com.company.assembleegameclient.objects.Player;
	import com.company.assembleegameclient.objects.Projectile;

	import flash.utils.ByteArray;

	import kabam.lib.net.impl.SocketServer;
	import kabam.rotmg.messaging.impl.data.SlotObjectData;
	import kabam.rotmg.servers.api.Server;

	import org.osflash.signals.Signal;

	public class GameServerConnection
		{
			[Embed(source="Packets.dat", mimeType="application/octet-stream")]
			public static const packets:Class;

			public static var FAILURE:int;
			public static var CREATESUCCESS:int;
			public static var CREATE:int;
			public static var PLAYERSHOOT:int;
			public static var MOVE:int;
			public static var PLAYERTEXT:int;
			public static var TEXT:int;
			public static var SERVERPLAYERSHOOT:int;
			public static var DAMAGE:int;
			public static var UPDATE:int;
			public static var UPDATEACK:int;
			public static var NOTIFICATION:int;
			public static var NEWTICK:int;
			public static var INVSWAP:int;
			public static var USEITEM:int;
			public static var SHOWEFFECT:int;
			public static var HELLO:int;
			public static var GOTO:int;
			public static var INVDROP:int;
			public static var INVRESULT:int;
			public static var RECONNECT:int;
			public static var PING:int;
			public static var PONG:int;
			public static var MAPINFO:int;
			public static var LOAD:int;
			public static var PIC:int;
			public static var SETCONDITION:int;
			public static var TELEPORT:int;
			public static var USEPORTAL:int;
			public static var DEATH:int;
			public static var BUY:int;
			public static var BUYRESULT:int;
			public static var AOE:int;
			public static var GROUNDDAMAGE:int;
			public static var PLAYERHIT:int;
			public static var ENEMYHIT:int;
			public static var AOEACK:int;
			public static var SHOOTACK:int;
			public static var OTHERHIT:int;
			public static var SQUAREHIT:int;
			public static var GOTOACK:int;
			public static var EDITACCOUNTLIST:int;
			public static var ACCOUNTLIST:int;
			public static var QUESTOBJID:int;
			public static var CHOOSENAME:int;
			public static var NAMERESULT:int;
			public static var CREATEGUILD:int;
			public static var GUILDRESULT:int;
			public static var GUILDREMOVE:int;
			public static var GUILDINVITE:int;
			public static var ALLYSHOOT:int;
			public static var ENEMYSHOOT:int;
			public static var REQUESTTRADE:int;
			public static var TRADEREQUESTED:int;
			public static var TRADESTART:int;
			public static var CHANGETRADE:int;
			public static var TRADECHANGED:int;
			public static var ACCEPTTRADE:int;
			public static var CANCELTRADE:int;
			public static var TRADEDONE:int;
			public static var TRADEACCEPTED:int;
			public static var CLIENTSTAT:int;
			public static var CHECKCREDITS:int;
			public static var ESCAPE:int;
			public static var FILE:int;
			public static var INVITEDTOGUILD:int;
			public static var JOINGUILD:int;
			public static var CHANGEGUILDRANK:int;
			public static var PLAYSOUND:int;
			public static var GLOBALNOTIFICATION:int;
			public static var RESKIN:int;
			public static var PETUPGRADEREQUEST:int;
			public static var ACTIVEPETUPDATEREQUEST:int;
			public static var ACTIVEPETUPDATE:int;
			public static var NEWABILITY:int;
			public static var PETYARDUPDATE:int;
			public static var EVOLVEPET:int;
			public static var DELETEPET:int;
			public static var HATCHPET:int;
			public static var ENTERARENA:int;
			public static var IMMINENTARENAWAVE:int;
			public static var ARENADEATH:int;
			public static var ACCEPTARENADEATH:int;
			public static var VERIFYEMAIL:int;
			public static var RESKINUNLOCK:int;
			public static var PASSWORDPROMPT:int;
			public static var QUESTFETCHASK:int;
			public static var QUESTREDEEM:int;
			public static var QUESTFETCHRESPONSE:int;
			public static var QUESTREDEEMRESPONSE:int;
			public static var PETCHANGEFORMMSG:int;
			public static var KEYINFOREQUEST:int;
			public static var KEYINFORESPONSE:int;
			public static var CLAIMLOGINREWARDMSG:int;
			public static var LOGINREWARDMSG:int;
			public static var QUESTROOMMSG:int;
			public static var PETCHANGESKINMSG:int;
			public static var instance:GameServerConnection;

			public var changeMapSignal:Signal;
			public var gs_:AGameSprite;
			public var server_:Server;
			public var gameId_:int;
			public var createCharacter_:Boolean;
			public var charId_:int;
			public var keyTime_:int;
			public var key_:ByteArray;
			public var mapJSON_:String;
			public var isFromArena_:Boolean = false;
			public var lastTickId_:int = -1;
			public var jitterWatcher_:JitterWatcher;
			public var serverConnection:SocketServer;
			public var outstandingBuy_:OutstandingBuy;

			public var tickIndex:int = -1;
			public var pingReceivedAt:int = -1;
			public var pingSentAt:int = -1;
			public var playerId_:int = -1;
			public var lastInvSwapTime:int = 0;


			public function chooseName(_arg_1:String):void
			{
			}

			public function createGuild(_arg_1:String):void
			{
			}

			public function connect():void
			{
			}

			public function disconnect():void
			{
			}

			public function checkCredits():void
			{
			}

			public function escape():void
			{
			}

			public function useItem(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:Number, _arg_6:Number, _arg_7:int):void
			{
			}

			public function useItem_new(_arg_1:GameObject, _arg_2:int):Boolean
			{
				return (false);
			}

			public function enableJitterWatcher():void
			{
			}

			public function disableJitterWatcher():void
			{
			}

			public function editAccountList(_arg_1:int, _arg_2:Boolean, _arg_3:int):void
			{
			}

			public function guildRemove(_arg_1:String):void
			{
			}

			public function guildInvite(_arg_1:String):void
			{
			}

			public function requestTrade(_arg_1:String):void
			{
			}

			public function changeTrade(_arg_1:Vector.<Boolean>):void
			{
			}

			public function acceptTrade(_arg_1:Vector.<Boolean>, _arg_2:Vector.<Boolean>):void
			{
			}

			public function keyDown(_arg_1:int):void
			{
			}

			public function cancelTrade():void
			{
			}

			public function joinGuild(_arg_1:String):void
			{
			}

			public function changeGuildRank(_arg_1:String, _arg_2:int):void
			{
			}

			public function isConnected():Boolean
			{
				return (false);
			}

			public function teleport(_arg_1:int):void
			{
			}

			public function setPlayerSkinTemplate(_arg_1:Player, _arg_2:int):void
			{
			}

			public function usePortal(_arg_1:int):void
			{
			}

			public function getNextDamage(_arg_1:uint, _arg_2:uint):uint
			{
				return (0);
			}

			public function groundDamage(_arg_1:int, _arg_2:Number, _arg_3:Number):void
			{
			}

			public function playerShoot(_arg_1:int, _arg_2:Projectile):void
			{
			}

			public function playerHit(_arg_1:int, _arg_2:int):void
			{
			}

			public function enemyHit(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:Boolean):void
			{
			}

			public function otherHit(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):void
			{
			}

			public function squareHit(_arg_1:int, _arg_2:int, _arg_3:int):void
			{
			}

			public function playerText(_arg_1:String):void
			{
			}

			public function invSwap(_arg_1:Player, _arg_2:GameObject, _arg_3:int, _arg_4:int, _arg_5:GameObject, _arg_6:int, _arg_7:int):Boolean
			{
				return (false);
			}

			public function invSwapPotion(_arg_1:Player, _arg_2:GameObject, _arg_3:int, _arg_4:int, _arg_5:GameObject, _arg_6:int, _arg_7:int):Boolean
			{
				return (false);
			}

			public function invDrop(_arg_1:GameObject, _arg_2:int, _arg_3:int):void
			{
			}

			public function setCondition(_arg_1:uint, _arg_2:Number):void
			{
			}

			public function buy(_arg_1:int, _arg_2:int):void
			{
			}

			public function questFetch():void
			{
			}

			public function questRedeem(_arg_1:String, _arg_2:Vector.<SlotObjectData>, _arg_3:int = -1):void
			{
			}

			public function keyInfoRequest(_arg_1:int):void
			{
			}

			public function gotoQuestRoom():void
			{
			}

			public function petUpgradeRequest(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:int):void
			{
			}

			public function reskin(_arg_1:Player, _arg_2:int):void
			{
			}

			public function changePetSkin(_arg_1:int, _arg_2:int, _arg_3:int):void
			{
			}


		}
	}//package kabam.rotmg.messaging.impl

