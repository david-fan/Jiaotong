/**
 * Created with IntelliJ IDEA.
 * User: david
 * Date: 8/2/13
 * Time: 8:26 PM
 * To change this template use File | Settings | File Templates.
 */
package games {
import flash.display.Sprite;

import game34.*;

public class Game34 extends Sprite {
    private var s:start;
    private var g:game;
    private var e:end;
    private var _gl:GameLogical;
    public function Game34() {
        super();

        s = new start();
        g = new game();
        e = new end();

        _gl = new GameLogical(this);
        _gl.setMC(s, g, e);
        _gl.setBtns(s.startBtn, g.submitBtn, e.endBtn, g.resultRight, g.resultWrong);
        var items:Array = new Array();
        items.push(new SelectItem(g.m1, true));
        items.push(new SelectItem(g.m2, true));
        items.push(new SelectItem(g.m3, true));
        items.push(new SelectItem(g.m4, true));
        _gl.setSelecteds(items);
    }
}
}
