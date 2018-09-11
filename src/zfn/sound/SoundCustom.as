//zfn.sound.SoundCustom

package zfn.sound
{
    import flash.utils.Dictionary;
    import flash.media.Sound;
    import com.company.assembleegameclient.sound.SoundEffectLibrary;
    import com.company.assembleegameclient.parameters.Parameters;

    public class SoundCustom 
    {
		[Embed(source="EmbeddedSound_ding.mp3", mimeType="application/octet-stream")]
        private static const dingEmbed:Class;

        private static var sounds_:Dictionary = new Dictionary();


        public static function load():void
        {
            addSound("ding", (new dingEmbed() as Sound));
        }

        public static function addSound(_arg_1:String, _arg_2:Sound):void
        {
            if (sounds_[_arg_1] == null)
            {
                sounds_[_arg_1] = [];
            }
            sounds_[_arg_1] = _arg_2;
        }

        public static function grab(_arg_1:String):Sound
        {
            return (sounds_[_arg_1]);
        }

        public static function play(_arg_1:String):void
        {
            if (_arg_1.indexOf("event") != -1)
            {
                SoundEffectLibrary.play(_arg_1, Parameters.data_.eventNotifierVolume, true);
            }
            else
            {
                if (Parameters.data_.customSounds)
                {
                    SoundEffectLibrary.play(_arg_1, Parameters.data_.customVolume, true);
                }
            }
        }


    }
}//package zfn.sound

