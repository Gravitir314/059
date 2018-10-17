//zfn.screens.vault.VaultList

package zfn.screens.vault
	{
	import flash.display.Sprite;

	import kabam.rotmg.core.model.PlayerModel;

	public class VaultList extends Sprite
		{

			private const AMOUNT_IN_ROW:int = 2;
			private const VAULT_OFFSET:int = 5;
			private const PREVIEW_WIDTH:int = 203;
			private const PREVIEW_HEIGHT:int = 107;

			private var playerModel:PlayerModel;
			private var vaults:Vector.<VaultPreview>;

			public function VaultList(_arg_1:PlayerModel)
			{
				this.playerModel = _arg_1;
				this.vaults = new Vector.<VaultPreview>();
				this.createVaults();
				this.addVaults();
			}

			private function createVaults():void
			{
				var _local_1:Vector.<VaultSlot>;
				for each (var _local_3:Vector.<int> in playerModel.getVaults())
				{
					_local_1 = new Vector.<VaultSlot>();
					for each (var _local_2:int in _local_3)
					{
						_local_1.push(new VaultSlot(_local_2));
					}
					vaults.push(new VaultPreview(_local_1));
				}
			}

			private function addVaults():void
			{
				var _local_4:int;
				var _local_2:int;
				var _local_1:int;
				var _local_5:VaultPreview;
				var _local_3:int = vaults.length;
				_local_4 = 0;
				while (_local_4 < _local_3)
				{
					_local_2 = (_local_4 % AMOUNT_IN_ROW);
					_local_1 = int((_local_4 / AMOUNT_IN_ROW));
					_local_5 = vaults[_local_4];
					_local_5.x = ((_local_2 * PREVIEW_WIDTH) + (_local_2 * VAULT_OFFSET));
					_local_5.y = (((_local_1 * PREVIEW_HEIGHT) + (_local_1 * VAULT_OFFSET)) + 15);
					addChild(_local_5);
					_local_4++;
				}
			}


		}
	}//package zfn.screens.vault

