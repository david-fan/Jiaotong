/**
 * Created with IntelliJ IDEA.
 * User: david
 * Date: 7/21/13
 * Time: 5:40 PM
 * To change this template use File | Settings | File Templates.
 */
package games {
import flash.display.Sprite;

import game26.*;

public class Game26 extends Sprite {
    private var s:start;
    private var g:game;
    private var e:end;
    private var _gl:GameLogical;
    public function Game26() {
        super();
        s = new start();
        g = new game();
        e = new end();

        _gl = new GameLogical(this);
        _gl.setMC(s, g, e);
        _gl.setBtns(s.startBtn, g.submitBtn, e.endBtn, g.resultRight, g.resultWrong);
        var items:Array = new Array();
        items.push(new SelectItem(g.person1, false));
        items.push(new SelectItem(g.person2, false));
        items.push(new SelectItem(g.person3, false));
        items.push(new SelectItem(g.person4, true));
        items.push(new SelectItem(g.person5, false));
        items.push(new SelectItem(g.person6, false));
        items.push(new SelectItem(g.person7, true));
        items.push(new SelectItem(g.person8, true));
        _gl.setSelecteds(items);
    }
}
}
