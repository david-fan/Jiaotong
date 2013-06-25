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
    private var g:game;
    private var r:end;

    public function Game3() {
        super();
        s = new game3.start();
        addChild(s);
        s.startBtn.addEventListener(MouseEvent.CLICK, onStart);
    }

    private function onStart(e:MouseEvent):void {
        removeChild(s);
        g = new game3.game();
        addChild(g);
        g.person1.addEventListener(MouseEvent.CLICK, onClick);
        g.person2.addEventListener(MouseEvent.CLICK, onClick);
        g.endBtn.addEventListener(MouseEvent.CLICK, onSubmit);
        // var e:end;
    }

    private function onSubmit(e:MouseEvent):void {
        var ps:Boolean = checkSelected(g.person1) && checkSelected(g.person2);
        if (ps) {
            g.resultRight.visible = true;
        } else {
            g.resultWrong.visible = true;
        }
    }

    private function checkSelected(e:DisplayObject):Boolean {
        return e.filters != null;
    }

    private function onClick(e:MouseEvent):void {
        if (e.target == g.person1) {
            if (g.person1.filters != null) {

            } else {

            }
        } else if (e.target == g.person2) {

        }
    }
}
}
