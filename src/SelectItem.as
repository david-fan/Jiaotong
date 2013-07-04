/**
 * Created with IntelliJ IDEA.
 * User: david
 * Date: 6/25/13
 * Time: 8:10 PM
 * To change this template use File | Settings | File Templates.
 */
package {
import flash.display.DisplayObject;

public class SelectItem {
    public var mc:DisplayObject;
    public var right:Boolean;


    public function SelectItem(mc:DisplayObject, right:Boolean) {
        this.mc = mc;
        this.right = right;
    }
}
}
