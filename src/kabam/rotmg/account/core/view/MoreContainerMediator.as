//kabam.rotmg.account.core.view.MoreContainerMediator

package kabam.rotmg.account.core.view
	{
	import kabam.lib.tasks.Task;
	import kabam.rotmg.account.core.signals.LoginSignal;
	import kabam.rotmg.account.web.model.AccountData;
	import kabam.rotmg.core.signals.TaskErrorSignal;

	import robotlegs.bender.bundles.mvcs.Mediator;

	public class MoreContainerMediator extends Mediator
		{
			[Inject]
			public var view:MoreContainer;
			[Inject]
			public var login:LoginSignal;
			[Inject]
			public var loginError:TaskErrorSignal;

			override public function initialize():void
			{
				this.view.signIn.add(this.onSignIn);
				this.loginError.add(this.onLoginError);
			}

			override public function destroy():void
			{
				this.view.signIn.remove(this.onSignIn);
				this.loginError.remove(this.onLoginError);
			}

			private function onSignIn(_arg_1:AccountData):void
			{
				this.login.dispatch(_arg_1);
			}

			private function onLoginError(_arg_1:Task):void
			{
				this.view.setError(_arg_1.error);
			}

		}

	}