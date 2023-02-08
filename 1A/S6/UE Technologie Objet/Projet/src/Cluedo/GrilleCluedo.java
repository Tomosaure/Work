package Cluedo;

import java.awt.FlowLayout;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import javax.swing.ImageIcon;
import javax.swing.JCheckBox;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.UIManager;
import javax.swing.plaf.nimbus.NimbusLookAndFeel;

public class GrilleCluedo extends JPanel {

	private static final long serialVersionUID = -3236044557837976658L;
	private static JCheckBox checkBox;
	private static ImageIcon carre_blanc = new ImageIcon("Ressources/Image/carre15px.png");
	private static ImageIcon check = new ImageIcon("Ressources/Image/check.png");
	private static ImageIcon interrogation = new ImageIcon("Ressources/Image/interrogation2.png");
	private static ImageIcon rond = new ImageIcon("Ressources/Image/rond.png");
	private static ImageIcon bleu = new ImageIcon("Ressources/Image/bleu.png");

	public GrilleCluedo() {

		JPanel grilles = new JPanel(new GridLayout(4, 1));

		grilles.add(grilleJoueurs());
		grilles.add(grillePersonnages());
		grilles.add(grilleArmes());
		grilles.add(grilleLieux());

		this.add(grilles);

	}

	// Créer une seule ligne de la grille
	private static JPanel ligne(String nom) {
		JPanel ligne = new JPanel(new FlowLayout());
		ligne.add(new JLabel(nom));
		for (int i = 1; i < 8; i++) {
			checkBox = new JCheckBox();
			checkBox.setIcon(carre_blanc);
			checkBox.addActionListener((e) -> checkBoxListener(e));
			ligne.add(checkBox);
		}
		return ligne;
	}

	private JPanel grilleJoueurs() {
		JPanel grille = new JPanel(new FlowLayout());
		JPanel joueurs = new JPanel(new GridLayout(1, 6));

		joueurs.add(new JTextField("j1     "));
		joueurs.add(new JTextField("j2"));
		joueurs.add(new JTextField("j3"));
		joueurs.add(new JTextField("j4"));
		joueurs.add(new JTextField("j5"));
		joueurs.add(new JTextField("j6"));

		grille.add(new JLabel("Joueurs                                           "));
		grille.add(joueurs);
		return grille;

	}

	// Créer la grille de personnages
	private JPanel grillePersonnages() {
		JPanel grille = new JPanel(new FlowLayout());
		JPanel personnages = new JPanel(new GridLayout(6, 1));
		personnages.add(ligne("Olive           "));
		personnages.add(ligne("Moutarde   "));
		personnages.add(ligne("Orchidée   "));
		personnages.add(ligne("Pervenche"));
		personnages.add(ligne("Violet         "));
		personnages.add(ligne("Rose           "));

		grille.add(new JLabel("Personnages   "));
		grille.add(personnages);

		return grille;

	}

	// Créer la grille des armes
	private JPanel grilleArmes() {
		JPanel grille = new JPanel(new FlowLayout());
		JPanel armes = new JPanel(new GridLayout(6, 1));
		armes.add(ligne("Chandelier          "));
		armes.add(ligne("Poignard             "));
		armes.add(ligne("Barre de fer        "));
		armes.add(ligne("Revolver              "));
		armes.add(ligne("Corde                 "));
		armes.add(ligne("Clé anglaise        "));

		grille.add(new JLabel("Armes   "));
		grille.add(armes);

		return grille;

	}

	// Créer la grille des armes
	private JPanel grilleLieux() {
		JPanel grille = new JPanel(new FlowLayout());
		JPanel lieux = new JPanel(new GridLayout(9, 1));
		lieux.add(ligne("Hall  		              "));
		lieux.add(ligne("Cuisine          "));
		lieux.add(ligne("Salle à manger  "));
		lieux.add(ligne("Bibliothèque      "));
		lieux.add(ligne("Grand salon      "));
		lieux.add(ligne("Bureau            "));
		lieux.add(ligne("Veranda           "));
		lieux.add(ligne("Petit salon       "));

		grille.add(new JLabel("Lieux      "));
		grille.add(lieux);

		return grille;

	}

	private static void checkBoxListener(ActionEvent e) {

		checkBox = (JCheckBox) e.getSource();

		if (checkBox.getIcon() == carre_blanc) {
			checkBox.setIcon(check);
		} else if (checkBox.getIcon() == check) {
			checkBox.setIcon(interrogation);
		} else if (checkBox.getIcon() == interrogation) {
			checkBox.setIcon(rond);
		} else if (checkBox.getIcon() == rond) {
			checkBox.setIcon(bleu);
		} else if (checkBox.getIcon() == bleu) {
			checkBox.setIcon(carre_blanc);
		}
	}

	// A mettre dans le programme principale

	public static void main(String[] args) throws Exception {
		// Changer le look
		UIManager.setLookAndFeel(new NimbusLookAndFeel());
		JFrame frame = new JFrame();
		frame.setSize(1500, 1500);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.setResizable(true);

		// Creer une fenetre
		GrilleCluedo myWindow = new GrilleCluedo();
		myWindow.setVisible(true);

		frame.add(myWindow);
		frame.setVisible(true);
	}

}
