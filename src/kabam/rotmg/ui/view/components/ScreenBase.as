//kabam.rotmg.ui.view.components.ScreenBase

package kabam.rotmg.ui.view.components
	{
	import com.company.assembleegameclient.ui.SoundIcon;

	import flash.display.Sprite;

	public class ScreenBase extends Sprite
		{

			[Embed(source="ScreenBase_TitleScreenBackground.png")]
			internal static var TitleScreenBackground:Class;

			public function ScreenBase()
			{
				addChild(new TitleScreenBackground());
				addChild(new DarkLayer());
				addChild(new SoundIcon());
			}

		}
	}//package kabam.rotmg.ui.view.components

