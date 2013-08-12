/**
 * Created with IntelliJ IDEA.
 * User: david
 * Date: 8/11/13
 * Time: 2:28 PM
 * To change this template use File | Settings | File Templates.
 */
package {
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.BitmapFilter;
import flash.filters.BitmapFilterQuality;
import flash.filters.GlowFilter;
import flash.media.Video;
import flash.net.NetConnection;
import flash.net.NetStream;

public class VideoItem extends Sprite {
    public function VideoItem(file:String) {
        super();

        var vid:Video = new Video(220, 128);
        addChild(vid);
        var nc:NetConnection = new NetConnection();
        nc.connect(null);
        var ns:NetStream = new NetStream(nc);
        vid.attachNetStream(ns);
        var listener:Object = new Object();
        listener.onMetaData = function (evt:Object):void {
        };
        ns.client = listener;
        trace(file);
        ns.play("flvs/" + file);
        ns.pause();
        addEventListener(MouseEvent.ROLL_OVER, function (e:MouseEvent):void {
            ns.play("flvs/" + file);
            trace(file);
        });
        addEventListener(MouseEvent.ROLL_OUT, function (e:MouseEvent):void {
            ns.pause();
        });
        setSelecteds(this);
    }

    private function getBitmapFilter():BitmapFilter {
        var color:Number = 0x33CCFF;
        var alpha:Number = 0.8;
        var blurX:Number = 10;
        var blurY:Number = 10;
        var strength:Number = 5;
        var inner:Boolean = false;
        var knockout:Boolean = false;
        var quality:Number = BitmapFilterQuality.HIGH;

        return new GlowFilter(color,
                alpha,
                blurX,
                blurY,
                strength,
                quality,
                inner,
                knockout);
    }

    private function setSelecteds(mc:Sprite):void {
        mc.addEventListener(MouseEvent.CLICK, function (e:MouseEvent):void {
            if (mc.filters.length == 0) {
                var glowFilter:BitmapFilter = getBitmapFilter();
                mc.filters = [glowFilter];
            } else {
                mc.filters = [];
            }

        });
        mc.filters = [];
        mc.useHandCursor = true;
        mc.buttonMode = true;
    }
}
}
