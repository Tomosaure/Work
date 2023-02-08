package Cluedo;

import java.awt.Rectangle;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;

public class Souris implements MouseListener{

	@Override
	public void mouseClicked(MouseEvent arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void mouseEntered(MouseEvent arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void mouseExited(MouseEvent arg0) {
		// TODO Auto-generated method stub
		
	}

	
	public void mousePressed(MouseEvent e) {
		int mx = e.getX();
		int my = e.getY();
	 /**public Rectangle playButton = new Rectangle(Jeu.WIDTH / 2 + 120,150,100,50);
		public Rectangle ruleButton = new Rectangle(Jeu.WIDTH / 2 + 120,250,100,50);
		public Rectangle optionButton = new Rectangle(Jeu.WIDTH / 2 + 120,350,100,50);
		public Rectangle quitButton = new Rectangle(Jeu.WIDTH / 2 + 120,450,100,50);
	  */
		// bouton jouer
		if (mx >= Jeu.WIDTH / 2 + 120 && mx<= Jeu.WIDTH / 2 +220)
		{
			if (my >= 150 && my <= 200)
			{
				Jeu.Etat = Jeu.ETAT.GAME;
			}
		}
	}

	@Override
	public void mouseReleased(MouseEvent arg0) {
		// TODO Auto-generated method stub
		
	}
	

}
