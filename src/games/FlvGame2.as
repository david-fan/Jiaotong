/**
 * Created with IntelliJ IDEA.
 * User: david
 * Date: 7/24/13
 * Time: 9:20 PM
 * To change this template use File | Settings | File Templates.
 */
package games {
import flash.desktop.NativeApplication;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.BitmapFilter;
import flash.filters.BitmapFilterQuality;
import flash.filters.GlowFilter;
import flash.media.Video;
import flash.net.NetConnection;
import flash.net.NetStream;
import flash.utils.setTimeout;

import flv2.*;

public class FlvGame2 extends Sprite {
    private var start:flv2.start;
    private var game:flv2.game;
    private var end:flv2.end;

    public function FlvGame2() {
        super();
        start = new flv2.start();
        game = new flv2.game();
        end = new flv2.end();
        addChild(start);
        start.startBtn.addEventListener(MouseEvent.CLICK, onStart);
        game.submitBtn.addEventListener(MouseEvent.CLICK, onSubmit);
        end.endBtn.addEventListener(MouseEvent.CLICK, onEnd);
    }

    private function onStart(e:MouseEvent):void {
        removeChild(start);
        addChild(game);

        for (var i:int = 0; i < 3; i++) {
            for (var m:int = 0; m < 3; m++) {
                var f:int = (i * 3 + m + 2);
                var v = new VideoItem(f > 9 ? f + ".flv" : "0" + f + ".flv");
                v.x = (220 + 10) * m + 180;
                v.y = (128 + 10) * i + 130;
                addChild(v);
                vs.push(v);
            }
        }

        addChild(game.resultRight);
        addChild(game.resultWrong);
        game.resultRight.visible = game.resultWrong.visible = false;
    }

    private var vs:Array = [];

    private function c(mc:DisplayObject):Boolean {
        if (mc.filters.length == 1)
            return true;
        else
            return false;
    }

    private function showWrong():void {
        game.resultWrong.visible = true;
        setTimeout(function ():void {
            game.resultWrong.visible = false;
        }, 1000 * 1);
    }

    private function showRight(callback:Function):void {

        game.resultRight.visible = true;
        setTimeout(function ():void {
            game.resultRight.visible = false;
            callback();
        }, 1000 * 1);
    }

    private function onSubmit(e:MouseEvent):void {
        for (var i:int = 0; i < vs.length; i++) {
            if (!c(vs[i])) {
                showWrong();
                return;
            }
        }
        showRight(showend);
    }

    private function showend():void {
        removeChild(game);
        addChild(end);
    }

    private function onEnd(e:MouseEvent):void {
        removeChild(end);
        NativeApplication.nativeApplication.exit();
    }
}
}
