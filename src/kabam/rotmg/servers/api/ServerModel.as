//kabam.rotmg.servers.api.ServerModel

package kabam.rotmg.servers.api
{
	public interface ServerModel
	{

		function setServers(_arg_1:Vector.<Server>):void;

		function getServer():Server;

		function getServerByName(_arg_1:String):Server;

		function isServerAvailable():Boolean;

		function getServers():Vector.<Server>;

		function getAbbreviations():Vector.<String>;

	}
}//package kabam.rotmg.servers.api

