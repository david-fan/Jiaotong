package {
import asset.Asset;

import away3d.cameras.*;
import away3d.containers.*;
import away3d.materials.*;
import away3d.primitives.Plane;
import away3d.primitives.Cube;
import away3d.containers.ObjectContainer3D;

import caurina.transitions.*

import flash.display.Bitmap;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.TimerEvent;
import flash.geom.Vector3D;
import flash.utils.Timer;

public class MemoryGame extends Sprite {


    var scene:Scene3D;
    var camera:Camera3D;
    var view:View3D;
    var totalchildren:int = 10;
    var cards:Array;
    var textures:Array = [ new Asset.texture0(),
        new Asset.texture1(),
        new Asset.texture2(),
        new Asset.texture3(),
        new Asset.texture4()];
    var backtexture:Bitmap = new Asset.textureback();
    var woodtexture:Bitmap = new Asset.texturewood();
    var cardwidth:Number = 110;
    var cardheight:Number = 150;
    var xoffset:Number = 10;
    var yoffset:Number = 10;
    var cardsholder:ObjectContainer3D;
    var selectedCard1:Plane;
    var selectedCard2:Plane;
    var disableMouseEvents:Boolean = false;

    function MemoryGame():void {

//        stage.align = StageAlign.TOP_LEFT;
//        stage.scaleMode = StageScaleMode.NO_SCALE;

        if(stage){
            onAddToStage(null);
        }
        else{
            addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
        }

    }

    function onAddToStage(e:Event):void{
        scene = new Scene3D();

        camera = new Camera3D();
        camera.y = 700;
        camera.z = 500;
        camera.lookAt(new Vector3D(0, 0, 0));

        view = new View3D({scene: scene, camera: camera});
        view.x = stage.stageWidth / 2;
        view.y = stage.stageHeight / 2;
        addChild(view);

        createGround();
        initCards();
        randomizeCards();
        addCardsToScene();
        startToRender();
    }

    function createGround():void {
        var cube:Cube = new Cube({width: 680, depth: 400, height: 20, pushback: true, ownCanvas: true, material: new BitmapMaterial(woodtexture.bitmapData)});
        cube.y = -20;
        scene.addChild(cube);
    }

    function createCard(texture:Bitmap, id:int):ObjectContainer3D {
        var card:ObjectContainer3D = new ObjectContainer3D();

        var front:Plane = new Plane({width: cardwidth, height: cardheight, material: new BitmapMaterial(texture.bitmapData, {smooth: true})});
        var back:Plane = new Plane({width: cardwidth, height: cardheight, material: new BitmapMaterial(backtexture.bitmapData, {smooth: true})});
        front.rotationY = 180;
        back.rotationZ = 180;
        back.rotationY = 180;


        back.extra = {};
        back.extra.id = id;
        back.extra.targetCard = card;
        back.addOnMouseDown(onBackClicked);

        card.rotationZ = 180;
        card.addChild(front);
        card.addChild(back);
        card.ownCanvas = true;
        return card;
    }

    function initCards():void {
        cards = new Array();
        for (var i:int = 0; i < textures.length; i++) {

            var card1:ObjectContainer3D = createCard(textures[i], i);
            var card2:ObjectContainer3D = createCard(textures[i], i);

            cards.push(card1);
            cards.push(card2);

        }
    }

    function randomizeCards():void {
        var newArray:Array = new Array();
        while (cards.length > 0) {
            newArray.push(cards.splice(Math.floor(Math.random() * cards.length), 1)[0]);
        }
        cards = newArray;
    }

    function addCardsToScene():void {
        cardsholder = new ObjectContainer3D();
        var currentindex:int = 0;

        for (var i:int = 0; i < 2; i++) {
            for (var b:int = 0; b < 5; b++) {
                cards[currentindex].x = b * (cardwidth + xoffset) + cardwidth / 2;
                cards[currentindex].z = i * (cardheight + yoffset) + cardheight / 2;
                cardsholder.addChild(cards[currentindex]);
                currentindex++;
            }
        }

        var cardswidth:Number = (5 * cardwidth) + (4 * xoffset);
        var cardsheight:Number = (2 * cardheight) + (1 * yoffset);

        cardsholder.x = -cardswidth / 2;
        cardsholder.z = -cardsheight / 2;

        scene.addChild(cardsholder);
    }

    function waitForDecision():void {
        var timer:Timer = new Timer(1000, 1);
        timer.addEventListener(TimerEvent.TIMER, makeDecision);
        timer.start();
    }

    function removeCard(e:ObjectContainer3D):void {
        cardsholder.removeChild(e);
        totalchildren--;
        if (totalchildren == 0) {
            trace("WIN");
        }

    }

    function startToRender():void {
        addEventListener(Event.ENTER_FRAME, render);
    }

    function onBackClicked(e:Event):void {
        if (disableMouseEvents == false) {
            if (selectedCard1 == null) {
                selectedCard1 = e.currentTarget as Plane;
            } else {
                if (selectedCard2 == null) {
                    selectedCard2 = e.currentTarget as Plane;
                    waitForDecision();
                    disableMouseEvents = true;
                }
            }
            Tweener.addTween(e.currentTarget.extra.targetCard, {y: 50, rotationZ: 0, time: 1});
        }
    }

    function makeDecision(e:Event):void {
        if (selectedCard1.extra.id == selectedCard2.extra.id) {
            Tweener.addTween(selectedCard1.extra.targetCard, {alpha: 0, time: 0.2, onComplete: removeCard, onCompleteParams: [selectedCard1.extra.targetCard]});
            Tweener.addTween(selectedCard2.extra.targetCard, {alpha: 0, time: 0.2, onComplete: removeCard, onCompleteParams: [selectedCard2.extra.targetCard]});
        } else {
            Tweener.addTween(selectedCard1.extra.targetCard, {y: 0, rotationZ: 180, time: 1});
            Tweener.addTween(selectedCard2.extra.targetCard, {y: 0, rotationZ: 180, time: 1});
        }
        disableMouseEvents = false;
        selectedCard1 = null;
        selectedCard2 = null;
    }

    function render(e:Event):void {
        view.render();
    }


}
}
