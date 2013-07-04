/**
 * Created with IntelliJ IDEA.
 * User: david
 * Date: 7/3/13
 * Time: 8:19 PM
 * To change this template use File | Settings | File Templates.
 */
package {
import flash.display.Sprite;

import game5.end;

import game5.game;

import game5.start;

public class Game5 extends Sprite {
    private var s:start;
    private var g:game;
    private var e:end;
    private var _gl:GameLogical;
    public function Game5() {
        super();

        s = new start();
        g = new game();
        e = new end();

        _gl = new GameLogical(this);
        _gl.setMC(s, g, e);
        _gl.setBtns(s.startBtn, g.endBtn, e.endbtn, g.resultRight, g.resultWrong);
        var items:Array = new Array();
        items.push(new SelectItem(g.c1, false));
        items.push(new SelectItem(g.c2, true));
        items.push(new SelectItem(g.c3, false));
        items.push(new SelectItem(g.c4, true));
        items.push(new SelectItem(g.c5, false));
        items.push(new SelectItem(g.c6, true));
        _gl.setSelecteds(items);
    }
}
}
