package Cluedo;

import java.awt.Graphics;
import java.util.*;
import java.awt.image.BufferedImage;
import javax.swing.ImageIcon;
import javax.imageio.ImageIO;
import java.io.File;
import java.io.IOException;

public class Jeu {

	public static final int WIDTH = 320;
	 private Menu menu;
	 public static enum ETAT{
	 	MENU,GAME            // les differents etats du jeu
	 };
	// menu=new Menu();

	private ArrayList<Carte> cartes;
	private ArrayList<Carte> cartesPerso;
	private ArrayList<Carte> cartesArme;
	private ArrayList<Carte> cartesSalle;
	private ArrayList<Personnage> personnages;

	public Jeu() throws IOException {
		Plateau plateau = new Plateau();
		/* Les 6 personnages */
		Personnage persoRose = new Personnage(NomCarte.ROSE);
		Personnage persoPervenche = new Personnage(NomCarte.PERVENCHE);
		Personnage persoOrchidee = new Personnage(NomCarte.ORCHIDEE);
		Personnage persoOlive = new Personnage(NomCarte.OLIVE);
		Personnage persoMoutarde = new Personnage(NomCarte.MOUTARDE);
		Personnage persoViolet = new Personnage(NomCarte.VIOLET);
		/* Toutes les cartes du jeu */

		/* Les 6 cartes PERSONNAGE */
		Carte rose = new Carte(persoRose);
		Carte pervenche = new Carte(persoPervenche);
		Carte orchidee = new Carte(persoOrchidee);
		Carte olive = new Carte(persoOlive);
		Carte moutarde = new Carte(persoMoutarde);
		Carte violet = new Carte(persoViolet);

		/* Les 6 cartes ARME */
		Carte corde = new Carte(TypeCarte.ARME, NomCarte.CORDE, new ImageIcon("../src/Ressources/Image/Cartes/carteCorde.png"));
		Carte revolver = new Carte(TypeCarte.ARME, NomCarte.REVOLVER, new ImageIcon("../src/Ressources/Image/Cartes/carteRevolver.png"));
		Carte chandelier = new Carte(TypeCarte.ARME, NomCarte.CHANDELIER, new ImageIcon("../src/Ressources/Image/Cartes/carteChandelier.png"));
		Carte barreDeFer = new Carte(TypeCarte.ARME, NomCarte.BARRE_DE_FER, new ImageIcon("../src/Ressources/Image/Cartes/carteBarreDeFer.png"));
		Carte cleAnglaise = new Carte(TypeCarte.ARME, NomCarte.CLE_ANGLAISE, new ImageIcon("../src/Ressources/Image/Cartes/carteCleAnglaise.png"));
		Carte poignard = new Carte(TypeCarte.ARME, NomCarte.POIGNARD, new ImageIcon("../src/Ressources/Image/Cartes/cartePoignard.png"));

		/* Les 9 cartes SALLE */
		Carte bibliotheque = new Carte(TypeCarte.SALLE, NomCarte.BIBLIOTHEQUE, new ImageIcon("../src/Ressources/Image/Cartes/carteBibliotheque.png"));
		Carte petitSalon = new Carte(TypeCarte.SALLE, NomCarte.PETIT_SALON, new ImageIcon("../src/Ressources/Image/Cartes/cartePetitSalon.png"));
		Carte grandSalon = new Carte(TypeCarte.SALLE, NomCarte.GRAND_SALON, new ImageIcon("../src/Ressources/Image/Cartes/carteGrandSalon.png"));
		Carte veranda = new Carte(TypeCarte.SALLE, NomCarte.VERANDA,new ImageIcon("../src/Ressources/Image/Cartes/carteVeranda.png"));
		Carte hall = new Carte(TypeCarte.SALLE, NomCarte.HALL, new ImageIcon("../src/Ressources/Image/Cartes/carteHall.png"));
		Carte cuisine = new Carte(TypeCarte.SALLE, NomCarte.CUISINE, new ImageIcon("../src/Ressources/Image/Cartes/carteCuisine.png"));
		Carte salleAManger = new Carte(TypeCarte.SALLE, NomCarte.SALLE_A_MANGER, new ImageIcon("../src/Ressources/Image/Cartes/carteSalleManger.png"));
		Carte bureau = new Carte(TypeCarte.SALLE, NomCarte.BUREAU, new ImageIcon("../src/Ressources/Image/Cartes/carteBureau.png"));
		Carte salleDeBillard = new Carte(TypeCarte.SALLE, NomCarte.SALLE_DE_BILLARD, new ImageIcon("../src/Ressources/Image/Cartes/carteBillard.png"));

		/* Le paquet de cartes (21 cartes) */
		this.cartes = new ArrayList(Arrays.asList(rose, pervenche, orchidee, olive, moutarde, violet,
			corde, revolver, chandelier, barreDeFer, cleAnglaise, poignard,
			bibliotheque, petitSalon, grandSalon, veranda, hall, cuisine, salleAManger, bureau, salleDeBillard));
		
		this.cartesPerso = new ArrayList(Arrays.asList(rose, pervenche, orchidee, olive, moutarde, violet));

		this.cartesArme = new ArrayList(Arrays.asList(corde, revolver, chandelier, barreDeFer, cleAnglaise, poignard));

		this.cartesSalle = new ArrayList(Arrays.asList(bibliotheque, petitSalon, grandSalon, veranda, hall, cuisine, salleAManger, bureau, salleDeBillard));

		this.personnages = new ArrayList(Arrays.asList(persoRose, persoPervenche, persoMoutarde, persoOrchidee, persoOlive, persoViolet));

	}

	
	
	public static ETAT Etat = ETAT.MENU;  // ça permet de définir dans quel état se situe le jeu
	
	// this.addMouseListener(new MouseInput());
	// if(Etat == ETAT.MENU) {
	// 	Graphics g;
	// 	menu.render(g); //ce qui fait apparaitre le menu 
	// }
	
	/* Retourne le paquet complet des cartes du jeu. */
	public ArrayList<Carte> getCartes() {
		return this.cartes;
	}

	public ArrayList<Carte> getCartesPerso() {
		return this.cartesPerso;
	}

	public ArrayList<Carte> getCartesArme() {
		return this.cartesArme;
	}

	public ArrayList<Carte> getCartesSalle() {
		return this.cartesSalle;
	}

	public ArrayList<Personnage> getPersos() {
		return this.personnages;
	}

	/* Trouver le personnage associé au nom 'nom'. */
	public Carte lePersonnage(NomCarte nom) {
		for (Carte perso : cartesPerso) {
			if (perso.getNomCarte() == nom) {
				return perso;
			}
		}
		return null;
	}

	public Carte laSalle(NomCarte nom) {
		for (Carte salle : cartesSalle) {
			if (salle.getNomCarte() == nom) {
				return salle;
			}
		}
		return null;
	}

	public Carte lArme(NomCarte nom) {
		for (Carte arme : cartesArme) {
			if (arme.getNomCarte() == nom) {
				return arme;
			}
		}
		return null;
	} 

}
