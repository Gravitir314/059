//io.decagames.rotmg.supportCampaign.tasks.GetCampaignStatusTask

package io.decagames.rotmg.supportCampaign.tasks
{
	import io.decagames.rotmg.supportCampaign.data.SupporterCampaignModel;

	import kabam.lib.tasks.BaseTask;
	import kabam.rotmg.account.core.Account;
	import kabam.rotmg.appengine.api.AppEngineClient;

	import robotlegs.bender.framework.api.ILogger;

	public class GetCampaignStatusTask extends BaseTask
	{

		[Inject]
		public var client:AppEngineClient;
		[Inject]
		public var account:Account;
		[Inject]
		public var logger:ILogger;
		[Inject]
		public var model:SupporterCampaignModel;

		override protected function startTask():void
		{
			this.logger.info("GetCampaignStatus start");
			var _local_1:Object = this.account.getCredentials();
			this.client.complete.addOnce(this.onComplete);
			this.client.sendRequest("/supportCampaign/status", _local_1);
		}

		private function onComplete(_arg_1:Boolean, _arg_2:*):void
		{
			if (_arg_1)
			{
				this.onCampaignUpdate(_arg_2);
			} else
			{
				this.onTextError(_arg_2);
			}
		}

		private function onTextError(_arg_1:String):void
		{
			this.logger.info("GetCampaignStatus error");
			completeTask(true);
		}

		private function onCampaignUpdate(_arg_1:String):void
		{
			var _local_3:XML;
			var _local_2:* = _arg_1;
			try
			{
				_local_3 = new XML(_local_2);
			}
			catch (e:Error)
			{
				logger.error(("Error parsing campaign data: " + _local_2));
				completeTask(true);
				return;
			}
			this.logger.info("GetCampaignStatus update");
			this.logger.info(_local_3);
			this.model.parseConfigData(_local_3);
			completeTask(true);
		}

	}
}//package io.decagames.rotmg.supportCampaign.tasks

