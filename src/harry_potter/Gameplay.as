package harry_potter 
{
	import flash.display.Bitmap; //We may not need this import here.
	import flash.display.Sprite;
	import harry_potter.game.Card; //Or this one
	import harry_potter.game.Player;
	
	import harry_potter.assets.Global;
	import harry_potter.game.Deck;
	import harry_potter.utils.LessonTypes; //Or this one
	import harry_potter.utils.DeckGeneration; //Or this one
	
	import caurina.transitions.Tweener;
	
	public class Gameplay extends Sprite {
		
		private var player:Player;
		private var opponentDeck:Deck;
		
		public function Gameplay(_playerDeck:Deck, _opponentDeck:Deck) {
			//Background image
			var bg:Bitmap = new Global.GameplayBackground();
			addChild(bg);
			
			player = new Player(_playerDeck);
			addChild(player);
			
			var player2:Player = new Player(_opponentDeck);
			//position the player 2 opposite of player 1
			player2.x = 800;
			player2.y = 600;
			player2.rotation = 180;
			addChild(player2);
			
			
			player.oppositePlayer = player2;
			player2.oppositePlayer = player;
			
			//TODO - Set up some layers for this screen
		}
	}
}
