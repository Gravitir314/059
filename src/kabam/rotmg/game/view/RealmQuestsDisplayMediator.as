//kabam.rotmg.game.view.RealmQuestsDisplayMediator

package kabam.rotmg.game.view
	{
	import com.company.assembleegameclient.map.Map;

	import kabam.rotmg.game.model.QuestModel;
	import kabam.rotmg.ui.signals.RealmHeroesSignal;
	import kabam.rotmg.ui.signals.RealmOryxSignal;
	import kabam.rotmg.ui.signals.RealmQuestLevelSignal;
	import kabam.rotmg.ui.signals.ToggleRealmQuestsDisplaySignal;

	import robotlegs.bender.bundles.mvcs.Mediator;

	public class RealmQuestsDisplayMediator extends Mediator
		{

			[Inject]
			public var view:RealmQuestsDisplay;
			[Inject]
			public var realmHeroesSignal:RealmHeroesSignal;
			[Inject]
			public var realmQuestLevelSignal:RealmQuestLevelSignal;
			[Inject]
			public var realmOryxSignal:RealmOryxSignal;
			[Inject]
			public var toggleRealmQuestsDisplay:ToggleRealmQuestsDisplaySignal;
			[Inject]
			public var questModel:QuestModel;


			override public function initialize():void
			{
				this.realmHeroesSignal.add(this.onRealmHeroes);
				this.realmQuestLevelSignal.add(this.onRealmQuestLevel);
				this.realmOryxSignal.add(this.onOryxKill);
				this.toggleRealmQuestsDisplay.add(this.onToggleDisplay);
				this.initView();
			}

			private function initView():void
			{
				this.view.requirementsStates = this.questModel.requirementsStates;
				this.view.init();
				this.view.realmName = this.questModel.currentRealm;
				if (((this.questModel.previousRealm == Map.REALM) && (this.view.requirementsStates[QuestModel.REMAINING_HEROES_REQUIREMENT])))
				{
					this.view.remainingHeroes = 0;
				}
			}

			private function onToggleDisplay():void
			{
				this.view.toggleOpenState();
			}

			private function onOryxKill():void
			{
				this.view.setOryxCompleted();
				this.questModel.requirementsStates = this.view.requirementsStates;
				this.questModel.hasOryxBeenKilled = true;
			}

			private function onRealmQuestLevel(_arg_1:int):void
			{
				this.view.level = _arg_1;
				this.questModel.requirementsStates = this.view.requirementsStates;
			}

			private function onRealmHeroes(_arg_1:int):void
			{
				if (!this.view.requirementsStates[QuestModel.REMAINING_HEROES_REQUIREMENT])
				{
					this.questModel.remainingHeroes = _arg_1;
					this.view.remainingHeroes = _arg_1;
					this.questModel.requirementsStates = this.view.requirementsStates;
				}
			}


		}
	}//package kabam.rotmg.game.view

