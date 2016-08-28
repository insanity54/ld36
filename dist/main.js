var game = new Phaser.Game(
  800,
  600,
  Phaser.CANVAS,
  'ld36',
  {
    preload: preload,
    create: create,
    update: update,
    render: wrender
  }
);


function preload() {
    game.load.image('back', 'assets/img/bg.png');
}

var bmd;
var text;

function create() {
    // background
    game.add.image(0, 0, 'back');

    // bitmap data we will be drawing to
    bmd = game.add.bitmapData(game.width, game.height);
    bmd.fill(200, 0, 0, 0.5);
    bmd.addToWorld();

    // cool text
    var textOpts = {
        font: 'bold 55pt Arial',
        fontStyle: 'italic',
        fill: 'white',
        stroke: 'black',
        strokeThickness: 25,
        wordWrap: false,
        maxLines: 1
    };
    text = game.make.text(50, 50, "YOLO", {
      font: "bold 32px Arial",
      fill: "white",
      stroke: "black",
      strokeThickness: 20
    });
    text.anchor.set(0.5);
    game.add.tween(text.scale).to( { x: 0.5, y: 0.5 }, 2000, Phaser.Easing.Linear.None, true, 0, Number.MAX_VALUE, true);

    //game.time.events.loop(Phaser.Timer.SECOND * 0.2, function() { bmd.cls(); }, this);
}


function update() {
    //bmd.fill(0, 0, 0, 1);

    //	Un-comment to see the rotation in action
    // text.rotation += 0.05;

    bmd.draw(text, game.world.randomX, game.world.randomY, null, null);
}



function wrender() {

}
