package harry_potter.utils 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.Font;
	import harry_potter.game.Card;
	import harry_potter.assets.Global;
	
	/**
	 * Simple class to display the starting character to the player based on the main menu
	 */
	public class MenuCharacterDisplay extends Sprite {
		
		//constant to switch to the cardback image
		public static const CARDBACK:String = "cardback";
		
		public static var spriteSheet:Bitmap;
		
		//descriptions for the various characters, to be used with our tooltip class
				
		private var gfxBitmap:Bitmap;
		private var blitRect:Rectangle;
		
		private var description:String;
		private var title:String;
		
		private var _parent:Sprite;
		
		public function MenuCharacterDisplay() {
			
			//instantiate our rectangle
			blitRect = new Rectangle(0, 0, 67, 48);
			
			//add our bitmap to the sprite with a blank BMD
			gfxBitmap = new Bitmap(new BitmapData(67, 48));
			addChild(gfxBitmap);
			
			//call our switch function to copy the correct pixels onto the image
			switchChar(CARDBACK);
			
			//Tooltips
			addEventListener(MouseEvent.MOUSE_OVER, showToolTip);
			addEventListener(MouseEvent.MOUSE_OUT, hideToolTip);
		}
		
		private function showToolTip(e:MouseEvent):void {
			if (description != "") {
				Global.tooltip.show(this, title, description);
			}
		}
		private function hideToolTip(e:MouseEvent):void {
			Global.tooltip.hide();
		}
		
		/**
		 * Switches the graphic for the main character based on the parameter.
		 * @param	lessonType Accepted values are LessonTypes constants or MenuCharacterDisplay.CARDBACK for the cardback image.
		 */
		public function switchChar(lessonType:String):void {
			
			//adjust the blitRect x and y properties based on which lesson is selected
			switch(lessonType) {
				case LessonTypes.CARE_OF_MAGICAL_CREATURES:
					description = String(Card.library.Card.(@title == DeckGeneration.CHARACTER_CREATURES).description);
					title = DeckGeneration.CHARACTER_CREATURES;
					blitRect.x = 136;
					blitRect.y = 0;
					break;
				case LessonTypes.CHARMS:
					description = Card.library.Card.(@title == DeckGeneration.CHARACTER_CHARMS).description;
					title = DeckGeneration.CHARACTER_CHARMS;
					blitRect.x = 68;
					blitRect.y = 0;
					break;
				case LessonTypes.TRANSFIGURATION:
					description = Card.library.Card.(@title == DeckGeneration.CHARACTER_TRANSFIGURATIONS).description;
					title = DeckGeneration.CHARACTER_TRANSFIGURATIONS;
					blitRect.x = 136;
					blitRect.y = 49;
					break;
				case LessonTypes.POTIONS:
					description = Card.library.Card.(@title == DeckGeneration.CHARACTER_POTIONS).description;
					title = DeckGeneration.CHARACTER_POTIONS;
					blitRect.x = 0;
					blitRect.y = 49;
					break;
				case LessonTypes.QUIDDITCH:
					description = Card.library.Card.(@title == DeckGeneration.CHARACTER_QUIDDITCH).description;
					title = DeckGeneration.CHARACTER_QUIDDITCH;
					blitRect.x = 68;
					blitRect.y = 49;
					break;
				case CARDBACK:
					description = "";
					title = "";
					blitRect.x = 0;
					blitRect.y = 0;
					break;
				default:
					trace("invalid parameter to MenuCharacterDisplay");
					return;
			}
			
			//copy the appropriate pixels to the image
			gfxBitmap.bitmapData.lock();
			gfxBitmap.bitmapData.copyPixels(spriteSheet.bitmapData, blitRect, new Point());
			gfxBitmap.bitmapData.unlock();
		}
	}
}