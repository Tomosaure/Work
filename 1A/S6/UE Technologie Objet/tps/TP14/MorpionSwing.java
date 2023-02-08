import javax.swing.*;
import java.awt.*;
import javax.swing.event.*;
import java.awt.event.*;
import java.util.*;

/** Programmation d'un jeu de Morpion avec une interface graphique Swing.
  *
  * REMARQUE : Dans cette solution, le patron MVC n'a pas été appliqué !
  * On a un modèle (?), une vue et un contrôleur qui sont fortement liés.
  *
  * @author	Xavier Crégut
  * @version	$Revision: 1.4 $
  */

public class MorpionSwing implements ActionListener {

	// les images à utiliser en fonction de l'état du jeu.
	private static final Map<ModeleMorpion.Etat, ImageIcon> images
		= new HashMap<ModeleMorpion.Etat, ImageIcon>();
	static {
		images.put(ModeleMorpion.Etat.VIDE, new ImageIcon("blanc.jpg"));
		images.put(ModeleMorpion.Etat.CROIX, new ImageIcon("croix.jpg"));
		images.put(ModeleMorpion.Etat.ROND, new ImageIcon("rond.jpg"));
	}

// Choix de réalisation :
// ----------------------
//
//  Les attributs correspondant à la structure fixe de l'IHM sont définis
//	« final static » pour montrer que leur valeur ne pourra pas changer au
//	cours de l'exécution.  Ils sont donc initialisés sans attendre
//  l'exécution du constructeur !

	private ModeleMorpion modele;	// le modèle du jeu de Morpion

//  Les éléments de la vue (IHM)
//  ----------------------------

	/** Fenêtre principale */
	private JFrame fenetre;

	/** Bouton pour quitter */
	private final JMenuItem boutonQuitter = new JMenuItem("Q");
	private final JButton Quitter = new JButton("Quitter");

	/** Bouton pour commencer une nouvelle partie */
	private final JMenuItem boutonNouvellePartie = new JMenuItem("N");
	private final JButton NouvellePartie = new JButton("Nouvelle partie");

	/** Cases du jeu */
	private final JLabel[][] cases = new JLabel[3][3];
	private final JButton[][] cellules = new JButton[3][3];
	
	/** Zone qui indique le joueur qui doit jouer */
	private final JLabel joueur = new JLabel();

	private JButton joueurcourant;
	
// Le constructeur
// ---------------

	/** Construire le jeu de morpion */
	public MorpionSwing() {
		this(new ModeleMorpionSimple());
	}

	/** Construire le jeu de morpion */
	public MorpionSwing(ModeleMorpion modele) {
		// Initialiser le modèle
		this.modele = modele;

		// Créer les cases du Morpion
		for (int i = 0; i < this.cases.length; i++) {
			for (int j = 0; j < this.cases[i].length; j++) {
				this.cases[i][j] = new JLabel();
			}
		}

		// Initialiser le jeu
		this.recommencer();
		// Construire la vue (présentation)
		//	Définir la fenêtre principale
		this.fenetre = new JFrame("Morpion");
		this.fenetre.setLocation(100, 200);
		this.fenetre.setSize(400,400);
		
		Image icon = Toolkit.getDefaultToolkit().getImage("croix.jpg");
		this.fenetre.setIconImage(icon);
		
		JMenuBar Menu = new JMenuBar();
		JMenu Jeu = new JMenu("jeu");
		
		this.boutonQuitter.addActionListener(this);
		this.boutonNouvellePartie.addActionListener(this);
		
		Jeu.add(this.NouvellePartie);
		Jeu.add(this.Quitter);
		Menu.add(Jeu);
		
		this.fenetre.setJMenuBar(Menu);
		
		this.boutonQuitter.setBounds(50, 300, 100, 30);
		this.boutonQuitter.addActionListener((ActionListener) this);
		this.fenetre.add(this.boutonQuitter);
		

		this.boutonNouvellePartie.setBounds(200, 300, 150, 30);
		this.boutonNouvellePartie.addActionListener((ActionListener) this);
		this.fenetre.add(this.boutonNouvellePartie);
		
		this.joueurcourant = new JButton(new ImageIcon("blanc.jpg"));
		this.joueurcourant.setBounds(150, 30, 50, 50);
		this.joueurcourant.addActionListener((ActionListener) this);
		this.fenetre.add(this.joueurcourant);
		
		
		for (int i =0; i < 3; i++) {
			for (int k = 0; k < 3; k++) {
				this.cellules[i][k] = new JButton(new ImageIcon("blanc.jpg"));
				this.cellules[i][k].setBounds(100 + 50 * k, 100 + 50 * i, 50, 50);
				this.cellules[i][k].addActionListener(this);
				this.fenetre.add(cellules[i][k]);
			}
		}
		
		// Construire le contrôleur (gestion des événements)
		this.fenetre.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
		// afficher la fenêtre
		//this.fenetre.pack();			// redimmensionner la fenêtre
		this.fenetre.setLayout(null);
		this.fenetre.setVisible(true);	// l'afficher
	}

// Quelques réactions aux interactions de l'utilisateur
// ----------------------------------------------------

	/** Recommencer une nouvelle partie. */
	public void recommencer() {
		this.modele.recommencer();

		// Vider les cases
		for (int i = 0; i < this.cases.length; i++) {
			for (int j = 0; j < this.cases[i].length; j++) {
				this.cases[i][j].setIcon(images.get(this.modele.getValeur(i, j)));
			}
		}

		// Mettre à jour le joueur
		joueur.setIcon(images.get(modele.getJoueur()));
	}



// La méthode principale
// ---------------------

	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				new MorpionSwing();
			}
		});
	}

@Override
public void actionPerformed(ActionEvent arg0) {
	// TODO Auto-generated method stub
	
}

}
