//io.decagames.rotmg.supportCampaign.data.SupporterCampaignModel

package io.decagames.rotmg.supportCampaign.data
	{
	import io.decagames.rotmg.supportCampaign.data.vo.RankVO;
	import io.decagames.rotmg.supportCampaign.signals.UpdateCampaignProgress;
	import io.decagames.rotmg.utils.date.TimeLeft;

	import kabam.rotmg.core.StaticInjectorContext;

	public class SupporterCampaignModel
		{

			public static const DEFAULT_DONATE_AMOUNT:int = 100;
			public static const DEFAULT_DONATE_SPINNER_STEP:int = 100;
			public static const DONATE_MAX_INPUT_CHARS:int = 5;
			public static const SUPPORT_COLOR:Number = 13395711;
			public static const RANKS_NAMES:Array = ["Basic", "Greater", "Superior", "Paramount", "Exalted", "Unbound"];

			private var _unlockPrice:int;
			private var _points:int;
			private var _rank:int;
			private var _tempRank:int;
			private var _donatePointsRatio:int;
			private var _shopPurchasePointsRatio:int;
			private var _endDate:Date;
			private var _startDate:Date;
			private var _ranks:Array;
			private var _isUnlocked:Boolean;
			private var _hasValidData:Boolean;
			private var _claimed:int;
			private var _rankConfig:Vector.<RankVO>;


			public function parseConfigData(_arg_1:XML):void
			{
				this._hasValidData = true;
				if (_arg_1.hasOwnProperty("CampaignConfig"))
				{
					this.parseConfig(_arg_1);
				}
				else
				{
					this._hasValidData = false;
				}
				if (_arg_1.hasOwnProperty("CampaignProgress"))
				{
					this.parseUpdateData(_arg_1.CampaignProgress, false);
				}
			}

			public function updatePoints(_arg_1:int):void
			{
				this._points = _arg_1;
				this._rank = this.getRankByPoints(this._points);
				StaticInjectorContext.getInjector().getInstance(UpdateCampaignProgress).dispatch();
			}

			public function getRankByPoints(_arg_1:int):int
			{
				var _local_3:int;
				if (!this.hasValidData)
				{
					return (0);
				}
				var _local_2:int;
				if (((!(this._ranks == null)) && (this._ranks.length > 0)))
				{
					_local_3 = 0;
					while (_local_3 < this._ranks.length)
					{
						if (_arg_1 >= this._ranks[_local_3])
						{
							_local_2 = (_local_3 + 1);
						}
						_local_3++;
					}
				}
				return (_local_2);
			}

			public function get rankConfig():Vector.<RankVO>
			{
				return (this._rankConfig);
			}

			public function parseUpdateData(_arg_1:Object, _arg_2:Boolean = true):void
			{
				this._isUnlocked = (this.getXMLData(_arg_1, "Unlocked", false) === 1);
				this._points = this.getXMLData(_arg_1, "Points", false);
				this._rank = this.getXMLData(_arg_1, "Rank", false);
				if (this._tempRank == 0)
				{
					this._tempRank = this._rank;
				}
				this._claimed = this.getXMLData(_arg_1, "Claimed", false);
				if (_arg_2)
				{
					StaticInjectorContext.getInjector().getInstance(UpdateCampaignProgress).dispatch();
				}
			}

			private function parseConfig(_arg_1:XML):void
			{
				this._unlockPrice = this.getXMLData(_arg_1.CampaignConfig, "UnlockPrice", true);
				this._donatePointsRatio = this.getXMLData(_arg_1.CampaignConfig, "DonatePointsRatio", true);
				this._endDate = new Date((this.getXMLData(_arg_1.CampaignConfig, "CampaignEndDate", true) * 1000));
				this._startDate = new Date((this.getXMLData(_arg_1.CampaignConfig, "CampaignStartDate", true) * 1000));
				this._ranks = this.getXMLData(_arg_1.CampaignConfig, "RanksList", true).split(",");
				this._shopPurchasePointsRatio = this.getXMLData(_arg_1.CampaignConfig, "ShopPurchasePointsRatio", true);
				this._rankConfig = new Vector.<RankVO>();
				var _local_2:int;
				while (_local_2 < this._ranks.length)
				{
					this._rankConfig.push(new RankVO(this._ranks[_local_2], SupporterCampaignModel.RANKS_NAMES[_local_2]));
					_local_2++;
				}
			}

			private function parseConfigStatus(_arg_1:XML):void
			{
				this._isUnlocked = (this.getXMLData(_arg_1.CampaignProgress, "Unlocked", false) === 1);
				this._points = this.getXMLData(_arg_1.CampaignProgress, "Points", false);
				this._rank = this.getXMLData(_arg_1.CampaignProgress, "Rank", false);
				this._claimed = this.getXMLData(_arg_1, "Claimed", false);
			}

			private function getXMLData(_arg_1:Object, _arg_2:String, _arg_3:Boolean):*
			{
				if (_arg_1.hasOwnProperty(_arg_2))
				{
					return (_arg_1[_arg_2]);
				}
				if (_arg_3)
				{
					this._hasValidData = false;
				}
				return ("");
			}

			public function get isStarted():Boolean
			{
				return (new Date().time >= this._startDate.time);
			}

			public function get isEnded():Boolean
			{
				return (new Date().time >= this._endDate.time);
			}

			public function get isActive():Boolean
			{
				return ((this.isStarted) && (!(this.isEnded)));
			}

			public function get nextClaimableTier():int
			{
				var _local_1:String;
				if (this._ranks.length == 0)
				{
					return (1);
				}
				var _local_2:int = 1;
				for each (_local_1 in this._ranks)
				{
					if (((this._rank >= _local_2) && (this._claimed < _local_2)))
					{
						return (_local_2);
					}
					_local_2++;
				}
				return (this._rank);
			}

			public function getStartTimeString():String
			{
				var _local_2:String = "";
				var _local_1:Number = this.getSecondsToStart();
				if (_local_1 <= 0)
				{
					return ("");
				}
				if (_local_1 > 86400)
				{
					_local_2 = (_local_2 + TimeLeft.parse(_local_1, "%dd %hh"));
				}
				else
				{
					if (_local_1 > 3600)
					{
						_local_2 = (_local_2 + TimeLeft.parse(_local_1, "%hh %mm"));
					}
					else
					{
						if (_local_1 > 60)
						{
							_local_2 = (_local_2 + TimeLeft.parse(_local_1, "%mm %ss"));
						}
						else
						{
							_local_2 = (_local_2 + TimeLeft.parse(_local_1, "%ss"));
						}
					}
				}
				return (_local_2);
			}

			private function getSecondsToStart():Number
			{
				var _local_1:Date = new Date();
				return ((this._startDate.time - _local_1.time) / 1000);
			}

			public function get unlockPrice():int
			{
				return (this._unlockPrice);
			}

			public function get donatePointsRatio():int
			{
				return (this._donatePointsRatio);
			}

			public function get shopPurchasePointsRatio():int
			{
				return (this._shopPurchasePointsRatio);
			}

			public function get ranks():Array
			{
				return (this._ranks);
			}

			public function get isUnlocked():Boolean
			{
				return (this._isUnlocked);
			}

			public function get hasValidData():Boolean
			{
				return (this._hasValidData);
			}

			public function get endDate():Date
			{
				return (this._endDate);
			}

			public function get points():int
			{
				return (this._points);
			}

			public function get rank():int
			{
				return (this._rank);
			}

			public function get claimed():int
			{
				return (this._claimed);
			}

			public function get tempRank():int
			{
				return (this._tempRank);
			}

			public function set tempRank(_arg_1:int):void
			{
				this._tempRank = _arg_1;
			}

			public function get startDate():Date
			{
				return (this._startDate);
			}


		}
	}//package io.decagames.rotmg.supportCampaign.data

