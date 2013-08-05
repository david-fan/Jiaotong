/**
 * Created with IntelliJ IDEA.
 * User: david
 * Date: 6/25/13
 * Time: 7:57 PM
 * To change this template use File | Settings | File Templates.
 */
package {
import flash.desktop.NativeApplication;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.events.MouseEvent;
import flash.filters.BitmapFilter;
import flash.filters.BitmapFilterQuality;
import flash.filters.DropShadowFilter;
import flash.filters.GlowFilter;
import flash.media.Sound;
import flash.net.URLRequest;
import flash.utils.setTimeout;

public class GameLogical {
    private var _start:DisplayObject;
    private var _game:DisplayObject;
    private var _end:DisplayObject;

    private var _resultRight:DisplayObject;
    private var _resultWrong:DisplayObject;
    private var _items:Array;

    private var _container:DisplayObjectContainer

    public function GameLogical(container:DisplayObjectContainer) {
        _container = container;
    }

    public function setMC(start:DisplayObject, game:DisplayObject, end:DisplayObject):void {
        _start = start;
        _game = game;
        _end = end;
        _container.addChild(start);
    }

    public function setBtns(start:DisplayObject, submit:DisplayObject, end:DisplayObject, resultRight:DisplayObject, resultWrong:DisplayObject):void {
        start.addEventListener(MouseEvent.CLICK, onStart);
        submit.addEventListener(MouseEvent.CLICK, onSubmit);
        end.addEventListener(MouseEvent.CLICK, onEnd);

        _resultRight = resultRight;
        _resultRight.visible = false;

        _resultWrong = resultWrong;
        _resultWrong.visible = false;
    }

    private function onStart(e:MouseEvent):void {
        if (_container.contains(_start))
            _container.removeChild(_start);
        _container.addChild(_game);
    }

    private function onSubmit(e:MouseEvent):void {
        var r:Boolean = true;
        for each (var o:SelectItem in _items) {
            if (o.right && o.mc.filters.length == 0) {
                r = false;
                break;
            }
            else if (!o.right && o.mc.filters.length == 1) {
                r = false;
                break;
            }
        }

        if (r){
            _resultRight.visible = true;
            var s:Sound=new Sound(new URLRequest("asset/r.mp3"));
            s.play();
        }
        else{
            _resultWrong.visible = true;
            var s:Sound=new Sound(new URLRequest("asset/w.mp3"));
            s.play();
        }

        setTimeout(checkEnd, 3 * 1000, r);
    }

    private function checkEnd(r:Boolean):void {
        if (r) {
            if (_container.contains(_game))
                _container.removeChild(_game);
            _container.addChild(_end);
        } else {
            _resultWrong.visible = false;
        }
    }

    private function onEnd(e:MouseEvent):void {
        _container.removeChild(_end);
        NativeApplication.nativeApplication.exit();
    }

    public function setSelecteds(items:Array):void {
        _items = items;
        for each (var o:SelectItem in _items) {
            o.mc.addEventListener(MouseEvent.CLICK, onItemClick);
            o.mc.filters=[];
        }
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

    private function onItemClick(e:MouseEvent):void {
        var glowFilter:BitmapFilter = getBitmapFilter();
        var item:DisplayObject = e.currentTarget as DisplayObject;
        if (item.filters.length == 0)
            item.filters = [glowFilter];
        else
            item.filters = [];
    }
}
}
