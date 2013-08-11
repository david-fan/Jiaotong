package games {

import flash.display.Loader;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.net.URLRequest;
import flash.text.TextField;
import flash.text.TextFormat;

/**
 * @author david
 */
public class JTAQ extends Sprite {
    public function JTAQ() {
        super();
        var l:Loader = new Loader();
        l.contentLoaderInfo.addEventListener(Event.INIT, onInit);
        l.load(new URLRequest("asset/jtaq.swf"));
        addChild(l);
        l.scaleY = l.scaleX = 1.72;

        var des:TextField=new TextField();
        des.height=30;
        des.width=200;
        des.text="使用空格键，停止行走";
        var tf:TextFormat=new TextFormat(null,18,0);
        addChild(des);
        des.setTextFormat(tf);
        des.x=des.y=10;
    }

    private function onInit(e:Event):void {

    }
}
}
