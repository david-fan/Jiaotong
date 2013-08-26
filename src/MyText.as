/**
 * Created with IntelliJ IDEA.
 * User: david
 * Date: 8/23/13
 * Time: 9:55 AM
 * To change this template use File | Settings | File Templates.
 */
package {
import flash.display.Sprite;
import flash.text.engine.ElementFormat;
import flash.text.engine.FontDescription;
import flash.text.engine.FontLookup;
import flash.text.engine.TextBlock;
import flash.text.engine.TextElement;
import flash.text.engine.TextLine;

public class MyText extends Sprite {
    public function MyText() {
        super();
    }

    public function updateText(text:String, size:int, color:uint, width:int):void {
        while (numChildren > 0) {
            removeChildAt(0);
        }
        var tb:TextBlock = new TextBlock();
        var te:TextElement;
        var ef1:ElementFormat;
        var fd1:FontDescription = new FontDescription();
        fd1.fontLookup = FontLookup.EMBEDDED_CFF;
        fd1.fontName = "jyy";
        ef1 = new ElementFormat(fd1);
        ef1.color = color;
        ef1.fontSize = size;
        var str:String = text;
        te = new TextElement(str, ef1);
        tb.content = te;

        var xPos:Number = 10;
        var yPos:Number = 30;

        var textLine:TextLine = tb.createTextLine(null, width);
        while (textLine) {
            textLine.x = xPos;
            textLine.y = yPos;
            yPos += textLine.height + 2;
            addChild(textLine);
            textLine = tb.createTextLine(textLine, width);
        }
    }
}
}
