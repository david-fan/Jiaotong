/**
 * Created with IntelliJ IDEA.
 * User: david
 * Date: 13-6-18
 * Time: 下午10:23
 * To change this template use File | Settings | File Templates.
 */
package games {
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;

import game3.end;

import game3.game;

import game3.start;

public class Game3 extends Sprite {
    private var s:start;
    private var g:game;
    private var e:end;

    private var _gl:GameLogical;

    public function Game3() {
        super();

        s = new start();
        g = new game();
        e = new end();

        _gl = new GameLogical(this);
        _gl.setMC(s, g, e);
        _gl.setBtns(s.startBtn, g.endBtn, e.endBtn, g.resultRight, g.resultWrong);
        var items:Array = new Array();
        items.push(new SelectItem(g.person1, true));
        items.push(new SelectItem(g.person2, true));
        items.push(new SelectItem(g.person3, false));
        items.push(new SelectItem(g.person4, false));
        items.push(new SelectItem(g.person5, true));
        _gl.setSelecteds(items);
    }
}
}
