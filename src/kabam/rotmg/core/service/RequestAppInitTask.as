//kabam.rotmg.core.service.RequestAppInitTask

package kabam.rotmg.core.service
	{
	import kabam.lib.tasks.BaseTask;
	import kabam.rotmg.account.core.Account;
	import kabam.rotmg.appengine.api.AppEngineClient;
	import kabam.rotmg.application.DynamicSettings;
	import kabam.rotmg.core.signals.AppInitDataReceivedSignal;

	import robotlegs.bender.framework.api.ILogger;

	public class RequestAppInitTask extends BaseTask
		{

			[Inject]
			public var logger:ILogger;
			[Inject]
			public var client:AppEngineClient;
			[Inject]
			public var account:Account;
			[Inject]
			public var appInitConfigData:AppInitDataReceivedSignal;


			override protected function startTask():void
			{
				var _local_1:XML = XML("<AppSettings><UseExternalPayments>1</UseExternalPayments><MaxStackablePotions>6</MaxStackablePotions><PotionPurchaseCooldown>400</PotionPurchaseCooldown><PotionPurchaseCostCooldown>8000</PotionPurchaseCostCooldown><PotionPurchaseCosts><cost>5</cost><cost>10</cost><cost>20</cost><cost>40</cost><cost>80</cost><cost>120</cost><cost>200</cost><cost>300</cost><cost>450</cost><cost>600</cost></PotionPurchaseCosts><FilterList></FilterList><DisableRegist>0</DisableRegist><MysteryBoxRefresh>600</MysteryBoxRefresh><SalesforceMobile>0</SalesforceMobile><UGDOpenSubmission>1</UGDOpenSubmission></AppSettings>");
				this.appInitConfigData.dispatch(_local_1);
				this.initDynamicSettingsClass(_local_1);
				completeTask(true, _local_1);
			}

			private function initDynamicSettingsClass(_arg_1:XML):void
			{
				if (_arg_1 != null)
				{
					DynamicSettings.xml = _arg_1;
				}
			}


		}
	}//package kabam.rotmg.core.service

