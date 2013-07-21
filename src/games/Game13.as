/**
 * Created with IntelliJ IDEA.
 * User: david
 * Date: 7/21/13
 * Time: 4:25 PM
 * To change this template use File | Settings | File Templates.
 */
package games {
import flash.display.Sprite;

import game13.*;

public class Game13 extends Sprite {
    private var s:start;
    private var g:game;
    private var e:end;
    private var _gl:GameLogical;

    public function Game13() {
        super();
        s = new start();
        g = new game();
        e = new end();

        _gl = new GameLogical(this);
        _gl.setMC(s, g, e);
        _gl.setBtns(s.startBtn, g.submitBtn, e.endBtn, g.resultRight, g.resultWrong);
        var items:Array = new Array();
        items.push(new SelectItem(g.num1, true));
        items.push(new SelectItem(g.num2, false));
        items.push(new SelectItem(g.num3, false));
        items.push(new SelectItem(g.num4, true));
        items.push(new SelectItem(g.num5, true));
        _gl.setSelecteds(items);
    }
}
}
