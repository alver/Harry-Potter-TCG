package harry_potter 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.utils.getTimer;
	import harry_potter.game.Card;
	
	import harry_potter.assets.Global;
	import harry_potter.game.Deck;
	import harry_potter.utils.LessonTypes;
	
	public class Gameplay extends Sprite {

		private var deck:Deck;
		
		public function Gameplay(_lessons:Array) {
			
			/* TO DO:
			 * Add a loading graphic while randomizing the deck, then add the gameplay background and begin the game.
			 */
			//Background image
			var bg:Bitmap = new Global.GameplayBackground();
			addChild(bg);
			
			deck = new Deck();
			
			//Begin deck generation, count how long it takes
			var startT:int = getTimer();
			switch(_lessons.length) {
				case 2:
					addLesson(deck, _lessons[0], 16, 15);
					addLesson(deck, _lessons[1], 14, 15);
					break;
				case 3:
					addLesson(deck, _lessons[0], 15);
					addLesson(deck, _lessons[1], 8);
					addLesson(deck, _lessons[2], 7);
					break;
			}

			var endT:int = getTimer() - startT;
			
			//Print stats of deck generation
			Global.console.print(deck.toString());
			Global.console.print("Deck size: " + deck.getNumCards());
			Global.console.print("Deck generated in: " + endT + " ms.");
			Global.console.toggle();
		}
		
		/**
		 * Adds a set of lessons and their respective cards to the specified deck.
		 * @param	_deck		A reference to the deck that you wish to insert cards into.
		 * @param	type		The type of lesson to insert (i.e. LessonTypes.CHARMS)
		 * @param	num_lessons	The number of lessons to insert
		 * @param	num_cards	How many cards of the given type should be added (default: 10)
		 */
		private function addLesson(_deck:Deck, type:uint, num_lessons:uint, num_cards:uint = 10):void {
			var startingName:String;
			var lessonName:String;
			var tagName:String;
			//Set the three variables in the switch case depending on the type of lesson the player has chosen.
			//this is simply to avoid having to copy/paste the algorithm 5 times inside a switch statement.
			switch(type) {
				case LessonTypes.CARE_OF_MAGICAL_CREATURES:
					startingName = "Ron, Youngest Brother";
					lessonName = "Care of Magical Creatures";
					tagName = "COMC";
					break;
				case LessonTypes.CHARMS:
					startingName = "The Famous Harry Potter";
					lessonName = "Charms";
					tagName = lessonName;
					break;
				case LessonTypes.TRANSFIGURATION:
					startingName = "Hermione Granger";
					lessonName = "Transfigurations";
					tagName = lessonName;
					break;
				case LessonTypes.POTIONS:
					startingName = "Draco Malfoy, Slytherin";
					lessonName = "Potions";
					tagName = lessonName;
					break;
				case LessonTypes.QUIDDITCH:
					startingName = "Oliver Wood";
					lessonName = "Quidditch";
					tagName = lessonName;
					break;
				default:
					throw new Error("Invalid parameter to addMainLesson");
			}
			
			//Add starting character
			var starting:Card = new Card(startingName);
			_deck.setStarting(starting);
			//Add number of lessons
			for (var i:uint = 0; i < num_lessons; ++i) {
				var lesson:Card = new Card(lessonName);
				_deck.add(lesson);
			}
			//Make array of non-lesson cards to add, use tag name to identify elegible cards.
			var listFromXML:XMLList = Card.library.Card.(tags == tagName);
			/**
			 * TEMPORARY - If no cards are found with the appropriate tagname, listFromXML won't initialize correctly, just exit here.
			 */
			if (listFromXML == null) {
				return;
			}
			//Pick cards to add at random from array
			for (var k:uint = 0; k < num_cards; ++k) {
				var index:int = Math.random() * listFromXML.length();
				if (!deck.add(new Card(listFromXML[index].@title))) {
					k--; //if the card failed to add, reduce k and try again.
				}
			}
		}
	}
}
