//kabam.rotmg.servers.api.Server

package kabam.rotmg.servers.api
	{
	public class Server
		{
			public static var serverAbbreviations:Array; // TODO add parser

			public var name:String;
			public var address:String;
			public var port:int;
			public var latLong:LatLong;
			public var usage:Number;
			public var isAdminOnly:Boolean;

			public function Server()
			{
				serverAbbreviations = [];
				serverAbbreviations["proxy"] = "Proxy";
				serverAbbreviations["usw3"] = "USWest3";
				serverAbbreviations["usw2"] = "USWest2";
				serverAbbreviations["usw"] = "USWest";
				serverAbbreviations["ussw"] = "USSouthWest";
				serverAbbreviations["uss3"] = "USSouth3";
				serverAbbreviations["uss2"] = "USSouth2";
				serverAbbreviations["uss"] = "USSouth";
				serverAbbreviations["usnw"] = "USNorthWest";
				serverAbbreviations["usmw2"] = "USMidWest2";
				serverAbbreviations["usmw"] = "USMidWest";
				serverAbbreviations["use3"] = "USEast3";
				serverAbbreviations["use2"] = "USEast2";
				serverAbbreviations["use"] = "USEast";
				serverAbbreviations["euw2"] = "EUWest2";
				serverAbbreviations["euw"] = "EUWest";
				serverAbbreviations["eusw"] = "EUSouthWest";
				serverAbbreviations["eus"] = "EUSouth";
				serverAbbreviations["eun2"] = "EUNorth2";
				serverAbbreviations["eun"] = "EUNorth";
				serverAbbreviations["eue"] = "EUEast";
				serverAbbreviations["ase"] = "AsiaSouthEast";
				serverAbbreviations["ae"] = "AsiaEast";
				serverAbbreviations["aus"] = "Australia";
				serverAbbreviations["au"] = "Australia";
				super();
			}

			public function setName(_arg_1:String):Server
			{
				this.name = _arg_1;
				return (this);
			}

			public function setAddress(_arg_1:String):Server
			{
				this.address = _arg_1;
				return (this);
			}

			public function setPort(_arg_1:int):Server
			{
				this.port = _arg_1;
				return (this);
			}

			public function setLatLong(_arg_1:Number, _arg_2:Number):Server
			{
				this.latLong = new LatLong(_arg_1, _arg_2);
				return (this);
			}

			public function setUsage(_arg_1:Number):Server
			{
				this.usage = _arg_1;
				return (this);
			}

			public function setIsAdminOnly(_arg_1:Boolean):Server
			{
				this.isAdminOnly = _arg_1;
				return (this);
			}

			public function priority():int
			{
				if (this.isAdminOnly)
				{
					return (2);
				}
				if (this.isCrowded())
				{
					return (1);
				}
				return (0);
			}

			public function isCrowded():Boolean
			{
				return (this.usage >= 0.66);
			}

			public function isFull():Boolean
			{
				return (this.usage >= 1);
			}

			public function toString():String
			{
				return (((((((((((("[" + this.name) + ": ") + this.address) + ":") + this.port) + ":") + this.latLong) + ":") + this.usage) + ":") + this.isAdminOnly) + "]");
			}


		}
	}//package kabam.rotmg.servers.api

