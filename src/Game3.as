/**
 * Created with IntelliJ IDEA.
 * User: david
 * Date: 13-6-18
 * Time: 下午10:23
 * To change this template use File | Settings | File Templates.
 */
package {
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.MouseEvent;

import game3.end;

import game3.game;

import game3.start;

public class Game3 extends Sprite {
    private var s:start;

    public function Game3() {
        super();
        s = new game3.start();
        addChild(s);
        s.startBtn.addEventListener(MouseEvent.CLICK, onStart);
    }

    private function onStart(e:MouseEvent):void {
        removeChild(s);
        var g:game = new game3.game();
        addChild(g);
        // var e:end;
    }
}
}
