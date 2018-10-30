//kabam.rotmg.account.core.view.AccountListXML

package kabam.rotmg.account.core.view
	{
	import com.company.assembleegameclient.parameters.Parameters;

	public class AccountListXML
		{

			public static var loginsVector:Array = Parameters.data_.logins;
			public static var passwordsVector:Array = Parameters.data_.passwords;

			public var logins:Vector.<String> = new Vector.<String>(0);
			public var passwords:Vector.<String> = new Vector.<String>(0);

			public function AccountListXML()
			{
				this.makeTipsVector();
			}

			private function makeTipsVector():void
			{
				var _local_1:String;
				var _local_2:Array = loginsVector;
				for each (_local_1 in _local_2)
				{
					this.logins.push(_local_1)
				}
				var _local_3:Array = passwordsVector;
				for each (_local_1 in _local_3)
				{
					this.passwords.push(_local_1);
				}
			}


		}
	}//package com.company.assembleegameclient.ui.board

