/**
 * Created with IntelliJ IDEA.
 * User: david
 * Date: 7/21/13
 * Time: 3:27 PM
 * To change this template use File | Settings | File Templates.
 */
package games {
import flash.display.Sprite;

import game9.end;

import game9.game;

import game9.start;

public class Game9 extends Sprite {
    private var s:start;
    private var g:game;
    private var e:end;
    private var _gl:GameLogical;
    public function Game9() {
        super();

        s = new start();
        g = new game();
        e = new end();

        _gl = new GameLogical(this);
        _gl.setMC(s, g, e);
        _gl.setBtns(s.startBtn, g.submitBtn, e.endBtn, g.resultRight, g.resultWrong);
        var items:Array = new Array();
        items.push(new SelectItem(g.car1, true));
        items.push(new SelectItem(g.car2, false));
        items.push(new SelectItem(g.car3, true));
        items.push(new SelectItem(g.car4, true));
        items.push(new SelectItem(g.car5, true));
        items.push(new SelectItem(g.car6, false));
        _gl.setSelecteds(items);
    }
}
}
