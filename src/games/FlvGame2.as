/**
 * Created with IntelliJ IDEA.
 * User: david
 * Date: 7/24/13
 * Time: 9:20 PM
 * To change this template use File | Settings | File Templates.
 */
package games {
import flash.desktop.NativeApplication;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.BitmapFilter;
import flash.filters.BitmapFilterQuality;
import flash.filters.GlowFilter;
import flash.media.Video;
import flash.net.NetConnection;
import flash.net.NetStream;

import flv2.*;

public class FlvGame2 extends Sprite {
    private var start:flv2.start;
    private var game:flv2.game;
    private var end:flv2.end;

    public function FlvGame2() {
        super();
        start = new flv2.start();
        game = new flv2.game();
        end = new flv2.end();
        addChild(start);
        start.startBtn.addEventListener(MouseEvent.CLICK, onStart);
        game.submitBtn.addEventListener(MouseEvent.CLICK, onSubmit);
        end.endBtn.addEventListener(MouseEvent.CLICK, onEnd);
    }

    private function onStart(e:MouseEvent):void {
        removeChild(start);
        addChild(game);

        for (var i:int = 0; i < 3; i++) {
            for (var m:int = 0; m < 3; m++) {
                var v = addVideo("0" + (i + m + 2) + ".flv");
                v.x = (220 + 10) * m + 180;
                v.y = (128 + 10) * i + 130;
            }

        }
    }

    private function addVideo(file:String):DisplayObject {
        var vid:Video = new Video(220, 128);
//        addChild(vid);
        var nc:NetConnection = new NetConnection();
        nc.connect(null);
        var ns:NetStream = new NetStream(nc);
        vid.attachNetStream(ns);
        var listener:Object = new Object();
        listener.onMetaData = function (evt:Object):void {
        };
        ns.client = listener;

        ns.play("flvs/" + file);
        ns.pause();
        var container:Sprite = new Sprite();
        container.graphics.beginFill(0, 0);
        container.graphics.drawRect(0, 0, 220, 128);
        container.graphics.endFill();
        addChild(container);
        container.addChild(vid);
        container.addEventListener(MouseEvent.ROLL_OVER, function (e:MouseEvent):void {
            ns.play("flvs/" + file);
        });
        container.addEventListener(MouseEvent.ROLL_OUT, function (e:MouseEvent):void {
            ns.pause();
        });
        setSelecteds(container);
        return container;
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

    public function setSelecteds(mc:Sprite):void {
        mc.addEventListener(MouseEvent.CLICK, function (e:MouseEvent):void {
            if(mc.filters.length==0){
                var glowFilter:BitmapFilter = getBitmapFilter();
                mc.filters = [glowFilter];
            }else{
                mc.filters = [];
            }

        });
        mc.filters = [];
        mc.useHandCursor = true;
        mc.buttonMode = true;
    }

    private function onSubmit(e:MouseEvent):void {
        removeChild(game);
        addChild(end);
    }

    private function onEnd(e:MouseEvent):void {
        removeChild(end);
        NativeApplication.nativeApplication.exit();
    }
}
}
