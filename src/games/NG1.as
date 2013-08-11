/**
 * Created with IntelliJ IDEA.
 * User: david
 * Date: 8/11/13
 * Time: 8:24 AM
 * To change this template use File | Settings | File Templates.
 */
package games {
import com.greensock.TweenLite;

import flash.desktop.NativeApplication;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.utils.setTimeout;

import nfg1.game;

public class NG1 extends Sprite {
    private var _index:int = 0;
    private var g:game;

    public function NG1() {
        super();
        g = new game();
        addChild(g);
        setTimeout(showCurrent, 1000 * 2, g.a1);
        g.a1.alpha = g.a2.alpha = g.a3.alpha = 0;
        g.submitBtn.addEventListener(MouseEvent.CLICK, onClick);
    }

    private function onClick(e:MouseEvent):void {
        _index += 1;
        if (_index == 1) {
            showCurrent(g.a2);
        } else if (_index == 2) {
            showCurrent(g.a3);
        } else if (_index == 3) {
            NativeApplication.nativeApplication.exit();
        }
    }

    private var _current:MovieClip;

    private function showCurrent(mc:MovieClip):void {
        if (_current) {
            TweenLite.to(_current, 0.5, {alpha: 0});
        }
        _current = mc;
        _current.alpha = 0;
        TweenLite.to(_current, 0.5, {alpha: 1});
    }
}
}
