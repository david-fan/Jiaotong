/**
 * Created with IntelliJ IDEA.
 * User: david
 * Date: 6/5/13
 * Time: 8:32 PM
 * To change this template use File | Settings | File Templates.
 */
package asset {
public class Asset {
    [Embed(source="/asset/texture0.png")]
    public static var texture0:Class;
    [Embed(source="/asset/texture1.png")]
    public static var texture1:Class;
    [Embed(source="/asset/texture2.png")]
    public static var texture2:Class;
    [Embed(source="/asset/texture3.png")]
    public static var texture3:Class;
    [Embed(source="/asset/texture4.png")]
    public static var texture4:Class;
    [Embed(source="/asset/textureback.png")]
    public static var textureback:Class;
    [Embed(source="/asset/texturewood.png")]
    public static var texturewood:Class;
    public function Asset() {
    }
}
}
