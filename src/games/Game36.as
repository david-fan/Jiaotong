/**
 * Created with IntelliJ IDEA.
 * User: david
 * Date: 8/2/13
 * Time: 8:32 PM
 * To change this template use File | Settings | File Templates.
 */
package games {
import flash.display.Sprite;
import game36.*;
public class Game36 extends Sprite {
    private var s:start;
    private var g:game;
    private var e:end;
    private var _gl:GameLogical;
    public function Game36() {
        super();

        s = new start();
        g = new game();
        e = new end();

        _gl = new GameLogical(this);
        _gl.setMC(s, g, e);
        _gl.setBtns(s.startBtn, g.submitBtn, e.endBtn, g.resultRight, g.resultWrong);
        var items:Array = new Array();
        items.push(new SelectItem(g.l1, true));
        items.push(new SelectItem(g.l2, true));
        items.push(new SelectItem(g.l3, true));
        items.push(new SelectItem(g.l4, true));
        items.push(new SelectItem(g.l5, true));
        items.push(new SelectItem(g.l6, false));
        _gl.setSelecteds(items);
    }
}
}
