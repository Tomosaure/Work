package Cluedo;

import java.awt.Graphics;

public class Jeu {
	public static final int WIDTH = 320;
	 private Menu menu;
	 public static enum ETAT{
	 	MENU,GAME            // les differents etats du jeu
	 };
	// menu=new Menu();
	
	public static ETAT Etat = ETAT.MENU;  // ça permet de définir dans quel état se situe le jeu
	
	// this.addMouseListener(new MouseInput());
	// if(Etat == ETAT.MENU) {
	// 	Graphics g;
	// 	menu.render(g); //ce qui fait apparaitre le menu 
	// }
	
}
