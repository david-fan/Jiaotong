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

public class FG2 extends Sprite {
    private var g:game;
    private var shows:Array = [];
    private var current:Object;
    private var currentIndex:int = 0;

    public function FG2() {
        super();
        g = new game();
        addChild(g);
        shows.push({mc: g.a1, des: "a1"});
        shows.push({mc: g.a2, des: "a2"});
        shows.push({mc: g.a3, des: "a3"});
        shows.push({mc: g.a4, des: "a4"});
        shows.push({mc: g.a5, des: "a5"});
        g.a1.visible = g.a2.visible = g.a3.visible = g.a4.visible = g.a5.visible = false;

        g.endBtn.addEventListener(MouseEvent.CLICK, showCurrent);
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
        g.panel.title.text=current.des;
        TweenLite.to(current.mc, 0.5, {scaleX: 1, scaleY: 1, alpha: 1});
        currentIndex++;
    }

    private function exit():void {
        NativeApplication.nativeApplication.exit();
    }
}
}
