import funkin.play.notes.SustainTrail;
import funkin.play.notes.notestyle.NoteStyle;
import flixel.FlxSprite;
import funkin.Paths;
import flixel.FlxCamera;

class EXESustainEnd extends SustainTrail
{
  public var customEndSprite:FlxSprite;
  var style:String;

  public function new(noteDirection:NoteDirection, sustainLength:Float, noteStyle:NoteStyle)
  {
    super(noteDirection, sustainLength, noteStyle);
    style = noteStyle.id;

    if(style != 'exe') return;
    customEndSprite = new FlxSprite();
    customEndSprite.loadGraphic(Paths.image('noteStyle/exe_holdEnds'), true, 91, 64);
    customEndSprite.animation.frameIndex = noteDirection;
    customEndSprite.antialiasing = antialiasing;
  }

  override public function updateClipping(songTime:Float = 0):Void
  {
    super.updateClipping(songTime);
    if(style != 'exe') return;

    if (visible && vertices != null && vertices.length >= 16)
    {
      var endCapCenterX:Float = this.x + ((vertices[12] + vertices[14]) / 2);
      var endCapCenterY:Float = this.y + ((vertices[13] + vertices[15]) / 2);
      
      if (customEndSprite != null)
      {
        customEndSprite.setPosition(
          endCapCenterX - (customEndSprite.width / 2),
          endCapCenterY - (customEndSprite.height / 2)
        );
        customEndSprite.visible = this.visible;
        customEndSprite.alpha = this.alpha;
      }
    }
    else if (customEndSprite != null)
    {
      customEndSprite.visible = false;
    }
  }

  @:access(FlxCamera)
  override public function draw():Void
  {
    super.draw();

    if (customEndSprite != null && customEndSprite.exists && customEndSprite.visible && customEndSprite.alpha > 0)
    {
      customEndSprite.cameras = this.cameras;
      customEndSprite.draw();
    }
  }

  override public function destroy():Void
  {
    if (customEndSprite != null)
    {
      customEndSprite.destroy();
      customEndSprite = null;
    }
    super.destroy();
  }
}