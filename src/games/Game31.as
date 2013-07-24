/**
 * Created with IntelliJ IDEA.
 * User: david
 * Date: 7/23/13
 * Time: 8:52 PM
 * To change this template use File | Settings | File Templates.
 */
package games {
import flash.display.Sprite;
import game31.*;

public class Game31 extends Sprite {
    private var s:start;
    private var g:game;
    private var e:end;

    public function Game31() {
        super();
        s = new start();
        g = new game();
        e = new end();
    }
}
}
