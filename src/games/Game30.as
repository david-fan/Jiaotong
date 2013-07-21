/**
 * Created with IntelliJ IDEA.
 * User: david
 * Date: 7/21/13
 * Time: 5:34 PM
 * To change this template use File | Settings | File Templates.
 */
package games {
import flash.display.Sprite;
import game30.*;

public class Game30 extends Sprite {
    private var s:start;
    private var g:game;
    private var e:end;
    private var _gl:GameLogical;
    public function Game30() {
        super();
        s = new start();
        g = new game();
        e = new end();

        _gl = new GameLogical(this);
        _gl.setMC(s, g, e);
        _gl.setBtns(s.startBtn, g.submitBtn, e.endBtn, g.resultRight, g.resultWrong);
        var items:Array = new Array();
        items.push(new SelectItem(g.dir1, true));
        items.push(new SelectItem(g.dir2, false));
        items.push(new SelectItem(g.dir3, true));
        items.push(new SelectItem(g.dir4, false));
        items.push(new SelectItem(g.dir5, false));
        items.push(new SelectItem(g.dir6, false));
        _gl.setSelecteds(items);
    }
}
}
