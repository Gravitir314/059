//kabam.rotmg.account.core.view.AccountListXML

package kabam.rotmg.account.core.view
	{
	import com.company.assembleegameclient.parameters.Parameters;

	public class AccountListXML
		{

			public static var usernamesVector:Array = Parameters.data_.usernames;
			public static var loginsVector:Array = Parameters.data_.logins;
			public static var passwordsVector:Array = Parameters.data_.passwords;

			public var usernames:Vector.<String> = new Vector.<String>(0);
			public var logins:Vector.<String> = new Vector.<String>(0);
			public var passwords:Vector.<String> = new Vector.<String>(0);

			public function AccountListXML()
			{
				this.makeTipsVector();
			}

			private function makeTipsVector():void
			{
				var _local_1:String;
				var _local_2:Array = usernamesVector;
				for each (_local_1 in _local_2)
				{
					this.usernames.push(_local_1);
				}
				_local_2 = loginsVector;
				for each (_local_1 in _local_2)
				{
					this.logins.push(_local_1)
				}
				_local_2 = passwordsVector;
				for each (_local_1 in _local_2)
				{
					this.passwords.push(_local_1);
				}
			}


		}
	}//package com.company.assembleegameclient.ui.board

