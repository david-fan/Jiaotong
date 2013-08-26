/**
 * Created with IntelliJ IDEA.
 * User: david
 * Date: 8/4/13
 * Time: 10:15 AM
 * To change this template use File | Settings | File Templates.
 */
package games {
import com.greensock.TweenLite;

import flash.desktop.NativeApplication;

import flash.display.MovieClip;
import flash.display.Sprite;

import fg2.*;

import flash.events.MouseEvent;
import flash.filters.BitmapFilter;
import flash.filters.BitmapFilterQuality;
import flash.filters.GlowFilter;
import flash.utils.setTimeout;

import org.david.ui.MTextBlock;

public class FG2 extends Sprite {
    private var s:start;
    private var g:game;
    private var e:end;
    private var shows:Array = [];
    private var current:Object;
    private var currentIndex:int = 0;

    private var txt:MyText;

    public function FG2() {
        super();
        s = new start();
        addChild(s);
        s.startBtn.addEventListener(MouseEvent.CLICK, onStart);
    }

    private function onStart(e:MouseEvent):void {
        removeChild(s);
        showgame();
    }

    private function showEnd():void {
        removeChild(g);
        e = new end();
        addChild(e);
        e.endBtn.addEventListener(MouseEvent.CLICK, onExit);
    }

    private function onExit(e:MouseEvent):void {
        NativeApplication.nativeApplication.exit();
    }

    private function showgame():void {
        g = new game();
        addChild(g);
        txt = new MyText();
        addChild(txt);
        txt.filters = [new GlowFilter(0xffffff, 1, 8, 8, 600)];
        txt.x = g.panel.x + 50;
        txt.y = g.panel.y;
        g.removeChild(g.panel);

        shows.push({mc: g.a1, des: "在夜间骑乘自行车，应检查白色前灯，红色后灯或者红色反射器。并清洁灯的表面，确保可以正常使用"});
        shows.push({mc: g.a2, des: "每次骑乘自行车之前，应检查刹车功能是否正常。"});
        shows.push({mc: g.a3, des: "每次骑乘自行车之前，要检查轮胎的气压是否充足。"});
        shows.push({mc: g.a4, des: "骑车前应调整座椅的高度，确保脚趾可以舒适的接触到地面，不要骑乘太大或太小的自行车。"});
        shows.push({mc: g.a5, des: "在夜间骑乘自行车，应检查车轮上的反射器，确保表面清洁。"});
        shows.push({mc: g.a6, des: "骑车前，应检查车铃是否正常"});
        g.a1.visible = g.a2.visible = g.a3.visible = g.a4.visible = g.a5.visible = g.a6.visible = false;

        g.submitBtn.addEventListener(MouseEvent.CLICK, showCurrent);
        showCurrent(null);
    }


    private function showCurrent(e:MouseEvent):void {
        if (current != null) {
            TweenLite.to(current.mc, 0.5, {scaleX: 0, scaleY: 0, alpha: 0});
        }
        if (currentIndex >= shows.length) {
            exit();
            return;
        }
        current = shows[currentIndex];
        current.mc.visible = true;
        current.mc.alpha = 0;
        current.mc.scaleX = current.mc.scaleY = 0;
//        g.panel.title.text = current.des;


        txt.updateText(current.des, 26, 0x5BC5BF, g.panel.width);
        TweenLite.to(current.mc, 0.5, {scaleX: 1, scaleY: 1, alpha: 1});
        currentIndex++;
    }

    private function exit():void {
//        NativeApplication.nativeApplication.exit();
        showEnd();
    }
}
}
