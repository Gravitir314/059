//zfn.xinput.ControllerEvent

package zfn.xinput
{
    import flash.events.Event;

    public class ControllerEvent extends Event 
    {

        public static const AXIS_MOVE:String = "axisMove";
        public static const BUTTON_DOWN:String = "buttonDown";
        public static const BUTTON_UP:String = "buttonUp";

        public var inputCode:int;
        public var inputValue:Number;

        public function ControllerEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false, _arg_4:int=-1, _arg_5:Number=NaN)
        {
            super(_arg_1, _arg_2, _arg_3);
            this.inputCode = _arg_4;
            this.inputValue = _arg_5;
        }

        override public function clone():Event
        {
            return (new ControllerEvent(type, bubbles, cancelable, inputCode, inputValue));
        }


    }
}//package zfn.xinput

