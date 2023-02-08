package Cluedo;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Rectangle;

public class Menu {
	
	public Rectangle playButton = new Rectangle(Jeu.WIDTH / 2 + 120,150,100,50);
	public Rectangle ruleButton = new Rectangle(Jeu.WIDTH / 2 + 120,250,100,50);
	public Rectangle optionButton = new Rectangle(Jeu.WIDTH / 2 + 120,350,100,50);
	public Rectangle quitButton = new Rectangle(Jeu.WIDTH / 2 + 120,450,100,50);
	
	
	
	public void render(Graphics g) {
		Graphics2D g2d=(Graphics2D) g;
		
		Font fnt0 = new Font("arial",Font.BOLD,50) ;//le titre 
		g.setFont(fnt0);
		g.setColor(Color.white);
		g.drawString("CLUEGROS", Jeu.WIDTH /2, 100);
		
		
		Font fnt1 = new Font("arial",Font.BOLD,30);
		g.setFont(fnt1);
		g.drawString("Jouer", playButton.x,playButton.y);
		g.drawString("Règles", ruleButton.x,ruleButton.y);
		g.drawString("Options", optionButton.x, optionButton.y);
		g.drawString("Quitter", quitButton.x,quitButton.y);
		g2d.draw(playButton);
		g2d.draw(ruleButton);
		g2d.draw(optionButton);
		g2d.draw(quitButton);
	}

}
