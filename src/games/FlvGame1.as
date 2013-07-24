/**
 * Created with IntelliJ IDEA.
 * User: david
 * Date: 7/24/13
 * Time: 9:20 PM
 * To change this template use File | Settings | File Templates.
 */
package games {
import flash.desktop.NativeApplication;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.media.Video;
import flash.net.NetConnection;
import flash.net.NetStream;

import flv1.*;

public class FlvGame1 extends Sprite {
    private var start:flv1.start;
    private var game:flv1.game;
    private var end:flv1.end;


    public function FlvGame1() {
        super();
        start = new flv1.start();
        addChild(start);
        start.startBtn.addEventListener(MouseEvent.CLICK, onStart);
        game = new flv1.game();
        game.submitBtn.addEventListener(MouseEvent.CLICK, onSubmit);
        end = new flv1.end();
        end.endBtn.addEventListener(MouseEvent.CLICK, onEnd);
    }

    private function onStart(e:MouseEvent):void {
        removeChild(start);
        addChild(game);
        var vid:Video = new Video(720, 416);
        addChild(vid);
        vid.x = (1024 - 720) / 2;
        vid.y = (768 - 416) / 2;

        var nc:NetConnection = new NetConnection();
        nc.connect(null);

        var ns:NetStream = new NetStream(nc);
        vid.attachNetStream(ns);

        var listener:Object = new Object();
        listener.onMetaData = function (evt:Object):void {
        };
        ns.client = listener;

        ns.play("flvs/01.flv");
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
